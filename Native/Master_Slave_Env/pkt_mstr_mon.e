<'
import pkt_types.e; 
import pkt_intf.e; 
import pkt_item.e; 

unit pkt_mstr_mon{

	-- Capture data on Falling Edge. 
	event clock_e ;  
    
    -- Create a default Unit Pointer for Master Interface. 
    mstr_intf_i : monitor pkt_intf;   
    --mstr_intf_i : master pkt_intf; 
    
    -- Create the packet to be captured. 
    !mon_pkt_tx : list of TX pkt_str; 
    
    -- Received Packet Stored in Buffer Port for post Processing in Scoreboard. 
    --tx_pkt_data : list of  out buffer_port of int is instance; 
    -- Above is used for sending data to scoreboard later. 
    
    -- The monitor TCM will check the status of request signal. 
    -- Grabs packet when request is high. 
    -- The data will also be put in buffer port in next example. 
    
    mon_send_pkt() @clock_e is{ 
    
    	var cap_pkt : TX pkt_str; 
        var req_bit : bit; 
        
        cap_pkt = new; 
        
        while TRUE{ 
        req_bit = mstr_intf_i.req$; 
        
        if(req_bit == 1) { 
         	message(LOW, "New Packet is Being Observed" );
        	cap_pkt	= capture_packet(mstr_intf_i); 
        	mon_pkt_tx.push(cap_pkt); 	
            message(LOW, "Send Packet is Captured ",cap_pkt); 
            print "captured packet : \n",cap_pkt; 
        
            message(HIGH , "Observed Packet is : ", mon_pkt_tx[0] ); 
         }; -- if c 
         wait cycle; 
         
      	}; --while l
        
    };-- mon_send_pkt t
    
    -- Below method captures the data on the transmitted data 
    -- Returns the captured data as mon_pkt. 
    capture_packet(mon_intf:monitor pkt_intf):TX pkt_str is { 
    
    		var mon_pkt : TX pkt_str; 
            mon_pkt = new; 
            mon_pkt.data 	= mon_intf.data_tx$;
        	mon_pkt.addr	= mon_intf.addr_tx$;
            mon_pkt.req		= mon_intf.req$; 
            mon_pkt.ack		= mon_intf.ack$; 
            
            return mon_pkt; 
    }; -- capture_packet. 
	 
    run() is also{ 
    	start mon_send_pkt(); 
    }; -- run m
}; -- pkt_mstr_mon u


'> 