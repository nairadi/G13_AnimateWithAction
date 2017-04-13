# G13_AnimateWithAction
# ECE532H1 W - Animate With Action - 2017
“Animate With Action” is an application which provides a live motion capture experience. We added a real-time component to the process of recording actions such that the actions of the actor are mimicked by the character on screen in real time. Our project requires the actor to be equipped with red marker tapes which are captured by a PMOD camera. The live video processing unit then detects the coordinates of the markers as fast as possible and therefore, was implemented in hardware. The graphics component of the project, which includes animating and controlling the character on screen, was achieved using in software.

How to run the program:
-----------------------
1. cd to src -> vivado and launch vivado.xpr
2. launch the SDK from vivado to run the animation code

Repository Structure:
---------------------
1. The src folder consists of the entire project. This includes:
- ip_repo/comm_1.0 - This folder contains all communication interface IPs
- ipu - This folder contains the image processing code in Verilog
- vga_ip - This folder contains the VGA ip to write to the screen
- video_in - This folder contains the PMOD camera code
- vivado - This folder contains the actual project and the animation code
2. The docs folder consists of supporting documents. This includes:
- Report.pdf - The group report for the project
- Presentation.pdf - The presentation slides for the final demo
- Detection.mp4 - Video demo of red pixel detection
- Animation.mp4 - Video demo of animation

Acknowledgements:
-----------------
At the outset, we would like to thank Professor Paul Chow for providing us with the opportunity to undertake this project. He provided guidance towards the goal of the project and various technologies we could utilize. Next, we would like to thank Nariman Eskandari for providing expert advice and helping us achieve our milestones. He provided valuable inputs at various stages such as the use of ILA cores and AXI Stream peripherals. Last but not least, we would like to thank Fernando Martin del Campo and Charles Lo for all the assistance they provided throughout the course.

Authors:
--------
Homagni Ghosh,  Tirthak Patel, Aditya Nair
