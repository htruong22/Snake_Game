library verilog;
use verilog.vl_types.all;
entity VGA_Controller is
    generic(
        H_ACTIVE        : integer := 800;
        H_SYNC_START    : integer := 856;
        H_SYNC_END      : integer := 976;
        H_TOTAL         : integer := 1040;
        V_ACTIVE        : integer := 600;
        V_SYNC_START    : integer := 637;
        V_SYNC_END      : integer := 643;
        V_TOTAL         : integer := 666
    );
    port(
        VGA_clk         : in     vl_logic;
        pixel_x         : out    vl_logic_vector(10 downto 0);
        pixel_y         : out    vl_logic_vector(9 downto 0);
        video_on        : out    vl_logic;
        h_sync          : out    vl_logic;
        v_sync          : out    vl_logic;
        blank_n         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of H_ACTIVE : constant is 1;
    attribute mti_svvh_generic_type of H_SYNC_START : constant is 1;
    attribute mti_svvh_generic_type of H_SYNC_END : constant is 1;
    attribute mti_svvh_generic_type of H_TOTAL : constant is 1;
    attribute mti_svvh_generic_type of V_ACTIVE : constant is 1;
    attribute mti_svvh_generic_type of V_SYNC_START : constant is 1;
    attribute mti_svvh_generic_type of V_SYNC_END : constant is 1;
    attribute mti_svvh_generic_type of V_TOTAL : constant is 1;
end VGA_Controller;
