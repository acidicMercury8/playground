package com.example.helloworld;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.scene.Group;
import javafx.scene.text.Text;

public class HelloApplication extends Application {
    public static void main(String[] args) {
        System.out.println("Application: main");

        launch();
    }

    @Override
    public void init() throws Exception {
        System.out.println("Application: init");
        super.init();
    }

    @Override
    public void start(Stage stage) {
        System.out.println("Application: start");

        var unnamedParameters = getParameters().getUnnamed();
        var i = 0;

        for (var parameter: unnamedParameters) {
            i++;
            System.out.printf("%d - %s \n", i, parameter);
        }

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

    @Override
    public void stop() throws Exception {
        System.out.println("Application: stop");
        super.stop();
    }
}
