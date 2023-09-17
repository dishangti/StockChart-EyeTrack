import cv2
from PyQt6.QtWidgets import QGraphicsSceneMouseEvent, QMainWindow, QMessageBox
from PyQt6.QtWidgets import QApplication
from PyQt6.QtGui import QImage, QPixmap
from PyQt6.QtWidgets import QGraphicsPixmapItem, QGraphicsScene, QGraphicsPathItem
from PyQt6.QtGui import QPainterPath, QPen, QPainter, QColor
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
            drawcolor = QColor(255, 255, 255, 160)
            pp1 = QPen()
            pp1.setColor(drawcolor)    # set a pen
            pp1.setWidth(20)
            pp2 = QPen()
            pp2.setColor(QtCore.Qt.GlobalColor.white)
            pp2.setWidth(20)
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

    def _saveDraw(self):
        self.drawscene.child.clearSelection()
        image = QImage(self.drawscene.child.sceneRect().size().toSize(), QImage.Format.Format_ARGB32)
        image.fill(QtCore.Qt.GlobalColor.black)

        painter = QPainter(image)
        self.drawscene.child.render(painter)
        image.save('./116_user.png')
        del painter
    
    def _score(self, im1, im2, threshold):
        total_cnt = (im1 >= threshold).sum()
        valid_cnd = ((im1 >= threshold) & (im2 >= threshold)).sum()
        return valid_cnd, total_cnt

    def evaluate(self):
        self._saveDraw()

        im1 = cv2.imread('./116_user.png',0)
        im2 = cv2.imread('./116_std.png',0)
        im2 = cv2.resize(im2, (im1.shape[1], im1.shape[0]), interpolation=cv2.INTER_AREA)

        thresh = 100
        score1 = self._score(im1,im2,threshold=thresh)
        score2 = self._score(im2,im1,threshold=thresh)
        print('Score1:',score1)
        print('Score2:',score2)
        if (score1[1] + score2[1]) == 0:
            score = 0
        else:
            score = ((score1[0] + score2[0]) / (score1[1] + score2[1]))*100
        print('Score:',score)

        perf = f'Your score is {round(score, 2)}.\n'
        if score >= 60:
            perf += 'You did a good job!'
        else:
            perf += 'Sorry, you seemed not to perform well.'
        QMessageBox.information(self, 'Your Performance', perf, QMessageBox.StandardButton.Ok)

    def answer(self):
        if self.isOrigin:
            self._showImage('./116_ans.png')
            self.isOrigin = False
            self.pushButton_evaluate.setEnabled(False)
            self.label.setText('Expert Attention Map')
        else:
            self.graphicsView.setScene(self.drawscene)
            self.isOrigin = True
            self.pushButton_evaluate.setEnabled(True)
            self.label.setText('Your Attention Map')

    def reset(self):
        self.drawscene = self._showOrigin('./116_origin')
        self.isOrigin = True
        self.pushButton_evaluate.setEnabled(True)
        self.label.setText('Your Attention Map')
    
    def helpinfo(self):
        # Show help message
        hlp = 'This is stock chart viewing training system.\nPaint the areas on the stock chart that you think should be focused on, and tap "Evaluate" to see your performance.\nTap "Answer" to see the expected result and "Reset" to clear your painting.'
        QMessageBox.information(self, 'Instruction', hlp, QMessageBox.StandardButton.Ok)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ui = mainWin()
    ui.show()
    sys.exit(app.exec())