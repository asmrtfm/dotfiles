#!/usr/bin/env python

from gimpfu import *

def export_pdf_pages_to_png(image, drawable, folder_path):
    # Get the number of layers
    num_layers = len(image.layers)

    # Iterate over each layer
    for i, layer in enumerate(image.layers):
        # Set the active layer
        pdb.gimp_image_set_active_layer(image, layer)

        # Create the filename with an incremented suffix
        filename = "page_{}.png".format(i + 1)

        # Export the layer as a PNG file
        file_path = "{}/{}".format(folder_path, filename)
        pdb.file_png_save_defaults(image, layer, file_path, file_path)

    # Close the image without saving changes
    gimp.quit(0)

register(
    "python-fu-export-pdf-pages-to-png",
    "Export PDF pages as individual PNG files",
    "Export each page of the PDF files imported into GIMP as individual PNG files with an incremented suffix for the page number in the exported filename.",
    "Your Name",
    "Your Name",
    "2024",
    "<Image>/File/Export PDF Pages to PNG",
    "*",
    [
        (PF_DIRNAME, "folder_path", "Output folder", "")
    ],
    [],
    export_pdf_pages_to_png)

main()
