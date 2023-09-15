import typing
from PyQt6.QtWidgets import QGraphicsSceneMouseEvent, QMainWindow, QMessageBox
from PyQt6.QtWidgets import QApplication
from PyQt6.QtGui import QImage, QPixmap
from PyQt6.QtWidgets import QGraphicsPixmapItem, QGraphicsScene, QGraphicsPathItem
from PyQt6.QtGui import QPainterPath, QPen
from PyQt6 import QtCore
from window import Ui_MainWindow
import sys

class DrawScene(QGraphicsScene):
    def __init__(self, width, height):
        super(DrawScene, self).__init__()
        self.setSceneRect(0,0,width,height)

    def mousePressEvent(self, event: QGraphicsSceneMouseEvent | None) -> None:
        if event.button() == QtCore.Qt.MouseButton.LeftButton:
            self.QGraphicsPath = QGraphicsPathItem()
            self.path1 = QPainterPath()
            self.path1.moveTo(event.scenePos())         # path begin
            pp = QPen()
            pp.setColor(QtCore.Qt.GlobalColor.white)    # set a pen
            pp.setWidth(10)
            self.QGraphicsPath.setPen(pp)
            self.addItem(self.QGraphicsPath)
        return super().mousePressEvent(event)

    def mouseMoveEvent(self, event: QGraphicsSceneMouseEvent | None) -> None:
        if event.buttons() & QtCore.Qt.MouseButton.LeftButton:
            if self.path1:
                self.path1.lineTo(event.scenePos()) # Move and link points
                self.QGraphicsPath.setPath(self.path1)
        return super().mouseMoveEvent(event)

    def mouseReleaseEvent(self, event: QGraphicsSceneMouseEvent | None) -> None:
        if event.button() == QtCore.Qt.MouseButton.LeftButton:
            if self.path1:
                self.path1.closeSubpath()   # End a path
        return super().mouseReleaseEvent(event)

class mainWin(QMainWindow, Ui_MainWindow):
    def __init__(self,parent=None):
        super(mainWin, self).__init__()
        self.setupUi(self)

        self.setFixedSize(self.width(), self.height())  # Fix window size
        self.setWindowFlags(QtCore.Qt.WindowType.WindowCloseButtonHint | QtCore.Qt.WindowType.WindowMinimizeButtonHint)

        ### Show original image
        self.drawscene = self._showImage('./116_origin.png', True)

        self.isOrigin = True
    
    def _showImage(self, imgPath, drawable):
        """
        Image should be scaled as 16:9
        """
        frame = QImage(imgPath)
        rcontent = self.graphicsView.contentsRect()
        graphicWidth = rcontent.width()
        graphicHeight = rcontent.height()
        scaled = frame.scaled(graphicWidth, graphicHeight, QtCore.Qt.AspectRatioMode.IgnoreAspectRatio, QtCore.Qt.TransformationMode.SmoothTransformation)
        pix = QPixmap.fromImage(scaled)
        item = QGraphicsPixmapItem(pix)
        if drawable:
            scene  = DrawScene(graphicWidth,graphicHeight)
        else:
            scene = QGraphicsScene()
            scene.setSceneRect(0,0,graphicWidth,graphicHeight)
        scene.addItem(item)
        self.graphicsView.setScene(scene)
        return scene

    def evaluate(self):
        pass

    def answer(self):
        if self.isOrigin:
            self._showImage('./116_ans.png', False)
            self.isOrigin = False
            self.pushButton_evaluate.setEnabled(False)
        else:
            self.graphicsView.setScene(self.drawscene)
            self.isOrigin = True
            self.pushButton_evaluate.setEnabled(True)

    def reset(self):
        self.drawscene = self._showImage('./116_origin')
        self.isOrigin = True
        self.pushButton_evaluate.setEnabled(True)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ui = mainWin()
    ui.show()
    sys.exit(app.exec())