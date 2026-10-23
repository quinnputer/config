import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData

        screen: modelData
        aboveWindows: false
        exclusionMode: ExclusionMode.Ignore

        WlrLayershell.layer: WlrLayer.Background
        WlrLayershell.namespace: "wallpaper"

        anchors {
            top: true
            right: true
            bottom: true
            left: true
        }

        Image {
            anchors.fill: parent
            asynchronous: true
            fillMode: Image.PreserveAspectCrop
            source: Config.wallpaper
        }
    }
}
