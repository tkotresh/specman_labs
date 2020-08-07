<'

-----------------------------------------------------------------------------------------------
-- EG : 4. 

-- This example will implement simple Master Slave Environment Using 'E'
-- The clock will be generated from HDL and Other aspects are taken care in 'E' Agents. 

-- The environment creates basic Agents for Tx and RX explicitly. 
-- For Simplicity Scoreboard Hooks are Not Added. 
-- Learning	 : Generation, Driving, Monitoring Concepts with TX and RX Modeling. 
-- Extensions: Create different packet structures like illegal, back to back etc. 
-- 			   Extend the same using callbacks, Add Coverage Hooks. 
-- 			   Create a score-board. 
--			   Encapsulate agents in environment. 
-- 			   Create External HDL Binding. 
-- 			   Coverage Gathering. 
--			   Temporal Expressions. 
-- 			   Enhance for different Signal Mapping using Config. 
-- 			   Agent Configuration. 
--			   Reset Mechanism
-- 			   MVL TYPES. 
-- 			   Add Test Layer. 
------------------------------------------------------------------------------------------------

import top.e; 

extend sys{
	
    -- Instance of Packet Environment. 
    pkt_env_i : pkt_env is instance; 
    
    --1. Create Tb Clock 
    --event clock_tb is rise('tb.clk') @sim; 

	-- 2.Create a Clock Port and Hook it to DUT with simple_port
    clk_i 		   :  in simple_port of bit is instance ;
    keep clk_i.hdl_path() 	== "tb.clk" ;
    keep bind (clk_i, external);  
    
    -- 3. Create clock with interface ports 
    -- 4. Create clock with event_port is instance. 
       
    -- 2. Create TB Clock 
    event 	clock_tb_r is rise(clk_i$) @sim;
    event 	clock_tb_f is fall(clk_i$) @sim;
    
   on clock_tb_r { 
   		emit pkt_env_i.pkt_mstr_agt_i.clock_tb_r; 
        emit pkt_env_i.pkt_slv_agt_i.clock_tb_r;
   }; 
   
   on clock_tb_f { 
   		emit pkt_env_i.pkt_mstr_agt_i.clock_tb_f; 
        emit pkt_env_i.pkt_slv_agt_i.clock_tb_f; 
   }; 
    
    -- Simple Clock Generation TCM() Check. 
    clock_tcm() @clock_tb_r is{
    
    	var i : int; 
        
        -- Exhausted after 8 Cycles 
        for i from 8 down to 0 do {
        	wait [1]*cycle; -- Event to make sure all clocks are exhausted. 
            print "Clock is generated @time ",sys.time; 
        }; --for l
     
         
    }; -- clock_tcm 
    
    run() is also{ 
       	-- Start the TCM. 
    	start clock_tcm();  
    }; -- run 
    
      
    setup() is also {
      set_config(run,tick_max,UNDEF);
    }; // setup() is also...

};  -- sys s

'> 
