from fastapi import FastAPI, UploadFile, File
import tensorflow as tf
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.image import load_img, img_to_array
import numpy as np
import io
from PIL import Image

app = FastAPI()

# Load the trained model
model = load_model('articleType_Model.ipynb')

# Preprocessing function
def preprocess_image(image: Image.Image):
    image = image.resize((224, 224))  # Resize to match the model input size
    image = img_to_array(image)
    image = np.expand_dims(image, axis=0)
    image = image / 255.0  # Normalize to [0, 1] range
    return image

# Prediction endpoint
@app.post("/predict/")
async def predict(file: UploadFile = File(...)):
    # Read the image file
    contents = await file.read()
    image = Image.open(io.BytesIO(contents))
    # Preprocess the image
    image = preprocess_image(image)
    # Make prediction
    prediction = model.predict(image)
    # Return the prediction result
    return {"prediction": prediction.tolist()}

# Run the API
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
