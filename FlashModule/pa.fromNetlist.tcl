
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name FlashModule -dir "D:/THUCS_ThinPad/FlashModule/planAhead_run_3" -part xc3s1200efg320-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/THUCS_ThinPad/FlashModule/FlashModule.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/THUCS_ThinPad/FlashModule} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "FlashModule.ucf" [current_fileset -constrset]
add_files [list {FlashModule.ucf}] -fileset [get_property constrset [current_run]]
link_design
