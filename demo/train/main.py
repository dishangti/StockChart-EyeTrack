import typing
from PyQt6.QtWidgets import QGraphicsSceneMouseEvent, QMainWindow, QMessageBox
from PyQt6.QtWidgets import QApplication
from PyQt6.QtGui import QImage, QPixmap
from PyQt6.QtWidgets import QGraphicsPixmapItem, QGraphicsScene, QGraphicsPathItem
from PyQt6.QtGui import QPainterPath, QPen, QPainter
from PyQt6 import QtCore
from window import Ui_MainWindow
import sys

class DrawScene(QGraphicsScene):
    def __init__(self, width, height, child=None):
        super(DrawScene, self).__init__()
        self.setSceneRect(0,0,width,height)
        if child:
            child.setSceneRect(0,0,width,height)
        self.child = child

    def mousePressEvent(self, event: QGraphicsSceneMouseEvent | None) -> None:
        if event.button() == QtCore.Qt.MouseButton.LeftButton:
            self.QGraphicsPath1 = QGraphicsPathItem()
            self.QGraphicsPath2 = QGraphicsPathItem()
            self.path1 = QPainterPath()
            self.path2 = QPainterPath()
            self.path1.moveTo(event.scenePos())         # path begin
            self.path2.moveTo(event.scenePos())
            pp1 = QPen()
            pp1.setColor(QtCore.Qt.GlobalColor.white)    # set a pen
            pp1.setWidth(10)
            pp2 = QPen()
            pp2.setColor(QtCore.Qt.GlobalColor.white)
            pp2.setWidth(10)
            self.QGraphicsPath1.setPen(pp1)
            self.QGraphicsPath2.setPen(pp2)
            self.addItem(self.QGraphicsPath1)
            if self.child:
                self.child.addItem(self.QGraphicsPath2)
        return super().mousePressEvent(event)

    def mouseMoveEvent(self, event: QGraphicsSceneMouseEvent | None) -> None:
        if event.buttons() & QtCore.Qt.MouseButton.LeftButton:
            if self.path1:
                self.path1.lineTo(event.scenePos()) # Move and link points
                self.QGraphicsPath1.setPath(self.path1)
            if self.path2:
                self.path2.lineTo(event.scenePos())
                self.QGraphicsPath2.setPath(self.path2)
        return super().mouseMoveEvent(event)

    def mouseReleaseEvent(self, event: QGraphicsSceneMouseEvent | None) -> None:
        if event.button() == QtCore.Qt.MouseButton.LeftButton:
            if self.path1:
                self.path1.closeSubpath()   # End a path
            if self.path2:
                self.path2.closeSubpath()
        return super().mouseReleaseEvent(event)

class mainWin(QMainWindow, Ui_MainWindow):
    def __init__(self,parent=None):
        super(mainWin, self).__init__()
        self.setupUi(self)

        self.setFixedSize(self.width(), self.height())  # Fix window size
        self.setWindowFlags(QtCore.Qt.WindowType.WindowCloseButtonHint | QtCore.Qt.WindowType.WindowMinimizeButtonHint)

        ### Show original image
        self.drawscene = self._showOrigin('./116_origin.png')

        self.isOrigin = True

    def _showOrigin(self, imgPath):
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
        child = DrawScene(graphicWidth,graphicHeight)
        scene  = DrawScene(graphicWidth,graphicHeight, child)
        scene.addItem(item)
        self.graphicsView.setScene(scene)
        return scene

    def _showImage(self, imgPath):
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
        scene = QGraphicsScene()
        scene.setSceneRect(0,0,graphicWidth,graphicHeight)
        scene.addItem(item)
        self.graphicsView.setScene(scene)
        return scene

    def evaluate(self):
        self.drawscene.child.clearSelection()
        image = QImage(self.drawscene.child.sceneRect().size().toSize(), QImage.Format.Format_ARGB32)
        image.fill(QtCore.Qt.GlobalColor.black)

        painter = QPainter(image)
        self.drawscene.child.render(painter)
        image.save('./116_user.png')
        del painter

    def answer(self):
        if self.isOrigin:
            self._showImage('./116_ans.png')
            self.isOrigin = False
            self.pushButton_evaluate.setEnabled(False)
        else:
            self.graphicsView.setScene(self.drawscene)
            self.isOrigin = True
            self.pushButton_evaluate.setEnabled(True)

    def reset(self):
        self.drawscene = self._showOrigin('./116_origin')
        self.isOrigin = True
        self.pushButton_evaluate.setEnabled(True)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ui = mainWin()
    ui.show()
    sys.exit(app.exec())