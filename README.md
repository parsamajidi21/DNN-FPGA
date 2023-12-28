# Neural Network implementaiton in FPGA using HLS
Regarding the project, you can choose one of the two ways of 
implementing a neural network: 
 
1) You build the entire network in VHDL. In this case you have to make 
the function of the single node and then you have to instantiate every 
node of the network and route the signals that connect each node. 
 
2) You follow the programming flow of [HLS4ML](https://fastmachinelearning.org/hls4ml/#:~:text=hls4ml%20is%20a%20Python%20package,configured%20for%20your%20use%2Dcase!). In this case you start 
from the network description in python (the same description that you 
used for the training) and following the HLS4ML flow you fist obtain the 
HLS description and then using Vivado HLS you get an IP ready to be 
instantiated in a VHDL file. 
 
In the first case, you have to write yourself much more code in VHDL. In 
the second instead, you have to use a tool (HLS4ML). 
You can check the [tutorial](https://github.com/fastmachinelearning/hls4ml-tutorial) that there is online and understand if it is 
feasible or maybe it is better to tackle the first option.


## Hardware Requirements
- Arty A7-100T Artix-7 FPGA Development Board - PN: XC7A100TCSG324-1
- A host computer running Windows or GNU/Linux
- A USB-A to USB-Micro cable - to load the bitstream

## Software Requirements
- Vivado® Design Suite 2020.1, download from [here](https://www.xilinx.com/support/download)
- The Python environment used for the tutorials is specified in the environment.yml file. It can be setup like:
```
conda env create -f environment.yml
conda activate FPGA_NN
```
### General Workflow to use HLS
- Problem
- Define your inputs & output
	- They will translate as the parameters of your HLS top-level function
- Write up your code
- Test your C++ code
- Synthesis, i.e. convert to VHDL code
	- Optimise it to get the desired performance while staying in your HW limits
- Test synthesised design
- Export design, typically in Vivado IP (Intellectual Property) format
- Implement in Vivado on actual FPGA
















## Some expected errors
if you have faced to a problem with jupyter notebook while creating the environment with hls4ml-tutorial, try the following command to have compatible version:
```
pip install --upgrade notebook==6.4.12
``` 
