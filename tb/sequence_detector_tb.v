`timescale 1ns/1ps

module sequence_detector_tb;

reg clk;
reg rst;
reg din;
wire detect;

sequence_detector DUT(
    .clk(clk),
    .rst(rst),
    .din(din),
    .detect(detect)
);

always #5 clk = ~clk;

task apply_bit(input bit_value);
begin
    din = bit_value;
    #10;
end
endtask

initial begin
    clk = 0;
    rst = 1;
    din = 0;

    #20;
    rst = 0;
   
    apply_bit(1);
    apply_bit(0);
    apply_bit(1);
    apply_bit(1);

     apply_bit(0);
    
    apply_bit(1);
    apply_bit(0);
    apply_bit(1);
    apply_bit(1);
    apply_bit(0);
    apply_bit(1);
    apply_bit(1);
    #20;
    $finish;
end

initial begin
    $monitor("Time=%0t | Input=%b | Detect=%b | State=%b",
             $time,
             din,
             detect,
             DUT.current_state);
end

endmodule
