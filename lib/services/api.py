from flask import Flask, request, jsonify
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.image import img_to_array, load_img
import numpy as np
import os

app = Flask(__name__)


model_path = "/content/drive/MyDrive/images harvest/64bs 50epochs 2023-04-14 07_43.keras"
model = load_model(model_path)


test_dir = "/content/drive/MyDrive/images harvest/Test"
class_names = sorted(os.listdir(test_dir))

def predict_image(img_path):

    img = load_img(img_path, target_size=(256, 256))
    img_array = img_to_array(img)
    img_array = img_array / 255.0
    img_array = np.expand_dims(img_array, axis=0)


    predictions = model.predict(img_array)
    predicted_class_index = np.argmax(predictions)
    probability = np.amax(predictions) * 100
    predicted_class = class_names[predicted_class_index]

    return predicted_class, probability

@app.route('/predict', methods=['POST'])
def predict():
    try:

        if 'image' not in request.files:
            return jsonify({'error': 'No image provided'})

        file = request.files['image']


        temp_path = '/tmp/temp_image.jpg'
        file.save(temp_path)


        predicted_class, probability = predict_image(temp_path)


        result = {
            'class': predicted_class,
            'probability': round(probability, 4)
        }
        return jsonify(result)

    except Exception as e:
        return jsonify({'error': str(e)})


# Configurar o túnel Ngrok
public_url = ngrok.connect(5000)
print(" * Ngrok Tunnel:", public_url)

if __name__ == '__main__':
    app.run()