# Asynchronous-FIFO
This is the course project done under EE705-VLSI Design Lab at IIT-B.

Info about the different modules used.

FIFO_1.v 		:-	This is the top-level wrapper-module that includes all clock domains. 
					The top module is only used as a wrapper to instantiate all of the other FIFO modules used in the design.

fifomem.v		:- 	This is the FIFO memory buffer that is accessed by both the write and read clock domains. 
					This buffer is most likely an instantiated, synchronous dual-port RAM.
				
sync_r2w.v		:-	This is a synchronizer module that is used to synchronize the read pointer into the write-clock domain. 
					The synchronized read pointer will be used by the wptr_full module to generate the FIFO full condition.
					This module only contains flip-flops that are synchronized to the write clock. No other logic is included in this module.	
				
sync_w2r.v		:-	This is a synchronizer module that is used to synchronize the write pointer into the read-clock domain. 
					The synchronized write pointer will be used by the rptr_empty module to generate the FIFO empty condition. 
					This module only contains flip-flops that are synchronized to the read clock. No other logic is included in this module.
				
rptr_empty.v	:-	This module is completely synchronous to the read-clock domain and contains the FIFO read pointer and empty-flag logic.

wptr_full.v		:-	This module is completely synchronous to the write-clock domain and contains the FIFO write pointer and full-flag logic.
