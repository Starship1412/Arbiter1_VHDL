library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity arbiter is
	port (
		clk : in std_logic;
		reset : in std_logic;
		cmd : in std_logic;
		req : in std_logic_vector(2 downto 0);
		gnt : out std_logic_vector(2 downto 0);
		n1, n2, n3 : out signed(2 downto 0)
	);
end arbiter;

architecture behavioral of arbiter is
	type state_type is (IDLE, READY_1, READY_2, GO);
	signal current_state, next_state : state_type := IDLE;
	signal gnt_temp : std_logic_vector(2 downto 0);
	signal counter : unsigned(1 downto 0) := "00";
	signal req_temp : std_logic_vector(2 downto 0) := (others => '0');
	signal n1_temp, n2_temp, n3_temp : signed(2 downto 0) := (others => '0');
begin
	gnt <= gnt_temp;
	n1 <= n1_temp;
    n2 <= n2_temp;
    n3 <= n3_temp;
	process(clk)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				current_state <= IDLE;
			else
				current_state <= next_state;
			end if;
		end if;
	end process;

	process(current_state, cmd)
	begin
		case current_state is
			when IDLE =>
				gnt_temp <= "000";
				if reset = '0' then
					if cmd = '1' then
						req_temp <= req;
						next_state <= READY_1;
					else
						next_state <= IDLE;
					end if;
				else
					next_state <= IDLE;
					n1_temp <= (others => '0');
					n2_temp <= (others => '0');
					n3_temp <= (others => '0');
					counter <= "00";
					req_temp <= (others => '0');
				end if;
			when READY_1 =>
				gnt_temp <= "000";
 				if cmd = '0' then
 					if counter /= 2 then
						counter <= counter + 1;
						next_state <= READY_2;
					else
						counter <= "00";
						next_state <= GO;
					end if;
				else
					req_temp <= req;
					counter <= "00";
 					next_state <= READY_1;
				end if;
			when READY_2 =>
				gnt_temp <= "000";
				if cmd = '0' then
					if counter = 2 then
						counter <= "00";
						next_state <= GO;
					else
						counter <= counter + 1;
						next_state <= READY_1;
					end if;
				else
					req_temp <= req;
					counter <= "00";
					next_state <= READY_2;
				end if;
			when GO =>
				if cmd = '0' then
				    next_state <= IDLE;
					if req_temp = "000" then
  						gnt_temp <= "000";
					elsif req_temp = "001" then
						gnt_temp <= "001";
					elsif req_temp = "010" then
						gnt_temp <= "010";
					elsif req_temp = "100" then
						gnt_temp <= "100";
					elsif req_temp = "011" then
						if n1_temp <= n2_temp then
 							gnt_temp <= "001";
							n1_temp <= n1_temp + 1;
							n2_temp <= n2_temp - 1;
						else
							gnt_temp <= "010";
							n1_temp <= n1_temp - 1;
							n2_temp <= n2_temp + 1;
						end if;
					elsif req_temp = "101" then
						if n1_temp <= n3_temp then
							gnt_temp <= "001";
							n1_temp <= n1_temp + 1;
							n3_temp <= n3_temp - 1;
 						else
							gnt_temp <= "100";
							n1_temp <= n1_temp - 1;
							n3_temp <= n3_temp + 1;
						end if;
					elsif req_temp = "110" then
						if n2_temp <= n3_temp then
							gnt_temp <= "010";
							n2_temp <= n2_temp + 1;
							n3_temp <= n3_temp - 1;
						else
							gnt_temp <= "100";
							n2_temp <= n2_temp - 1;
							n3_temp <= n3_temp + 1;
						end if;
					elsif req_temp = "111" then
						if n1_temp <= n2_temp and n1_temp <= n3_temp then
							gnt_temp <= "001";
							n1_temp <= n1_temp + 2;
							n2_temp <= n2_temp - 1;
							n3_temp <= n3_temp - 1;
						elsif n2_temp <= n1_temp and n2_temp <= n3_temp then
							gnt_temp <= "010";
							n1_temp <= n1_temp - 1;
							n2_temp <= n2_temp + 2;
							n3_temp <= n3_temp - 1;
						elsif n3_temp <= n1_temp and n3_temp <= n2_temp then
							gnt_temp <= "100";
							n1_temp <= n1_temp - 1;
							n2_temp <= n2_temp - 1;
							n3_temp <= n3_temp + 2;
						end if;
					end if;
				else
					req_temp <= req;
					counter <= "00";
					next_state <= READY_1;
				end if;
		end case;
	end process;
end behavioral;