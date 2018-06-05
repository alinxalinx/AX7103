onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib afifo_64i_32o_2048_opt

do {wave.do}

view wave
view structure
view signals

do {afifo_64i_32o_2048.udo}

run -all

quit -force
