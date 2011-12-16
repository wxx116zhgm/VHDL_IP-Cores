#------------------------------------------------------------------------------------------------------------------------
#-- POWERLINK XPS PLB Component (TCL)
#--
#-- 	  Copyright (C) 2011 B&R
#--
#--    Redistribution and use in source and binary forms, with or without
#--    modification, are permitted provided that the following conditions
#--    are met:
#--
#--    1. Redistributions of source code must retain the above copyright
#--       notice, this list of conditions and the following disclaimer.
#--
#--    2. Redistributions in binary form must reproduce the above copyright
#--       notice, this list of conditions and the following disclaimer in the
#--       documentation and/or other materials provided with the distribution.
#--
#--    3. Neither the name of B&R nor the names of its
#--       contributors may be used to endorse or promote products derived
#--       from this software without prior written permission. For written
#--       permission, please contact office@br-automation.com
#--
#--    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
#--    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#--    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
#--    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
#--    COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
#--    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
#--    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#--    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#--    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
#--    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
#--    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#--    POSSIBILITY OF SUCH DAMAGE.
#--
#------------------------------------------------------------------------------------------------------------------------
#-- Version History
#------------------------------------------------------------------------------------------------------------------------
#-- 2011-11-18	V0.01	zelenkaj	converted to first stable solution with MAC-layer only
#-- 2011-11-01	V0.02	mairt	added procedures for the powerlink gui 
#-- 2011-12-06	V0.03	mairt	added packet size calculation, better async buffer handling and bugfixes
#-- 2011-12-14	V0.04	mairt	enhancement of the driver generate procedure
#------------------------------------------------------------------------------------------------------------------------

#uses "xillib.tcl"

###################################################
## driver generate statement
###################################################
proc generate {drv_handle} {
	puts "###################################"
	puts "POWERLINK IP-Core found!"
	
	set periph [xget_periphs $drv_handle]  
	
	#internal vars
	set ip_core_mode [xget_param_value $periph "C_IP_CORE_MODE"]
	set pack_lock [xget_param_value $periph "C_PACKET_LOCATION"]
	set second_phy [xget_param_value $periph "C_USE_2ND_PHY"] 
	set dma_observer [xget_param_value $periph "C_OBSERVER_ENABLE"]
	
	# calc new phy count value
	if { $second_phy } {
		  set C_PHY_COUNT {C_PHY_COUNT 2}
	} else {
		  set C_PHY_COUNT {C_PHY_COUNT 1}
	} 
	
	# calc new dma observer value
	if { $dma_observer} {
		  set C_OBSERVER_ENABLE {C_OBSERVER_ENABLE 1}
	} else {
		  set C_OBSERVER_ENABLE {C_OBSERVER_ENABLE 0}
	} 
	
	if { $ip_core_mode == 0} {
		# Direct IO		  
		puts "POWERLINK IP-Core in Direct IO mode!"
		if { $pack_lock == 2 } {
			# all packets are external
			my_xdefine_include_file $drv_handle "xparameters.h" "plb_powerlink" "C_MAC_REG_BASEADDR" "C_MAC_REG_HIGHADDR" "C_MAC_CMP_BASEADDR" "C_MAC_CMP_HIGHADDR" "C_SMP_PCP_BASEADDR" "C_SMP_PCP_HIGHADDR" "C_PACKET_LOCATION" $C_PHY_COUNT $C_OBSERVER_ENABLE "C_MAC_PKT_SIZE" "C_MAC_RX_BUFFERS"
		} else {
			# there are internal packets									  
			my_xdefine_include_file $drv_handle "xparameters.h" "plb_powerlink" "C_MAC_REG_BASEADDR" "C_MAC_REG_HIGHADDR" "C_MAC_CMP_BASEADDR" "C_MAC_CMP_HIGHADDR" "C_MAC_PKT_BASEADDR" "C_MAC_PKT_HIGHADDR" "C_SMP_PCP_BASEADDR" "C_SMP_PCP_HIGHADDR" "C_PACKET_LOCATION" $C_PHY_COUNT $C_OBSERVER_ENABLE "C_MAC_PKT_SIZE" "C_MAC_RX_BUFFERS"						  
		}
	} elseif { $ip_core_mode == 1} {
		# PDI with pap		  
		puts "POWERLINK IP-Core in PDI mode with parallel interface!"
		if { $pack_lock == 2 } {
			# all packets are external
			my_xdefine_include_file $drv_handle "xparameters.h" "plb_powerlink" "C_MAC_REG_BASEADDR" "C_MAC_REG_HIGHADDR" "C_MAC_CMP_BASEADDR" "C_MAC_CMP_HIGHADDR" "C_PDI_PCP_BASEADDR" "C_PDI_PCP_HIGHADDR" "C_PACKET_LOCATION" $C_PHY_COUNT $C_OBSERVER_ENABLE "C_MAC_PKT_SIZE" "C_MAC_RX_BUFFERS"
		} else {
			# there are internal packets									  
			my_xdefine_include_file $drv_handle "xparameters.h" "plb_powerlink" "C_MAC_REG_BASEADDR" "C_MAC_REG_HIGHADDR" "C_MAC_CMP_BASEADDR" "C_MAC_CMP_HIGHADDR" "C_MAC_PKT_BASEADDR" "C_MAC_PKT_HIGHADDR" "C_PDI_PCP_BASEADDR" "C_PDI_PCP_HIGHADDR" "C_PACKET_LOCATION" $C_PHY_COUNT $C_OBSERVER_ENABLE "C_MAC_PKT_SIZE" "C_MAC_RX_BUFFERS"						  
		}
	} elseif { $ip_core_mode == 3} {
		# PDI with spi		  
		puts "POWERLINK IP-Core in PDI mode with SPI interface!"
		if { $pack_lock == 2 } {
			# all packets are external
			my_xdefine_include_file $drv_handle "xparameters.h" "plb_powerlink" "C_MAC_REG_BASEADDR" "C_MAC_REG_HIGHADDR" "C_MAC_CMP_BASEADDR" "C_MAC_CMP_HIGHADDR" "C_PDI_PCP_BASEADDR" "C_PDI_PCP_HIGHADDR" "C_PACKET_LOCATION" $C_PHY_COUNT $C_OBSERVER_ENABLE "C_MAC_PKT_SIZE" "C_MAC_RX_BUFFERS"
		} else {
			# there are internal packets									  
			my_xdefine_include_file $drv_handle "xparameters.h" "plb_powerlink" "C_MAC_REG_BASEADDR" "C_MAC_REG_HIGHADDR" "C_MAC_CMP_BASEADDR" "C_MAC_CMP_HIGHADDR" "C_MAC_PKT_BASEADDR" "C_MAC_PKT_HIGHADDR" "C_PDI_PCP_BASEADDR" "C_PDI_PCP_HIGHADDR" "C_PACKET_LOCATION" $C_PHY_COUNT $C_OBSERVER_ENABLE "C_MAC_PKT_SIZE" "C_MAC_RX_BUFFERS"						  
		}
	} elseif { $ip_core_mode == 4} {
		# PDI with plb interface		  
		puts "POWERLINK IP-Core in PDI mode with PLB interface!" 
		if { $pack_lock == 2 } {
			# all packets are external
			my_xdefine_include_file $drv_handle "xparameters.h" "plb_powerlink" "C_MAC_REG_BASEADDR" "C_MAC_REG_HIGHADDR" "C_MAC_CMP_BASEADDR" "C_MAC_CMP_HIGHADDR" "C_PDI_PCP_BASEADDR" "C_PDI_PCP_HIGHADDR" "C_PDI_AP_BASEADDR" "C_PDI_AP_HIGHADDR" "C_PACKET_LOCATION" $C_PHY_COUNT $C_OBSERVER_ENABLE "C_MAC_PKT_SIZE" "C_MAC_RX_BUFFERS"
		} else {
			# there are internal packets									  
			my_xdefine_include_file $drv_handle "xparameters.h" "plb_powerlink" "C_MAC_REG_BASEADDR" "C_MAC_REG_HIGHADDR" "C_MAC_CMP_BASEADDR" "C_MAC_CMP_HIGHADDR" "C_MAC_PKT_BASEADDR" "C_MAC_PKT_HIGHADDR" "C_PDI_PCP_BASEADDR" "C_PDI_PCP_HIGHADDR" "C_PDI_AP_BASEADDR" "C_PDI_AP_HIGHADDR" "C_PACKET_LOCATION" $C_PHY_COUNT $C_OBSERVER_ENABLE "C_MAC_PKT_SIZE" "C_MAC_RX_BUFFERS"						  
		}
	} elseif { $ip_core_mode == 5} {
		# PDI with pap		  
		puts "POWERLINK IP-Core in openMAC only mode!"
		if { $pack_lock == 2 } {
			# all packets are external
			my_xdefine_include_file $drv_handle "xparameters.h" "plb_powerlink" "C_MAC_REG_BASEADDR" "C_MAC_REG_HIGHADDR" "C_MAC_CMP_BASEADDR" "C_MAC_CMP_HIGHADDR" "C_PACKET_LOCATION" $C_PHY_COUNT $C_OBSERVER_ENABLE "C_MAC_PKT_SIZE" "C_MAC_RX_BUFFERS"
		} else {
			# there are internal packets									  
			my_xdefine_include_file $drv_handle "xparameters.h" "plb_powerlink" "C_MAC_REG_BASEADDR" "C_MAC_REG_HIGHADDR" "C_MAC_CMP_BASEADDR" "C_MAC_CMP_HIGHADDR" "C_MAC_PKT_BASEADDR" "C_MAC_PKT_HIGHADDR" "C_PACKET_LOCATION" $C_PHY_COUNT $C_OBSERVER_ENABLE "C_MAC_PKT_SIZE" "C_MAC_RX_BUFFERS"						  
		}
	} else {
	 	error "Invalid Powerlink IP-Core mode $ip_core_mode!" "" "mdd_error"
	}
	
	puts "###################################"
}   	

###################################################
## internal procedures
###################################################
proc my_xdefine_include_file {drv_handle file_name drv_string args} {
    # Open include file
    set file_handle [xopen_include_file $file_name]

    # Get all peripherals connected to this driver
    set periphs [xget_periphs $drv_handle] 

    # Handle special cases
    set arg "NUM_INSTANCES"
    set posn [lsearch -exact $args $arg]
    if {$posn > -1} {
	puts $file_handle "/* Definitions for driver [string toupper [xget_sw_name $drv_handle]] */"
	# Define NUM_INSTANCES
	puts $file_handle "#define [xget_dname $drv_string $arg] [llength $periphs]"
	set args [lreplace $args $posn $posn]
    }
    # Check if it is a driver parameter

    lappend newargs 
    foreach arg $args {
	set value [xget_value $drv_handle "PARAMETER" $arg]
	if {[llength $value] == 0} {
	    lappend newargs $arg
	} else {
	    puts $file_handle "#define [xget_dname $drv_string $arg] [xget_value $drv_handle "PARAMETER" $arg]"
	}
    }
    set args $newargs

    # Print all parameters for all peripherals
    set device_id 0
    foreach periph $periphs {
	puts $file_handle ""
	puts $file_handle "/* Definitions for peripheral [string toupper [xget_hw_name $periph]] */"
	foreach arg $args {
	    if {[string compare -nocase "DEVICE_ID" $arg] == 0} {
			set value $device_id
			incr device_id
	    } else {
			set value [xget_param_value $periph $arg]
	    }
	    if {[llength $value] == 0} {
			set value 0
	    }
		 
		 ##################################
		 #make use of lists possible
		 if { [llength $arg ] == 2 } {
			puts $file_handle "#define [xget_name $periph [ lindex $arg 0 ]] [ lindex $arg 1 ]"
		 } else {
		 ##################################
			set value [xformat_addr_string $value $arg]
			if {[string compare -nocase "HW_VER" $arg] == 0} {
				puts $file_handle "#define [xget_name $periph $arg] \"$value\""
			} else {
				puts $file_handle "#define [xget_name $periph $arg] $value"
			}
		 }
	}
	puts $file_handle ""
    }		
    puts $file_handle "\n/******************************************************************/\n"
    close $file_handle
}
 
# calc RX buffer size
proc calc_rx_buffer_size { param_handle } {
 	set macPktLength	4
	# rx buffer header (header + packet length)
	set macRxHd 		[expr 26 + $macPktLength]
	# max rx buffers
	set macRxBuffers 	16	
	# mtu by ieee
	set mtu 			1500
	# eth header
	set ethHd			14
	# crc size by ieee
	set crc				4
	
	set macRxBuffers [ calc_mac_rx_buffers $param_handle ] 

	#calculate rx buffer size out of packets per cycle
	set rxBufSize [expr $ethHd + $mtu + $crc + $macRxHd]
	set rxBufSize [expr ($rxBufSize + 3) & ~3]
	set rxBufSize [expr $macRxBuffers * $rxBufSize]
	
	return $rxBufSize
}

# calc TX buffer size
proc calc_tx_buffer_size { param_handle } {	
 	set macPktLength	4
	# tx buffer header (header + packet length)
	set macTxHd			[expr  0 + $macPktLength]
	# max tx buffers
	set macTxBuffers	16
	# mtu by ieee
	set mtu 			1500
	# eth header
	set ethHd			14
	# crc size by ieee
	set crc				4
	# min data size of a packet
	set minDatSize		46
	# min packet size (ethheader + mindata + crc + tx buffer header)
	set minPktBufSize	[expr $ethHd + $minDatSize + $crc + $macTxHd]
	# max packet size (ethheader + mtu + crc + tx buffer header)
	set maxPktBufSize	[expr $ethHd + $mtu + $crc + $macTxHd]	

	# get tpdo0 size
	set tpdo0size [ calc_tpdo_buffer_size $param_handle ]
	
	#calc tx packet size
	set IdRes 	[expr 176 				+ $crc + $macTxHd]
	set StRes 	[expr 72 				+ $crc + $macTxHd]
	set NmtReq 	[expr $ethHd + $mtu		+ $crc + $macTxHd]
	set nonEpl	[expr $ethHd + $mtu		+ $crc + $macTxHd]
	set PRes	[expr 24 + $tpdo0size	+ $crc + $macTxHd]
	#sync response for poll-resp-ch (44 bytes + padding = 60bytes)
	set SyncRes [expr 60				+ $crc + $macTxHd]
	
	if {$PRes < $minPktBufSize} {
		#PRes buffer is smaller 64 bytes => padding!
		set PRes $minPktBufSize
	}
	
	#the following error is catched by the allowed range of pdo size
	if {$PRes > $maxPktBufSize} {
		error "TPDO Size is too large. Allowed Range 1...1490 bytes!"
	}	
	
	#align all tx buffers
	set IdRes 	[expr ($IdRes + 3) & ~3]
	set StRes 	[expr ($StRes + 3) & ~3]
	set NmtReq 	[expr ($NmtReq + 3) & ~3]
	set nonEpl 	[expr ($nonEpl + 3) & ~3]
	set PRes 	[expr ($PRes + 3) & ~3]
	set SyncRes [expr ($SyncRes + 3) & ~3]
	
	#calculate tx buffer size out of tpdos and other packets
	set txBufSize [expr $IdRes + $StRes + $NmtReq + $nonEpl + $PRes + $SyncRes]
	set macTxBuffers 6
	
	#openPOWERLINK allocates TX buffers twice (ping-pong)
	set txBufSize [expr $txBufSize * 2]
	set macTxBuffers [expr $macTxBuffers * 2]
	 
	return $txBufSize 
}

###################################################
## IP-Core mode calculation
###################################################
# get if pdi should be generated in the ip-core
proc get_pdi_enable { param_handle }	{

  	set mhsinst      [xget_hw_parent_handle $param_handle]
    set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
	
	if {$ipcore_mode > 0 && $ipcore_mode < 5} {
	   return true
	} else {
	   return false
	}
}  
	
# check if the parallel interface is enabled
proc get_par_if_enable { param_handle }	{

  	set mhsinst      [xget_hw_parent_handle $param_handle]
    set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
	
	if {$ipcore_mode == 1} {
	   return true
	} else {
	   return false
	}
}	

# check if the SPI interface is enabled
proc get_spi_if_enable { param_handle }	{

  	set mhsinst      [xget_hw_parent_handle $param_handle]
    set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
	
	if {$ipcore_mode == 3} {
	   return true
	} else {
	   return false
	}
}

# check if the plb bus interface is enabled
proc get_plb_bus_enable { param_handle }	{

  	set mhsinst      [xget_hw_parent_handle $param_handle]
    set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
	
	if {$ipcore_mode == 4} {
	   return true
	} else {
	   return false
	}
}


# check if the simple IO interface is enabled
proc get_simple_io_enable { param_handle }	{

  	set mhsinst      [xget_hw_parent_handle $param_handle]
    set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
	
	if {$ipcore_mode == 0} {
	   return true
	} else {
	   return false
	}
} 

###################################################
## calculate packet location
###################################################
proc update_tx_packet_location { param_handle} {
	
	set mhsinst      [xget_hw_parent_handle $param_handle]
    set packet_location   [xget_hw_parameter_value $mhsinst "C_PACKET_LOCATION"] 

	if {$packet_location == 0} {
		# TX is in DPRAM
		return true
	} elseif  {$packet_location == 1} {
		# TX is in DPRAM
		return true
	} else { 
		# TX is in external RAM
		return false 
	}
}	 

proc update_rx_packet_location { param_handle} {
	
	set mhsinst      [xget_hw_parent_handle $param_handle]
    set packet_location   [xget_hw_parameter_value $mhsinst "C_PACKET_LOCATION"] 

	if {$packet_location == 0} {
		# RX is in DPRAM
	   	return true
	} elseif  {$packet_location == 1} {
		# RX is in external RAM
		return false
	} else { 
		# RX is in external RAM
		return false 
	}
} 

###################################################
## MAC Packet size calculation
###################################################			 
proc calc_mac_packet_size { param_handle } {

	set mhsinst      [xget_hw_parent_handle $param_handle]	
	set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
	set pack_loc   [xget_hw_parameter_value $mhsinst "C_PACKET_LOCATION"] 	
	
	if {$ipcore_mode == 5} {
		#openMAC only
		set rxBufSize   [xget_hw_parameter_value $mhsinst "C_MAC_PKT_SIZE_RX_USER"] 	
		set txBufSize   [xget_hw_parameter_value $mhsinst "C_MAC_PKT_SIZE_TX_USER"] 			
	} else {  
		# PDI or simple IO is used
		set txBufSize [ calc_tx_buffer_size $param_handle ]
		set rxBufSize [ calc_rx_buffer_size $param_handle]
	}
	
	if { $pack_loc == 0 } {
		#TX and RX into DPRAM
		set macBufSize [expr $txBufSize + $rxBufSize]
	} elseif {$pack_loc == 1} {
		#TX into DPRAM and RX over PLB
		set macBufSize $txBufSize
	} elseif {$pack_loc == 2} {
		#TX and RX over PLB
		set macBufSize 0
	} else {
	 	#should not happen
		error "Packet location invalid! (Should not happen)" "" "mdt_error"
	}

	return $macBufSize
}

proc calc_mac_packet_size_log2 { param_handle } {
	set mhsinst      [xget_hw_parent_handle $param_handle]	
	set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
	set pack_loc   [xget_hw_parameter_value $mhsinst "C_PACKET_LOCATION"] 
	
	if {$ipcore_mode == 5} {
		#openMAC only
		set rxBufSize   [xget_hw_parameter_value $mhsinst "C_MAC_PKT_SIZE_RX_USER"] 	
		set txBufSize   [xget_hw_parameter_value $mhsinst "C_MAC_PKT_SIZE_TX_USER"] 			
	} else {  
		# PDI or simple IO is used
		set txBufSize [ calc_tx_buffer_size $param_handle ]
		set rxBufSize [ calc_rx_buffer_size $param_handle ]
	}
	
	if { $pack_loc == 0 } {
		#TX and RX into DPRAM
		set macBufSize [expr $txBufSize + $rxBufSize]
		set log2MacBufSize [expr int(ceil(log($macBufSize) / log(2.)))]
	} elseif {$pack_loc == 1} {
		#TX into DPRAM and RX over PLB
		set macBufSize $txBufSize
		set log2MacBufSize [expr int(ceil(log($macBufSize) / log(2.)))]
	} elseif {$pack_loc == 2} {
		#TX and RX over PLB
		set log2MacBufSize 3
	} else {
	 	#should not happen
		error "Packet location invalid! (Should not happen)" "" "mdt_error"
	}  

	return $log2MacBufSize	
}

###################################################
## PDO Buffer size calculation
###################################################			 
# calc rpdo 0 buffer size
proc calc_rpdo_0_buffer_size { param_handle} {
	set mhsinst      [xget_hw_parent_handle $param_handle]		  
    set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
    set buffer_size   [xget_hw_parameter_value $mhsinst "C_PDI_RPDO_BUF_SIZE_USER"]
	
	if {$ipcore_mode == 0} {
		#DirectIO is used
		# header + 4 bytes real data 
		return [ expr 4 + 16 ] 
	} elseif {$ipcore_mode == 5} {
		#openMAC only
		return [ expr 0 ]		
	} else {  
		# PDI is used
		# add header
		return [ expr $buffer_size + 16 ]
	}
} 	  

proc calc_rpdo_1_buffer_size { param_handle} {
	set mhsinst      		[xget_hw_parent_handle $param_handle]		  
    set ipcore_mode   		[xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
	set buffer_count_mac  	[xget_hw_parameter_value $mhsinst "C_MAC_NUM_RPDO_USER"] 
    set buffer_size   		[xget_hw_parameter_value $mhsinst "C_PDI_RPDO_BUF_SIZE_USER"]
	
	if {$ipcore_mode == 0} {
		#DirectIO is used
		if {$buffer_count_mac < 2} {
			# buffer deactivated
			return [ expr 0 ] 
		} else { 
			# header + 4 bytes real data
			return [ expr 4 + 16 ] 
		}
	} elseif {$ipcore_mode == 5} {
		#openMAC only
		return [ expr 0 ]		
	} else {	 
		# PDI is used
		# add header
		return [ expr $buffer_size + 16 ] 
	}
} 	 

proc calc_rpdo_2_buffer_size { param_handle} {
	set mhsinst [xget_hw_parent_handle $param_handle]		  
    set ipcore_mode [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
	set buffer_count_mac [xget_hw_parameter_value $mhsinst "C_MAC_NUM_RPDO_USER"] 
    set buffer_size [xget_hw_parameter_value $mhsinst "C_PDI_RPDO_BUF_SIZE_USER"]
	
	if {$ipcore_mode == 0} {
		#DirectIO is used
		if {$buffer_count_mac < 3} {
		   # buffer deactivated
			return [ expr 0 ] 
		} else { 	
			# header + 4 bytes real data
			return [ expr 4 + 16 ] 
		} 
	} elseif {$ipcore_mode == 5} {
		#openMAC only
		return [ expr 0 ]					
	} else {	 
		# PDI is used
		# add header
		return [ expr $buffer_size + 16 ]
	}
} 	

# calc tpdo buffer size
proc calc_tpdo_buffer_size { param_handle} {
	set mhsinst      [xget_hw_parent_handle $param_handle]	 
	set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
    set param1val   [xget_hw_parameter_value $mhsinst "C_PDI_TPDO_BUF_SIZE_USER"]
	
	if {$ipcore_mode == 0} {
		#DirectIO is used
		# just 4 bytes real data 
		return [ expr 4 ]  
	} elseif {$ipcore_mode == 5} {
		#openMAC only
		return [ expr 0 ]			
	} else {
		return [ expr $param1val + 16 ]
	}
} 

# calc the number of mac rx buffers for the driver
proc calc_mac_rx_buffers { param_handle } {	
   	set rpdo_count [ calc_rpdo_count $param_handle ] 

	if { $rpdo_count == 1 } {
		set macRxBuffers 4 
	} elseif { $rpdo_count == 2 } {
		set macRxBuffers 5 
	} elseif { $rpdo_count == 3 } {
		set macRxBuffers 6
	} elseif { $rpdo_count == 0 } {		
		# openMAC only has no RPDO definition and therefore we choose max RPDOs for the safe side
		set macRxBuffers 16
	} else {
		error "Number of Rpdos invalid!"
	}				
	
	return $macRxBuffers 
}

###################################################
## Calc asynchronous buffers settings
###################################################	
# update async buffer 0
proc gen_async_0_buffer { param_handle} {
	set mhsinst      	[xget_hw_parent_handle $param_handle]
	set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 	
	set async_buf_size	[xget_hw_parameter_value $mhsinst "C_PDI_ASYNC_BUF_0_SIZE_USER"] 
	
	if { $ipcore_mode == 0 || $ipcore_mode == 5 } {
		return false							   
	}	
	
	if { $async_buf_size == 0 } {
		return false
	} else {
	 	return true
	}
}  

proc calc_async_0_buffer_size { param_handle} {
   	set mhsinst      	[xget_hw_parent_handle $param_handle]
	set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
	set async_buf_size	[xget_hw_parameter_value $mhsinst "C_PDI_ASYNC_BUF_0_SIZE_USER"]	
	
	if { $ipcore_mode == 0 || $ipcore_mode == 5 } {
		return 0							   
	}
	
	set async_buf_size [expr $async_buf_size + 4]
	
	return $async_buf_size
}		

#update async buffer 1
proc gen_async_1_buffer { param_handle} {
	set mhsinst      	[xget_hw_parent_handle $param_handle]
	set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 	
	set async_buf_size	[xget_hw_parameter_value $mhsinst "C_PDI_ASYNC_BUF_1_SIZE_USER"] 	
	
	if { $ipcore_mode == 0 || $ipcore_mode == 5 } {
		return false							   
	}
	
	if { $async_buf_size == 0 } {
		return false
	} else {
	 	return true
	}
}  

proc calc_async_1_buffer_size { param_handle} {
   	set mhsinst      	[xget_hw_parent_handle $param_handle]
	set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"] 
	set async_buf_size	[xget_hw_parameter_value $mhsinst "C_PDI_ASYNC_BUF_1_SIZE_USER"]
	
	if { $ipcore_mode == 0 || $ipcore_mode == 5 } {
		return 0							   
	}
	
	if { $async_buf_size != 0 } {
		set async_buf_size [expr $async_buf_size + 4]
	} 
	
	return $async_buf_size
}

###################################################
## Calc RPDO and TPDO count
###################################################	
proc calc_rpdo_count { param_handle} {
	set mhsinst      	[xget_hw_parent_handle $param_handle]
	set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"]	
	set rpdo_count_mac	[xget_hw_parameter_value $mhsinst "C_MAC_NUM_RPDO_USER"]
	set rpdo_count_pdi	[xget_hw_parameter_value $mhsinst "C_PDI_NUM_RPDO_USER"] 
	
	if {$ipcore_mode == 0} {
		#DirectIO is used
		return $rpdo_count_mac
	} elseif {$ipcore_mode == 5} {
		#openMAC only
		return [ expr 0 ]		
	} else {  
		#pdi is used
	    return $rpdo_count_pdi
	}
}

proc calc_tpdo_count { param_handle} {
	set returnVal 0

	set mhsinst      [xget_hw_parent_handle $param_handle]
	set ipcore_mode   [xget_hw_parameter_value $mhsinst "C_IP_CORE_MODE"]	
    set tpdo_count_mac	[xget_hw_parameter_value $mhsinst "C_MAC_NUM_TPDO_USER"]
	set tpdo_count_pdi	[xget_hw_parameter_value $mhsinst "C_PDI_NUM_TPDO_USER"]
	
	if {$ipcore_mode == 0} {
		#DirectIO is used
		return $tpdo_count_mac					
	} elseif {$ipcore_mode == 5} {
		#openMAC only
		return [ expr 0 ]					
	} else {  
		#pdi is used
	    return $tpdo_count_pdi
	}
}

###################################################
## calc dma observer state
###################################################	
proc calc_dma_observer_state { param_handle } {
  	set mhsinst      [xget_hw_parent_handle $param_handle] 
	set pack_lock   [xget_hw_parameter_value $mhsinst "C_PACKET_LOCATION"] 
	set observer_state   [xget_hw_parameter_value $mhsinst "C_OBSERVER_ENABLE_USER"] 
	
	if { $pack_lock == 0 } {
		# disable if RX and TX are internal
		return false
	} else { 
		return $observer_state
	}
}