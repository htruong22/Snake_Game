library verilog;
use verilog.vl_types.all;
entity Game_Clock is
    port(
        CLOCK_50        : in     vl_logic;
        score           : in     vl_logic_vector(7 downto 0);
        game_tick       : out    vl_logic
    );
end Game_Clock;
