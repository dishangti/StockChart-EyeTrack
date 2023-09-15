from PyQt6.QtWidgets import QMainWindow, QMessageBox
from PyQt6.QtWidgets import QApplication
from PyQt6.QtGui import QImage, QPixmap
from PyQt6.QtWidgets import QGraphicsPixmapItem, QGraphicsScene
from window import Ui_MainWindow
import sys

class mainWin(QMainWindow, Ui_MainWindow):
    def __init__(self,parent=None):
        super(mainWin, self).__init__()
        self.setupUi(self)
    
    def evaluate():
        pass

    def answer():
        pass

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ui = mainWin()
    ui.show()
    sys.exit(app.exec())