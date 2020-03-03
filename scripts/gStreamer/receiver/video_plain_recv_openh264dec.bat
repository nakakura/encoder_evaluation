gst-launch-1.0 udpsrc port=20000 caps="application/x-rtp,paylocad=(int)100" ! rtpjitterbuffer latency=0 ! rtph264depay ! h264parse ! openh264dec ! videoconvert ! autovideosink sync=false
