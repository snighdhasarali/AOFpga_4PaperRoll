module forklift_golden;

    integer r, c;
    integer count;
    integer n;

    reg grid [0:9][0:9];

    initial begin
        grid[0][0]=0; grid[0][1]=0; grid[0][2]=1; grid[0][3]=1; grid[0][4]=0;
        grid[0][5]=1; grid[0][6]=1; grid[0][7]=1; grid[0][8]=1; grid[0][9]=0;

        grid[1][0]=1; grid[1][1]=1; grid[1][2]=1; grid[1][3]=0; grid[1][4]=1;
        grid[1][5]=0; grid[1][6]=1; grid[1][7]=0; grid[1][8]=1; grid[1][9]=1;

        grid[2][0]=1; grid[2][1]=1; grid[2][2]=1; grid[2][3]=1; grid[2][4]=1;
        grid[2][5]=0; grid[2][6]=1; grid[2][7]=0; grid[2][8]=1; grid[2][9]=1;

        grid[3][0]=1; grid[3][1]=0; grid[3][2]=1; grid[3][3]=1; grid[3][4]=1;
        grid[3][5]=1; grid[3][6]=0; grid[3][7]=0; grid[3][8]=1; grid[3][9]=0;

        grid[4][0]=1; grid[4][1]=1; grid[4][2]=0; grid[4][3]=1; grid[4][4]=1;
        grid[4][5]=1; grid[4][6]=1; grid[4][7]=0; grid[4][8]=1; grid[4][9]=1;

        grid[5][0]=0; grid[5][1]=1; grid[5][2]=1; grid[5][3]=1; grid[5][4]=1;
        grid[5][5]=1; grid[5][6]=1; grid[5][7]=1; grid[5][8]=0; grid[5][9]=1;

        grid[6][0]=0; grid[6][1]=1; grid[6][2]=0; grid[6][3]=1; grid[6][4]=0;
        grid[6][5]=1; grid[6][6]=0; grid[6][7]=1; grid[6][8]=1; grid[6][9]=1;

        grid[7][0]=1; grid[7][1]=0; grid[7][2]=1; grid[7][3]=1; grid[7][4]=1;
        grid[7][5]=0; grid[7][6]=1; grid[7][7]=1; grid[7][8]=1; grid[7][9]=1;

        grid[8][0]=0; grid[8][1]=1; grid[8][2]=1; grid[8][3]=1; grid[8][4]=1;
        grid[8][5]=1; grid[8][6]=1; grid[8][7]=1; grid[8][8]=1; grid[8][9]=0;

        grid[9][0]=1; grid[9][1]=0; grid[9][2]=1; grid[9][3]=0; grid[9][4]=1;
        grid[9][5]=1; grid[9][6]=1; grid[9][7]=0; grid[9][8]=1; grid[9][9]=0;
    end

    initial begin
        count = 0;
        for (r = 0; r < 10; r = r + 1)
            for (c = 0; c < 10; c = c + 1)
                if (grid[r][c]) begin
                    n = 0;
                    if (r>0   && c>0) n = n + grid[r-1][c-1];
                    if (r>0)          n = n + grid[r-1][c];
                    if (r>0   && c<9) n = n + grid[r-1][c+1];
                    if (c>0)          n = n + grid[r][c-1];
                    if (c<9)          n = n + grid[r][c+1];
                    if (r<9 && c>0)   n = n + grid[r+1][c-1];
                    if (r<9)          n = n + grid[r+1][c];
                    if (r<9 && c<9)   n = n + grid[r+1][c+1];
                    if (n < 4) count = count + 1;
                end
        $display("FINAL ACCESSIBLE COUNT = %0d", count);
        $finish;
    end
endmodule
