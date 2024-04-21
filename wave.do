onerror {resume}
radix define 
sldk;fjkds
 {
    -default default
}
radix define States {
    "5'd0" "RST",
    "5'd1" "IF1",
    "5'd2" "IF2",
    "5'd3" "UPDPC",
    "5'd4" "DECODE",
    "5'd5" "ITORN",
    "5'd6" "RMTOB",
    "5'd7" "BTOC",
    "5'd8" "CTORD",
    "5'd9" "RNTOA",
    "5'd10" "ABTOC",
    "5'd11" "ABTOS",
    "5'd12" "AITOC",
    "5'd13" "CTOADR",
    "5'd14" "READ",
    "5'd15" "MEMRD",
    "5'd16" "AICRDB",
    "5'd17" "BCADR",
    "5'd18" "WRITE",
    "5'd19" "STOP",
    -default default
}
radix define mem_cmd {
    "2'd0" "MNONE",
    "2'd1" "MREAD",
    "2'd2" "MWRITE",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Inverted Clock and Reset}
add wave -noupdate {/lab7_top_tb/KEY[0]}
add wave -noupdate {/lab7_top_tb/KEY[1]}
add wave -noupdate -divider {Program Counter}
add wave -noupdate -radix decimal /lab7_top_tb/DUT/CPU/PC
add wave -noupdate -divider {State Machine State}
add wave -noupdate -max 15.0 -min -16.0 -radix States -radixshowbase 0 /lab7_top_tb/DUT/CPU/theStateMachine/state
add wave -noupdate -divider {Lab 7 New Control Signals}
add wave -noupdate /lab7_top_tb/DUT/CPU/theStateMachine/reset_pc
add wave -noupdate /lab7_top_tb/DUT/CPU/theStateMachine/load_pc
add wave -noupdate /lab7_top_tb/DUT/CPU/theStateMachine/addr_sel
add wave -noupdate /lab7_top_tb/DUT/CPU/theStateMachine/load_addr
add wave -noupdate /lab7_top_tb/DUT/CPU/theStateMachine/load_ir
add wave -noupdate -divider {CPU I/O}
add wave -noupdate -radix mem_cmd /lab7_top_tb/DUT/mem_cmd
add wave -noupdate /lab7_top_tb/DUT/mem_addr
add wave -noupdate /lab7_top_tb/DUT/read_data
add wave -noupdate /lab7_top_tb/DUT/write_data
add wave -noupdate -divider Instruction
add wave -noupdate /lab7_top_tb/DUT/CPU/regToDec
add wave -noupdate -divider Error
add wave -noupdate /lab7_top_tb/err
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 284
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {66 ps}
