# Ultralytics's YOLO model containerization for model deployment on HPE MLIS
Containerize and deploy a YOLO model by Ultralytics on Kubernetes using BentoML.

## Overview

This project containerizes a YOLOv11 object detection model using BentoML for easy deployment and scaling. The service provides REST API endpoints for object detection inference.

**Note**: This method has been tested with YOLOv11 and might also work with YOLOv12 models. 

## Features

- **YOLOv11 Model**: State-of-the-art object detection using Ultralytics YOLOv11
- **BentoML Integration**: Easy model serving and containerization
- **Dual APIs**: 
  - `predict`: Batch processing with JSON output
  - `render`: Single image processing with visual output
- **GPU Support**: Configured for GPU acceleration
- **Docker Ready**: Containerized for easy deployment

## Project Structure

```
├── service.py          # BentoML service implementation
├── bentofile.yaml      # BentoML configuration
├── requirements.txt    # Python dependencies
├── Dockerfile         # Docker configuration
└── README.md          # This file
```

## Quick Start

### Prerequisites

- Python 3.11+
- Docker
- BentoML
- NVIDIA GPU (optional, for acceleration)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/caovd/yolo-ultralytics.git
cd yolo-ultralytics
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

### Build and Run

#### Using BentoML

1. Build the BentoML service:
```bash
bentoml build
```

2. Serve locally:
```bash
bentoml serve service:yolov11x --reload
```

#### Using Docker

1. Build the Docker image:
```bash
docker build -t caovd/yolo-ultralytics:latest .
```

2. Run the container:
```bash
docker run -p 3000:3000 caovd/yolo-ultralytics:latest
```

## API Usage

### Prediction API

Send POST request to `/predict` with image files:

```bash
curl -X POST "http://localhost:3000/predict" \
  -F "images=@your_image.jpg"
```

### Render API  

Send POST request to `/render` with a single image:

```bash
curl -X POST "http://localhost:3000/render" \
  -F "image=@your_image.jpg" \
  --output result.jpg
```

## Configuration

### Model Selection

Set the `YOLO_MODEL` environment variable to use different model weights. Only the model name is required (as accepted by Ultralytics YOLO()):

```bash
export YOLO_MODEL=yolov11n.pt  # For nano model
export YOLO_MODEL=yolov11s.pt  # For small model
export YOLO_MODEL=yolov11m.pt  # For medium model
export YOLO_MODEL=yolov11l.pt  # For large model
export YOLO_MODEL=yolov11x.pt  # For extra large model (default)
```

### GPU Configuration

The service is configured to use 1 GPU by default. Modify the `resources` parameter in `service.py` to adjust GPU allocation.

## Deployment

### Docker Hub

The container is available on Docker Hub:

```bash
docker pull caovd/yolo-ultralytics:latest
```

### Kubernetes

Deploy using the provided Kubernetes manifests (coming soon).

## Development

### File Descriptions

- **service.py**: Main BentoML service with two endpoints:
  - `predict()`: Batch inference returning JSON results
  - `render()`: Single image inference with visual output
- **bentofile.yaml**: BentoML configuration specifying Python version, dependencies, and Docker settings
- **requirements.txt**: Python package dependencies including ultralytics and bentoml
- **Dockerfile**: Custom Docker configuration for containerization

### Environment Variables

- `YOLO_MODEL`: Model name accepted by Ultralytics's YOLO(...) (default: yolo11x.pt)

## License

This project is licensed under the MIT License.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch  
5. Create a Pull Request

## Support

For issues and questions, please open an issue on GitHub.

