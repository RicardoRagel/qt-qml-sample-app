#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QDebug>
#include <QString>
#include <QDir>

#include "Constants.h"
#include "ItemList.h"

// QmlObjectListModel Class, imported from the QGroundControl Project to manage easily QObject derived classes from both QML and C++ sides
#include "QmlObjectListModel.h"

using namespace std;

class DataManager : public QObject
{
  Q_OBJECT

public:

  // Constructor
  DataManager();

  // Destuctor
  ~DataManager();

  // QML properties declarations
  Q_PROPERTY(QString listName READ listName WRITE setListName NOTIFY listNameChanged)
  Q_PROPERTY(QmlObjectListModel* qmlItemList READ qmlItemList NOTIFY qmlItemListChanged)

  // QML properties getters
  QString listName() {return _list_name;}
  QmlObjectListModel* qmlItemList(){return &_qml_item_list;}

  // QML Invokable properties setters
  Q_INVOKABLE void setListName(QString list_name);

  // QML Invokable standalone functions
  Q_INVOKABLE void clearList();
  Q_INVOKABLE void addItem(int id, QString name, bool checked, double score, QString filepath);
  Q_INVOKABLE void saveList(QString file_path);
  Q_INVOKABLE bool loadList(QString file_path);

signals:

  // QML properties signals
  void listNameChanged();
  void qmlItemListChanged();

private:

  // Variables
  QString _list_name;
  ItemList _item_list;                  /** Ordered List by ID in C++ **/
  QmlObjectListModel _qml_item_list;    /** Idem list for QML access **/
  void updateQmlItemList();             /** C++ list to QML list*/

  // Aux functions
  QJsonDocument getItemListJson();
  void loadListFromJson(QJsonDocument doc);
};

#endif // DATAMANAGER_H
