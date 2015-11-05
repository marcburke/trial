import Vector::*;
import FIFO::*;
import BRAM::*;
import CBus::*;
import WCFIFOx4::*;


(* synthesize *)
module mkTbWidthChangeFIFOx4();
    //Vector#(8,BRAM2Port#(Bit#(18), UInt#(32))) wc_fifo <- replicateM(mkWCFIFO());
    WCFIFOx4_ifc wc_fifo <- mkWCFIFOx4();
   
    Reg#(Bit#(16)) state <- mkReg(0);
    
   //startup time
    rule step0(state == 0);
        state <= 1;
    endrule

    rule step1(state == 1);
    BRAMRequest#(Bit#(18), UInt#(64)) req = defaultValue;
       req.address = 18'h10;
       req.write   = True;
       req.datain  = 64'h11223344;
       
       for(Integer i=0; i<2; i=i+1)
	  begin
	     wc_fifo.pio[i].request.put(req);
	  end
       state <= 2;
    endrule

    rule step2(state == 2);
       let x <- wc_fifo.pio[0].response.get;
       let y <- wc_fifo.pio[1].response.get;       
       $display("BRAM01 Read = %x %x", x, y);
        state <= 3;
    endrule

    rule step3(state == 3);
     BRAMRequest#(Bit#(18), UInt#(64)) req = defaultValue;
       req.address = 18'h14;
       req.write   = True;
       req.datain  = 64'h22334455;
   
       for(Integer i=0; i<2; i=i+1)
	  begin
	     wc_fifo.pio[i].request.put(req);
	  end
      req.datain  = 64'hBBBBBBBB;
      wc_fifo.pio[2].request.put(req);
      wc_fifo.pio[3].request.put(req);
       state <= 4;
    endrule

    rule step4(state == 4);
       let x <- wc_fifo.pio[0].response.get;
       let y <- wc_fifo.pio[1].response.get;       
       $display("BRAM01 Read = %x %x", x,y);
        state <= 5;
    endrule

    rule step5(state == 5);
       let x <- wc_fifo.pio[2].response.get;
       let y <- wc_fifo.pio[3].response.get;       
       $display("BRAM23 Read = %x %x", x,y);
        state <= 6;
    endrule

    rule done(state == 6);
        $display("TESTS FINISHED");
        $finish(0);
    endrule
endmodule
