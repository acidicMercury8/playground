from PySide6.QtCore import QObject, Property, Signal

class TextModel(QObject):
    def __init__(self) -> None:
        super().__init__()

        self._text = "Текст"

    text_changed = Signal()

    @Property(str, notify=text_changed)
    def text(self): # pyright: ignore[reportRedeclaration]
        return self._text

    @text.setter
    def text(self, value):
        if self._text != value:
            self._text = value
            self.text_changed.emit()
