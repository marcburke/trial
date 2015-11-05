// 8x32 FIFO with 256 bit load, 64 bit read

import Vector::*;
import FIFO::*;
import BRAM::*;
import CBus::*;

(* synthesize *)
module mkWCFIFO(BRAM2Port#(Bit#(18), UInt#(32)));
   BRAM_Configure bram_cfg = defaultValue;
   bram_cfg.memorySize = (1024 * 16 )/2;

   //Vector#(8,BRAM2Port#(Bit#(18), UInt#(32))) wc_fifos <- replicateM (mkBRAM2Server(bram_cfg));
  BRAM2Port#(Bit#(18), UInt#(32))  wc_fifos <- mkBRAM2Server(bram_cfg);
     
   interface portA = wc_fifos.portA;
   interface portB = wc_fifos.portB;
   interface portAClear = wc_fifos.portAClear;
   interface portBClear = wc_fifos.portBClear;

endmodule
