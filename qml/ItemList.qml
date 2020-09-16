/** ItemList.qml
 **
 ** Simple list of elements within a scrollview.
 **
**/

import QtQuick 2.14

// Import C++ data handlers
import DataManager 1.0
import Constants 1.0

// Import other project QML scripts
import "CustomWidgets"

Rectangle
{
    id: root
    color: "transparent"
    property int fontPixelSize: 12
    property color fontColor: "white"
    property color headerBackgroundColor: "black"
    property color rowColor1: Qt.rgba(30/255,30/255,30/255, 1)
    property color rowColor2: Qt.rgba(85/255,85/255,85/255, 1)
    property int rowsHeight: 20
    property int idColumnWidth: 30
    property int nameColumnWidth: 100
    property int checkedColumnWidth: 75
    property int scoreColumnWidth: 50

    property var itemListObject: "None"

    // Set it to clip its children's painting to its bounding rectangle.
    clip: true

    /**************************************
    ** Table Header
    ***************************************/
    Rectangle
    {
        id: headerRow
        width: parent.width
        height: rowsHeight*1.5
        color: headerBackgroundColor
        anchors.top: root.top
        anchors.left: parent.left

        Row
        {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 0

            // some space
            Item
            {
                width: 10
                height: rowsHeight
            }

            //ID
            Item
            {
                width: idColumnWidth
                height: rowsHeight
                anchors.verticalCenter: parent.verticalCenter
                Text
                {
                    id: headerIDText
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    elide: Text.ElideRight
                    font.pixelSize: root.fontPixelSize
                    font.bold: true
                    color: fontColor

                    text: "ID"
                }
            }
            //NAME
            Item
            {
                width: nameColumnWidth
                height: rowsHeight
                anchors.verticalCenter: parent.verticalCenter
                Text
                {
                    id: headerNameText
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    elide: Text.ElideRight
                    font.pixelSize: root.fontPixelSize
                    font.bold: true
                    color: fontColor

                    text: "Name"
                }
            }
            //SCORE
            Item
            {
                width: scoreColumnWidth
                height: rowsHeight
                anchors.verticalCenter: parent.verticalCenter
                Text
                {
                    id: scoreNameText
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    elide: Text.ElideRight
                    font.pixelSize: root.fontPixelSize
                    font.bold: true
                    color: fontColor

                    text: "Score"
                }
            }
            //CHECKED
            Item
            {
                width: checkedColumnWidth
                height: rowsHeight
                anchors.verticalCenter: parent.verticalCenter
                Text
                {
                    id: checkedNameText
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    elide: Text.ElideRight
                    font.pixelSize: root.fontPixelSize
                    font.bold: true
                    color: fontColor

                    text: "Checked"
                }
            }
            //FILEPATH
            Item
            {
                width: headerRow.width - idColumnWidth - nameColumnWidth - scoreColumnWidth - checkedColumnWidth
                height: rowsHeight
                anchors.verticalCenter: parent.verticalCenter
                Text
                {
                    id: filepathNameText
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    elide: Text.ElideRight
                    font.pixelSize: root.fontPixelSize
                    font.bold: true
                    color: fontColor

                    text: "Image path"
                }
            }
        }

        CustomButton
        {
            id: filepathButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            height: headerRow.height
            width: height
            imgSizeFactor: 0.7

            pressedColor: rowColor1
            unpressedColor: "transparent"
            opacity: 1.0

            image_url: "qrc:/resources/delete.svg"

            onClickedChanged:
            {
                if(clicked)
                {
                    clicked = false
                    DataManager.clearList()
                }
            }
         }
    }

    /**************************************
    ** Table - Scroll View
    ***************************************/
    Rectangle
    {
        id: listSpace
        color: "transparent"
        anchors.top: headerRow.bottom
        width: parent.width
        height: parent.height - headerRow.height

        CustomScrollView
        {
            id: scrollView
            anchors.fill: parent
            anchors.centerIn: parent

            enableHorizontalScroll: false
            enableVerticalScroll: true
            buttonUnpressedColor: Qt.rgba(100/255,100/255,100/255, 1)
            buttonPressedColor: Qt.rgba(85/255,85/255,85/255, 1)

            Column
            {
                id: column
                width: parent.width
                spacing: 0

                // Content
                Repeater
                {
                    id: repeater
                    model: root.itemListObject
                    // Use "object" and "index" to access to each element

                    Rectangle
                    {
                        id: row
                        width: scrollView.width
                        height: root.rowsHeight

                        // Row color
                        property color rowColor: index % 2 == 0 ? root.rowColor1: root.rowColor2
                        color: rowColor

                        // Mouse hovering
                        property bool isHovered: false
                        border.color: isHovered? Qt.rgba(255/255,255/255,255/255, 0.5) : "transparent"
                        border.width: 1
                        MouseArea
                        {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onContainsMouseChanged:
                            {
                                if(containsMouse)
                                    row.isHovered = true
                                else
                                    row.isHovered = false
                            }
                        }

                        Row
                        {
                            id: rowContent
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 0

                            // some space
                            Item
                            {
                                width: 10
                                height: rowsHeight
                            }

                            //ID
                            Rectangle
                            {
                                id: idRectangle
                                width: idColumnWidth
                                height: rowsHeight
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                Text
                                {
                                    id: idText
                                    width: parent.width
                                    anchors.verticalCenter: parent.verticalCenter
                                    elide: Text.ElideRight
                                    font.pixelSize: root.fontPixelSize
                                    font.bold: true
                                    color: fontColor

                                    text: object.id
                                }
                            }
                            //Name
                            Rectangle
                            {
                                id: nameRectangle
                                width: nameColumnWidth
                                height: rowsHeight
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                Text
                                {
                                    id: nameText
                                    width: parent.width
                                    anchors.verticalCenter: parent.verticalCenter
                                    elide: Text.ElideRight
                                    font.pixelSize: root.fontPixelSize
                                    font.bold: true
                                    color: fontColor

                                    text: object.name
                                }
                            }
                            //Score
                            Rectangle
                            {
                                id: scoreRectangle
                                width: scoreColumnWidth
                                height: rowsHeight
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                Text
                                {
                                    id: scoreText
                                    width: parent.width
                                    anchors.verticalCenter: parent.verticalCenter
                                    elide: Text.ElideRight
                                    font.pixelSize: root.fontPixelSize
                                    font.bold: true
                                    color: fontColor

                                    text: object.score
                                }
                            }
                            //Checked
                            Rectangle
                            {
                                id: checkedRectangle
                                width: checkedColumnWidth
                                height: rowsHeight
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                Image
                                {
                                    sourceSize.height: parent.height * 0.75
                                    fillMode: Image.PreserveAspectFit
                                    anchors.centerIn: parent
                                    source: object.checked?"qrc:/resources/accept.svg":"qrc:/resources/cancel.svg"
                                    opacity: 0.7
                                }
                            }
                            //Filepath
                            Rectangle
                            {
                                id: filepathRectangle
                                width: row.width - idColumnWidth - nameColumnWidth - scoreColumnWidth - checkedColumnWidth - 30
                                height: rowsHeight
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"

                                Text
                                {
                                    id: filepathText
                                    width: parent.width
                                    anchors.verticalCenter: parent.verticalCenter
                                    elide: Text.ElideRight
                                    font.pixelSize: root.fontPixelSize
                                    font.bold: true
                                    color: fontColor

                                    text: object.filepath
                                }
                            }
                        }//row
                    }//rectangleRow
                }//repeater
            }//column
        }//scrollarea
    }//rotutinesListSpace
}
