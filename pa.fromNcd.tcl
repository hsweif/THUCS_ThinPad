
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name ThinPad -dir "D:/workspace/THUCS_ThinPad/planAhead_run_2" -part xc3s1200efg320-4
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "D:/workspace/THUCS_ThinPad/PipeLine.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/workspace/THUCS_ThinPad} }
set_property target_constrs_file "PipeLine.ucf" [current_fileset -constrset]
add_files [list {PipeLine.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "D:/workspace/THUCS_ThinPad/PipeLine.ncd"
if {[catch {read_twx -name results_1 -file "D:/workspace/THUCS_ThinPad/PipeLine.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"D:/workspace/THUCS_ThinPad/PipeLine.twx\": $eInfo"
}
