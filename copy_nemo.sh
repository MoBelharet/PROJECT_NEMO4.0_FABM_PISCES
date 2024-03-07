

project_home="/home/belharet/Documents/PROJECT_NEMO4.0_FABM_PISCES"

if [ $1 = "fabm" ]; then
	flag="fabm"
	destination_path="$project_home/run_nemo_fabm_pisces"
else
	flag="pisces"
	destination_path="$project_home/run_nemo_pisces"
fi

source_path="$project_home/NEMO4.0-FABM/cfgs/test_nemo_$flag/BLD/bin"

\cp $source_path/nemo.exe $destination_path

if [ $? = 0 ]; then
	echo "The executable file nemo.exe was copied with success from $source_path to $destination_path"
else
	echo "Copy of executable failed !!!" 
fi
