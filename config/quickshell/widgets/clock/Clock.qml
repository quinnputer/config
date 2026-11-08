import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData

        screen: modelData
        aboveWindows: false
        exclusionMode: ExclusionMode.Ignore
        color: "transparent"

        WlrLayershell.layer: WlrLayer.Background
        WlrLayershell.namespace: "wallpaper"

        anchors {
            top: true
            right: true
            bottom: true
            left: true
        }

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        Text {
            text: Qt.formatDateTime(clock.date, "hh:mm")
            layer.enabled: true
            color: "white"

            font {
                pointSize: 70
                family: "Maple Mono NF"
                weight: Font.Bold
            }

            anchors {
                top: parent.top
                topMargin: 120
                horizontalCenter: parent.horizontalCenter
            }

            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowOpacity: 0.3
            }
        }
    }
}
