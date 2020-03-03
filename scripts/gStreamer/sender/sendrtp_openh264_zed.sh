#!/bin/sh
export IF=../resource/test.mp4
export OF=../red.png

#!/bin/sh
gst-launch-1.0 v4l2src device=/dev/video4 ! video/x-raw,width=2560,height=720,framerate=60/1 ! videoconvert ! \
	gdkpixbufoverlay location=$OF alpha=1 relative-x=0.5 relative-y=0.0 ! \
  openh264enc enable-denoise=true qp-max=20 complexity=high background-detection=true rate-control=off ! \
  rtph264pay pt=100 mtu=1400 config-interval=3 ! \
  udpsink port=20000 host=10.156.97.180 sync=false
#preset 3 is Low Latency, 4 is Low Latency, High Quality
#rc-mode 2 is Constant Bit Rate


