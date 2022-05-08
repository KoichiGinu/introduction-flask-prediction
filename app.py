import os
from flask import Flask, render_template, request
import cv2
import numpy as np
from PIL import Image

app = Flask(__name__)

def load_model():
    global recognizer
    print(" * Loading pre-trained model ...")
    recognizer = cv2.face.LBPHFaceRecognizer_create()
    recognizer.read('./sample_model.yml')

    print(' * Loading end')


@app.route("/")
def hello_world():
    return render_template('./flask_api_index.html')

@app.route('/result', methods=['POST'])
def result():
    # submitした画像が存在したら処理する
    if request.files['image']:
        # 白黒画像として読み込み
        image_pil = Image.open(request.files['image']).convert('L')
        image = np.array(image_pil, 'uint8')
        # 類似度を出力
        label, predict_Confidence = recognizer.predict(image)
        predict_Confidence = str(predict_Confidence)
        # render_template('./result.html')
        return render_template('./result.html', title='類似度', predict_Confidence=predict_Confidence)

load_model()
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
