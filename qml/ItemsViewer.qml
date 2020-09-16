/** ItemsViewer.qml
 **
 ** Simple viewer showing the preview images selected as filepath
 **
**/

import QtQuick 2.14
import QtQuick.Controls 2.14    // Popups

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
    property int imagesPixelSize: 100

    property var itemListObject: "None"

    // Set it to clip its children's painting to its bounding rectangle.
    clip: true

    CustomScrollView
    {
        id: scrollView
        anchors.fill: parent
        anchors.centerIn: parent

        enableHorizontalScroll: false
        enableVerticalScroll: true
        buttonUnpressedColor: Qt.rgba(100/255,100/255,100/255, 1)
        buttonPressedColor: Qt.rgba(85/255,85/255,85/255, 1)

        Grid
        {
            id: grid
            width: parent.width
            anchors.centerIn: parent
            spacing: 10
            columns: scrollView.width / (imagesPixelSize + spacing)

            Repeater
            {
                id: repeater
                model: root.itemListObject
                // Use "object" and "index" to access to each element

                Rectangle
                {
                    id: element
                    width: 100
                    height: 100
                    color: rowColor1

                    // Mouse controller
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
                                element.isHovered = true
                            else
                                element.isHovered = false
                        }

                        onDoubleClicked:
                        {
                            console.log("Double click over element " + index)
                            bigSizeViewer.filepath = imagePreview.source
                            bigSizeViewer.visible = true
                        }
                    }

                    // Image preview
                    Image
                    {
                        id: imagePreview
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        source: object.filepath === "no_file"?"qrc:/resources/reddit.svg":object.filepath
                        opacity: 0.7
                    }

                    // Label
                    Rectangle
                    {
                        id: elementId
                        anchors.top: parent.top
                        anchors.left: parent.left
                        height: parent.height/4
                        width: height
                        color: rowColor2
                        opacity: 0.75

                        Text
                        {
                            id: label
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: object.id
                            font.bold: true
                            color: fontColor
                            width: parent.width
                            height: parent.height
                            font.pointSize: 100
                            minimumPointSize: 10
                            fontSizeMode: Text.Fit
                        }
                    }
                }//rectangleRow
            }//repeater
        }//grid
    }//scrollview

    // Image big-size Viewer
    Popup
    {
        id: bigSizeViewer
        property string filepath: "qrc:/resources/reddit.svg"

        visible: false
        focus: true
        modal: true
        height: parent.height * 7/8
        width: parent.width * 7/8
        anchors.centerIn: parent
        background: Rectangle
        {
            anchors.fill: parent
            color: Qt.rgba(100/255,100/255,100/255, 0.5)
        }
        Image
        {
            id: imageBigSize
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            source: bigSizeViewer.filepath
            opacity: 1.0
        }
    }

}//root
