<'

-- Defines all types used in environment. 
type active_passive_enum_t : [active,passive] ;
type pkt_agent_t 		   : [master,slave,monitor]  ;

-- Packet Transaction Write or Read 
type pkt_trans_t  		   : [write=1,read=0] ;

-- Packet Tranmit Direction. 
type pkt_txn_t 			   : [TX,RX] ; 

-- Memory Types
type mem_data_t : uint(bits:32) ; 
type mem_addr_t : uint(bits:16) ; 

'>