library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity common_std_logic_vector_delay is
	generic
	(
		WIDTH : integer := 1;
		DELAY : integer := 0
	);
	port
	(
		-- clock, enable and reset
		clock : in  std_logic;
		reset : in  std_logic;
		ena   : in  std_logic := '1';

		-- input and output
		data  : in  std_logic_vector(WIDTH - 1 downto 0);
		q     : out std_logic_vector(WIDTH - 1 downto 0)
	);
end entity;

architecture rtl of common_std_logic_vector_delay is
begin

	-- check generics
	assert WIDTH > 0
		report "Generic WIDTH must be greater than zero"
		severity ERROR;
	assert DELAY >= 0
		report "Generic DELAY must greater than or equal to zero"
		severity ERROR;
	
	-- if zero delay is requested, just combinationally pass through
	no_delay_gen :
	if DELAY = 0 generate
	begin
		q <= data;
	end generate;
	
	-- if one or more cycles of delay have been requested, build a simple
	-- shift register and do the delaying
	some_delay_gen :
	if DELAY > 0 generate
		-- shift register, to do the required delaying
		type shift_register_type is array(integer range <>) of std_logic_vector(WIDTH - 1 downto 0);
		signal shift_register : shift_register_type(DELAY - 1 downto 0);
	begin
		-- clocked process to update shift register
		shift_reg : process (clock, reset)
		begin
			if reset = '1' then
				shift_register <= (others => (others => '0'));
			elsif clock'EVENT and clock = '1' then
				if ena = '1' then
					for i in 0 to DELAY - 2 loop
						shift_register(i) <= shift_register(i + 1);
					end loop;
					shift_register(DELAY - 1) <= data;
				end if;
			end if;
		end process;
		-- assign output from end of shift register
		q <= shift_register(0);
	end generate;
  
end ;
