# Use an official Python runtime as a parent image
FROM python:3.12.0

# Install git and other dependencies
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Create a new user
RUN useradd -m jupyteruser

# Set the working directory in the container
WORKDIR /home/jupyteruser/app

# Copy the current directory contents into the container at /home/jupyteruser/app
COPY . .

# Change ownership of the working directory
RUN chown -R jupyteruser:jupyteruser /home/jupyteruser/app

# Switch to the new user
USER jupyteruser

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 8888

# Run Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
