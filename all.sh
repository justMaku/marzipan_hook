#!/bin/bash
killall VoiceMemos
./build.sh
python patch.py
./run.sh
