import sys
import os

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

application = QGuiApplication(sys.argv)

engine = QQmlApplicationEngine()
engine.quit.connect(application.quit)
engine.load(os.path.join(os.path.dirname(__file__), 'Views/MainView.qml'))

sys.exit(application.exec())
