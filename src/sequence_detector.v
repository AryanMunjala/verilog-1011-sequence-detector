module sequence_detector(
    input wire clk,
    input wire rst,
    input wire din,
    output reg detect
);

parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;

reg [1:0] current_state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (rst)
        current_state <= S0;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        S0: begin
            if (din)
                next_state = S1;
            else
                next_state = S0;
        end

        S1: begin
            if (din)
                next_state = S1;
            else
                next_state = S2;
        end

        S2: begin
            if (din)
                next_state = S3;
            else
                next_state = S0;
        end

        S3: begin
            if (din)
                next_state = S1;
            else
                next_state = S2;
        end

        default:
            next_state = S0;
    endcase
end

always @(*) begin
    if (current_state == S3 && din)
        detect = 1'b1;
    else
        detect = 1'b0;
end

endmodule
