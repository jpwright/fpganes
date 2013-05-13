fpgaNES - A Hardware-Based FPGA AI for Super Mario Bros. 
========================================================

An FPGA-based hardware AI for Super Mario Bros. See [NintendoNinja.com](http://www.nintendoninja.com) for more details.

The main system file is DE2_TV.v in the cam_2_vga folder. The MATLAB scripts are used for generating circular buffers of arbitrary size, and updating the references in the main system file accordingly. The Excel sprite generator is used to generate the Verilog for an arbitrary kernel.
