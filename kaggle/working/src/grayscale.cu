
#include <opencv2/opencv.hpp>
#include <iostream>

__global__ void rgb2grayKernel(unsigned char* input, unsigned char* output, int width, int height, int step) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    if (x < width && y < height) {
        int grayOffset = y * width + x;
        int rgbOffset = y * step + (3 * x);

        unsigned char r = input[rgbOffset];
        unsigned char g = input[rgbOffset + 1];
        unsigned char b = input[rgbOffset + 2];

        output[grayOffset] = static_cast<unsigned char>(0.299f * r + 0.587f * g + 0.114f * b);
    }
}

int main(int argc, char** argv) {
    if (argc != 3) {
        std::cerr << "Usage: ./grayscale <input_path> <output_path>\n";
        return 1;
    }

    std::string input_path = argv[1];
    std::string output_path = argv[2];

    cv::Mat input_image = cv::imread(input_path, cv::IMREAD_COLOR);
    if (input_image.empty()) {
        std::cerr << "Failed to read image: " << input_path << "\n";
        return 1;
    }

    int width = input_image.cols;
    int height = input_image.rows;
    int step = input_image.step;

    cv::Mat gray_image(height, width, CV_8UC1);

    unsigned char *d_input, *d_output;
    cudaMalloc(&d_input, sizeof(unsigned char) * height * step);
    cudaMalloc(&d_output, sizeof(unsigned char) * height * width);

    cudaMemcpy(d_input, input_image.ptr(), sizeof(unsigned char) * height * step, cudaMemcpyHostToDevice);

    dim3 blockSize(16, 16);
    dim3 gridSize((width + 15) / 16, (height + 15) / 16);
    rgb2grayKernel<<<gridSize, blockSize>>>(d_input, d_output, width, height, step);
    cudaDeviceSynchronize();

    cudaMemcpy(gray_image.ptr(), d_output, sizeof(unsigned char) * height * width, cudaMemcpyDeviceToHost);

    cv::imwrite(output_path, gray_image);

    cudaFree(d_input);
    cudaFree(d_output);

    return 0;
}
