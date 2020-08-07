<'
import pkt_intf.e;

-- Import All Files 
unit pkt_mstr_agt { 

	-- Kind of Environment. 
    active_passive_enum : active_passive_enum_t; 
    keep active_passive_enum == active ; 
    
    --pkt_agent_enum		: pkt_agent_t  ; 
    --keep  pkt_agent_enum 	 == master ; 
    
	-- Instantiate Master Components 
    pkt_mstr_mon_i : pkt_mstr_mon  is instance; 
    pkt_mstr_drv_i : pkt_mstr_drv  is instance ; 
    
    event clock_tb_r ; 
    
    event clock_tb_f ; 
    
    on clock_tb_r{
    	emit	pkt_mstr_drv_i.clock_e ; 
    };
    
    on clock_tb_f{ 
    	emit    pkt_mstr_mon_i.clock_e ; 
    }; 
    
    -- Instantiate Interface Used for Agent
   	pkt_mstr_intf_i  : master  pkt_intf is instance ;  
	pkt_mon_intf_i   : monitor pkt_intf is instance ;  
	
    keep pkt_mstr_drv_i.mstr_intf_i == pkt_mstr_intf_i; 
    keep pkt_mstr_mon_i.mstr_intf_i == pkt_mon_intf_i; 
    
    --keep pkt_mon_intf_i.monitor_intf_i == pkt_mstr_mon_i; 
    
}; -- pkt_mstr_agt

unit pkt_slv_agt { 

	-- Kind of Environment. 
    active_passive_enum : active_passive_enum_t; 
    keep active_passive_enum == passive ; 
      
	-- Instantiate Slave Components. 
    pkt_slv_drv_i : pkt_slv_drv is instance; 
    pkt_slv_mon_i : pkt_slv_mon  is instance; 
       
	-- Instantiate Interface Used for Agent
   	pkt_slv_intf_i  : slave pkt_intf is instance ;
    
    pkt_mon_intf_i 	: monitor pkt_intf is instance; 
    
	keep pkt_slv_mon_i.slv_intf_i == pkt_mon_intf_i; 
    keep pkt_slv_drv_i.slv_intf_i  == pkt_slv_intf_i; 
    
    event clock_tb_r; 
    event clock_tb_f; 
    
    
    on clock_tb_r{ 
    	emit    pkt_slv_mon_i.clock_e ; 
        emit    pkt_slv_drv_i.clock_e ; 
    }; 
    
    
 	on clock_tb_f{ 
    --	emit    pkt_slv_mon_i.clock_e ; 
     --   emit    pkt_slv_drv_i.clock_e ; 
    }; 
    
}; -- pkt_slv_agt 


'>
