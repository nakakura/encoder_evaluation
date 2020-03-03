#!/bin/sh
export IF=../resource/test.mp4
export OF=../red.png

#!/bin/sh
gst-launch-1.0 v4l2src device=/dev/video4 ! video/x-raw,framerate=60/1 ! videoconvert ! \
	gdkpixbufoverlay location=$OF alpha=1 relative-x=0.5 relative-y=0.0 ! \
  openh264enc ! \
  rtph264pay pt=100 mtu=1400 config-interval=3 ! \
  udpsink port=20000 host=10.156.97.180 sync=false
# open video and play as 60fps video


