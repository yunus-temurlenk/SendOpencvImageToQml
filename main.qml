import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

Window {
    width: Screen.width
    height: Screen.height
    visible: true
    title: qsTr("OpencvToQml")

    Rectangle{
        id: imageRect
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 800
        height: 600

        color: "transparent"
        border.color: "black"
        border.width: 3

        Image{
            id: opencvImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            property bool counter: false
            visible: false
            source: "image://live/image"
            asynchronous: false
            cache: false

            function reload()
            {
                counter = !counter
                source = "image://live/image?id=" + counter
            }

        }
    }

    Button{
        id: startButton
        x: imageRect.x/2 - startButton.width/2
        y:imageRect.height/6 + imageRect.y
        text: "Open"

        onClicked: {
            VideoStreamer.openVideoCamera(videoPath.text)
            opencvImage.visible = true
        }


    }

    TextField{
        id:videoPath
        x: startButton.x - startButton.width
        y: startButton.y + startButton.height * 2
        placeholderText: "Video Path or Video Index"
        cursorVisible: true

        width: startButton.width * 3



    }

    Connections{
        target: liveImageProvider

        function onImageChanged()
        {
            opencvImage.reload()
        }

    }
}
