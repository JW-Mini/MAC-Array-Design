`timescale 1ns/10ps

module MAC_Lab3_test;
    reg clk, rstb;
    reg signed [7:0] IN1, IN2, IN3;
    reg signed [7:0] W1, W2, W3;
    wire signed [19:0] OUT1, OUT2, OUT3, OUT4, OUT5, OUT6, OUT7, OUT8, OUT9;

    systolic_array testArray (
        .CLK(clk),
        .RSTB(rstb),
        .IN1(IN1),   .IN2(IN2),   .IN3(IN3),
        .W1(W1),     .W2(W2),     .W3(W3),
        .OUT1(OUT1), .OUT2(OUT2), .OUT3(OUT3),
        .OUT4(OUT4), .OUT5(OUT5), .OUT6(OUT6),
        .OUT7(OUT7), .OUT8(OUT8), .OUT9(OUT9)
    );

    // generate clock
    always begin
        #1 clk = ~clk;
    end

    // test inputs
    integer i;
    initial begin
        $sdf_annotate("./Synthesis/Backend/MAC_Lab3.sdf", testArray);
        clk = 0;
        rstb = 0;
        IN1 = 8'sd0; IN2 = 8'sd0; IN3 = 8'sd0;
        W1  = 8'sd0; W2  = 8'sd0; W3  = 8'sd0;

        
        #2;
        rstb = 1; // ends reset

        // non-zero varying inputs every clock cycle
        for (i = 1; i <= 13; i = i + 1) begin
            @(posedge clk);
            #0.1; // delay for timing constraints
            IN1 = i;      W1 = i + 2;  
            IN2 = i + 1;  W2 = i;
            IN3 = i + 2;  W3 = i + 1;
        end

        // extra cycles to show freeze
        #10;
        $finish;
    end
endmodule
