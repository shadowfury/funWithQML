// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Cursor 1.0

Rectangle {
    id:mainRect
    width: 500
    height: 500
    color:"#800000FF"
    signal testSig()
    focus: true

    /*CursorShapeArea {
        anchors.fill: parent
        anchors.margins: 50
        cursorShape: Qt.OpenHandCursor
      }*/

    Text {
        id: winText
        visible: false

        property real count: 0

        text: '<font color="#f7d303"> You ate peach!! </font>'
                    font.pixelSize: 14
                    textFormat: Text.StyledText

        states:
            State{
                name: "nomnomnom"

                PropertyChanges {
                    target: winText
                    x:area1.mouseX+60
                    y:area1.mouseY-60
                    font.pointSize: 11
                    visible:true

                }
            }
            State {
                name: "chasing"
                PropertyChanges {
                    target: winText
                    visible:false
                }
            }
            transitions: [
                Transition {
                    from: "chasing"
                    to: "nomnomnom"
                    NumberAnimation { properties: "x"; from: rectangle1.x+rectangle1.width/2; to: score.x ; duration: 150 }
                    NumberAnimation { properties: "y"; from: rectangle1.y+rectangle1.height/2; to:score.y ; duration: 150 }

                }
            ]
     }
    Text {
        id: score
        anchors { right: parent.right; topMargin: 3; rightMargin: 11; top: parent.top}
        text: "SCORE: "+ winText.count
    }

    property bool key_W_pressed:false
    property bool key_A_pressed:false
    property bool key_D_pressed:false
    property bool key_S_pressed:false



    Keys.onPressed: {
        console.log("any key pressed")

        if ( event.key == Qt.Key_W ) key_W_pressed=true;
        if ( event.key == Qt.Key_A ) key_A_pressed=true;
        if ( event.key == Qt.Key_D ) key_D_pressed=true;
        if ( event.key == Qt.Key_S ) key_S_pressed=true;

        /*if ( event.key == Qt.Key_W ){ key_W_pressed=true; console.log("W pressed")}
        if ( event.key == Qt.Key_A ){ key_A_pressed=true; console.log("A pressed")}
        if ( event.key == Qt.Key_D ){ key_D_pressed=true; console.log("D pressed")}
        if ( event.key == Qt.Key_S ){ key_S_pressed=true; console.log("S pressed")}//*/

        var speed=5
        //rectangle1.color = "#8000FF00"
        var angle=(rectangle1.rotation+180)* Math.PI / 180


        if (key_W_pressed){
            if (Math.abs(rectangle1.x+rectangle1.width/2-area1.mouseX) <= Math.abs((speed+45)*Math.cos(angle)) &&
                    Math.abs(rectangle1.y+rectangle1.height/2-area1.mouseY) <= Math.abs((speed+45)*Math.sin(angle))){
                if (winText.state=="chasing"){
                    winText.state="nomnomnom"
                    winText.count++

                }

                //inText.state="chasing"
            }
            else{
                winText.state="chasing"
                rectangle1.x+=speed*Math.cos(angle)
                rectangle1.y+=speed*Math.sin(angle)
            }
        }
        if (key_A_pressed){
            rectangle1.rotation-=speed*2
        }
        if (key_S_pressed){
            rectangle1.x-=speed*Math.cos(angle)
            rectangle1.y-=speed*Math.sin(angle)
        }
        if (key_D_pressed){
            rectangle1.rotation+=speed*2
        }
        //event.accepted = true;

    }

    Keys.onReleased: {
        if ( event.key == Qt.Key_W ) key_W_pressed=false;
        if ( event.key == Qt.Key_A ) key_A_pressed=false;
        if ( event.key == Qt.Key_D ) key_D_pressed=false;
        if ( event.key == Qt.Key_S ) key_S_pressed=false;

        /*if ( event.key == Qt.Key_W ){ key_W_pressed=false; console.log("W released")}
        if ( event.key == Qt.Key_A ){ key_A_pressed=false; console.log("A released")}
        if ( event.key == Qt.Key_D ){ key_D_pressed=false; console.log("D released")}
        if ( event.key == Qt.Key_S ){ key_S_pressed=false; console.log("S released")}//*/
        //rectangle1.color = "#800000FF"
    }


    MouseArea {

        id: area1
        hoverEnabled: true
        anchors.fill: parent
        onClicked: {
            mainRect.testSig()
            rectangle1.visible=true

        }

        onPressed:{
            console.log("Key_A "+mainRect.key_A_pressed)
            console.log("Key_W "+mainRect.key_W_pressed)
            console.log("Key_S "+mainRect.key_S_pressed)
            console.log("Key_D "+mainRect.key_D_pressed)
        }//*/
        onReleased: {

        }


        onMousePositionChanged:  {
            // figuring out rotation angle
            winText.state="chasing"

            var Ax=rectangle1.x+rectangle1.width/2
            var Ay=rectangle1.y+rectangle1.height/2
            var Bx=mouseX
            var By=mouseY
            var AB=Math.sqrt(Math.pow(Ax-Bx,2)+Math.pow(Ay-By,2))
            var Cx=Ax-AB
            var Cy=Ay//+AB
            var BC=Math.sqrt(Math.pow(Cx-Bx,2)+Math.pow(Cy-By,2))
            var angle=2*Math.asin((BC/2)/AB)*180/Math.PI


            if (mouseY >= Ay) rectangle1.rotation=-angle
            else rectangle1.rotation=angle


            //console.log(rectangle1.rotation)

        }


        Rectangle {
            width: animation.width; height: animation.height

            id: rectangle1
            property real scaleFactor: 1
            x:200; y:200
            property real speed: 5

            //height: 40 * scaleFactor
            //width: 60 * scaleFactor
            color: "#00000000"


            //anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                AnimatedImage{
                    id: animation
                    x: 0
                    y: 0
                    width: 250
                    height: 182
                    source: "qrc:/images/tumblr_mlj1noI43H1rl43djo1_500.gif"

                }
                id: area2
                drag.target: rectangle1
                drag.axis: Drag.XandYAxis
                //hoverEnabled: true
                anchors.fill: parent
                onDoubleClicked: {
                    rectangle1.visible=false
                }
                onPressed: {
                    rectangle1.color = "#8000FF00"
                }
                onReleased: {
                    //rectangle1.color = "#800000FF"
                    rectangle1.color= "#00000000"
                }

            }


        }


    }    
}
