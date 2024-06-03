`default_nettype none
module serial_writer(input wire clk, 
                     input wire ready, 
                     input serial_data_i,
                     inout wire serial_bus, 
                     output wire serial_data_o, 
                     input wire next_byte, 
                     output wire [2:0] count);

    reg current_bit;
    reg out_bit;
    reg [7:0] current_byte;
    reg [2:0] bit_count;
    assign count = bit_count;

    assign serial_bus = ready ? current_bit : 1'bX; 
    assign serial_data_o = out_bit;

    initial begin
        current_byte = 8'h0;
        bit_count = 3'h0;
    end

    always @(posedge clk) begin
        if (ready) begin
            current_bit <= serial_data_i;
            if (bit_count == 0 && next_byte) begin
                current_byte[0] <= serial_bus;
            end
            else if (bit_count != 0) begin
                current_byte[bit_count] <= serial_bus;
            end
            bit_count = bit_count + 1;
        end
        else begin
            out_bit <= current_byte[bit_count];
            bit_count = bit_count + 1;
        end
    end

endmodule