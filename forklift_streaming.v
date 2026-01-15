module forklift_streaming #(
    parameter W = 10
)(
    input  wire clk,
    input  wire rst,
    input  wire in_valid,
    input  wire cell_in,

    output wire [3:0] nsum,
    output wire accessible
);

    reg [$clog2(W)-1:0] col;
    reg [15:0] row;

    reg [W-1:0] r0, r1, r2;
    reg center;

    always @(posedge clk) begin
        if (rst) begin
            col <= 0; row <= 0;
            r0 <= 0; r1 <= 0; r2 <= 0;
            center <= 0;
        end else if (in_valid) begin
            r2[col] <= r1[col];
            r1[col] <= r0[col];
            r0[col] <= cell_in;
            center  <= r1[col];

            if (col == W-1) begin col <= 0; row <= row + 1; end
            else col <= col + 1;
        end
    end

    wire valid = (row >= 2) && (col > 0) && (col < W-1);

    assign nsum =
        (valid ? r2[col-1] : 0) +
        (valid ? r2[col]   : 0) +
        (valid ? r2[col+1] : 0) +
        (valid ? r1[col-1] : 0) +
        (valid ? r1[col+1] : 0) +
        (valid ? r0[col-1] : 0) +
        (valid ? r0[col]   : 0) +
        (valid ? r0[col+1] : 0);

    assign accessible = in_valid && valid && center && (nsum < 4);

endmodule
