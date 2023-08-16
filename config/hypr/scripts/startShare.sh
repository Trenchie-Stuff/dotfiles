#!/usr/bin/env bash
echo "y\n1\n" | wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video0 -t &
echo "y\n2\n" | wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video1 -t &
