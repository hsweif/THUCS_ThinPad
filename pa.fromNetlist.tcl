
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name ThinPad -dir "D:/THUCS_ThinPad/planAhead_run_5" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/THUCS_ThinPad/PipeLine.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/THUCS_ThinPad} }
set_property target_constrs_file "PipeLine.ucf" [current_fileset -constrset]
add_files [list {PipeLine.ucf}] -fileset [get_property constrset [current_run]]
link_design
