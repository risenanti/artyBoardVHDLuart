#!/bin/bash -f
xv_path="/home/keith/Documents/Vivado/2017.1"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto b98421f32db84ddfb1d33e24533a6549 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot top_behav xil_defaultlib.top xil_defaultlib.glbl -log elaborate.log