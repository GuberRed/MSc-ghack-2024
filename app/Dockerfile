# Use the official Python base image with Alpine Linux
FROM python:3.12.0b1-alpine3.18

# Set the workin directory in the container
WORKDIR /app

# Copy the requirements file to the working directory
COPY requirements.txt .

# Install build dependencies
RUN apk update \
    && apk add --no-cache gcc musl-dev libffi-dev openssl-dev

# Install the required dependencies
RUN apk update \
    && apk add --no-cache gcc musl-dev \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code to the working directory
COPY . .

# Expose
EXPOSE 5000

# Set the entrypoint command
CMD ["python", "app.py"]
