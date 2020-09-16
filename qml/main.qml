import QtQuick 2.14
import QtQuick.Window 2.3
import QtQuick.Scene3D 2.14

import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3
import QtGraphicalEffects 1.0

import QtQuick.Layouts 1.3

// Import C++ data handlers
import DataManager 1.0
import Constants 1.0

// Import other project QML scripts
import "CustomWidgets"

// App Window
ApplicationWindow
{
    id: root

    // Design
    property int verticalMargin:        50
    property int horizontalMargin:      50
    property int fontPixelSize:         12
    property color fontColor:           Qt.rgba(242/255,242/255,242/255, 1)
    property color appWindowColor:      Qt.rgba(30/255,30/255,30/255, 1)
    property color appSectionColor:     Qt.rgba(60/255,60/255,60/255, 1)
    property color appButtonPressedColor:   Qt.rgba(85/255,85/255,85/255, 1)
    property color appButtonUnpressedColor: Qt.rgba(100/255,100/255,100/255, 1)

    property int buttonSize: 30
    property color appButtonDisabledColor:  Qt.rgba(100/255,100/255,100/255, 0.2)
    property color appEditableSpaceColor:   Qt.rgba(45/255,45/255,45/255, 1)

    // Windows Configuration
    title: qsTr(Constants.appTitle)
    visible: true
    visibility : Window.Maximized
    x: 0
    y: 0
    minimumWidth: Screen.width * 0.5
    minimumHeight: Screen.height * 0.75
    color: appWindowColor

    // Manage the app starup
    Component.onCompleted:
    {
        // nothing for now
        //console.log("verticalMargin: " + verticalMargin)
        //console.log("horizontalMargin: " + horizontalMargin)
    }

    /*
        CONTENTS DIVIDED IN A SPLITVIEW
    */
    Rectangle
    {
        id: appBackground
        visible: true
        anchors.fill: parent
        color: "transparent"

        SplitView
        {
            id: appViews
            orientation: Qt.Vertical
            anchors.fill: parent

            // TOP VIEW
            Rectangle
            {
                id: view1

                Layout.fillWidth: true
                Layout.minimumHeight: 100
                height: 350

                color: "transparent"

                // Sections in a row
                Row
                {
                    anchors.centerIn: parent
                    spacing: 0

                    // Section: ADD ITEM
                    Rectangle
                    {
                        id: section1
                        width: 400
                        height: view1.height
                        anchors.verticalCenter: parent.verticalCenter
                        color: "transparent"

                        Rectangle
                        {
                            id: contentAddItem
                            visible: true
                            width: parent.width - horizontalMargin
                            height: parent.height - verticalMargin
                            anchors.centerIn: parent
                            color: appSectionColor
                            border.color: appButtonUnpressedColor
                            border.width: 1
                            radius: 5


                            // Set it to clip its children's painting to its bounding rectangle.
                            clip: true

                            Column
                            {
                                spacing: 0
                                anchors.top: parent.top
                                anchors.left: parent.left
                                Rectangle
                                {
                                    id: title
                                    width: contentAddItem.width
                                    height: fontPixelSize * 5
                                    color: "transparent"
                                    Text
                                    {
                                        id: titleAddItem
                                        text: qsTr("Add items")
                                        font.bold: true
                                        font.pixelSize: fontPixelSize * 1.5
                                        color: fontColor
                                        anchors.left: parent.left
                                        anchors.leftMargin: horizontalMargin/2
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                Rectangle
                                {
                                    width: contentAddItem.width
                                    height: 180
                                    color: "transparent"

                                    ItemInput
                                    {
                                        id: itemInput
                                        width: parent.width - horizontalMargin - 25
                                        height: parent.height
                                        anchors.centerIn: parent

                                        fontPixelSize: root.fontPixelSize
                                        fontColor: root.fontColor
                                        editableSpaceColor: root.appEditableSpaceColor
                                        buttonPressedColor: root.appButtonPressedColor
                                        buttonUnpressedColor: root.appButtonUnpressedColor
                                        buttonSize: root.buttonSize
                                    }
                                }
                            }
                        }
                    }

                    // Section: Item List
                    Rectangle
                    {
                        id: section2
                        width: view1.width - section1.width
                        height: view1.height
                        anchors.verticalCenter: parent.verticalCenter
                        color: "transparent"

                        Rectangle
                        {
                            id: contentItemList
                            visible: true
                            width: parent.width - horizontalMargin
                            height: parent.height - verticalMargin
                            anchors.centerIn: parent
                            color: appSectionColor
                            border.color: appButtonUnpressedColor
                            border.width: 1
                            radius: 5

                            // Set it to clip its children's painting to its bounding rectangle.
                            clip: true
                            Column
                            {
                                spacing: 0
                                anchors.top: parent.top
                                anchors.left: parent.left
                                Rectangle
                                {
                                    id: titleList
                                    width: contentItemList.width
                                    height: fontPixelSize * 5
                                    color: "transparent"
                                    Text
                                    {
                                        id: titleListText
                                        text: DataManager.listName
                                        font.bold: true
                                        font.pixelSize: fontPixelSize * 1.5
                                        color: fontColor
                                        anchors.left: parent.left
                                        anchors.leftMargin: horizontalMargin/2
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                Rectangle
                                {
                                    width: contentItemList.width - horizontalMargin
                                    height: contentItemList.height -  titleList.height - verticalMargin/2
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "transparent"

                                    ItemList
                                    {
                                        id: itemList
                                        anchors.fill: parent

                                        fontPixelSize: root.fontPixelSize
                                        fontColor: root.fontColor
                                        headerBackgroundColor: appButtonUnpressedColor
                                        rowColor1: appWindowColor
                                        rowColor2: appButtonPressedColor
                                        itemListObject: DataManager.qmlItemList
                                    }
                                }
                            }
                        }
                    }
                }

            }//view1

            // BOTTOM VIEW
            Rectangle
            {
                id: view2

                Layout.fillWidth: true
                Layout.minimumHeight: 100
                Layout.fillHeight: true
                color: "transparent"

                Rectangle
                {
                    id: contentItemsViewer
                    visible: true
                    width: parent.width - horizontalMargin
                    height: parent.height - verticalMargin
                    anchors.centerIn: parent
                    color: appSectionColor
                    border.color: appButtonUnpressedColor
                    border.width: 1
                    radius: 5

                    // Set it to clip its children's painting to its bounding rectangle.
                    clip: true

                    ItemsViewer
                    {
                        id: itemsViewer
                        width: parent.width - horizontalMargin
                        height: parent.height - verticalMargin
                        anchors.centerIn: parent

                        fontPixelSize: root.fontPixelSize
                        fontColor: root.fontColor
                        headerBackgroundColor: appButtonUnpressedColor
                        rowColor1: appWindowColor
                        rowColor2: appButtonPressedColor
                        itemListObject: DataManager.qmlItemList
                    }
                }
            }//view2


        }//splitview
    }//background


    /*
        APP MENU TOP BAR
    */
    menuBar: MenuBar
    {
        id: menuBar

        style: MenuBarStyle
        {
            background: Rectangle
            {
                color: "lightgray"
            }
        }

        Menu
        {
            title: "File"

            MenuItem
            {
                id: saveListItem
                text: "Save list"
                iconSource: "qrc:/resources/save.svg"
                checkable: false
                enabled: true
                onTriggered:
                {
                    console.log("Requesting to save the list")
                    saveDialog.visible = true
                }
            }

            MenuItem
            {
                id: loadListItem
                text: "Load list"
                iconSource: "qrc:/resources/import.svg"
                checkable: false
                enabled: true
                onTriggered:
                {
                    console.log("Requesting to load a list")
                    loadDialog.visible = true
                }
            }

            MenuSeparator{}

            MenuItem
            {
                id: exitAppItem
                text: "Exit"
                checkable: false
                enabled: true
                onTriggered:
                {
                    console.log("Requesting close app")
                    root.close()
                }
            }
        }

        Menu
        {
            title: "Help"

            MenuItem
            {
                text: "About..."
                onTriggered:
                {
                    aboutBox.open()
                }
            }
            MessageDialog
            {
                id: aboutBox
                title: "About this Application"
                text: " <b>Sample App</b>" +
                      " is an Qt application that provides a template" +
                      " to create another Qt and QML application.<br>" +
                      " <br>" +
                      " <b>Author</b>  Ricardo Ragel <br>" +
                      " <b>Contact</b> ricardoragel4@gmail.com<br>" +
                      " <br>" +
                      " <b>Build</b> with Qt 5.14.1 and QtCreator<br>" +
                      " <b>Version</b> " + Qt.application.version + "<br>"
                icon: StandardIcon.Information
            }
        }
    }

    /*
        EXTERNAL WINDOWS
    */
    // filepath Button -> File selector
    FileDialog
    {
        id: saveDialog
        title: "Save your list as JSON"
        selectFolder: false
        selectExisting: false
        onAccepted:
        {
            console.log("You chose the file: " + saveDialog.fileUrls[0])
            DataManager.saveList(saveDialog.fileUrls[0])
        }
        onRejected:
        {
            console.log("Canceled")
        }

        Component.onCompleted:
        {
            visible = false
            nameFilters = [ "JSON AppList (*.json)" ]
        }
    }

    FileDialog
    {
        id: loadDialog
        title: "Open a json list file"
        selectFolder: false
        selectExisting: true
        onAccepted:
        {
            console.log("You chose the file: " + loadDialog.fileUrls[0])
            DataManager.loadList(loadDialog.fileUrls[0])
        }
        onRejected:
        {
            console.log("Canceled")
        }

        Component.onCompleted:
        {
            visible = false
            nameFilters = [ "JSON AppList (*.json)" ]
        }
    }
}
