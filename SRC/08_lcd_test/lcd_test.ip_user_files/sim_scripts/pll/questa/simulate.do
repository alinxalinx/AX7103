onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib pll_opt

do {wave.do}

view wave
view structure
view signals

do {pll.udo}

run -all

quit -force
