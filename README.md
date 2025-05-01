# CUDA-at-Scale-Image-Processing-Project


## 📌 Overview

This project demonstrates **image processing at scale using CUDA**, where the task is to **convert large batches of RGB images to grayscale using a custom CUDA kernel**. The code leverages NVIDIA GPU acceleration to efficiently process multiple high-resolution images in parallel.

## 🧠 What This Project Does

- Loads images from a specified directory (`image/`).
- Uses a CUDA kernel to convert each RGB image to grayscale.
- Writes the processed grayscale image to an output directory (`image/`).
- Logs kernel execution and processing details to `output/execution_log.txt`.

This aligns with real-world use cases like image pre-processing in medical imaging, surveillance, or satellite data processing.

---

## 📁 Project Structure

/kaggle/working/ │ ├── src/ │ └── grayscale.cu # Main CUDA C++ source file with kernel │ ├── image/ │ ├── 4.1.01.tiff # Original image (input) │ ├── 4.1.01_gray.png # Processed grayscale image (output) │ └── ... # Other TIFF files │ ├── output/ │ └── execution_log.txt # Kernel logs (printed from C++) │ └── README.md # Project description and usage guide

## HOW TO COMPILE AND RUN 


### 1. Compile the CUDA Code
```bash
!nvcc /kaggle/working/src/grayscale.cu -o /kaggle/working/src/grayscale `pkg-config --cflags --libs opencv4`

### 2. Run Grayscale Conversion on an Image
!/kaggle/working/src/grayscale /kaggle/working/image/4.1.01.tiff /kaggle/working/image/4.1.01_gray.png >> /kaggle/working/output/execution_log.txt 2>&1


