import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    title: "Application"
    width: 300
    height: 200
    visible: true

    ColumnLayout {
        spacing: 10
        anchors.fill: parent
        anchors.margins: 20

        TextField {
            id: textField
            placeholderText: "Enter text"
            text: viewModel.model.text
            onTextChanged: viewModel.model.text = text
            Layout.fillWidth: true
        }

        Button {
            text: "Reverse text"
            onClicked: viewModel.reverse_text()
            Layout.fillWidth: true
        }

        Text {
            text: "Text: " + viewModel.model.text
            Layout.fillWidth: true
            font.pixelSize: 14
        }
    }
}
