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
