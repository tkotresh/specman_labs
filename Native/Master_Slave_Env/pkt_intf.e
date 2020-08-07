<'

unit pkt_intf { 

-- Define Packet Interface Kind. 
	pkt_agent_enum : pkt_agent_t ; 
    
    when master'pkt_agent_enum pkt_intf { 
    	data_tx : out simple_port of int is instance;
        -- Use Below for Binding DUT Signals. 
        --keep data_tx.hdl_path() == "data_tx"; 
        --keep bind(data_tx,external); 
        
        addr_tx : out simple_port of int is instance; 
        -- Use Below for Binding DUT Signals. 
        --keep addr_tx.hdl_path() == "data_tx"; 
        --keep bind(addr_tx,external); 
        
        
        req : out simple_port of bit is instance; 
        -- Use Below for Binding DUT Signals. 
        --keep data_tx.hdl_path() == "req"; -- make it req 
        --keep bind(req_tx,external); 
        
        ack : in simple_port of bit is instance ; 
        -- Use Below for Binding DUT Signals. 
        --keep ack_tx.hdl_path() == "ack"; -- make it ack 
        --keep bind(ack_tx,external); 
        
        wr_rd : out simple_port of bit is instance; 
         
    }; -- pkt_intf ws
    
    when slave'pkt_agent_enum pkt_intf { 
    	data_rx : in simple_port of int is instance;
        -- Use Below for Binding DUT Signals. 
        --keep data_rx.hdl_path() == "data_rx"; 
        --keep bind(data_rx,external); 
        
        addr_rx	: in simple_port of int is instance ; 
        
        req		: in simple_port of bit is instance; 
        
        ack 	: out simple_port of bit is instance; 
        
        wr_rd   : in simple_port of bit is instance; 
        
    }; -- pkt_intf ws
    
    when monitor'pkt_agent_enum pkt_intf{ 
    
    	data_tx : in simple_port of int is instance;
        -- Use Below for Binding DUT Signals. 
        --keep data_tx.hdl_path() == "data_tx"; 
        --keep bind(data_tx,external); 
        
        addr_tx : in simple_port of int is instance; 
        -- Use Below for Binding DUT Signals. 
        --keep addr_tx.hdl_path() == "data_tx"; 
        --keep bind(addr_tx,external); 
        
        
        req : in simple_port of bit is instance; 
        -- Use Below for Binding DUT Signals. 
        --keep data_tx.hdl_path() == "req"; -- make it req 
        --keep bind(req_tx,external); 
        
        ack : in simple_port of bit is instance ; 
        -- Use Below for Binding DUT Signals. 
        --keep ack_tx.hdl_path() == "ack"; -- make it ack 
        --keep bind(ack_tx,external); 
        
        wr_rd : in simple_port of bit is instance; 
            
    }; -- pkt_intf ws

}; -- pkt_intf u




'> 
 