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
ExecStep $xv_path/bin/xsim top_behav -key {Behavioral:sim_1:Functional:top} -tclbatch top.tcl -view /home/keith/xilProjects/artyBoardVHDLuart/top_behav.wcfg -log simulate.log
