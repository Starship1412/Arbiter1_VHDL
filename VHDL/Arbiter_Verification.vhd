library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench is
end entity testbench;

architecture behavioral of testbench is
	component arbiter is
		port (
			clk : in std_logic;
			reset : in std_logic;
			cmd : in std_logic;
			req : in std_logic_vector(2 downto 0);
			gnt : out std_logic_vector(2 downto 0);
			n1, n2, n3 : out signed(2 downto 0)
		);
	end component;

	component property_checker is
		port (
			clk : in std_logic;
			reset : in std_logic;
			cmd : in std_logic;
			req : in std_logic_vector(2 downto 0);
			gnt : in std_logic_vector(2 downto 0);
			Fails : out std_logic_vector(2 downto 0);
			protocol_violation : out std_logic
		);
	end component;
	
    component driver is
        port (
            clk : in std_logic;
            cmd : in std_logic;
            n1, n2, n3 : in signed(2 downto 0);
            req : in std_logic_vector(2 downto 0)
        );
    end component;

	signal clk_tb, reset_tb, cmd_tb : std_logic := '0';
	signal protocol_violation_tb : std_logic;
	signal req_tb : std_logic_vector(2 downto 0) := "000";
	signal gnt_tb : std_logic_vector(2 downto 0);
	signal Fails_tb : std_logic_vector(2 downto 0);
	signal n1_tb, n2_tb, n3_tb : signed(2 downto 0);
	constant clk_period : time := 10 ns;

begin
	uut: arbiter port map(
		clk => clk_tb,
		reset => reset_tb,
		cmd => cmd_tb,
		req => req_tb,
		gnt => gnt_tb,
		n1 => n1_tb,
		n2 => n2_tb,
		n3 => n3_tb
	);
	
    i1: driver port map(
        clk => clk_tb,
        cmd => cmd_tb,
        req => req_tb,
		n1 => n1_tb,
		n2 => n2_tb,
		n3 => n3_tb
    );
    
	i2: property_checker port map(
		clk => clk_tb,
		reset => reset_tb,
		cmd => cmd_tb,
		req => req_tb,
		gnt => gnt_tb,
		Fails => Fails_tb,
		protocol_violation => protocol_violation_tb
	);

	clk_process : process
	begin
		while now < 2000 ns loop
			clk_tb <= '0';
			wait for clk_period/2;
			clk_tb <= '1';
			wait for clk_period/2;
		end loop;
		wait;
	end process;
	
	reset_process : process
	begin
		reset_tb <= '1';
		wait for 50 ns;
		reset_tb <= '0';
		wait for 390 ns;
		reset_tb <= '1';
		wait for 50 ns;
		reset_tb <= '0';
		wait;
	end process;

	cmd_process : process
	begin
		wait for 30 ns;

		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 30 ns;

		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
        
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 10 ns;
        
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 30 ns;
		cmd_tb <= '1';
		wait for clk_period * 2;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period * 3;
		cmd_tb <= '0';
		wait for 50 ns;
		cmd_tb <= '1';
		wait for clk_period;
		cmd_tb <= '0';
		wait for 50 ns;
		wait;
	end process;

	sti_process : process
	begin
		wait for 20 ns;
		req_tb <= "101";
		wait for clk_period * 2;
		req_tb <= "000";
		wait for 50 ns;
 		req_tb <= "001";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "010";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "100";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "101";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "011";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "110";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "010";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "111";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "110";
		wait for clk_period;
		req_tb <= "000";
		wait for 30 ns;
		req_tb <= "001";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "100";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "001";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "010";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "110";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "101";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "111";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "100";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "111";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "101";
		wait for clk_period;
		req_tb <= "000";
		
		wait for 10 ns;
		req_tb <= "010";
		wait for clk_period;
		req_tb <= "000";
		
		wait for 50 ns;
		req_tb <= "110";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "001";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "101";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "010";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;

		req_tb <= "110";
		wait for clk_period;
		req_tb <= "000";
		wait for 30 ns;
		req_tb <= "011";
		wait for clk_period;
		req_tb <= "111";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "001";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "000";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "011";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "010";
		wait for clk_period;
		req_tb <= "100";
		wait for clk_period;
		req_tb <= "101";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		req_tb <= "110";
		wait for clk_period;
		req_tb <= "000";
		wait for 50 ns;
		
		wait;
	end process;

	gnt_tb_show: process
	begin
		if gnt_tb /= "000" then
		wait;
		end if;
		wait;
	end process;

end architecture behavioral;