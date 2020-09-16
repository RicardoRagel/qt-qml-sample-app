#include "ItemList.h"

Item::Item():
    _id(0),
    _name("Unknown"),
    _checked(false),
    _score(0.0)
{
}

bool Item::init(int id, QString name, bool checked, double score, QString filepath)
{
    return update(id, name, checked, score, filepath);
}

void Item::setId(int value)
{
    _id = value;
}
void Item::setName(QString value)
{
    _name = value;
}

void Item::setChecked(bool value)
{
    _checked = value;
}
void Item::setScore(double value)
{
    _score = value;
}

void Item::setFilepath(QString value)
{
    _filepath = value;
}

bool Item::update(int id, QString name, bool checked, double score, QString filepath)
{
    _id = id;
    _name = name;
    _checked = checked;
    _score = score;
    _filepath = filepath;

    return true;
}
