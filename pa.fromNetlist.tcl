
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name ThinPad -dir "D:/workspace/THUCS_ThinPad/planAhead_run_1" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/workspace/THUCS_ThinPad/PipeLine.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/workspace/THUCS_ThinPad} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "PipeLine.ucf" [current_fileset -constrset]
add_files [list {PipeLine.ucf}] -fileset [get_property constrset [current_run]]
link_design