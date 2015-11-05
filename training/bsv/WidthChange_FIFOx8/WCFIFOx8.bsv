// 8x32 FIFO with 256 bit load, 64 bit read

import Vector::*;
import FIFO::*;
import BRAM::*;
import CBus::*;

interface WCFIFOx8_ifc;
   interface Vector#(4,BRAMServer#(Bit#(18), Vector#(2,UInt#(32)))) pio;
endinterface

(* synthesize *)
module mkWCFIFOx8(WCFIFOx8_ifc);
   BRAM_Configure bram_cfg = defaultValue;
   bram_cfg.memorySize = (1024 * 16 )/2;

   Vector#(8,BRAM2Port#(Bit#(18),UInt#(32))) pio_brams <- replicateM (mkBRAM2Server(bram_cfg));
  //BRAM2Port#(Bit#(18), UInt#(32))  wc_fifos <- mkBRAM2Server(bram_cfg);
     
   Vector#(4,BRAMServer#(Bit#(18), Vector#(2,UInt#(32)))) bram_pio_ifc = ?;
      for (Integer i = 0; i < 4;  i = i + 1)
      begin
        bram_pio_ifc[i] = (interface BRAMServer
                          interface Put request;
                            method Action put (BRAMRequest#(Bit#(18), Vector#(2,UInt#(32))) req);
                              BRAMRequest#(Bit#(18), UInt#(32)) reqX = defaultValue;
                                reqX.write = req.write;    
                                // Assumptions that the requests are aligned on 8 byte boundary !!
                                reqX.address = req.address;
			        reqX.datain  = req.datain[0];
                                pio_brams[i*2+1].portB.request.put(reqX);
			        reqX.datain  = req.datain[1];
                                pio_brams[i*2].portB.request.put(reqX);
                            endmethod
                         endinterface
                         interface Get response;
                            method ActionValue#(Vector#(2,UInt#(32)))  get;
                               Vector#(2,UInt#(32))  res = ?;
                                 res[0] <- pio_brams[i*2+1].portB.response.get;
                                 res[1] <- pio_brams[i*2].portB.response.get;
                            return res;
                            endmethod
                         endinterface
                      endinterface);
      end

	   interface pio = bram_pio_ifc;
	 
endmodule
