onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L fifo_generator_v13_1_4 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.afifo_64i_32o_2048 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {afifo_64i_32o_2048.udo}

run -all

quit -force
