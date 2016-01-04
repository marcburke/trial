import Vector::*;
import FIFO::*;
import BRAM::*;
import CBus::*;
import WCFIFO::*;


(* synthesize *)
module mkTbWidthChangeFIFO();
    Vector#(8,BRAM2Port#(Bit#(18), UInt#(32))) wc_fifo <- replicateM(mkWCFIFO());
   
    Reg#(Bit#(16)) state <- mkReg(0);
    
   //startup time
    rule step0(state == 0);
        state <= 1;
    endrule

    rule step1(state == 1);
    BRAMRequest#(Bit#(18), UInt#(32)) req = defaultValue;
       req.address = 18'h10;
       req.write   = True;
       req.datain  = 32'h11223344;
       
       for(Integer i=0; i<8; i=i+1)
	  begin
	     wc_fifo[i].portA.request.put(req);
	  end
       state <= 2;
    endrule

    rule step2(state == 2);
       let x <- wc_fifo[0].portA.response.get;
       let y <- wc_fifo[1].portA.response.get;       
       $display("BRAM01 Read = %x %x", x, y);
        state <= 3;
    endrule

    rule step3(state == 3);
     BRAMRequest#(Bit#(18), UInt#(32)) req = defaultValue;
       req.address = 18'h14;
       req.write   = True;
       req.datain  = 32'h22334455;
   
      wc_fifo[0].portA.request.put(req);
      req.datain  = 32'hBBBBBBBB;
      wc_fifo[1].portA.request.put(req);
       state <= 4;
    endrule

    rule step4(state == 4);
       let x <- wc_fifo[0].portA.response.get;
       let y <- wc_fifo[1].portA.response.get;       
       $display("BRAM01 Read = %x %x", x,y);
        state <= 5;
    endrule

    rule step5(state == 5);
       let x <- wc_fifo[2].portA.response.get;
       let y <- wc_fifo[3].portA.response.get;       
       $display("BRAM23 Read = %x %x", x,y);
        state <= 6;
    endrule

    rule done(state == 6);
        $display("TESTS FINISHED");
        $finish(0);
    endrule
endmodule
