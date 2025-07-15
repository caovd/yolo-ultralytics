FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY service.py .
COPY bentofile.yaml .

# Expose port
EXPOSE 8080

# Environment variable for YOLO model (can be overridden at runtime)
ENV YOLO_MODEL=yolo11x.pt

# Command to run the service
CMD ["bentoml", "serve", "service:yolo11x", "--host", "0.0.0.0", "--port", "8080"]