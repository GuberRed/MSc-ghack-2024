#Python with Alpine Linux
FROM python:3.12.0b1-alpine3.18
WORKDIR /app
COPY requirements.txt .
# Install build dependencies
RUN apk update \
    && apk add --no-cache gcc musl-dev libffi-dev openssl-dev
RUN apk update \
    && apk add --no-cache gcc musl-dev \
    && pip install --no-cache-dir -r requirements.txt
COPY . .
#expose and run app
EXPOSE 5000
CMD ["python", "app.py"]
