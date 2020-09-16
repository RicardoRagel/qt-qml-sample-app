#include "DataManager.h"
#include <QJsonObject>

/** *********************************
 *  DataManager Initizalization
 ** ********************************/

DataManager::DataManager(): _list_name("New List")
{

  qDebug() << "(DataManager) Initialization ...";

//  // Add some elements to the list as example
//  clearList();
//  addItem(0, "Batman", false, 75.0, "no_file");
//  addItem(1, "Robin", false, 50.0, "no_file");
//  addItem(2, "Joker", true, 100.0, "no_file");
}

DataManager::~DataManager()
{

}

/** *********************************
 *  QML Invokable properties setters
 ** ********************************/
void DataManager::setListName(QString list_name)
{
    _list_name = list_name;
    emit listNameChanged();
}

/** *********************************
 *  QML Invokable standalone functions
 ** ********************************/
void DataManager::clearList()
{
    _item_list.clear();
    updateQmlItemList();
}

void DataManager::addItem(int id, QString name, bool checked, double score, QString filepath)
{
    Item* new_item = new Item();
    new_item->update(id, name, checked, score, filepath);
    _item_list.insert(new_item);

    updateQmlItemList();
}

void DataManager::saveList(QString file_path)
{
    // Prepare file name and path
#ifdef __linux__
    file_path.remove("file://");
#elif _WIN32
    file_path.remove("file:///");
#endif
    QString full_file_path = file_path.contains(".json")? file_path : file_path.append(".json");
    qDebug() << "(DataManager) Requested save list as " << full_file_path;

    // Get the current list as JSON
    QJsonDocument doc = getItemListJson();

    // Save JSON
    QFile jsonFile(full_file_path);
    jsonFile.open(QFile::WriteOnly);
    jsonFile.write(doc.toJson());
    jsonFile.close();

    // Set new List name
    QFileInfo fileInfo(jsonFile.fileName());
    QString filename(fileInfo.fileName().remove(".json"));
    setListName(filename);
}

bool DataManager::loadList(QString file_path)
{
    if(!file_path.contains(".json"))
    {
        qCritical() << "(DataManager) Error, the file should be a JSON file";
        return false;
    }

    // Prepare file
#ifdef __linux__
    file_path.remove("file://");
#elif _WIN32
    file_path.remove("file:///");
#endif
    qDebug() << "(DataManager) Requested load the list " << file_path;

    // Load JSON file
    QFile jsonFile(file_path);
    jsonFile.open(QFile::ReadOnly);
    QJsonDocument doc = QJsonDocument().fromJson(jsonFile.readAll());

    // Parse it to the app list
    loadListFromJson(doc);

    return true;
}

/** *********************************
 *  QML Updaters
 ** ********************************/
void DataManager::updateQmlItemList()
{
    _qml_item_list.clear();
    for (ItemList::iterator it=_item_list.begin(); it!=_item_list.end(); ++it)
        _qml_item_list.append(*it);
}

/** *********************************
 *  Auxiliar functions
 ** ********************************/
QJsonDocument DataManager::getItemListJson()
{
    QJsonArray objs_array;
    for(const auto item : _item_list)
    {
        QJsonObject json_obj;
        json_obj.insert("id", item->id());
        json_obj.insert("name", item->name());
        json_obj.insert("score", item->score());
        json_obj.insert("checked", item->checked());
        json_obj.insert("filepath", item->filepath());

        objs_array.push_back(json_obj);
    }

    QJsonDocument doc(objs_array);
    //qDebug() << doc.toJson();

    return doc;
}

void DataManager::loadListFromJson(QJsonDocument doc)
{
    //qDebug() << doc.toJson();
    QJsonArray objs_array = doc.array();
    qDebug() << "Loading " << objs_array.size() << " elements";

    for(const auto value : objs_array)
    {
        QJsonObject obj = value.toObject();
        addItem(obj["id"].toInt(), obj["name"].toString(), obj["checked"].toBool(), obj["score"].toDouble(), obj["filepath"].toString());
    }
}
