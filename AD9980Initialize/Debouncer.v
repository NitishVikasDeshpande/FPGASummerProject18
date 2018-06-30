`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:30:25 06/30/2018 
// Design Name: 
// Module Name:    Debouncer 
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
// Assumes ~33 Mhz clock and ~100ms button press.

module Debouncer(
    input clk, in,
    output out
);

    reg [21:0] count;

    always@(posedge clk)
        if(~in)
            count <= 21'b0;
        else 
            count <= count + 1;

    assign out = count == 21'hFFFFF;

endmodule
