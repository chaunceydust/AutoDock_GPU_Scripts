#!/usr/bin/env python

# This script will convert the file .dlg > .pdbqt removing in the same time the string "Docked" in the output of AutodockGPU. This will allow you to see your results in pymol.

# Istruction: 
# $python from_dlg_to_pdbqt.py
# write the complete path of the directory containing the .dlg files

path = input("Enter Path:")

import glob, os
os.chdir(path)
for file in glob.glob("*.dlg"):
    with open(file,'r') as infile:
        read = infile.read()
    changed = read.replace('DOCKED: ', '')
    with open(file,'w') as outfile:
        outfile.write(changed)

#from dlg to pdb
for file in glob.glob("*.dlg"):
    os.rename(file, file.split('.')[0]+'.pdbqt')

