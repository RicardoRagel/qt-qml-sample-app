/** ItemInput.qml
 **
 ** Panel for introducing new elements
 **
**/

import QtQuick 2.14
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3

// Import other project QML scripts
import "CustomWidgets"

// Import C++ data handlers
import DataManager 1.0

Rectangle
{
    id: root
    color: "transparent"
    property int fontPixelSize: 12
    property color fontColor: "white"
    property int rowsHeight: 20
    property int cellsLength: root.width/2
    property int buttonSize: 20
    property color editableSpaceColor: "black"
    property color buttonPressedColor: "gray"
    property color buttonUnpressedColor: "black"

    // Set it to clip its children's painting to its bounding rectangle.
    clip: true

    // Column of the table + buttons
    Column
    {
        spacing: 20
        anchors.centerIn: parent

        // Column of the table rows
        Column
        {
            id: dataInputRow
            anchors.horizontalCenter: parent.Center
            spacing: 5

            //ID
            Row
            {
                anchors.left: parent.left
                spacing: 0
                Rectangle
                {
                    width: cellsLength
                    height: rowsHeight
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter

                    Text
                    {
                        id: idText
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        font.pixelSize: root.fontPixelSize
                        font.bold: true
                        color: fontColor

                        text: "ID "
                    }
                }
                Rectangle
                {
                    width: cellsLength
                    height: rowsHeight
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter

                    TextField
                    {
                        id: idInput
                        anchors.verticalCenter: parent.verticalCenter
                        style: TextFieldStyle
                        {
                            background: Rectangle
                            {
                                color: editableSpaceColor
                                radius: 1
                            }
                            textColor: fontColor
                        }
                        font.pixelSize: root.fontPixelSize
                        horizontalAlignment: TextInput.AlignHCenter
                        verticalAlignment: TextInput.AlignVCenter

                        width: cellsLength
                        height: rowsHeight
                        text: '0'
                        validator: IntValidator {bottom: 0; top: 100;}
                    }
                }
            }

            //Name
            Row
            {
                anchors.left: parent.left
                spacing: 0

                Rectangle
                {
                    width: cellsLength
                    height: rowsHeight
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter

                    Text
                    {
                        id: nameText
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        font.pixelSize: root.fontPixelSize
                        font.bold: true
                        color: fontColor

                        text: "Name "
                    }
                }
                Rectangle
                {
                    width: cellsLength
                    height: rowsHeight
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter

                    TextField
                    {
                        id: nameInput
                        anchors.verticalCenter: parent.verticalCenter
                        style: TextFieldStyle
                        {
                            background: Rectangle
                            {
                                color: editableSpaceColor
                                radius: 1
                            }
                            textColor: fontColor
                        }
                        font.pixelSize: root.fontPixelSize
                        horizontalAlignment: TextInput.AlignHCenter
                        verticalAlignment: TextInput.AlignVCenter

                        width: cellsLength
                        height: rowsHeight
                        text: 'Unknown'
                    }
                }
            }

            //Score
            Row
            {
                anchors.left: parent.left
                spacing: 0

                Rectangle
                {
                    width: cellsLength
                    height: rowsHeight
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter

                    Text
                    {
                        id: scoreText
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        font.pixelSize: root.fontPixelSize
                        font.bold: true
                        color: fontColor

                        text: "Score "
                    }
                }
                Rectangle
                {
                    width: cellsLength
                    height: rowsHeight
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    TextField
                    {
                        id: scoreInput
                        anchors.verticalCenter: parent.verticalCenter
                        style: TextFieldStyle
                        {
                            background: Rectangle
                            {
                                color: editableSpaceColor
                                radius: 1
                            }
                            textColor: fontColor
                        }
                        font.pixelSize: root.fontPixelSize
                        horizontalAlignment: TextInput.AlignHCenter
                        verticalAlignment: TextInput.AlignVCenter

                        width: cellsLength
                        height: rowsHeight
                        text: '0.0'
                        validator: DoubleValidator {bottom: 0; top: 100;}
                    }
                }
            }

            //Checked
            Row
            {
                anchors.left: parent.left
                spacing: 0

                Rectangle
                {
                    width: cellsLength
                    height: rowsHeight
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    Text
                    {
                        id: checkedText
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        font.pixelSize: root.fontPixelSize
                        font.bold: true
                        color: fontColor

                        text: "Checked "
                    }
                }
                Rectangle
                {
                    width: cellsLength
                    height: rowsHeight
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    CustomCheckBox
                    {
                        id: checkedInput
                        anchors.verticalCenter: parent.verticalCenter

                        font.pixelSize: root.fontPixelSize

                        box_width: fontPixelSize * 1.25
                        checked: false
                    }
                }
            }

            //Filepath
            Row
            {
                anchors.left: parent.left
                spacing: 0

                Rectangle
                {
                    width: cellsLength
                    height: rowsHeight
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter

                    Text
                    {
                        id: filepathText
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        font.pixelSize: root.fontPixelSize
                        font.bold: true
                        color: fontColor

                        text: "Image path "
                    }
                }
                Rectangle
                {
                    width: cellsLength
                    height: rowsHeight
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter

                    Row
                    {
                        id: filepathRow
                        spacing: 5
                        TextField
                        {
                            id: filepathInput
                            anchors.verticalCenter: parent.verticalCenter
                            style: TextFieldStyle
                            {
                                background: Rectangle
                                {
                                    color: editableSpaceColor
                                    radius: 1
                                }
                                textColor: fontColor
                            }
                            font.pixelSize: root.fontPixelSize
                            horizontalAlignment: TextInput.AlignHCenter
                            verticalAlignment: TextInput.AlignVCenter

                            width: cellsLength - filepathRow.spacing - filepathButton.width
                            height: rowsHeight
                            text: 'no_file'
                        }
                        CustomButton
                        {
                            id: filepathButton
                            anchors.verticalCenter: parent.verticalCenter
                            width: rowsHeight
                            height: rowsHeight
                            imgSizeFactor: 0.8

                            pressedColor: buttonPressedColor
                            unpressedColor: buttonUnpressedColor
                            opacity: 1.0

                            image_url: "qrc:/resources/folder.svg"

                            onClickedChanged:
                            {
                                if(clicked)
                                {
                                    clicked = false
                                    fileDialog.visible = true
                                }
                            }
                         }
                    }
                }
            }
        }//column

        // Button
        Row
        {
            spacing: 10
            anchors.right: parent.right

            CustomButton
            {
                id: acceptButton
                anchors.verticalCenter: parent.verticalCenter
                width: buttonSize
                height: buttonSize
                imgSizeFactor: 0.7

                pressedColor: buttonPressedColor
                unpressedColor: buttonUnpressedColor
                image_url: "qrc:/resources/accept.svg"

                onClickedChanged:
                {
                    if(clicked)
                    {
                        clicked = false
                        console.log("Adding new element")

                        DataManager.addItem(idInput.text, nameInput.text, checkedInput.checked, scoreInput.text, filepathInput.text)
                    }
                }
            }
            CustomButton
            {
                id: cancelButton
                anchors.verticalCenter: parent.verticalCenter
                width: buttonSize
                height: buttonSize
                imgSizeFactor: 0.5

                pressedColor: buttonPressedColor
                unpressedColor: buttonUnpressedColor
                image_url: "qrc:/resources/cancel.svg"

                onClickedChanged:
                {
                    if(clicked)
                    {
                        clicked = false
                        console.log("Cancelling data input")

                        idInput.text = "0"
                        nameInput.text = "Unknown"
                        checkedInput.checked = false
                        scoreInput.text = "0.0"
                    }
                }
            }
        }
    }

    // filepath Button -> File selector
    FileDialog
    {
        id: fileDialog
        title: "Please choose an image file"
        selectFolder: false
        onAccepted:
        {
            console.log("You chose the file: " + fileDialog.fileUrls[0])
            filepathInput.text = fileDialog.fileUrls[0]
        }
        onRejected:
        {
            console.log("Canceled")
        }

        Component.onCompleted:
        {
            visible = false
            nameFilters = [ "Images (*.bmp *.jpeg *.jpg)", "All files (*)" ]
        }
    }
}
