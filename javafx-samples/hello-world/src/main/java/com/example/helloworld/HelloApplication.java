package com.example.helloworld;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.scene.Group;
import javafx.scene.text.Text;

public class HelloApplication extends Application {
    @Override
    public void start(Stage stage) {
        var text = new Text("Hello, world!");
        text.setLayoutX(80);
        text.setLayoutY(80);

        var group = new Group(text);
        var scene = new Scene(group);
        stage.setScene(scene);
        stage.setTitle("JavaFX Application");
        stage.setWidth(300);
        stage.setHeight(250);

        stage.show();
    }

    public static void main(String[] args) {
        launch();
    }
}
