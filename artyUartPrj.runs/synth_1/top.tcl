# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35ticsg324-1L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/keithconley/Documents/xilinx/artyUartPrj/artyUartPrj.cache/wt [current_project]
set_property parent.project_path /home/keithconley/Documents/xilinx/artyUartPrj/artyUartPrj.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo /home/keithconley/Documents/xilinx/artyUartPrj/artyUartPrj.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib /home/keithconley/Documents/xilinx/artyUartPrj/artyUartPrj.srcs/sources_1/new/top.vhd
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/keithconley/Documents/xilinx/artyUartPrj/artyUartPrj.srcs/constrs_1/new/arty.xdc
set_property used_in_implementation false [get_files /home/keithconley/Documents/xilinx/artyUartPrj/artyUartPrj.srcs/constrs_1/new/arty.xdc]


synth_design -top top -part xc7a35ticsg324-1L


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
