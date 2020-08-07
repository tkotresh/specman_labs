<'

import fifo_types.e; 

unit fifo_intf_u{ 
	-- Write Interface. 
	i_wr   : out simple_port of bit is instance; 
    i_data : out simple_port of input_data is instance;
    o_full : in simple_port of bit is instance; 
    o_fill :  out simple_port of LGFLEN is instance; 
    
    -- Bind the HDL Path: 
    keep i_wr.hdl_path() == "i_wr"; 
    keep bind(i_wr,external); 
    --keep i_wr.verilog_wire() == TRUE; 
    
    keep i_data.hdl_path() == "i_data"; 
    keep bind(i_data,external); 
    --keep i_data.verilog_wire() == TRUE; 
    keep i_data.declared_range() == "[7:0]"; 
    
    keep o_full.hdl_path() == "o_full"; 
    keep bind(o_full,external); 
    
    keep o_fill.hdl_path() == "o_fill"; 
    keep bind(o_fill,external); 
    
    -- Read Interface. 
    i_rd   : out simple_port of bit is instance;
    o_data : in simple_port of input_data is instance;
    o_empty : in simple_port of bit is instance; 

	-- Bind the HDL Path: 
    keep i_rd.hdl_path() 	== "i_rd"; 
    keep bind(i_rd,external); 
   -- keep i_rd.verilog_wire() == TRUE; 
    
    keep o_data.hdl_path() 	== "o_data"; 
    keep bind(o_data,external); 
    
    keep o_empty.hdl_path() == "o_empty"; 
    keep bind(o_empty,external); 
    
    run() is also{ 
    	i_data$ = 200; 
    }; 
}; -- fifo_intf_u 


'> 