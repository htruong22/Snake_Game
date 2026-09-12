library verilog;
use verilog.vl_types.all;
entity Game_Logic is
    port(
        VGA_CLK         : in     vl_logic;
        game_tick       : in     vl_logic;
        SW0_RESET       : in     vl_logic;
        reset_kb        : in     vl_logic;
        key_dir         : in     vl_logic_vector(4 downto 0);
        px_x            : in     vl_logic_vector(10 downto 0);
        px_y            : in     vl_logic_vector(9 downto 0);
        rnd_x           : in     vl_logic_vector(10 downto 0);
        rnd_y           : in     vl_logic_vector(8 downto 0);
        score           : out    vl_logic_vector(7 downto 0);
        game_over       : out    vl_logic;
        cur_dir         : out    vl_logic_vector(4 downto 0);
        is_border       : out    vl_logic;
        is_obstacle     : out    vl_logic;
        is_apple        : out    vl_logic;
        is_head         : out    vl_logic;
        is_body         : out    vl_logic
    );
end Game_Logic;
