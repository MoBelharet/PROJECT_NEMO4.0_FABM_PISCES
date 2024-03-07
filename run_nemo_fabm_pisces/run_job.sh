#!/bin/bash


#************************************************************
#  / PARAMETERS /
#************************************************************

# config_name = spectral or original
config_name=$1


#************************************************************
#  / SET-UP /
#************************************************************

# Update the fabm configuration file according to the selected set-up
\cp fabm_$config_name.yaml fabm.yaml

# Update the set-up name in the namlist
cn_exp_expr="   cn_exp      = \"data\/C1D_PAPA_fabm_${config_name}\"    !  experience name"

nb_line_cn_exp=`awk '/'cn_exp'/{ print NR; exit }' namelist_cfg`

sed -i "${nb_line_cn_exp}s/.*/${cn_exp_expr}/" namelist_cfg

# run the simulation
./nemo.exe

exit 0
	

