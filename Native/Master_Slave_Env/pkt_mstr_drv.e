<'

import pkt_types.e; 
import pkt_intf.e; 
import pkt_item.e ; 

unit pkt_mstr_drv { 

	event clock_e ;  
    
    -- Packet Instance; 
    pkt_str_i	: TX	pkt_str; 
    
    -- Create a default Unit Pointer for Master Interface. 
    mstr_intf_i : master pkt_intf; 
    
    -- Future Reset Modelling. 
    wait_for_reset() is empty; 
    
    -- Pre- Hooks for Transmitting Illegal Packet. 
    send_illegal_packet() is empty; 
    
    -- Post - Processing Hooks for Coverage, Etc.
    send_packet_post_cb() is empty; 
    
    
    drv_send_pkt() @clock_e is{ 
    
    	var num_of_pkts : uint; 
        
    	-- Reset 
        	wait_for_reset();
            
        -- Generate and  Send
        --for(num_of_pkts=0; num_of_pkts < 10 ; num_of_pkts+=1) do{ 
        for  num_of_pkts from 0 to 10 do{ 
        	
            gen pkt_str_i; 
        	send_illegal_packet(); 
            send_packet(pkt_str_i,num_of_pkts); 
        	wait cycle; 
             
         	mstr_intf_i.req$	 = 1'b0; 
  			
            wait cycle; 
            
            pkt_str_i.pkt_trans_enum = read; 
            send_packet(pkt_str_i,num_of_pkts); 
        	wait cycle; 
             
         	mstr_intf_i.req$	 = 1'b0; 
  			
            wait cycle; 
        	-- CB's 
        	send_packet_post_cb(); 
        	-- Post Processing. 
    	
        }; -- end for 
        
        -- Below is limitation Improvise it later. 
        wait [10]*cycle ; 
        stop_run(); 
        
    };-- drv_send_pkt t
    
    send_packet(send_pkt:TX pkt_str,num_pkts:uint) is { 
    
    	message(LOW,"Started Sending Packet ", num_pkts," across TX Interface"); 
        
        mstr_intf_i.data_tx$ = send_pkt.data; 
        mstr_intf_i.addr_tx$ = send_pkt.addr; 
        mstr_intf_i.req$	 = send_pkt.req; 
        mstr_intf_i.wr_rd$   = send_pkt.pkt_trans_enum.as_a(bit) ; 
          
        message(LOW,"Ending Sending Packet ",num_pkts," across TX Interface ");
        print "Sent Packet",send_pkt; 
        
    }; -- send_packet m 
    
    run() is also{
    	start	drv_send_pkt(); 
    }; 
    
}; -- pkt_mstr_drv u

'> 