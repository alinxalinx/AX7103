onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+wrfifo -L xil_defaultlib -L xpm -L fifo_generator_v13_1_4 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.wrfifo xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {wrfifo.udo}

run -all

endsim

quit -force
