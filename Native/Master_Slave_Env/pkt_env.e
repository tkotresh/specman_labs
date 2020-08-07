<' 

-- Instantiate Master Agent.

unit pkt_env { 

    -- Instantiate Master Agent. 
    pkt_mstr_agt_i : pkt_mstr_agt  is instance ; 
    
    -- Instantiate Slave Agent
    pkt_slv_agt_i  : pkt_slv_agt   is instance  ; 
    
    -- Bind Master Slave Signals. 
    keep bind(pkt_slv_agt_i.pkt_slv_intf_i.data_rx,pkt_mstr_agt_i.pkt_mstr_intf_i.data_tx); 
	keep bind(pkt_slv_agt_i.pkt_slv_intf_i.addr_rx,pkt_mstr_agt_i.pkt_mstr_intf_i.addr_tx); 
    keep bind(pkt_slv_agt_i.pkt_slv_intf_i.req,pkt_mstr_agt_i.pkt_mstr_intf_i.req); 
    keep bind(pkt_slv_agt_i.pkt_slv_intf_i.ack,pkt_mstr_agt_i.pkt_mstr_intf_i.ack);
    keep bind(pkt_slv_agt_i.pkt_slv_intf_i.wr_rd,pkt_mstr_agt_i.pkt_mstr_intf_i.wr_rd);
    
    -- Bind Monitor Signals. 
    keep bind(pkt_mstr_agt_i.pkt_mon_intf_i.data_tx,pkt_mstr_agt_i.pkt_mstr_intf_i.data_tx); 
	keep bind(pkt_mstr_agt_i.pkt_mon_intf_i.addr_tx,pkt_mstr_agt_i.pkt_mstr_intf_i.addr_tx); 
    keep bind(pkt_mstr_agt_i.pkt_mon_intf_i.req,pkt_mstr_agt_i.pkt_mstr_intf_i.req); 
    keep bind(pkt_mstr_agt_i.pkt_mon_intf_i.ack,pkt_mstr_agt_i.pkt_mstr_intf_i.ack);
    keep bind(pkt_mstr_agt_i.pkt_mon_intf_i.wr_rd,pkt_mstr_agt_i.pkt_mstr_intf_i.wr_rd);
    
    -- Bind Slave Monitor Signals. 
    -- Change the agents to slave later
    keep bind(pkt_slv_agt_i.pkt_mon_intf_i.data_tx,pkt_mstr_agt_i.pkt_mstr_intf_i.data_tx); 
	keep bind(pkt_slv_agt_i.pkt_mon_intf_i.addr_tx,pkt_mstr_agt_i.pkt_mstr_intf_i.addr_tx); 
    keep bind(pkt_slv_agt_i.pkt_mon_intf_i.req,pkt_mstr_agt_i.pkt_mstr_intf_i.req); 
    keep bind(pkt_slv_agt_i.pkt_mon_intf_i.ack,pkt_mstr_agt_i.pkt_mstr_intf_i.ack);
    keep bind(pkt_slv_agt_i.pkt_mon_intf_i.wr_rd,pkt_mstr_agt_i.pkt_mstr_intf_i.wr_rd);
    
    
	-- This is printed First 
	--on clock_tb{
    --	print "Clock is emitted @ ",sys.time; 
    --};
    
}; -- pkt_env u 

'> 
