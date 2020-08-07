<'

import fifo_intf.e; 
import fifo_str.e; 

unit fifo_drv_u { 

	fifo_wr_rd : bool ; 
    keep soft fifo_wr_rd == TRUE; 

	fifo_intf_i: fifo_intf_u; 
    
	fifo_str_i : list of fifo_str ; 
    
    event clk_drv; 
	
}; -- fifo_drv_u 

'> 