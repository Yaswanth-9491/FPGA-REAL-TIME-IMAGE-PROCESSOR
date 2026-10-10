set script_dir [file dirname [file normalize [info script]]]
set root_dir [file dirname $script_dir]

set project_name "image_processor"
set project_file [file join $root_dir $project_name ${project_name}.xpr]

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

if {![file exists $project_file]} {
    error "Project not found. Run scripts/build.tcl first."
}

if {[current_project -quiet] ne ""} {
    close_project
}

open_project $project_file

foreach fileset_name {sources_1 sim_1 constrs_1} {
    set fs [get_filesets $fileset_name]
    set old_files [get_files -quiet -of_objects $fs]

    if {[llength $old_files] > 0} {
        remove_files -quiet $old_files
    }
}

set rtl_files [collect_files [file join $root_dir Design_sources] {.v .sv .vhd .vhdl}]
set tb_files [collect_files [file join $root_dir testbenches] {.v .sv .vhd .vhdl}]
set xdc_files [collect_files [file join $root_dir constraints] {.xdc}]

if {[llength $rtl_files] == 0} {
    error "No design files found in Design_sources."
}

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

save_project

puts "Project refreshed successfully."
