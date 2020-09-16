QT += widgets qml quick # Others usual: 3dinput positioning svg multimedia gamepad
CONFIG += c++17         # C++ Version
CONFIG += qml_debug     # Enable QML console debug
#CONFIG += resources_big # Set this flag if your resources are big and cause a compilation error

VERSION = 1.0.0         # App version as major.minor.patch
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

INCLUDEPATH += include/Core \
               include/DataLayer \
               include/Utils
HEADERS += \
    include/Core/SampleApp.h \
    include/DataLayer/Constants.h \
    include/DataLayer/DataManager.h \
    include/DataLayer/ItemList.h \
    include/Utils/QmlObjectListModel.h

SOURCES += \
    src/Core/SampleApp.cpp \
    src/DataLayer/DataManager.cpp \
    src/DataLayer/ItemList.cpp \
    src/Utils/QmlObjectListModel.cc \
    src/main.cpp

OTHER_FILES += \
    qml/CustomWidgets/CustomButton.qml \
    qml/CustomWidgets/CustomCheckBox.qml \
    qml/CustomWidgets/CustomScrollView.qml \
    qml/ItemList.qml \
    qml/ItemInput.qml \
    qml/ItemsViewer.qml \
    qml/main.qml

RESOURCES += \
    sample_app_media.qrc \
    sample_app_qml.qrc

#LIBS += -lopencv_core -lopencv_highgui -lopencv_stitching -lopencv_superres -lopencv_imgproc

# Default rules for deployment.
#qnx: target.path = /tmp/$${TARGET}/bin
#else: unix:!android: target.path = /opt/$${TARGET}/bin
#!isEmpty(target.path): INSTALLS += target
