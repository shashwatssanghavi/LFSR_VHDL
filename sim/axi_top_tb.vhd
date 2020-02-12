----------------------------------------------------------------------------------
-- Company: Technische Universität Hamburg    
-- Engineer: Shashwat S. Sanghavi
-- 
-- Create Date: 12.02.2020 15:37:16
-- Design Name: axi_top_tb.vhd
-- Module Name: axi_top_tb - Behavioral
-- Project Name: LFSR_8bit
-- Target Devices: TE0820-3CG-1E
-- Tool Versions: Vivado 2018.2
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision: 1.0 - test bench code for AXI testing of slave added
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity axi_top_tb is
generic
(
  C_S_AXI_DATA_WIDTH             : integer              := 32;
  C_S_AXI_ADDR_WIDTH             : integer              := 4
);
end axi_top_tb;

architecture Behavioral of axi_top_tb is

    signal pn_out                        : std_logic;
	signal random_vector				 : std_logic_vector(7 downto 0);
    
    signal S_AXI_ACLK                     :  std_logic;
    signal S_AXI_ARESETN                  :  std_logic;
    signal S_AXI_AWADDR                   :  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal S_AXI_AWVALID                  :  std_logic;
    signal S_AXI_WDATA                    :  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal S_AXI_WSTRB                    :  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    signal S_AXI_WVALID                   :  std_logic;
    signal S_AXI_BREADY                   :  std_logic;
    signal S_AXI_ARADDR                   :  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal S_AXI_ARVALID                  :  std_logic;
    signal S_AXI_RREADY                   :  std_logic;
    signal S_AXI_ARREADY                  : std_logic;
    signal S_AXI_RDATA                    : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal S_AXI_RRESP                    : std_logic_vector(1 downto 0);
    signal S_AXI_RVALID                   : std_logic;
    signal S_AXI_WREADY                   : std_logic;
    signal S_AXI_BRESP                    : std_logic_vector(1 downto 0);
    signal S_AXI_BVALID                   : std_logic;
    signal S_AXI_AWREADY                  : std_logic;
    signal S_AXI_AWPROT                   : std_logic_vector(2 downto 0);
    signal S_AXI_ARPROT                   : std_logic_vector(2 downto 0);

    
    Constant ClockPeriod : TIME := 5 ns;
    Constant ClockPeriod2 : TIME := 10 ns;
    shared variable ClockCount : integer range 0 to 50_000 := 10;
    signal sendIt : std_logic := '0';
    signal readIt : std_logic := '0';

component LFSR_8bit_ip is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
        pn_out : out std_logic;
        random_vector : out std_logic_vector(7 downto 0);
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end component LFSR_8bit_ip;


begin
 -- instance LM3409_Interface
 UUT : LFSR_8bit_ip
	generic map (
		C_S00_AXI_DATA_WIDTH => C_S_AXI_DATA_WIDTH ,
		C_S00_AXI_ADDR_WIDTH => C_S_AXI_ADDR_WIDTH
	)
	port map (
		s00_axi_aclk =>  S_AXI_ACLK ,
		s00_axi_aresetn => S_AXI_ARESETN,
		s00_axi_awaddr => S_AXI_AWADDR,
		s00_axi_awprot => S_AXI_AWPROT ,
		s00_axi_awvalid => S_AXI_AWVALID,
		s00_axi_awready => S_AXI_AWREADY,
		s00_axi_wdata => S_AXI_WDATA,
		s00_axi_wstrb => S_AXI_WSTRB,
		s00_axi_wvalid => S_AXI_WVALID ,
		s00_axi_wready => S_AXI_WREADY ,
		s00_axi_bresp => S_AXI_BRESP,
		s00_axi_bvalid => S_AXI_BVALID,
		s00_axi_bready => S_AXI_BREADY,
		s00_axi_araddr => S_AXI_ARADDR,
		s00_axi_arprot => S_AXI_ARPROT,
		s00_axi_arvalid => S_AXI_ARVALID,
		s00_axi_arready => S_AXI_ARREADY,
		s00_axi_rdata => S_AXI_RDATA,
		s00_axi_rresp => S_AXI_RRESP,
		s00_axi_rvalid => S_AXI_RVALID,
		s00_axi_rready => S_AXI_RREADY,
		pn_out => pn_out,
		random_vector => random_vector
	);

-- Generate S_AXI_ACLK signal
 GENERATE_REFCLOCK : process
 begin
   wait for (ClockPeriod / 2);
   ClockCount:= ClockCount+1;
   S_AXI_ACLK <= '1';
   wait for (ClockPeriod / 2);
   S_AXI_ACLK <= '0';
 end process;
 
 -- Initiate process which simulates a master wanting to write.
  -- This process is blocked on a "Send Flag" (sendIt).
  -- When the flag goes to 1, the process exits the wait state and
  -- execute a write transaction.
  send : PROCESS
  BEGIN
     S_AXI_AWVALID<='0';
     S_AXI_WVALID<='0';
     S_AXI_BREADY<='0';
     loop
         wait until sendIt = '1';
         wait until S_AXI_ACLK= '0';
             S_AXI_AWVALID<='1';
             S_AXI_WVALID<='1';
         wait until (S_AXI_AWREADY and S_AXI_WREADY) = '1';  --Client ready to read address/data        
             S_AXI_BREADY<='1';
         wait until S_AXI_BVALID = '1';  -- Write result valid
             assert S_AXI_BRESP = "00" report "AXI data not written" severity failure;
             S_AXI_AWVALID<='0';
             S_AXI_WVALID<='0';
             S_AXI_BREADY<='1';
         wait until S_AXI_BVALID = '0';  -- All finished
             S_AXI_BREADY<='0';
     end loop;
  END PROCESS send;
 
   -- Initiate process which simulates a master wanting to read.
   -- This process is blocked on a "Read Flag" (readIt).
   -- When the flag goes to 1, the process exits the wait state and
   -- execute a read transaction.
   read : PROCESS
   BEGIN
     S_AXI_ARVALID<='0';
     S_AXI_RREADY<='0';
      loop
          wait until readIt = '1';
          wait until S_AXI_ACLK= '0';
              S_AXI_ARVALID<='1';
              S_AXI_RREADY<='1';
          wait until (S_AXI_RVALID and S_AXI_ARREADY) = '1';  --Client provided data
             assert S_AXI_RRESP = "00" report "AXI data not written" severity failure;
              S_AXI_ARVALID<='0';
             S_AXI_RREADY<='0';
      end loop;
   END PROCESS read;
 
 
  -- 
  tb : PROCESS
  BEGIN
         S_AXI_ARESETN<='0';
         sendIt<='0';
     wait for 15 ns;
         S_AXI_ARESETN<='1';
 
         S_AXI_AWADDR<=x"1"; -- address offset
         S_AXI_WDATA<=x"000000A4"; -- SEED
         S_AXI_WSTRB<=b"1111";
         sendIt<='1';                --Start AXI Write to Slave
         wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
     wait until S_AXI_BVALID = '1';
     wait until S_AXI_BVALID = '0';  --AXI Write finished
         S_AXI_WSTRB<=b"0000";
             
         -- S_AXI_AWADDR<=x"4";
         -- S_AXI_WDATA<=x"00000064"; -- 
         -- S_AXI_WSTRB<=b"1111";
         -- sendIt<='1';                --Start AXI Write to Slave
         -- wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
     -- wait until S_AXI_BVALID = '1';
     -- wait until S_AXI_BVALID = '0';  --AXI Write finished
         -- S_AXI_WSTRB<=b"0000";
         
         -- S_AXI_AWADDR<=x"8";       -- 
         -- S_AXI_WDATA<=x"00000001"; -- set the enable to 1
         -- S_AXI_WSTRB<=b"1111";
         -- sendIt<='1';                --Start AXI Write to Slave
         -- wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
     -- wait until S_AXI_BVALID = '1';
     -- wait until S_AXI_BVALID = '0';  --AXI Write finished
         -- S_AXI_WSTRB<=b"0000";
         
--         S_AXI_AWADDR<=x"4";
--         S_AXI_WDATA<=x"A5A5A5A5";
--         S_AXI_WSTRB<=b"1111";
--         sendIt<='1';                --Start AXI Write to Slave
--         wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--     wait until S_AXI_BVALID = '1';
--     wait until S_AXI_BVALID = '0';  --AXI Write finished
--         S_AXI_WSTRB<=b"0000";
         
--         S_AXI_ARADDR<=x"0";
--         readIt<='1';                --Start AXI Read from Slave
--         wait for 1 ns; readIt<='0'; --Clear "Start Read" Flag
--     wait until S_AXI_RVALID = '1';
--     wait until S_AXI_RVALID = '0';
--         S_AXI_ARADDR<=x"4";
--         readIt<='1';                --Start AXI Read from Slave
--         wait for 1 ns; readIt<='0'; --Clear "Start Read" Flag
--     wait until S_AXI_RVALID = '1';
--     wait until S_AXI_RVALID = '0';
         
      wait; -- will wait forever
  END PROCESS tb;


end Behavioral;
