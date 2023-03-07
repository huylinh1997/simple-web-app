# Use a lightweight base image
FROM alpine:3.14

# Install required packages
RUN apk add --no-cache python3 py3-pip

# Copy the rest of the application code into the container

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .
# Expose port 80 for the web server
EXPOSE 80

# Start the web server
CMD ["python3", "app.py"]

