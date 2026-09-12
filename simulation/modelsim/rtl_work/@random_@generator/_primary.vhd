library verilog;
use verilog.vl_types.all;
entity Random_Generator is
    port(
        VGA_clk         : in     vl_logic;
        rnd_x           : out    vl_logic_vector(10 downto 0);
        rnd_y           : out    vl_logic_vector(8 downto 0)
    );
end Random_Generator;
