<'

import testbench.e; 


extend fifo_drv_u { 
    keep fifo_str_i.size() == 1; 
    
    on clk_drv{
    	print "Clock is emitted"; 
    }; 
    
    fifo_wr_rd_test() @clk_drv is{
    	var fifo_str_v : fifo_str; 
        var fifo_rd_data : input_data; 
        
        fifo_str_v = new; 
        
    	gen fifo_str_v  keeping { it.wr_fifo==1; it.rd_fifo == 1;  it.wr_addr == 0; it.rd_addr==0};  
        
        print fifo_str_v; 
        fifo_intf_i.i_wr$ = 0; 
        fifo_intf_i.i_rd$ = 0; 
        
        wait [1]*cycle; 
        
        fifo_wr_drive( fifo_str_v.wr_fifo, fifo_str_v.wr_data,fifo_str_v.wr_addr); 
        
        wait [1]*cycle; 
         -- fifo_intf_i.i_data$ = wr_data; 
            
        fifo_intf_i.i_wr$= 0; 
        
        -- Perform FIFO Read Operation.    
        fifo_rd_drive(fifo_str_v.rd_fifo, fifo_str_v.rd_addr); 
        wait [1]*cycle; 
   		fifo_rd_data = fifo_intf_i.o_data$; 
        fifo_intf_i.i_rd$ = 0; 
       
       	check that fifo_rd_data == fifo_str_v.wr_data  else dut_error("Incorrect Data Read from DUT"); 
        
    }; 
    
    fifo_rd_drive(rd:bit, rd_addr:*addr_type )  is{
       		fifo_intf_i.i_rd$ = rd;
            rd_addr+=1;         
    }; -- fifo_wr_drive 
    
    
    /* Write To FIFO */ 
    fifo_wr_drive(wr:bit, wr_data : input_data , wr_addr:*addr_type ) is{
    		-- FIFO INTF WR
    		fifo_intf_i.i_wr$ = wr;
            fifo_intf_i.i_data$ = wr_data; 
     }; -- fifo_wr_drive 
    
    run() is also{
    	start fifo_wr_rd_test();
    }; -- run m
    

}; -- fifo_drv_u  



unit fifo_wr_rd_test like  fifo_base_test_u{ 
	
    

}; -- fifo_wr_rd_test


'> 