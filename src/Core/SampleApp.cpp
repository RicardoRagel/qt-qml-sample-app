#include "SampleApp.h"

SampleApp* SampleApp::_app = nullptr;

SampleApp::SampleApp(int& argc, char* argv[]) : QApplication(argc, argv),
                                                _constants(nullptr),
                                                _dataManager(nullptr),
                                                _qmlAppEngine(nullptr)
{
  //qDebug()<< "(SampleApp) Constructor";
  Q_ASSERT(_app == nullptr);
  _app = this;

  // Constants Manager Class
  _constants = new Constants();

  // Main Data Manager Class
  _dataManager = new DataManager();

  // Set Application Icon
  _app->setWindowIcon(QIcon(":/resources/icon_app.png"));

  // Set Application Version
  _app->setApplicationVersion(APP_VERSION);
}

SampleApp::~SampleApp()
{

}

QObject* SampleApp::_rootQmlObject(void)
{
  return _qmlAppEngine->rootObjects()[0];
}

QObject* dataManagerQmlGlobalSingletonFactory(QQmlEngine*, QJSEngine*)
{
  return SampleApp::_app->dataManager();
}

QObject* constantsQmlGlobalSingletonFactory(QQmlEngine*, QJSEngine*)
{
  return SampleApp::_app->constants();
}

void SampleApp::initCommon(void)
{
  qDebug() << "(SampleApp) Init Common functionalities..";

  // Register Classes to be accesible from QML
  qmlRegisterUncreatableType<QmlObjectListModel>("SampleApp", 1, 0, "QmlObjectListModel", "Reference only");
  qmlRegisterSingletonType<Constants>("Constants", 1, 0, "Constants", constantsQmlGlobalSingletonFactory);
  qmlRegisterSingletonType<DataManager>("DataManager", 1, 0, "DataManager", dataManagerQmlGlobalSingletonFactory);
}

bool SampleApp::loadQmlEngine(void)
{
  qDebug() << "(SampleApp) Init QML engine";

  _qmlAppEngine = new QQmlApplicationEngine(this);

  qDebug() << "(SampleApp).. registering qml files";

  _qmlAppEngine->addImportPath("qrc:/qml");
  _qmlAppEngine->load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

  return true;
}
