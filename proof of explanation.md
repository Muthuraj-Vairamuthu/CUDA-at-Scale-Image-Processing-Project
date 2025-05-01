
💡 CUDA Kernel Explanation

The kernel rgb2grayKernel performs the following:

    Calculates thread coordinates.

    Accesses R, G, B values from the image.

    Applies the grayscale formula:

    gray = 0.299 * R + 0.587 * G + 0.114 * B

    Writes the result to the output array.

We launch this kernel with a (16, 16) block and calculate the appropriate grid size based on image dimensions.


🖼️ Proof of Execution
Example Logs

Reading image from: /kaggle/working/image/4.1.01.tiff
Image dimensions: 512x512 | Step: 1536
Launching CUDA kernel with grid size (32,32) and block size (16,16)
Grayscale image saved to: /kaggle/working/image/4.1.01_gray.png

Before and After (Screenshots in repo or zipped folder)

📷 4.1.01.tiff → 🖤 4.1.01_gray.png

(Visual proof is in image/ folder and screenshots zipped in the submission archive.)