#!/bin/bash

# Author: Riccardo Fusco
# Copyright : Riccardo Fusco 2022

# This script will save the histogram result table, extract the first 9 poses, join together the these poses in a convenient .pdbqt file easily readble in pymol

# ISTRUCTION: move in the working directory where there are the subfolder containing the .dlg file and run
# $bash analysis_adgpu.sh

for folder in $( find . -type d -maxdepth 1 -mindepth 1 )
do
cd $folder

for file in `ls | grep \.dlg`
do
cat $file | grep -B 500 RMSD\ TABLE | grep -A 500 CLUSTERING > clustering_histogram.txt
for line in {1..500}                          
do
cat clustering_histogram.txt | grep "^   $line" >> clustering_histogram_divided.txt
done
awk '{print $5}' clustering_histogram_divided.txt > runs.txt
mkdir Runs
for run in `cat runs.txt`
do
sed 's/DOCKED:\ //g' $file | grep -A 10000 $run\ /\ 100 | grep -m1 -B 10000 ^ENDMDL > Runs/run$run.pdbqt
done
folder=_${PWD##*/}
cd Runs
cat * > gpu$folder.pdbqt
cd ..
rm clustering_histogram_divided.txt
rm runs.txt
done
cd ..
done
