# Use an official Python runtime as a parent image
FROM python:3.12.0-slim
 
# Install git (needed if you are pulling packages from git repositories)
RUN apt-get update && apt-get install -y git

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Copy the Jupyter server configuration file into the container
COPY C:/Users/itShop/.jupyter/jupyter_server_config.py /root/.jupyter/jupyter_server_config.py

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 8888

# Run Jupyter Notebook
CMD ["jupyter", "notebook", "--config=/root/.jupyter/jupyter_server_config.py"]
