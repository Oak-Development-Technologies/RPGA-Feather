<image src="/images/RPGA_Feather_Banner.jpeg">

# RPGA-Feather

Welcome to the RPGA Feather GitHub page. This page is designed to be a single source of truth for this board, including board files like schematics, production files, BOM, and more. In addition to that, there are also a handful of examples available to build with just a little effort specifically for the RPGA Feather.

Continue reading to get started.

# Getting Started

What is the RPGA Feather? RPGA Feather is a development board which provides the ease of use of the RP2040 from Raspberry Pi with the wide open source support of the iCE40 FPGA line. RPGA Feather combines the RP2040 with an iCE5LP4K FPGA from Lattice Semiconductor which has 3520 LUTs, 2 hardware SPI and I2C blocks, a bright RGB LED driver, two internal oscillators, and 1 PLL which can be used to generate additional clocks for your designs.

RPGA Feather provides up to 11 direct GPIO connected between the RP2040 and the iCE5LP4K. This includes the 3 pins used for programming the bitstream onto the FPGA.

Having a good pinout guide can be useful for getting started. We provide this pinout card with every RPGA Feather purchased from our shop.

<image src="/images/RPGA%20Feather%20rev%20b.jpg">

You can find the PDF under the [Hardware Directory Here](/hardware/RPGA.pdf). Thanks to [@skliffmueller](https://github.com/skliffmueller) for making and sharing it.

### usage examples

We provide a few examples in this repository for getting familiar with interfacing with the iCE5LP4K FPGA.

Following the comments in the [top.v](/src/top.v) file under the `src` directory can enable you to build these specific examples quickly. Once you have the example set up in the file, you can build it using the following command:

```make
make build
```

Building requires using Yosys OSS CAD Suite, which can be found by visiting the [OSS CAD Suite build github repository](https://github.com/YosysHQ/oss-cad-suite-build). Follow the instructions for setting up the tools on your OS and you'll be good to go.

Once you have a `top.bin` file which should be in the base directory of the repository, you can simply copy it over onto your RPGA Feather `CIRCUITPY` drive. If you haven't downloaded the CircuitPython Community Bundle to get IcePython you can [head to the CircuitPython Libraries page](https://circuitpython.org/libraries) to download it, or [download the latest release directly](https://github.com/skerr92/Oakdevtech_CircuitPython_IcePython/releases).

Once you have IcePython and the `top.bin` file loaded onto your RPGA Feather, the next step is to get your code setup to load the FPGA.

Using Mu or your favorite CircuitPython compatible IDE, open up the `code.py` file and past the following code:

```py
# SPDX-FileCopyrightText: 2017 Scott Shawcroft, written for Adafruit Industries
# SPDX-FileCopyrightText: Copyright (c) 2023 Seth Kerr for Oak Development Technologies
#
# SPDX-License-Identifier: Unlicense

"""
Example showing how to program an iCE40 FPGA with circuitpython!
"""

import time
import board, busio
import oakdevtech_icepython
import gc

print("Mem Free: ",gc.mem_free(),"Mem Alloc", gc.mem_alloc())
spi = busio.SPI(clock=board.F_SCK, MOSI=board.F_MOSI, MISO=board.F_MISO)

iceprog = oakdevtech_icepython.Oakdevtech_icepython(
    spi, board.F_CSN, board.F_RST, "top.bin"
)

timestamp = time.monotonic()

iceprog.program_fpga()

endstamp = time.monotonic()
print("done in: ", (endstamp - timestamp), "seconds")

print("done")
```
Save the file and you should see the green CDONE LED light up on your board. Depending on the example you built, you might see the RGB LED light up that is next to the FPGA.

### Questions?

If you have any questions, please feel free to open an issue. Issues are a great way to raise concerns or bugs with the examples or hardware itself. And your feedback is critical to making sure we can fix issues and improve the quality of life for everyone's experience with RPGA Feather.
