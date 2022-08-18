module fifo1 ( output [8-1:0] rdata,
 output wfull,
 output rempty,
 input [8-1:0] wdata,
 input winc, wclk, wrst_n,
 input rinc, rclk, rrst_n);
 
 wire [4-1:0] waddr, raddr;
 wire [4:0] wptr, rptr, wq2_rptr, rq2_wptr;
 
 fifomem fifomem1 (.rdata(rdata), .wdata(wdata), .waddr(waddr), .raddr(raddr), .wclken(winc), .wfull(wfull), .wclk(wclk));
 
 sync_r2w sync_r2w1 (.wq2_rptr(wq2_rptr), .rptr(rptr), .wclk(wclk), .wrst_n(wrst_n));
 
 sync_w2r sync_w2r1 (.rq2_wptr(rq2_wptr), .wptr(wptr), .rclk(rclk), .rrst_n(rrst_n));
 
 rptr_empty  rptr_empty1 (.rempty(rempty),.raddr(raddr),.rptr(rptr), .rq2_wptr(rq2_wptr),.rinc(rinc), .rclk(rclk),.rrst_n(rrst_n));
 
 wptr_full  wptr_full1 (.wfull(wfull), .waddr(waddr),.wptr(wptr), .wq2_rptr(wq2_rptr),.winc(winc), .wclk(wclk),.wrst_n(wrst_n));
 
endmodule


module tb; 

reg [7:0] wdata;
reg wclk,rclk,winc,rinc,wrst_n,rrst_n;
wire wfull,rempty;

wire [7:0] rdata;

fifo1 fifo1_t (rdata,wfull,rempty,wdata,winc, wclk, wrst_n,rinc, rclk, rrst_n);

initial
	begin
		wclk = 0;
		rclk = 0;
		wrst_n = 1;
		rrst_n = 1;
		#5 wrst_n = 0;
		#5 rrst_n = 0;
		#5 wrst_n = 1;
		#5 rrst_n = 1;
	end
	

always #10 wclk = ~wclk;
always #50 rclk = ~rclk;
	
always@ (posedge wclk)
	begin
		wdata <= 1;winc	<= 1; 
		#40 wdata <= 2;
		#40 wdata <= 3;
		#40 wdata <= 4;
		#40 wdata <= 5;
		
		#200 winc	<= 0; 
		
		//#1900 winc <= 1;
		//#300 winc <= 0;
		
		#3000 $finish;
	end
always@ (posedge rclk)
	begin

		rinc <= 1;
		
		#2000 rinc <= 0;
	
		#3000 $finish;
	end
endmodule