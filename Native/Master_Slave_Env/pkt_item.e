<' 

-- Create Simple Packet Struct. 
struct pkt_str{ 

	-- Transaction Packet Type. 
    pkt_txn_enum : pkt_txn_t ; 
    

	-- Place Holder for Messages. 
    print_me() is empty; 
    
	when TX'pkt_txn_enum pkt_str { 
	-- Default Generated value is non-zero. 
	%data : uint ; 
    keep soft data in [1..100]; 
    
    -- Address Generated for Packet Transaction Type. 
    %addr : uint ; 
    keep soft addr < 100; 
    
    -- Packet Transaction Enum Type. 
    %pkt_trans_enum : pkt_trans_t ;
    keep soft pkt_trans_enum == write ; 
    
    %req	   : bit; 
    keep soft req == 1; 
    
    !ack	   : bit; 
    keep soft ack == 0; 
    
    print_me() is { 
    	me.do_print(); 
   	}; -- print_me 
    
    }; -- TX pkt_str 
    
    when RX'pkt_txn_enum pkt_str { 
	-- Default Generated value is non-zero. 
	!data : uint ; 
    
    -- Address Generated for Packet Transaction Type. 
    %addr : uint ; 
    
    -- Packet Transaction Enum Type. 
    !pkt_trans_enum : pkt_trans_t ;
    
    -- Request Packet 
    req   : bit; 
    
    -- Acknowledge Packet. 
    ack	  : bit; 
    
    print_me() is { 
    	me.do_print(); 
   	}; -- print_me 
    
    }; -- RX pkt_str 
   

}; -- pkt_str str

'> 
 
 