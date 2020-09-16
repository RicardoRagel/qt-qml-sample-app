#ifndef ITEMLIST_H
#define ITEMLIST_H

#include <QObject>
#include <QDebug>
#include <QtQuick/QQuickItem>

#include "set"

class Item : public QObject
{
    Q_OBJECT

public:

    Item();

    bool init(int id, QString name, bool checked, double score, QString filepath);

    ~Item(){ }

    // List comparator -> Public
    double _id;          // The ID assigned to this element

    // QProperties
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(bool checked READ checked WRITE setChecked NOTIFY checkedChanged)
    Q_PROPERTY(double score READ score WRITE setScore NOTIFY scoreChanged)
    Q_PROPERTY(QString filepath READ filepath WRITE setFilepath NOTIFY filepathChanged)

    // QProperties getters
    int id(void){return _id;}
    QString name(void){return _name;}
    bool checked(void){return _checked;}
    double score(void){return _score;}
    QString filepath(void){return _filepath;}

    // QProperties setters
    Q_INVOKABLE void setId(int value);
    Q_INVOKABLE void setName(QString value);
    Q_INVOKABLE void setChecked(bool value);
    Q_INVOKABLE void setScore(double value);
    Q_INVOKABLE void setFilepath(QString value);
    Q_INVOKABLE bool update(int id, QString name, bool checked, double score, QString filepath);

signals:
    void idChanged();
    void nameChanged();
    void checkedChanged();
    void scoreChanged();
    void filepathChanged();

private:
    //double _id;       // The ID assigned to this element
    QString _name;      // Element's name
    bool _checked;      // True if it has been checked
    double _score;      // The score assigned to this element
    QString _filepath;  // Path to the file
};

struct list_items_comparation
{
    bool operator() (const Item* const& lhs_, const Item* const& rhs_) const
    {
        const Item * lhs = lhs_;
        const Item * rhs = rhs_;

        double id_1, id_2;
        id_1 = lhs->_id;
        id_2 = rhs->_id;
        return id_1 <= id_2;
    }
};

// A id-ordered list of items. WARNING: It is mandatory use Item pointers due to QObject is non-copyable
typedef std::set<Item*, list_items_comparation> ItemList;
/// Why a Item pointer? Item is derived from QObject, that is NON-COPYABLE class

#endif // ITEMLIST_H
