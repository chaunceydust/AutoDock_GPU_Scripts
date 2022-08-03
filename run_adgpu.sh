#!/bin/bash

# This script will allow you to make a virtual screening of compounds using autodock_GPU. Here you can see just an example of some settings, as you can immagine you can choose the setting that you prefer changing the value (e.g --nev 50000000)

# The script will take all the .pdbqt files from a folder (ligands) and will give the output in different folders

# Istruction: move in the working directory (where there are your map files) and run
# $bash run_adgpu.sh

for f in ligands/*.pdbqt; do
    echo Processing ligand $b
    b=`basename $f .pdbqt`
    mkdir -p $b
    path_to/autodock_gpu_128wi --lfile $f --ffile MIF2prep_rigid.maps.fld --flexres MIF2prep_flex.pdbqt --resnam ${b}/${b}_out --gbest 0 --xmloutput 0 --heuristics 0 --asfreq 10 --nrun 100 -nev 50000000 -ngen 100000 -psize 300
done

#--heuristics        -H | Ligand-based automatic search method and # evals      | 1 (yes) 
#--heurmax           -E | Asymptotic heuristics # evals limit (smooth limit)    | 12000000
#--autostop          -A | Automatic stopping criterion based on convergence     | 1 (yes)
#--asfreq            -a | AutoStop testing frequency (in # of generations)      | 5
#--nrun              -n | # LGA runs                                            | 20
#--nev               -e | # Score evaluations (max.) per LGA run                | 2500000
#--ngen              -g | # Generations (max.) per LGA run                      | 42000
#--lsmet             -l | Local-search method                                   | ad (ADADELTA)
#--lsit              -i | # Local-search iterations (max.)                      | 300
#--psize             -p | Population size                                       | 150
#--mrat                 | Mutation rate                                         | 2   (%)
#--crat                 | Crossover rate                                        | 80  (%)
#--lsrat                | Local-search rate                                     | 100 (%)
#--trat                 | Tournament (selection) rate                           | 60  (%)
#--dmov                 | Maximum LGA movement delta                            | 6 (Å)
#--dang                 | Maximum LGA angle delta                               | 90 (°)
#--rholb                | Solis-Wets lower bound of rho parameter               | 0.01
#--lsmov                | Solis-Wets movement delta                             | 2 (Å)
#--lsang                | Solis-Wets angle delta                                | 75 (°)
#--cslim                | Solis-Wets cons. success/failure limit to adjust rho  | 4
#--stopstd              | AutoStop energy standard deviation tolerance          | 0.15 (kcal/mol)
#--initswgens           | Initial # generations of Solis-Wets instead of -lsmet | 0 (no)

