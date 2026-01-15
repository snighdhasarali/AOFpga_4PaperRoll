`timescale 1ns/1ps
module tb_streaming;

    reg clk = 0;
    always #5 clk = ~clk;

    reg rst, in_valid, cell_in;
    wire [3:0] nsum;
    wire accessible;

    forklift_streaming dut (
        .clk(clk), .rst(rst),
        .in_valid(in_valid), .cell_in(cell_in),
        .nsum(nsum), .accessible(accessible)
    );

    reg [9:0] grid [0:9];
    integer r,c;

    initial begin
        grid[0]="..@@.@@@@.";
        grid[1]="@@@.@.@.@@";
        grid[2]="@@@@@.@.@@";
        grid[3]="@.@@@@..@.";
        grid[4]="@@.@@@@.@@";
        grid[5]=".@@@@@@@.@";
        grid[6]=".@.@.@.@@@";
        grid[7]="@.@@@.@@@@";
        grid[8]=".@@@@@@@@.";
        grid[9]="@.@.@@@.@.";
    end

    initial begin
        $dumpfile("waves/streaming.vcd");
        $dumpvars(0, tb_streaming);
    end

    initial begin
        rst=1; in_valid=0; cell_in=0;
        #20 rst=0;

        for(r=0;r<10;r=r+1)
            for(c=0;c<10;c=c+1) begin
                @(posedge clk);
                in_valid=1;
                cell_in=(grid[r][9-c]=="@");
            end
        #50 $finish;
    end
endmodule
