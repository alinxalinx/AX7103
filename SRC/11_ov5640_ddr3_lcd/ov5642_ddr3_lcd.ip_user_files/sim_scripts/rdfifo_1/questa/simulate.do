onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib rdfifo_opt

do {wave.do}

view wave
view structure
view signals

do {rdfifo.udo}

run -all

quit -force
