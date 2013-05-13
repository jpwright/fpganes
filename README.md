fpganes
=======

An FPGA-based hardware AI for Super Mario Bros. See <a href="http://nintendoninja.com">nintendoninja.com</a> for more details.

The main system file is DE2_TV.v in the cam_2_vga folder. The MATLAB scripts are used for generating circular buffers of arbitrary size, and updating the references in the main system file accordingly. The Excel sprite generator is used to generate the Verilog for an arbitrary kernel.
