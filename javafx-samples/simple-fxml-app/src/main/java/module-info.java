module com.example.simplefxmlapp {
    requires javafx.controls;
    requires javafx.fxml;

    opens com.example.simplefxmlapp to javafx.fxml;
    exports com.example.simplefxmlapp;
}
