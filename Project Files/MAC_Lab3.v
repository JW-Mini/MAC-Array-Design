`timescale 1ns/10ps
// Individual PE cell
module MAC_Lab3 (clk, rstb, updateEN, INPUT, WEIGHT, INPUT_out, WEIGHT_out, trueOUT);

    input clk, rstb, updateEN;
    input signed [7:0] INPUT;
    input signed [7:0] WEIGHT;
    output reg signed [7:0] INPUT_out;
    output reg signed [7:0] WEIGHT_out;
    output reg signed [19:0] trueOUT;

    always @(posedge clk or negedge rstb) begin
        if (!rstb) begin
            INPUT_out  <= 8'sd0;
            WEIGHT_out <= 8'sd0;
            trueOUT    <= 20'sd0;
        end else begin
            INPUT_out  <= INPUT;
            WEIGHT_out <= WEIGHT;
           
            // Stop increasing at cycle 13
            if (updateEN) begin
                trueOUT <= trueOUT + (INPUT * WEIGHT);
            end
        end
    end
endmodule

// 3x3 MAC Array Grid
module systolic_array (CLK, RSTB, IN1, IN2, IN3, W1, W2, W3, OUT1, OUT2, OUT3, OUT4, OUT5, OUT6, OUT7, OUT8, OUT9);
    
    input CLK, RSTB;
    input signed [7:0] IN1, IN2, IN3;
    input signed [7:0] W1, W2, W3;
    output signed [19:0] OUT1, OUT2, OUT3, OUT4, OUT5, OUT6, OUT7, OUT8, OUT9;

    reg [3:0] cycleNum;
    wire enableWIRE;

    always @(posedge CLK or negedge RSTB) begin
        if (!RSTB) begin
            cycleNum <= 4'd0;
        end else if (cycleNum < 4'd13) begin
            cycleNum <= cycleNum + 4'd1;
        end
    end

    assign enableWIRE = (cycleNum < 4'd13);

    // Wires for connecting the cells together
    wire signed [7:0] IN1R, IN1RR, IN2R, IN2RR, IN3R, IN3RR;
    wire signed [7:0] W1R, W1RR, W2R, W2RR, W3R, W3RR;
    wire signed [7:0] junk_i3, junk_i6, junk_i9, junk_w7, junk_w8, junk_w9; // used for cells with no connections at certain parts

    // Rows 1-3, in groups of 3
    MAC_Lab3 PE1 (.clk(CLK), .rstb(RSTB), .updateEN(enableWIRE), .INPUT(IN1),   .WEIGHT(W1),   .INPUT_out(IN1R),   .WEIGHT_out(W1R),  .trueOUT(OUT1));
    MAC_Lab3 PE2 (.clk(CLK), .rstb(RSTB), .updateEN(enableWIRE), .INPUT(IN1R),  .WEIGHT(W2),   .INPUT_out(IN1RR),  .WEIGHT_out(W2R),  .trueOUT(OUT2));
    MAC_Lab3 PE3 (.clk(CLK), .rstb(RSTB), .updateEN(enableWIRE), .INPUT(IN1RR), .WEIGHT(W3),   .INPUT_out(junk_i3),.WEIGHT_out(W3R),  .trueOUT(OUT3));

    MAC_Lab3 PE4 (.clk(CLK), .rstb(RSTB), .updateEN(enableWIRE), .INPUT(IN2),   .WEIGHT(W1R),  .INPUT_out(IN2R),   .WEIGHT_out(W1RR), .trueOUT(OUT4));
    MAC_Lab3 PE5 (.clk(CLK), .rstb(RSTB), .updateEN(enableWIRE), .INPUT(IN2R),  .WEIGHT(W2R),  .INPUT_out(IN2RR),  .WEIGHT_out(W2RR), .trueOUT(OUT5));
    MAC_Lab3 PE6 (.clk(CLK), .rstb(RSTB), .updateEN(enableWIRE), .INPUT(IN2RR), .WEIGHT(W3R),  .INPUT_out(junk_i6),.WEIGHT_out(W3RR), .trueOUT(OUT6));

    MAC_Lab3 PE7 (.clk(CLK), .rstb(RSTB), .updateEN(enableWIRE), .INPUT(IN3),   .WEIGHT(W1RR), .INPUT_out(IN3R),   .WEIGHT_out(junk_w7), .trueOUT(OUT7));
    MAC_Lab3 PE8 (.clk(CLK), .rstb(RSTB), .updateEN(enableWIRE), .INPUT(IN3R),  .WEIGHT(W2RR), .INPUT_out(IN3RR),  .WEIGHT_out(junk_w8), .trueOUT(OUT8));
    MAC_Lab3 PE9 (.clk(CLK), .rstb(RSTB), .updateEN(enableWIRE), .INPUT(IN3RR), .WEIGHT(W3RR), .INPUT_out(junk_i9),.WEIGHT_out(junk_w9), .trueOUT(OUT9));
endmodule




