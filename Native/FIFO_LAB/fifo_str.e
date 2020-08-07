<'

-- This code implements fifo models for both read and write. 

import fifo_types.e; 

struct fifo_str { 

	%wr_fifo: bit ; 
    !wr_addr: addr_type; 
    !wr_fill: LGFLEN;
    !wr_full: bit; 
    %wr_data : input_data; 
    
    wr_fifo_m( wr: bit , wr_data: input_data, wr_addr: *addr_type, wr_fill: LGFLEN,wr_full:bit) is empty; 
    
	%rd_fifo: bit ; 
    !rd_addr: addr_type; 
    !rd_fill: LGFLEN;
    !rd_full: bit; 
    !rd_empty : bool ; 
    !rd_data  : input_data; 
    
    
    rd_fifo_m( rd: bit , rd_addr: *addr_type, 	rd_fill:LGFLEN,rd_full:bit,o_empty:bool):input_data is empty; 

}; -- fifo_str 


extend fifo_str { 

	fifo_mem : list of uint(bits:8) ; 
    
	wr_fifo_m( wr: bit , wr_data : input_data,  wr_addr: *addr_type, wr_fill: LGFLEN,wr_full:bit) is { 
    	if ( wr.as_a(bool) && !wr_full.as_a(bool) ) { 
    		fifo_mem.push(wr_data); 
            wr_addr+=1;
        }; -- if
    }; --wr_fifo_m
    

    
    rd_fifo_m(rd : bit , rd_addr: *addr_type , rd_fill : LGFLEN, rd_full:bit,o_empty:bool) : input_data is {
    	var rd_data:input_data; 
        
    	if ( rd.as_a(bool) && !o_empty ) { 
    		rd_data=fifo_mem[rd_addr]; 
            rd_addr+=1;
        }; -- if
        result=rd_data; 
        
    }; -- rd_fifo_m 

}; -- fifo_str


'> 