module fifomem (
 output [8-1:0] rdata,
 input [8-1:0] wdata,
 input [4-1:0] waddr, raddr,
 input wclken, wfull, wclk);
 
		localparam DEPTH = 1<<4;
		reg [8-1:0] mem [0:DEPTH-1];
		assign rdata = mem[raddr];
		always @(posedge wclk)
			if (wclken && !wfull) 
				mem[waddr] <= wdata;
endmodule