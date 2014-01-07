#!/bin/bash

path=$(cd "$(dirname "$0")"; pwd)
echo $path

cd $path/m
pwd

nohup matlab -nodisplay <test.m 1>$path/run.log 2>$path/run.err &