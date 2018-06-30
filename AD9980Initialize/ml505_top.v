`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:27:20 06/30/2018 
// Design Name: 
// Module Name:    ml505_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ml505_top(

	input  [4:0]  GPIO_COMPSW,
	output [1:0]  GPIO_LED,
	input        USER_CLK,
	inout IIC_SDA_VIDEO,
	inout IIC_SCL_VIDEO,
	input VGA_IN_DATA_CLK
    );

	 wire rst;
	 wire iic_done;

	 assign GPIO_LED[0] = iic_done;
	 assign GPIO_LED[1]= rst;

   wire user_clk_g;
   wire cpu_clk;
   wire cpu_clk_g;
   wire pll_lock;

	PLL_BASE
  #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT(24),
    .CLKFBOUT_PHASE(0.0),
    .CLKIN_PERIOD(10.0),

    .CLKOUT0_DIVIDE(8),
    .CLKOUT0_DUTY_CYCLE(0.5),
    .CLKOUT0_PHASE(0.0),

    .COMPENSATION("SYSTEM_SYNCHRONOUS"),
    .DIVCLK_DIVIDE(4),
    .REF_JITTER(0.100)
  )
  user_clk_pll
  (
    .CLKFBOUT(pll_fb),
    .CLKOUT0(cpu_clk),
    .LOCKED(pll_lock),
    .CLKFBIN(pll_fb),
    .CLKIN(user_clk_g),
    .RST(1'b0)
  );
	 IBUFG user_clk_buf ( .I(USER_CLK), .O(user_clk_g) );
   BUFG  cpu_clk_buf  ( .I(cpu_clk),  .O(cpu_clk_g)  );


	 Debouncer rst_parse(
      .clk(cpu_clk_g),
      .in(GPIO_COMPSW[4] | GPIO_COMPSW[3] | GPIO_COMPSW[2] | GPIO_COMPSW[1] | GPIO_COMPSW[0]),
      .out(rst));

  iic_init #(.CLK_RATE_MHZ(27)) init (
        // Outputs
      .Done  (iic_done),
        // Inouts
      .SDA  (IIC_SDA_VIDEO),
      .SCL  (IIC_SCL_VIDEO),
        // Inputs
      .Clk  (VGA_IN_DATA_CLK),
      .Reset  (rst),
      .Pixel_clk_greater_than_65Mhz(1'b1)
      );

endmodule
