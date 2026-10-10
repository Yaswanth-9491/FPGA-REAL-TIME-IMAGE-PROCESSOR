set script_dir [file dirname [file normalize [info script]]]
set root_dir [file dirname $script_dir]

set project_name "image_processor"
set project_dir [file join $root_dir $project_name]
set fpga_part "xc7a100tcsg324-1"

proc collect_files {directory extensions} {
    set result {}

    if {![file isdirectory $directory]} {
        return $result
    }

    foreach entry [glob -nocomplain -directory $directory *] {
        if {[file isdirectory $entry]} {
            set result [concat $result [collect_files $entry $extensions]]
        } elseif {[lsearch -exact $extensions [string tolower [file extension $entry]]] >= 0} {
            lappend result [file normalize $entry]
        }
    }

    return $result
}

set rtl_files [collect_files [file join $root_dir Design_sources] {.v .sv .vhd .vhdl}]
set tb_files [collect_files [file join $root_dir testbenches] {.v .sv .vhd .vhdl}]
set xdc_files [collect_files [file join $root_dir constraints] {.xdc}]

if {[llength $rtl_files] == 0} {
    error "No design files found in Design_sources."
}

create_project -force $project_name $project_dir -part $fpga_part

set_property target_language Verilog [current_project]

add_files -norecurse -fileset sources_1 $rtl_files

if {[llength $tb_files] > 0} {
    add_files -norecurse -fileset sim_1 $tb_files
}

if {[llength $xdc_files] > 0} {
    add_files -norecurse -fileset constrs_1 $xdc_files
}

set_property include_dirs [list [file join $root_dir Design_sources]] [get_filesets sources_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "Project created: [file join $project_dir ${project_name}.xpr]"
