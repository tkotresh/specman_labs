<' 
import fifo_intf.e; 
import fifo_drv.e; 


unit fifo_env_u { 

	--fifo_agent_i : fifo_agent_u is instance; 
    fifo_drv_i 	: fifo_drv_u is instance; 
   
    
	fifo_intf_i  : fifo_intf_u is instance; 
    keep fifo_intf_i.hdl_path() == "tb";

	keep fifo_drv_i.fifo_intf_i == fifo_intf_i ; 
    
}; -- fifo_env_u


'> 