<'


import pkt_types.e; 
import pkt_intf.e; 

-- Temporary Hack to avoid aliasing problem. 
import pkt_types.e; 
import pkt_intf.e; 
import mem_model.e; 

unit pkt_slv_drv{ 

	-- Clock Generated from Slave Agent. 
	event clock_e; 
    
    -- Instantiate Memory Model. 
    mem_model_i :  mem_model_s; 
    
    -- Slave Memory Model Interface. 
  	slv_intf_i 	  : slave pkt_intf; 
    
	-- Receive Driver Callbacks. 
    --receive_driver_cbs() is empty; 
    
    -- Receive Reset 
    --wait_for_reset() is empty; 
    
    -- Receive Driver. 
    receive_driver() @clock_e is{ 
       	var mem_obj : mem; 
        var rd_data :uint ;
        var mem_addr_v: uint ;
        var mem_data_v : uint; 
          
         mem_obj=new ; 
    
     while TRUE{ 
    	-- Wait for Reset. 
        -- wait_for_reset()
        -- Create callbacks. 
 		       
        -- Implement Driver.
    	if( slv_intf_i.req$ == 1   && slv_intf_i.wr_rd$==1) { 
     
     		mem_addr_v = slv_intf_i.addr_rx$; 
            mem_data_v = slv_intf_i.data_rx$ ; 
            mem_model_i.write_mem(mem_addr_v,mem_addr_v); 
            
        	message(LOW, " Write Data From Slave : ", mem_obj); 
        } else if(slv_intf_i.req$ == 1) { 
        	
            mem_obj.mem_addr = slv_intf_i.addr_rx$; 
           	rd_data=mem_model_i.read_mem(mem_obj.mem_addr); 
            message(LOW, " Read Data From Slave : ",rd_data); 
     
        }; -- if c 
      	  
        
      	wait cycle; 
        
      }; -- while l   
    
    }; -- receive_driver t 
	

	run() is also{
    	start receive_driver(); 
    }; -- run m 

}; -- pkt_slv_drv u


'> 