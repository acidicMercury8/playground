package com.example.helloworld;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.Group;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.FlowPane;
import javafx.stage.Stage;

public class HelloApplication extends Application {
    public static void main(String[] args) {
        launch();
    }

    @Override
    public void start(Stage stage) {
        var label = new Label("Hello");
        var button = new Button("Button");
        var group = new Group(button);

        var root = new FlowPane(label, group);
        var scene = new Scene(root);
        stage.setScene(scene);

        stage.setTitle("JavaFX Application");
        stage.setWidth(300);
        stage.setHeight(150);

        stage.show();
    }
}
