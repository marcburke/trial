// 8x32 FIFO with 256 bit load, 64 bit read

import Vector::*;
import FIFO::*;
import BRAM::*;
import CBus::*;

interface WCFIFOx4_ifc;
   interface Vector#(4,BRAMServer#(Bit#(18), UInt#(64))) pio;
endinterface

(* synthesize *)
module mkWCFIFOx4(WCFIFOx4_ifc);
   BRAM_Configure bram_cfg = defaultValue;
   bram_cfg.memorySize = (1024 * 16 )/2;

   Vector#(4,BRAM2Port#(Bit#(18), UInt#(64))) pio_brams <- replicateM (mkBRAM2Server(bram_cfg));
  //BRAM2Port#(Bit#(18), UInt#(32))  wc_fifos <- mkBRAM2Server(bram_cfg);
     
   Vector#(4,BRAMServer#(Bit#(18), UInt#(64))) bram_pio_ifc = ?;
      for (Integer i = 0; i < 4;  i = i + 1)
      begin
        bram_pio_ifc[i] = (interface BRAMServer
                          interface Put request;
                            method Action put (BRAMRequest#(Bit#(18), UInt#(64)) req);
                              BRAMRequest#(Bit#(18), UInt#(64)) reqX = defaultValue;
                                reqX.write = req.write;    
                                // Assumptions that the requests are aligned on 8 byte boundary !!
                                reqX.address = req.address;
			        reqX.datain  = req.datain;
                                pio_brams[i].portB.request.put(reqX);
                            endmethod
                         endinterface
                         interface Get response;
                            method ActionValue#(UInt#(64))  get;
                               UInt#(64)  res = ?;
                                 res <- pio_brams[i].portB.response.get;
                            return res;
                            endmethod
                         endinterface
                      endinterface);
      end

	   interface pio = bram_pio_ifc;
	 
endmodule
