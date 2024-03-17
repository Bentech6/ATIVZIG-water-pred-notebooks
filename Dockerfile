# Python image to use.
FROM python:3.8-slim-buster

RUN apt-get update && apt-get install -y vim

# Set the working directory to /app
WORKDIR /app

# Update pip
RUN python -m pip install --upgrade pip

# copy the requirements file used for dependencies
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --ignore-installed -r requirements.txt

# Copy the rest of the working directory contents into the container at /app
COPY . .

# Add path to pythonpath
ENV PYTHONPATH=/app/

#installing jupyternotebook
RUN pip install notebook

# installing psycopg2 for communication with the sql server
RUN pip install psycopg2-binary

# This doesn't run the notebook while building, but automatically starts it, wether the container from this image has been started
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# Expose the port so that others can run the image
EXPOSE 8888/tcp
