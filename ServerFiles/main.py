import cvlib as cv
from cvlib.object_detection import draw_bbox
import cv2
import base64
import requests
import json
import time
import threading

def readData():
    url = 'https://firestore.googleapis.com/v1/projects/parkingfrontend/databases/(default)/documents/images/lotOne'
      
    #sending post request and saving response as response object 

    while True:
        resp = requests.get(url=url)
        data = resp.json()
        imgStr = data["fields"]["imageData"]["stringValue"]

        with open("imageToSave.png", "wb") as fh:
            fh.write(base64.b64decode(imgStr))
            fh.close()
        time.sleep(3)


thread1 = threading.Thread(target = readData, args = ())
thread1.start()



def numberPost(n):
    url = "http://hughboy.com:9999/number"
    #url = "https://parkingfrontend.firebaseio.com/carsNumber/data.json"
    headers = {'Content-Type': 'application/json'}
    data = {'number':n}	
    r = requests.post(url=url, headers=headers, data=json.dumps(data))

def numberImage(n):
    url = "http://hughboy.com:9999/img.png" 
    #url = "https://parkingfrontend.firebaseio.com/imageResult/data.json"
    headers = {'Content-Type': 'application/json'}
    data = {'image':n}	
    r = requests.post(url=url, headers=headers, data=json.dumps(data))


while True:
    #read input image

    image = cv2.imread("imageToSave.png")
    #image = cv2.imread("randomGooglePic.jpg")

    #apply object detection
    bbox, label, conf = cv.detect_common_objects(image)



    #draw bounding box over detected objects
    out = draw_bbox(image, bbox, label, conf)
    cv2.imwrite('resultImage.png',image)
    with open("resultImage.png", "rb") as image:
        bkl = base64.b64encode(image.read())
        bkl = str(bkl, 'utf-8')
        numberImage(bkl)
        image.close()
        
    # display output
    # press any key to close window           
    #cv2.imshow("object_detection", out)
    #cv2.waitKey()

    #save output to disk if needed

        
    countNumber = label.count("car")+label.count("motorcycle")+label.count("bus")+label.count("truck")
    numberPost(countNumber)
    print(label)
    print("Master Sam, I have counter that there is",str(countNumber)," cars!")
    time.sleep(1)
