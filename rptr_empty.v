module rptr_empty (
 output reg rempty,
 output [4-1:0] raddr,
 output reg [4 :0] rptr,
 input [4 :0] rq2_wptr,
 input rinc, rclk, rrst_n);
 
 reg [4:0] rbin;
 wire [4:0] rgraynext, rbinnext;
 
 //-------------------
 // GRAYSTYLE2 pointer
 //-------------------
 always @(posedge rclk or negedge rrst_n)
	if (!rrst_n) 
		{rbin, rptr} <= 0;
	else 
		{rbin, rptr} <= {rbinnext, rgraynext};
 
 // Memory read-address pointer (okay to use binary to address memory)
 assign raddr = rbin[4-1:0];
 assign rbinnext = rbin + (rinc & ~rempty);
 assign rgraynext = (rbinnext>>1) ^ rbinnext;
 
 //---------------------------------------------------------------
 // FIFO empty when the next rptr == synchronized wptr or on reset
  //---------------------------------------------------------------
 
 assign rempty_val = (rgraynext == rq2_wptr);
 always @(posedge rclk or negedge rrst_n)
	if (!rrst_n) 
		rempty <= 1'b1;
	else 
		rempty <= rempty_val;
		
endmodule