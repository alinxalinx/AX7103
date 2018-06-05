onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib afifo_32i_64o_4096_opt

do {wave.do}

view wave
view structure
view signals

do {afifo_32i_64o_4096.udo}

run -all

quit -force
