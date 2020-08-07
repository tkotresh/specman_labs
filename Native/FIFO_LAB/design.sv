// Code your design here
////////////////////////////////////////////////////////////////////////////////
//
// Filename: 	sfifo.v
//
// Project:	Verilog Tutorial Example file
//
// Purpose:	A synchronous data FIFO.
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
//
// Written and distributed by Gisselquist Technology, LLC
//
// This program is hereby granted to the public domain.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.
//
////////////////////////////////////////////////////////////////////////////////
//
//
`default_nettype	none
//

module tb(); 
	
  	 bit clk; 
  	 logic  i_wr,i_rd; 
  	 logic [7:0] i_data; 
  	 reg [7:0] o_data; 
  	 bit [3:0] o_fill; 
  	 bit o_full,o_empty; 
  
  	 initial 
       begin  
       	forever #30  clk = ~clk; 
       end
  	
     initial
       #600 $finish; 
  
  	  initial 
        begin 
          $dumpfile("dump.vcd"); 
          $dumpvars ; 
        end 
  
  	 sfifo sfifo_i(clk, i_wr, i_data, o_full, o_fill, i_rd, o_data, o_empty);
  
endmodule // tb 


module sfifo(i_clk, i_wr, i_data, o_full, o_fill, i_rd, o_data, o_empty);
	parameter	BW=8;	// Byte/data width
	parameter 	LGFLEN=4;
	//
	//
	input	wire		i_clk;
	//
	// Write interface
	input	wire		i_wr;
	input	wire [(BW-1):0]	i_data;
	output	reg 		o_full;
	output	reg [LGFLEN:0]	o_fill;
	//
	// Read interface
	input	wire		i_rd;
	output	reg [(BW-1):0]	o_data;
	output	reg		o_empty;	// True if FIFO is empty
	// 

	reg	[(BW-1):0]	fifo_mem[0:(1<<LGFLEN)-1];
	reg	[LGFLEN:0]	wr_addr, rd_addr;
	reg	[LGFLEN-1:0]	rd_next;


	wire	w_wr = (i_wr && !o_full);
	wire	w_rd = (i_rd && !o_empty);

	//
	// Write a new value into our FIFO
	//
	initial	wr_addr = 0;
	always @(posedge i_clk)
	if (w_wr)
		wr_addr <= wr_addr + 1'b1;

	always @(posedge i_clk)
	if (w_wr)
		fifo_mem[wr_addr[(LGFLEN-1):0]] <= i_data;

	//
	// Read a value back out of it
	//
	initial	rd_addr = 0;
	always @(posedge i_clk)
	if (w_rd)
		rd_addr <= rd_addr + 1;

  always @(posedge i_clk)
    if (w_rd)
		o_data = fifo_mem[rd_addr[LGFLEN-1:0]];

	//
	// Return some metrics of the FIFO, it's current fill level,
	// whether or not it is full, and likewise whether or not it is
	// empty
	//
  always_comb
    	o_fill = wr_addr - rd_addr;
  
  always_comb
		o_full = o_fill == { 1'b1, {(LGFLEN){1'b0}} };
  
  always_comb
		o_empty = (o_fill  == 0);


	always @(*)
		rd_next = rd_addr[LGFLEN-1:0] + 1;


	// Make Verilator happy
	// verilator lint_off UNUSED
	wire	[LGFLEN-1:0]	unused;
	assign	unused = rd_next;
	// verilator lint_on  UNUSED


endmodule
