Attempt at solving the mountain paths assignment.

http://nifty.stanford.edu/2016/franke-mountain-paths/

Problem decomposition:
- get new maps from https://maps.ngdc.noaa.gov/viewers/wcs-client/
	- use coastal relief models (or the ETOP1 models also seem to work)
	- output format is 
- I/O of file to 2D array
	- use hash? 
- algorithm to find best path
- Visualize path (output graph to picture file)
	- chunky_png -> works
	- use feh with flag -D 0.1 (e.g.) (http://askubuntu.com/questions/237310/what-fast-image-viewers-are-available-for-ubuntu)

todo:
- install ruby and git on the rasp pi and git clone this project there
- create some script to take a random new map and create the images for that and show it using feh. Use crontab to schedule
- auto start feh on startup
- create a case for the rasp pi and touchscreen to place it on the wall.
- better algorithm that finds a more optimum route 
	- looking further forward
	- working backward from right to left