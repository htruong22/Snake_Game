library verilog;
use verilog.vl_types.all;
entity GameOver_Display is
    port(
        px_x            : in     vl_logic_vector(10 downto 0);
        px_y            : in     vl_logic_vector(9 downto 0);
        is_text         : out    vl_logic
    );
end GameOver_Display;
