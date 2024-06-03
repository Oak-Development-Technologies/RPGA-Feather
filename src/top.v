`default_nettype none
//`include "serial_writer.v"
`include "three_bits_out.v"
module top(input clk, output pico17, output pico18, output pico19, output [2:0] RGB);
    // This basic example takes inputs from the RPGA's RP2040 host controller and translated them to the RGB LED on board!
    // reg [31:0] counter;
    reg red;
    reg green;
    reg blue;
    assign RGB[2] = red;
    assign RGB[1] = green;
    assign RGB[0] = blue;

    //serial_writer serial_writer_init(.clk(clk),.ready(pico17),.serial_bus(pico18),.next_byte(pico19),.count(RGB));
    three_bits_out tbo_init(.clk(clk),.top(pico17),.middle(pico18),.bottom(pico19));
    initial begin
        red = 1;
        green = 1;
        blue = 1;
    end

    always @(posedge clk) begin 
        // comment the next 3 lines to use an example :)
        red <= pico17;
        green <= pico18;
        blue <= pico19;

    end

endmodule