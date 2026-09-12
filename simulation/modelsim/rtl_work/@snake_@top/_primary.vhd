library verilog;
use verilog.vl_types.all;
entity Snake_Top is
    port(
        CLOCK_50        : in     vl_logic;
        PS2_CLK         : in     vl_logic;
        PS2_DAT         : in     vl_logic;
        SW0_RESET       : in     vl_logic;
        VGA_R           : out    vl_logic_vector(9 downto 0);
        VGA_G           : out    vl_logic_vector(9 downto 0);
        VGA_B           : out    vl_logic_vector(9 downto 0);
        VGA_HS          : out    vl_logic;
        VGA_VS          : out    vl_logic;
        VGA_BLANK_N     : out    vl_logic;
        VGA_SYNC_N      : out    vl_logic;
        VGA_CLK         : out    vl_logic;
        LEDR            : out    vl_logic_vector(9 downto 0);
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0)
    );
end Snake_Top;
