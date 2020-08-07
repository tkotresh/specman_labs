<'

import pkt_types.e; 
import pkt_intf.e; 
import pkt_item.e; 


-- This is a basic slave monitor interface. 

unit pkt_slv_mon { 

	event clock_e; 
	
	-- Create a default Unit Pointer for Slave Interface. 
    slv_intf_i :monitor pkt_intf; 
    
    !rx_pkt	   : RX pkt_str; 
    
    -- Store the list of packet from monitor Receive Interface. 
    !mon_pkt_rx : list of RX pkt_str; 
    
    
    -- Received Packet Stored in Buffer Port. 
    --rx_pkt_data : out buffer_port of int is instance; 
    -- Above will be used later for scoreboard. 
       
    mon_receive_pkt() @clock_e is{ 
    	var rec_pkt : RX pkt_str; 
        var req_bit : bit; 
        -- Create Hooks for Pre-Receive 
        
        
        -- Receive the Packet. 
        rec_pkt = new; 
        
        while TRUE{ 
        req_bit = slv_intf_i.req$; 
        
        if(req_bit == 1) { 
         	message(LOW, "New Packet is Being Observed on Receive Monitor" );
        	rec_pkt	= receive_packet(slv_intf_i); 
        	mon_pkt_rx.push(rec_pkt); 	
            message(LOW, "Received Packet at RX Agent Mon is:  ",rec_pkt); 
            print "Received packet : \n",rec_pkt; 
        
            message(HIGH , "Observed Packet is : ", mon_pkt_rx[0] ); 
         }; -- if c 
      
      	wait cycle; 
         
      	}; --while l
        
        
        -- Create Hooks for Post Receive Processing. 
    
    };-- mon_receive_pkt t
    
    
    -- Below method captures the data on the received data 
    -- Returns the received data as mon_pkt. 
    receive_packet(mon_intf:monitor pkt_intf):RX pkt_str is { 
    
    		var mon_pkt : RX pkt_str; 
            mon_pkt = new; 
            mon_pkt.data 	= mon_intf.data_tx$;
        	mon_pkt.addr	= mon_intf.addr_tx$;
            mon_pkt.req		= mon_intf.req$; 
            mon_pkt.ack		= mon_intf.ack$; 
            
            return mon_pkt; 
    }; -- capture_packet. 
	 
    run() is also{ 
    	start mon_receive_pkt(); 
    }; -- run m
    
    
}; -- pkt_slv_mon 


'> 