#!/bin/bash

rm -rf Hook.dylib
clang -framework Foundation -F/System/iOSSupport/System/Library/Frameworks -framework UIKit -o Hook.dylib -dynamiclib main.m
