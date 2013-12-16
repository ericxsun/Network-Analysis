#!/bin/bash

pwd

cd m/

pwd

nohup matlab -nodisplay <test.m 1>../run.log 2>../run.err &