<'

-- This file implements generic memory model that can be configured and used for the 
-- Slave Testbench. 

struct mem { 
	
    -- Memory Model Data and Address. 
    mem_addr : mem_data_t; 
	mem_data : mem_addr_t; 
    
}; --mem s 


struct mem_model_s{ 
	    
        -- Define Memory Array 
        !mem_arr	 : list (key : mem_addr) of mem;
        
        -- Override Bit 
        override_bit : bit ; 
        keep soft override_bit == 1 ; 
        
        
        write_mem( wr_addr: uint , wr_data : uint ) is { 
        		
                	var mem_obj : mem ;
                    mem_obj = new; 
                    mem_obj.mem_addr = wr_addr;
                    mem_obj.mem_data = wr_data; 
                
                message(LOW, "Started Writing Data to Memory Model"); 
                	if (mem_arr.key_exists(wr_addr)) { 
                    	if(override_bit == 1) { 
                        	mem_arr.add(mem_obj); 
                        }; -- if c
                    }else { 
                    		mem_arr.add(mem_obj); 		
                    }; -- if c
                message(LOW, "Ended Writing Data to Memory Model"); 
                    
        }; -- write_mem m 
    

		read_mem ( rd_addr : mem_addr_t ) : mem_data_t  is { 
        
                	if ( mem_arr.key_exists(rd_addr) ) {        
                   		result=mem_arr.key(rd_addr).mem_data ; 
                    } else { 
                    	message(LOW, "No Data is available in Memory Read Location"); 
                    }; -- if c
                
        }; -- read_mem m 


}; -- mem_model_s s


'> 