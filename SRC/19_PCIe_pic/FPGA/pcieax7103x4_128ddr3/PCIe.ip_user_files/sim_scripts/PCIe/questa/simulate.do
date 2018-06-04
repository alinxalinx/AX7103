onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib PCIe_opt

do {wave.do}

view wave
view structure
view signals

do {PCIe.udo}

run -all

quit -force
