DE2_Tv
------

This design converts DVD video into a format suitable for display on a CRT/LCD monitor. A DVD video source, such as a DVD player, should be connected to the VIDEO IN port on the DE2 board. A CRT/LCD monitor should be connected to the VGA port. The DVD video should be displayed on the monitor.

Initially, the video may be shifted vertically; press KEY0 to force the design to resynchronize.

Running the Design
------------------

1) Launch the Quartus II software.
2) Open the DE2_Tv.qpf project located in the <install path>\DE2_Tv folder. (File menu -> Open Project)
3) Open the Programmer window. (Tools menu -> Programmer)
4) The DE2_Tv.sof programming file should be listed.
   Check the 'Program/Configure' box and set up the JTAG programming hardware connection via the 'Hardware Setup' button.
5) Press 'Start' to start programming. The design should now be programmed and running.

User Inputs to the Design
-------------------------

KEY0: resets the circuit and resynchronizes with the input video

Compiling the Design
--------------------

1) Launch the Quartus II software.
2) Open the DE2_Tv.qpf project located in the <install path>\DE2_Tv folder. (File menu -> Open Project)
3) Start compilation. (Processing -> Start Compilation)
4) After compilation is finished, you can run the design with the generated SOF file. See 'Running the Design' above.
