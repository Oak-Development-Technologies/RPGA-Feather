`default_nettype none

module three_bits_out(input wire clk, output wire top, output wire middle, output wire bottom);

    reg [15:0] counter;
    reg [15:0] index;
    initial begin 
        counter = 0;
    end

    assign top = index[counter];
    assign middle = index[0] ^ counter[15];
    assign bottom = counter[index];

    always @(posedge clk) begin
        counter <= counter + 1;
        index <= counter + index;
    end
endmodule