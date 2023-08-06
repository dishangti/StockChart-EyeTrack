import cv2
import numpy as np

img1 = cv2.imread("./Sam_vgg/5463.jpg",0)
img2 = cv2.imread("./Sam_vgg_ft/5463.jpg",0)

img = np.abs(img1 - img2)
max_pix = np.max(img)
min_pix = np.min(img)

img.astype(np.float64)

img = (img - min_pix) / (max_pix - min_pix) * 255
img = 15*np.sqrt(img)   # Strenthen the difference

img.astype(np.uint8)

cv2.imwrite('5463.png', 255-  img)

#6518
#1689