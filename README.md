# FPGA Summer Project I @ IIT Kanpur.
* This project is designed on Xilinx XUPV5-LX110T fpga board. 
* This project has two source codes: AD9980 initilization and VGA to DVI XPS project.
* The AD9980 initilization code sets the register values(for 1024x768 @70Hz) required by VGA chip AD9980 to work properly.
  So first initiliaze the chip by uploading this code. 
* The XPS project contains two local pcores:
1. vgain: This pcore takes vga data(24-bit) from vga input port and converts it into fifo and sends it to ddr2 ram through NPI port.
2. readcop: This pcore reads the video data written on ddr2 ram using NPI port and sends it to dvi port @1024x768,70Hz.
* The XPS project also has a tests forlder for quick analysis.
Credits:
* UC Berkeley
* https://github.com/alexlee-gk/cs150/
* https://github.com/zephray/vga_to_ascii 
