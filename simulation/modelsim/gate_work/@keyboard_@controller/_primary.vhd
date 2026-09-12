library verilog;
use verilog.vl_types.all;
entity Keyboard_Controller is
    port(
        ps2_clk         : in     vl_logic;
        ps2_data        : in     vl_logic;
        direction       : out    vl_logic_vector(4 downto 0);
        reset_cmd       : out    vl_logic
    );
end Keyboard_Controller;
