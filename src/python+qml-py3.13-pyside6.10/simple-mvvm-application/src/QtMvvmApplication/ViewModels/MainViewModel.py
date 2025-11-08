from PySide6.QtCore import QObject, Property, Slot

from Models.TextModel import TextModel

class MainViewModel(QObject):
    def __init__(self):
        super().__init__()
        self._model = TextModel()

    model = Property(QObject, lambda self: self._model, constant=True)

    @Slot()
    def reverse_text(self):
        self._model.text = self._model.text[::-1] # pyright: ignore[reportIndexIssue]
