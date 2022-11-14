#!/usr/bin/env python
# coding: utf-8

# In[1]:


import re
import pdb
import glob
import os


# In[2]:


filepath = "*.dlg"
files = glob.glob(filepath)

for file in files:
    
    basename, extension = os.path.splitext(file)

    pattern_1 = r'[^\d][\s\d][\s\d]\s\W\s\s\s\s[\s\W][\s\d\W]\d\W\d\d\s\W\s([\d\s]+)\W\s\s\s\s[\s\W]'
    
    # Create a list in which there are the best clusters
    best_cluster = []
    with open(file,"r") as f:
        content = f.read()
        for i in re.finditer(pattern_1,content):
            best_cluster.append(i.group(1))
    
    # Cast the numbers into an integer
    best_cluster_int = []
    for i in best_cluster:
         best_cluster_int.append(int(i))
    
    # Find the beginning and the end of the molecules
    
    pattern_tot = r"(?s)^(\w{3}:)[^\S\n]*(\d+)[^\S\n]*/[^\S\n]*(\d+)\n(.*?\nDOCKED: ENDMDL)"

    poses_row = (re.findall(pattern_tot,content, re.MULTILINE))
    
    # Clean the DOCKED: string in the beginning to make it compatible with python
    
    poses = []
    poses_clean = []

    for i in poses_row:
        poses.append(i[3] + "\n")

    for i in poses:
        poses_clean.append(re.sub("DOCKED:\s","",i))

    # Write the final .pdb
    with open(basename + "_best" + ".pdb","w") as f:

        for num in best_cluster_int:
            f.write(poses_clean[num-1])

