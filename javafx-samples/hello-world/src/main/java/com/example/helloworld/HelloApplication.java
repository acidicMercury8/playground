package com.example.helloworld;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.Group;
import javafx.scene.control.Button;
import javafx.stage.Stage;

public class HelloApplication extends Application {
    public static void main(String[] args) {
        launch();
    }

    @Override
    public void start(Stage stage) {
        var button = new Button();
        button.setText("Button");
        button.setOnAction(actionEvent -> button.setText("Clicked!"));

        var group = new Group(button);
        var scene = new Scene(group);
        stage.setScene(scene);

        stage.setTitle("JavaFX Application");
        stage.setWidth(300);
        stage.setHeight(150);

        stage.show();
    }
}
