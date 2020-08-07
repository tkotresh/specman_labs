<' 
import fifo_env.e; 

unit fifo_base_test_u{ 
	fifo_env_i : fifo_env_u is instance; 
    
    
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
    	emit fifo_env_i.fifo_drv_i.clk_drv ; 
    }; -- clock_tb_r 
}; 


'> 