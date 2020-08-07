<'
--------------------------------------------------------------
-- Code your testbench here.
-- Doc: 
-- 		This testbench verifies the FIFO Design. 
-- Features: 
-- 		Addition of test layers. 
-- 		Feature based test cases for different sequences. 
-- 		
--------------------------------------------------------------

import fifo_str.e;
import fifo_intf.e; 
import fifo_env.e; 
import fifo_base_test.e; 


extend sys { 
	fifo_base_test_i : fifo_base_test_u is instance; 
    
    	-- 2.Create a Clock Port and Hook it to DUT with simple_port
    clk_i 		   :  in simple_port of bit is instance ;
    keep clk_i.hdl_path() 	== "tb.clk" ;
    keep bind (clk_i, external);  
    
    -- 3. Create clock with interface ports 
    -- 4. Create clock with event_port is instance. 
       
    -- 2. Create TB Clock 
    event 	clock_tb_r is rise(clk_i$) @sim;
    event 	clock_tb_f is fall(clk_i$) @sim;
    
}; -- end sys 





'>