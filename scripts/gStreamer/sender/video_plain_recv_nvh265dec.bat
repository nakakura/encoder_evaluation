gst-launch-1.0 udpsrc port=20000 caps="application/x-rtp,paylocad=(int)100" ! rtpjitterbuffer latency=0 ! rtph265depay ! h265parse ! nvh265dec ! video/x-raw ! videoconvert ! autovideosink sync=false
