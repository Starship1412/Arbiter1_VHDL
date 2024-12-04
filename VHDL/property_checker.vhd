library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity property_checker is
	port (
		clk : in std_logic;
		reset : in std_logic;
		cmd : in std_logic;
		req : in std_logic_vector(2 downto 0);
		gnt : in std_logic_vector(2 downto 0);
		Fails : out std_logic_vector(2 downto 0);
		protocol_violation : out std_logic
	);
end property_checker;

architecture behavioral of property_checker is
	type req_array_type is array (3 downto 0) of std_logic_vector(2 downto 0);
	signal cmd_history : std_logic_vector(3 downto 0) := (others => '0');
	signal req_history : req_array_type := (others => (others => '0'));
begin
	protocol_violation <= '1' when ((cmd_history(0) = '1' and cmd_history(1) = '1') or (cmd = '1' and req = "000")) else '0';
	Fails(0) <= '1' when (cmd_history(3) = '1' and not (gnt = "001" or gnt = "010" or gnt = "100")) else '0';
	Fails(1) <= '1' when (cmd_history(3) = '0' and not (gnt = "000")) else '0';
	Fails(2) <= '1' when (cmd_history(3) = '1' and (req_history(3)(0) and gnt(0)) = '0' and (req_history(3)(1) and gnt(1)) = '0' and (req_history(3)(2) and gnt(2)) = '0') else '0';
	process(clk)
		begin
			if rising_edge(clk) then
				cmd_history <= cmd_history(2 downto 0) & cmd;
				req_history(3 downto 1) <= req_history(2 downto 0);
				req_history(0) <= req;
				if reset = '1' then
					cmd_history <= (others => '0');
					req_history <= (others => (others => '0'));
				end if;
			end if;
	end process;
end behavioral;