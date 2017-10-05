Written By Ji Hoon Jang

Before you use GUI programs described below, you need to download ky_tools, which are necessary functions to control hydrophone/oscilloscope/xyz stage. Contact Ji Hoon Jang (diazero@stanford.edu)

Each folder has related manual, figure and code file. Please read the manual first.

1. gui_cmut_characterization
	a. gui_motor_calibration : Get 32x32 CMUT array's element pad position
	b. gui_impedance : Load the element pad position and control the motorized positioner and impedance analyzer to acquire the impedance of 32x32 CMUT elements
	c. gui_analyze : Load and analyze the saved impedance data

2. gui_gpib : Turn on/off the power supply(VDD, HVDD, HVREF and HV_CMUT) sequentially for Imaging mode and HIFU mode

3. gui_HIFU : Control and measure 8 HIFU channels phase and amplitude

4. gui_uniformity : Move hydrophone to get the output pressure of 32x32 CMUT array's elements

5. gui_scan_plot_xyz
	a. gui_move_scan_xyz : Scan hydrophone in XY/XZ/YZ plane and save the waveform of hydrophone
	b. gui_plot_scan_xyz : Load the data and plot the peak-to-peak pressure to find the focus



