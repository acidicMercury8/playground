import sys
import os

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from ViewModels.MainViewModel import MainViewModel

application = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.quit.connect(application.quit)

view_model = MainViewModel()
engine.rootContext().setContextProperty("viewModel", view_model)
engine.load(os.path.join(os.path.dirname(__file__), 'Views/MainView.qml'))

sys.exit(application.exec())
