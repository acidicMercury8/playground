package com.example.simplefxmlapp;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;

public class HelloController {
    @FXML
    private Button button;

    @FXML
    private void click(ActionEvent event) {
        button.setText("Clicked!");
    }
}
