onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib wrfifo_opt

do {wave.do}

view wave
view structure
view signals

do {wrfifo.udo}

run -all

quit -force
