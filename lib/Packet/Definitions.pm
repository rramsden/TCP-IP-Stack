package Packet::Definitions;

use vars qw/ $VERSION @ISA /;
$VERSION = '0.01';

my %sizeof = (
	"char"	=> 1,
	"double"	=> 8,
	"fpos"	=> 8,
	"gid"	=> 4,
	"i16"	=> 2,
	"int16_t"	=> 2,
	"int16"	=> 2,
	"i32"	=> 4,
	"int32_t"	=> 4,
	"int32"	=> 4,
	"i64"	=> 8,
	"int64_t"	=> 8,
	"int64"	=> 8,
	"i8"	=> 1,
	"int8_t"	=> 1,
	"int8"	=> 1,
	"int"	=> 4,
	"iv"	=> 4,
	"longdbl"	=> 12,
	"longlong"	=> 8,
	"long"	=> 4,
	"lseek"	=> 8,
	"nv"	=> 8,
	"ptr"	=> 4,
	"short"	=> 2,
	"size"	=> 4,
	"u16"	=> 2,
	"__uint16_t"	=> 2,
	"__uint16"	=> 2,
	"u32"	=> 4,
	"__uint32_t"	=> 4,
	"__uint32"	=> 4,
	"u64"	=> 8,
	"__uint64_t"	=> 8,
	"__uint64"	=> 8,
	"u8"	=> 1,
	"__uint8_t"	=> 1,
	"__uint8"	=> 1,
	"uid"	=> 4,
	"uv"	=> 4,
	"*"	=> 4
);
$sizeof{"u_char"}	= $sizeof{"char"} unless $sizeof{"u_char"};
$sizeof{"u_short"}	= $sizeof{"short"} unless $sizeof{"u_short"};
$sizeof{"u_int"}	= $sizeof{"int"} unless $sizeof{"u_int"};
$sizeof{"u_long"}	= $sizeof{"long"} unless $sizeof{"u_long"};
$sizeof{"ushort"}	= $sizeof{"short"} unless $sizeof{"ushort"};
$sizeof{"uint"}	= $sizeof{"int"} unless $sizeof{"uint"};
$sizeof{"u_int8_t"}	= $sizeof{"__uint8_t"} unless $sizeof{"u_int8_t"};
$sizeof{"u_int16_t"}	= $sizeof{"__uint16_t"} unless $sizeof{"u_int16_t"};
$sizeof{"u_int32_t"}	= $sizeof{"__uint32_t"} unless $sizeof{"u_int32_t"};
$sizeof{"u_int64_t"}	= $sizeof{"__uint64_t"} unless $sizeof{"u_int64_t"};
$sizeof{"u_quad_t"}	= $sizeof{"u_int64_t"} unless $sizeof{"u_quad_t"};
$sizeof{"quad_t"}	= $sizeof{"int64_t"} unless $sizeof{"quad_t"};
$sizeof{"qaddr_t"}	= $sizeof{"*"} unless $sizeof{"qaddr_t"};
$sizeof{"caddr_t"}	= $sizeof{"*"} unless $sizeof{"caddr_t"};
$sizeof{"*v_caddr_t"}	= $sizeof{"char"} unless $sizeof{"*v_caddr_t"};
$sizeof{"daddr_t"}	= $sizeof{"int32_t"} unless $sizeof{"daddr_t"};
$sizeof{"u_daddr_t"}	= $sizeof{"u_int32_t"} unless $sizeof{"u_daddr_t"};
$sizeof{"fixpt_t"}	= $sizeof{"u_int32_t"} unless $sizeof{"fixpt_t"};
$sizeof{"gid_t"}	= $sizeof{"u_int32_t"} unless $sizeof{"gid_t"};
$sizeof{"in_addr_t"}	= $sizeof{"u_int32_t"} unless $sizeof{"in_addr_t"};
$sizeof{"in_port_t"}	= $sizeof{"u_int16_t"} unless $sizeof{"in_port_t"};
$sizeof{"ino_t"}	= $sizeof{"u_int32_t"} unless $sizeof{"ino_t"};
$sizeof{"key_t"}	= $sizeof{"long"} unless $sizeof{"key_t"};
$sizeof{"mode_t"}	= $sizeof{"u_int16_t"} unless $sizeof{"mode_t"};
$sizeof{"nlink_t"}	= $sizeof{"u_int16_t"} unless $sizeof{"nlink_t"};
$sizeof{"off_t"}	= $sizeof{"_BSD_OFF_T_"} unless $sizeof{"off_t"};
$sizeof{"pid_t"}	= $sizeof{"_BSD_PID_T_"} unless $sizeof{"pid_t"};
$sizeof{"rlim_t"}	= $sizeof{"quad_t"} unless $sizeof{"rlim_t"};
$sizeof{"segsz_t"}	= $sizeof{"int64_t"} unless $sizeof{"segsz_t"};
$sizeof{"segsz_t"}	= $sizeof{"int32_t"} unless $sizeof{"segsz_t"};
$sizeof{"swblk_t"}	= $sizeof{"int32_t"} unless $sizeof{"swblk_t"};
$sizeof{"ufs_daddr_t"}	= $sizeof{"int32_t"} unless $sizeof{"ufs_daddr_t"};
$sizeof{"uid_t"}	= $sizeof{"u_int32_t"} unless $sizeof{"uid_t"};
$sizeof{"boolean_t"}	= $sizeof{"int"} unless $sizeof{"boolean_t"};
$sizeof{"uoff_t"}	= $sizeof{"u_int64_t"} unless $sizeof{"uoff_t"};
$sizeof{"*vm_page_t"}	= $sizeof{"vm_page"} unless $sizeof{"*vm_page_t"};
$sizeof{"udev_t"}	= $sizeof{"u_int32_t"} unless $sizeof{"udev_t"};
$sizeof{"*dev_t"}	= $sizeof{"specinfo"} unless $sizeof{"*dev_t"};
$sizeof{"dev_t"}	= $sizeof{"u_int32_t"} unless $sizeof{"dev_t"};
$sizeof{"clock_t"}	= $sizeof{"_BSD_CLOCK_T_"} unless $sizeof{"clock_t"};
$sizeof{"clockid_t"}	= $sizeof{"_BSD_CLOCKID_T_"} unless $sizeof{"clockid_t"};
$sizeof{"size_t"}	= $sizeof{"_BSD_SIZE_T_"} unless $sizeof{"size_t"};
$sizeof{"ssize_t"}	= $sizeof{"_BSD_SSIZE_T_"} unless $sizeof{"ssize_t"};
$sizeof{"time_t"}	= $sizeof{"_BSD_TIME_T_"} unless $sizeof{"time_t"};
$sizeof{"timer_t"}	= $sizeof{"_BSD_TIMER_T_"} unless $sizeof{"timer_t"};
$sizeof{"fd_mask"}	= $sizeof{"long"} unless $sizeof{"fd_mask"};
$sizeof{"bpf_int32"}	= $sizeof{"int32_t"} unless $sizeof{"bpf_int32"};
$sizeof{"bpf_u_int32"}	= $sizeof{"u_int32_t"} unless $sizeof{"bpf_u_int32"};
$sizeof{"sa_family_t"}	= $sizeof{"u_char"} unless $sizeof{"sa_family_t"};
$sizeof{"socklen_t"}	= $sizeof{"_BSD_SOCKLEN_T_"} unless $sizeof{"socklen_t"};
$sizeof{"sysctl_oid"}	= 26;
$sizeof{"sf_hdtr"}	= 16;
$sizeof{"ifqueue"}	= 20;
$sizeof{"if_clonereq"}	= 9;
$sizeof{"bpf_version"}	= 4;
$sizeof{"sockaddr"}	= 16;
$sizeof{"msghdr"}	= 12;
$sizeof{"cmsgcred"}	= 14 + (&CMGROUP_MAX * 4);
$sizeof{"linger"}	= 8;
$sizeof{"if_clone"}	= 5;
$sizeof{"clockinfo"}	= 20;
$sizeof{"ifma_msghdr"}	= 14;
$sizeof{"sockproto"}	= 4;
$sizeof{"ifmediareq"}	= 24 + (&IFNAMSIZ * 1);
$sizeof{"ether_addr"}	=  + (&ETHER_ADDR_LEN * 1);
$sizeof{"ctlname"}	= 5;
$sizeof{"bpf_insn"}	= 8;
$sizeof{"nit_ii"}	= 20;
$sizeof{"if_nameindex"}	= 5;
$sizeof{"sysctl_ctx_entry"}	= 26;
$sizeof{"ifconf"}	= 8;
$sizeof{"ifmultiaddr"}	= 40;
$sizeof{"ifaliasreq"}	= 48 + (&IFNAMSIZ * 1);
$sizeof{"ifreq"}	= 16 + (&IFNAMSIZ * 1);
$sizeof{"ifstat"}	= 1 + (&IFNAMSIZ * 1);
$sizeof{"cmsghdr"}	= 8;
$sizeof{"ifa_msghdr"}	= 18;
$sizeof{"sysctl_req"}	= 16;
$sizeof{"bpf_program"}	= 12;
$sizeof{"ifprefix"}	= 22;
$sizeof{"timezone"}	= 8;
$sizeof{"bpf_stat"}	= 8;
$sizeof{"osockaddr"}	= 16;
$sizeof{"ether_header"}	= 2 + (&ETHER_ADDR_LEN * 1) + (&ETHER_ADDR_LEN * 1);
$sizeof{"omsghdr"}	= 24;
$sizeof{"accept_filter_arg"}	= 256;
$sizeof{"sockaddr_storage"}	= 10 + (&_SS_PAD1SIZE * 1) + (&_SS_PAD2SIZE * 1);
$sizeof{"timeval"}	= 8;
$sizeof{"if_laddrreq"}	= 29;
$sizeof{"itimerval"}	= 16;
$sizeof{"bpf_hdr"}	= 18;
$sizeof{"ether_addr"}	= 1;
$sizeof{"nit_hdr"}	= 20;
$sizeof{"nit_ioc"}	= 36;
$sizeof{"if_data"}	= 78;
$sizeof{"if_msghdr"}	= 92;
$sizeof{"ifaddr"}	= 144;


sub sizeof {
 return (@sizeof{@_});
}
sub sysctl_oid {
  my %tmp = %{$_[0]};
  return
  pack("a4iiiiii",
    &sysctl_oid_list($tmp{"*oid_parent"}), $tmp{"oid_link"}, $tmp{"oid_number"}, $tmp{"oid_kind"}, $tmp{"*oid_arg1"}, $tmp{"oid_arg2"}, $tmp{"char"}, $tmp{"(*oid_handler)(SYSCTL_HANDLER_ARGS)"}, $tmp{"char"}, $tmp{"oid_refcnt"}
  )
}
sub unp_sysctl_oid {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("oid_parent","oid_link","oid_number","oid_kind","oid_arg1","oid_arg2","char","(oid_handler)(SYSCTL_HANDLER_ARGS)","char","oid_refcnt")[$i++] =>
      $_
    }
    &unp_sysctl_oid_list(substr($tmp, 0, $sizeof{"sysctl_oid_list"}, "")), unpack("iiiiii", substr($tmp, 0, 27, ""))
  }
}
sub sf_hdtr {
  my %tmp = %{$_[0]};
  return
  pack("a4ia4i",
    &iovec($tmp{"*headers"}), $tmp{"hdr_cnt"}, &iovec($tmp{"*trailers"}), $tmp{"trl_cnt"}
  )
}
sub unp_sf_hdtr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("headers","hdr_cnt","trailers","trl_cnt")[$i++] =>
      $_
    }
    &unp_iovec(substr($tmp, 0, $sizeof{"iovec"}, "")), unpack("i", substr($tmp, 0, 4, "")),
    &unp_iovec(substr($tmp, 0, $sizeof{"iovec"}, "")), unpack("i", substr($tmp, 0, 4, ""))
  }
}
sub ifqueue {
  my %tmp = %{$_[0]};
  return
  pack("a4a4iii",
    &mbuf($tmp{"*ifq_head"}), &mbuf($tmp{"*ifq_tail"}), $tmp{"ifq_len"}, $tmp{"ifq_maxlen"}, $tmp{"ifq_drops"}
  )
}
sub unp_ifqueue {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifq_head","ifq_tail","ifq_len","ifq_maxlen","ifq_drops")[$i++] =>
      $_
    }
    &unp_mbuf(substr($tmp, 0, $sizeof{"mbuf"}, "")),
    &unp_mbuf(substr($tmp, 0, $sizeof{"mbuf"}, "")), unpack("iii", substr($tmp, 0, 12, ""))
  }
}
sub if_laddrreq {
  my %tmp = %{$_[0]};
  return
  pack("a" . &IFNAMSIZ . "IIa$sizeof{sockaddr_storage}a$sizeof{sockaddr_storage}",
    $tmp{"iflr_name"}, $tmp{"flags"}, $tmp{"prefixlen"}, &sockaddr_storage($tmp{"addr"}), &sockaddr_storage($tmp{"dstaddr"})
  )
}
sub unp_if_laddrreq {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("iflr_name[IFNAMSIZ]","flags","prefixlen","addr","dstaddr")[$i++] =>
      $_
    }
    unpack("a" . &IFNAMSIZ . "II", substr($tmp, 0, 8, "")),
    &unp_sockaddr_storage(substr($tmp, 0, $sizeof{"sockaddr_storage"}, "")),
    &unp_sockaddr_storage(substr($tmp, 0, $sizeof{"sockaddr_storage"}, ""))
  }
}
sub if_clonereq {
  my %tmp = %{$_[0]};
  return
  pack("iia",
    $tmp{"ifcr_total"}, $tmp{"ifcr_count"}, $tmp{"*ifcr_buffer"}
  )
}
sub unp_if_clonereq {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifcr_total","ifcr_count","ifcr_buffer")[$i++] =>
      $_
    }
    unpack("iia", substr($tmp, 0, 9, ""))
  }
}
sub bpf_version {
  my %tmp = %{$_[0]};
  return
  pack("SS",
    $tmp{"bv_major"}, $tmp{"bv_minor"}
  )
}
sub unp_bpf_version {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("bv_major","bv_minor")[$i++] =>
      $_
    }
    unpack("SS", substr($tmp, 0, 4, ""))
  }
}
sub itimerval {
  my %tmp = %{$_[0]};
  return
  pack("a$sizeof{timeval}a$sizeof{timeval}",
    &timeval($tmp{"it_interval"}), &timeval($tmp{"it_value"})
  )
}
sub unp_itimerval {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("it_interval","it_value")[$i++] =>
      $_
    }
    &unp_timeval(substr($tmp, 0, $sizeof{"timeval"}, "")),
    &unp_timeval(substr($tmp, 0, $sizeof{"timeval"}, ""))
  }
}
sub sockaddr {
  my %tmp = %{$_[0]};
  return
  pack("aaa14",
    $tmp{"sa_len"}, $tmp{"sa_family"}, $tmp{"sa_data"}
  )
}
sub unp_sockaddr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("sa_len","sa_family","sa_data[14]")[$i++] =>
      $_
    }
    unpack("aaa14", substr($tmp, 0, 16, ""))
  }
}
sub msghdr {
  my %tmp = %{$_[0]};
  return
  pack("ia4iii",
    $tmp{"*msg_name"}, $tmp{"msg_namelen"}, &iovec($tmp{"*msg_iov"}), $tmp{"msg_iovlen"}, $tmp{"*msg_control"}, $tmp{"msg_controllen"}, $tmp{"msg_flags"}
  )
}
sub unp_msghdr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("msg_name","msg_namelen","msg_iov","msg_iovlen","msg_control","msg_controllen","msg_flags")[$i++] =>
      $_
    }
    unpack("i", substr($tmp, 0, 5, "")),
    &unp_iovec(substr($tmp, 0, $sizeof{"iovec"}, "")), unpack("iii", substr($tmp, 0, 13, ""))
  }
}
sub bpf_hdr {
  my %tmp = %{$_[0]};
  return
  pack("a$sizeof{timeval}IIS",
    &timeval($tmp{"bh_tstamp"}), $tmp{"bh_caplen"}, $tmp{"bh_datalen"}, $tmp{"bh_hdrlen"}
  )
}
sub unp_bpf_hdr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("bh_tstamp","bh_caplen","bh_datalen","bh_hdrlen")[$i++] =>
      $_
    }
    &unp_timeval(substr($tmp, 0, $sizeof{"timeval"}, "")), unpack("IIS", substr($tmp, 0, 10, ""))
  }
}
sub ifaddr {
  my %tmp = %{$_[0]};
  return
  pack("a4a4a4a$sizeof{if_data}a4iSIi",
    &sockaddr($tmp{"*ifa_addr"}), &sockaddr($tmp{"*ifa_dstaddr"}), &sockaddr($tmp{"*ifa_netmask"}), &if_data($tmp{"if_data"}), &ifnet($tmp{"*ifa_ifp"}), $tmp{"ifa_link"}, $tmp{"(*ifa_rtrequest)"}, $tmp{"ifa_flags"}, $tmp{"ifa_refcnt"}, $tmp{"ifa_metric"}, $tmp{"notdef"}, $tmp{"int"}
  )
}
sub unp_ifaddr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifa_addr","ifa_dstaddr","ifa_netmask","if_data","ifa_ifp","ifa_link","(ifa_rtrequest)","ifa_flags","ifa_refcnt","ifa_metric","notdef","int")[$i++] =>
      $_
    }
    &unp_sockaddr(substr($tmp, 0, $sizeof{"sockaddr"}, "")),
    &unp_sockaddr(substr($tmp, 0, $sizeof{"sockaddr"}, "")),
    &unp_sockaddr(substr($tmp, 0, $sizeof{"sockaddr"}, "")),
    &unp_if_data(substr($tmp, 0, $sizeof{"if_data"}, "")),
    &unp_ifnet(substr($tmp, 0, $sizeof{"ifnet"}, "")), unpack("iSIi", substr($tmp, 0, 17, ""))
  }
}
sub cmsgcred {
  my %tmp = %{$_[0]};
  return
  pack("IIisi" . &CMGROUP_MAX . "",
    $tmp{"cmcred_pid"}, $tmp{"cmcred_uid"}, $tmp{"cmcred_euid"}, $tmp{"cmcred_gid"}, $tmp{"cmcred_ngroups"}, $tmp{"cmcred_groups"}
  )
}
sub unp_cmsgcred {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("cmcred_pid","cmcred_uid","cmcred_euid","cmcred_gid","cmcred_ngroups","cmcred_groups[CMGROUP_MAX]")[$i++] =>
      $_
    }
    unpack("IIisi" . &CMGROUP_MAX . "", substr($tmp, 0, 6, ""))
  }
}
sub linger {
  my %tmp = %{$_[0]};
  return
  pack("ii",
    $tmp{"l_onoff"}, $tmp{"l_linger"}
  )
}
sub unp_linger {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("l_onoff","l_linger")[$i++] =>
      $_
    }
    unpack("ii", substr($tmp, 0, 8, ""))
  }
}
sub if_clone {
  my %tmp = %{$_[0]};
  return
  pack("ii",
    $tmp{"ifc_list"}, $tmp{"char"}, $tmp{"ifc_namelen"}, $tmp{"(*ifc_create)(struct"}, $tmp{"(*ifc_destroy)(struct"}
  )
}
sub unp_if_clone {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifc_list","char","ifc_namelen","(ifc_create)(struct","(ifc_destroy)(struct")[$i++] =>
      $_
    }
    unpack("ii", substr($tmp, 0, 11, ""))
  }
}
sub clockinfo {
  my %tmp = %{$_[0]};
  return
  pack("iiiii",
    $tmp{"hz"}, $tmp{"tick"}, $tmp{"tickadj"}, $tmp{"stathz"}, $tmp{"profhz"}
  )
}
sub unp_clockinfo {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("hz","tick","tickadj","stathz","profhz")[$i++] =>
      $_
    }
    unpack("iiiii", substr($tmp, 0, 20, ""))
  }
}
sub ifma_msghdr {
  my %tmp = %{$_[0]};
  return
  pack("SaaiiS",
    $tmp{"ifmam_msglen"}, $tmp{"ifmam_version"}, $tmp{"ifmam_type"}, $tmp{"ifmam_addrs"}, $tmp{"ifmam_flags"}, $tmp{"ifmam_index"}
  )
}
sub unp_ifma_msghdr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifmam_msglen","ifmam_version","ifmam_type","ifmam_addrs","ifmam_flags","ifmam_index")[$i++] =>
      $_
    }
    unpack("SaaiiS", substr($tmp, 0, 14, ""))
  }
}
sub sockproto {
  my %tmp = %{$_[0]};
  return
  pack("SS",
    $tmp{"sp_family"}, $tmp{"sp_protocol"}
  )
}
sub unp_sockproto {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("sp_family","sp_protocol")[$i++] =>
      $_
    }
    unpack("SS", substr($tmp, 0, 4, ""))
  }
}
sub ifmediareq {
  my %tmp = %{$_[0]};
  return
  pack("a" . &IFNAMSIZ . "iiiiii",
    $tmp{"ifm_name"}, $tmp{"ifm_current"}, $tmp{"ifm_mask"}, $tmp{"ifm_status"}, $tmp{"ifm_active"}, $tmp{"ifm_count"}, $tmp{"*ifm_ulist"}
  )
}
sub unp_ifmediareq {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifm_name[IFNAMSIZ]","ifm_current","ifm_mask","ifm_status","ifm_active","ifm_count","ifm_ulist")[$i++] =>
      $_
    }
    unpack("a" . &IFNAMSIZ . "iiiiii", substr($tmp, 0, 24, ""))
  }
}
sub ether_addr {
  my %tmp = %{$_[0]};
  return
  pack("a" . &ETHER_ADDR_LEN . "",
    $tmp{"octet"}
  )
}
sub unp_ether_addr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("octet[ETHER_ADDR_LEN]")[$i++] =>
      $_
    }
    unpack("a" . &ETHER_ADDR_LEN . "", substr($tmp, 0, " . &ETHER_ADDR_LEN . ", ""))
  }
}
sub ctlname {
  my %tmp = %{$_[0]};
  return
  pack("ai",
    $tmp{"*ctl_name"}, $tmp{"ctl_type"}
  )
}
sub unp_ctlname {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ctl_name","ctl_type")[$i++] =>
      $_
    }
    unpack("ai", substr($tmp, 0, 5, ""))
  }
}
sub bpf_insn {
  my %tmp = %{$_[0]};
  return
  pack("SaaI",
    $tmp{"code"}, $tmp{"jt"}, $tmp{"jf"}, $tmp{"k"}
  )
}
sub unp_bpf_insn {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("code","jt","jf","k")[$i++] =>
      $_
    }
    unpack("SaaI", substr($tmp, 0, 8, ""))
  }
}
sub nit_ii {
  my %tmp = %{$_[0]};
  return
  pack("iiIii",
    $tmp{"nii_header"}, $tmp{"nii_hdrlen"}, $tmp{"nii_type"}, $tmp{"nii_datalen"}, $tmp{"nii_promisc"}
  )
}
sub unp_nit_ii {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("nii_header","nii_hdrlen","nii_type","nii_datalen","nii_promisc")[$i++] =>
      $_
    }
    unpack("iiIii", substr($tmp, 0, 17, ""))
  }
}
sub if_nameindex {
  my %tmp = %{$_[0]};
  return
  pack("Ia",
    $tmp{"if_index"}, $tmp{"*if_name"}
  )
}
sub unp_if_nameindex {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("if_index","if_name")[$i++] =>
      $_
    }
    unpack("Ia", substr($tmp, 0, 5, ""))
  }
}
sub ifnet { }
sub unp_ifnet { }
sub sysctl_ctx_entry {
  my %tmp = %{$_[0]};
  return
  pack("a4",
    &sysctl_oid($tmp{"*entry"}), $tmp{"link"}
  )
}
sub unp_sysctl_ctx_entry {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("entry","link")[$i++] =>
      $_
    }
    &unp_sysctl_oid(substr($tmp, 0, $sizeof{"sysctl_oid"}, "")), unpack("", substr($tmp, 0, 1, ""))
  }
}
sub timecounter { }
sub unp_timecounter { }
sub nit_hdr {
  my %tmp = %{$_[0]};
  return
  pack("ia$sizeof{timeval}i",
    $tmp{"nh_state"}, &timeval($tmp{"nh_timestamp"}), $tmp{"nh_wirelen"}, $tmp{"nh_un"}
  )
}
sub unp_nit_hdr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("nh_state","nh_timestamp","nh_wirelen","nh_un")[$i++] =>
      $_
    }
    unpack("i", substr($tmp, 0, 4, "")),
    &unp_timeval(substr($tmp, 0, $sizeof{"timeval"}, "")), unpack("i", substr($tmp, 0, 5, ""))
  }
}
sub ifconf {
  my %tmp = %{$_[0]};
  return
  pack("i",
    $tmp{"ifc_len"}, $tmp{"ifc_ifcu"}, $tmp{".ifcu_req"}
  )
}
sub unp_ifconf {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifc_len","ifc_ifcu",".ifcu_req")[$i++] =>
      $_
    }
    unpack("i", substr($tmp, 0, 6, ""))
  }
}
sub ifmultiaddr {
  my %tmp = %{$_[0]};
  return
  pack("a4a4a4Ii",
    $tmp{"ifma_link"}, &sockaddr($tmp{"*ifma_addr"}), &sockaddr($tmp{"*ifma_lladdr"}), &ifnet($tmp{"*ifma_ifp"}), $tmp{"ifma_refcount"}, $tmp{"*ifma_protospec"}
  )
}
sub unp_ifmultiaddr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifma_link","ifma_addr","ifma_lladdr","ifma_ifp","ifma_refcount","ifma_protospec")[$i++] =>
      $_
    }
    unpack("", substr($tmp, 0, 1, "")),
    &unp_sockaddr(substr($tmp, 0, $sizeof{"sockaddr"}, "")),
    &unp_sockaddr(substr($tmp, 0, $sizeof{"sockaddr"}, "")),
    &unp_ifnet(substr($tmp, 0, $sizeof{"ifnet"}, "")), unpack("Ii", substr($tmp, 0, 8, ""))
  }
}
sub ifaliasreq {
  my %tmp = %{$_[0]};
  return
  pack("a" . &IFNAMSIZ . "a$sizeof{sockaddr}a$sizeof{sockaddr}a$sizeof{sockaddr}",
    $tmp{"ifra_name"}, &sockaddr($tmp{"ifra_addr"}), &sockaddr($tmp{"ifra_broadaddr"}), &sockaddr($tmp{"ifra_mask"})
  )
}
sub unp_ifaliasreq {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifra_name[IFNAMSIZ]","ifra_addr","ifra_broadaddr","ifra_mask")[$i++] =>
      $_
    }
    unpack("a" . &IFNAMSIZ . "", substr($tmp, 0, " . &IFNAMSIZ . ", "")),
    &unp_sockaddr(substr($tmp, 0, $sizeof{"sockaddr"}, "")),
    &unp_sockaddr(substr($tmp, 0, $sizeof{"sockaddr"}, "")),
    &unp_sockaddr(substr($tmp, 0, $sizeof{"sockaddr"}, ""))
  }
}
sub ifreq {
  my %tmp = %{$_[0]};
  return
  pack("a" . &IFNAMSIZ . "",
    $tmp{"ifr_name"}, $tmp{"ifr_ifru"}, $tmp{".ifru_dstaddr"}
  )
}
sub unp_ifreq {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifr_name[IFNAMSIZ]","ifr_ifru",".ifru_dstaddr")[$i++] =>
      $_
    }
    unpack("a" . &IFNAMSIZ . "", substr($tmp, 0, 2, ""))
  }
}
sub ifstat {
  my %tmp = %{$_[0]};
  return
  pack("a" . &IFNAMSIZ . "a",
    $tmp{"ifs_name"}, $tmp{"ascii[IFSTATMAX"}
  )
}
sub unp_ifstat {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifs_name[IFNAMSIZ]","ascii[IFSTATMAX")[$i++] =>
      $_
    }
    unpack("a" . &IFNAMSIZ . "a", substr($tmp, 0, 1, ""))
  }
}
sub cmsghdr {
  my %tmp = %{$_[0]};
  return
  pack("ii",
    $tmp{"cmsg_len"}, $tmp{"cmsg_level"}, $tmp{"cmsg_type"}
  )
}
sub unp_cmsghdr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("cmsg_len","cmsg_level","cmsg_type")[$i++] =>
      $_
    }
    unpack("ii", substr($tmp, 0, 9, ""))
  }
}
sub nit_ioc {
  my %tmp = %{$_[0]};
  return
  pack("iiIiiia$sizeof{timeval}i",
    $tmp{"nioc_bufspace"}, $tmp{"nioc_chunksize"}, $tmp{"nioc_typetomatch"}, $tmp{"nioc_snaplen"}, $tmp{"nioc_bufalign"}, $tmp{"nioc_bufoffset"}, &timeval($tmp{"nioc_timeout"}), $tmp{"nioc_flags"}
  )
}
sub unp_nit_ioc {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("nioc_bufspace","nioc_chunksize","nioc_typetomatch","nioc_snaplen","nioc_bufalign","nioc_bufoffset","nioc_timeout","nioc_flags")[$i++] =>
      $_
    }
    unpack("iiIiii", substr($tmp, 0, 24, "")),
    &unp_timeval(substr($tmp, 0, $sizeof{"timeval"}, "")), unpack("i", substr($tmp, 0, 4, ""))
  }
}
sub ifa_msghdr {
  my %tmp = %{$_[0]};
  return
  pack("SaaiiSi",
    $tmp{"ifam_msglen"}, $tmp{"ifam_version"}, $tmp{"ifam_type"}, $tmp{"ifam_addrs"}, $tmp{"ifam_flags"}, $tmp{"ifam_index"}, $tmp{"ifam_metric"}
  )
}
sub unp_ifa_msghdr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifam_msglen","ifam_version","ifam_type","ifam_addrs","ifam_flags","ifam_index","ifam_metric")[$i++] =>
      $_
    }
    unpack("SaaiiSi", substr($tmp, 0, 18, ""))
  }
}
sub sysctl_req {
  my %tmp = %{$_[0]};
  return
  pack("a4iiiii",
    &proc($tmp{"*p"}), $tmp{"lock"}, $tmp{"*oldptr"}, $tmp{"oldlen"}, $tmp{"oldidx"}, $tmp{"(*oldfunc)(struct"}, $tmp{"*newptr"}, $tmp{"newlen"}, $tmp{"newidx"}, $tmp{"(*newfunc)(struct"}
  )
}
sub unp_sysctl_req {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("p","lock","oldptr","oldlen","oldidx","(oldfunc)(struct","newptr","newlen","newidx","(newfunc)(struct")[$i++] =>
      $_
    }
    &unp_proc(substr($tmp, 0, $sizeof{"proc"}, "")), unpack("iiiii", substr($tmp, 0, 24, ""))
  }
}
sub if_data {
  my %tmp = %{$_[0]};
  return
  pack("aaaaaaLLLLLLLLLLLLLLLLa$sizeof{timeval}",
    $tmp{"ifi_type"}, $tmp{"ifi_physical"}, $tmp{"ifi_addrlen"}, $tmp{"ifi_hdrlen"}, $tmp{"ifi_recvquota"}, $tmp{"ifi_xmitquota"}, $tmp{"ifi_mtu"}, $tmp{"ifi_metric"}, $tmp{"ifi_baudrate"}, $tmp{"ifi_ipackets"}, $tmp{"ifi_ierrors"}, $tmp{"ifi_opackets"}, $tmp{"ifi_oerrors"}, $tmp{"ifi_collisions"}, $tmp{"ifi_ibytes"}, $tmp{"ifi_obytes"}, $tmp{"ifi_imcasts"}, $tmp{"ifi_omcasts"}, $tmp{"ifi_iqdrops"}, $tmp{"ifi_noproto"}, $tmp{"ifi_hwassist"}, $tmp{"ifi_unused"}, &timeval($tmp{"ifi_lastchange"})
  )
}
sub unp_if_data {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifi_type","ifi_physical","ifi_addrlen","ifi_hdrlen","ifi_recvquota","ifi_xmitquota","ifi_mtu","ifi_metric","ifi_baudrate","ifi_ipackets","ifi_ierrors","ifi_opackets","ifi_oerrors","ifi_collisions","ifi_ibytes","ifi_obytes","ifi_imcasts","ifi_omcasts","ifi_iqdrops","ifi_noproto","ifi_hwassist","ifi_unused","ifi_lastchange")[$i++] =>
      $_
    }
    unpack("aaaaaaLLLLLLLLLLLLLLLL", substr($tmp, 0, 70, "")),
    &unp_timeval(substr($tmp, 0, $sizeof{"timeval"}, ""))
  }
}
sub ipt_ta { }
sub unp_ipt_ta { }
sub bpf_program {
  my %tmp = %{$_[0]};
  return
  pack("Ia4",
    $tmp{"bf_len"}, &bpf_insn($tmp{"*bf_insns"})
  )
}
sub unp_bpf_program {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("bf_len","bf_insns")[$i++] =>
      $_
    }
    unpack("I", substr($tmp, 0, 4, "")),
    &unp_bpf_insn(substr($tmp, 0, $sizeof{"bpf_insn"}, ""))
  }
}
sub if_msghdr {
  my %tmp = %{$_[0]};
  return
  pack("SaaiiSa$sizeof{if_data}",
    $tmp{"ifm_msglen"}, $tmp{"ifm_version"}, $tmp{"ifm_type"}, $tmp{"ifm_addrs"}, $tmp{"ifm_flags"}, $tmp{"ifm_index"}, &if_data($tmp{"ifm_data"})
  )
}
sub unp_if_msghdr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifm_msglen","ifm_version","ifm_type","ifm_addrs","ifm_flags","ifm_index","ifm_data")[$i++] =>
      $_
    }
    unpack("SaaiiS", substr($tmp, 0, 14, "")),
    &unp_if_data(substr($tmp, 0, $sizeof{"if_data"}, ""))
  }
}
sub ifprefix {
  my %tmp = %{$_[0]};
  return
  pack("a4a4aa",
    &sockaddr($tmp{"*ifpr_prefix"}), &ifnet($tmp{"*ifpr_ifp"}), $tmp{"ifpr_list"}, $tmp{"ifpr_plen"}, $tmp{"ifpr_type"}
  )
}
sub unp_ifprefix {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ifpr_prefix","ifpr_ifp","ifpr_list","ifpr_plen","ifpr_type")[$i++] =>
      $_
    }
    &unp_sockaddr(substr($tmp, 0, $sizeof{"sockaddr"}, "")),
    &unp_ifnet(substr($tmp, 0, $sizeof{"ifnet"}, "")), unpack("aa", substr($tmp, 0, 3, ""))
  }
}
sub timezone {
  my %tmp = %{$_[0]};
  return
  pack("ii",
    $tmp{"tz_minuteswest"}, $tmp{"tz_dsttime"}
  )
}
sub unp_timezone {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("tz_minuteswest","tz_dsttime")[$i++] =>
      $_
    }
    unpack("ii", substr($tmp, 0, 8, ""))
  }
}
sub bpf_stat {
  my %tmp = %{$_[0]};
  return
  pack("II",
    $tmp{"bs_recv"}, $tmp{"bs_drop"}
  )
}
sub unp_bpf_stat {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("bs_recv","bs_drop")[$i++] =>
      $_
    }
    unpack("II", substr($tmp, 0, 8, ""))
  }
}
sub osockaddr {
  my %tmp = %{$_[0]};
  return
  pack("Sa14",
    $tmp{"sa_family"}, $tmp{"sa_data"}
  )
}
sub unp_osockaddr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("sa_family","sa_data[14]")[$i++] =>
      $_
    }
    unpack("Sa14", substr($tmp, 0, 16, ""))
  }
}
sub ether_header {
  my %tmp = %{$_[0]};
  return
  pack("a" . &ETHER_ADDR_LEN . "a" . &ETHER_ADDR_LEN . "S",
    $tmp{"ether_dhost"}, $tmp{"ether_shost"}, $tmp{"ether_type"}
  )
}
sub unp_ether_header {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ether_dhost[ETHER_ADDR_LEN]","ether_shost[ETHER_ADDR_LEN]","ether_type")[$i++] =>
      $_
    }
    unpack("a" . &ETHER_ADDR_LEN . "a" . &ETHER_ADDR_LEN . "S", substr($tmp, 0, 2, ""))
  }
}
sub omsghdr {
  my %tmp = %{$_[0]};
  return
  pack("iia4iii",
    $tmp{"msg_name"}, $tmp{"msg_namelen"}, &iovec($tmp{"*msg_iov"}), $tmp{"msg_iovlen"}, $tmp{"msg_accrights"}, $tmp{"msg_accrightslen"}
  )
}
sub unp_omsghdr {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("msg_name","msg_namelen","msg_iov","msg_iovlen","msg_accrights","msg_accrightslen")[$i++] =>
      $_
    }
    unpack("ii", substr($tmp, 0, 5, "")),
    &unp_iovec(substr($tmp, 0, $sizeof{"iovec"}, "")), unpack("iii", substr($tmp, 0, 9, ""))
  }
}
sub accept_filter_arg {
  my %tmp = %{$_[0]};
  return
  pack("a16a240",
    $tmp{"af_name"}, $tmp{"af_arg"}
  )
}
sub unp_accept_filter_arg {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("af_name[16]","af_arg[256-16]")[$i++] =>
      $_
    }
    unpack("a16a240", substr($tmp, 0, 256, ""))
  }
}
sub sockaddr_storage {
  my %tmp = %{$_[0]};
  return
  pack("aaa" . &_SS_PAD1SIZE . "ia" . &_SS_PAD2SIZE . "",
    $tmp{"ss_len"}, $tmp{"ss_family"}, $tmp{"__ss_pad1"}, $tmp{"__ss_align"}, $tmp{"__ss_pad2"}
  )
}
sub unp_sockaddr_storage {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("ss_len","ss_family","__ss_pad1[_SS_PAD1SIZE]","__ss_align","__ss_pad2[_SS_PAD2SIZE]")[$i++] =>
      $_
    }
    unpack("aaa" . &_SS_PAD1SIZE . "ia" . &_SS_PAD2SIZE . "", substr($tmp, 0, 6, ""))
  }
}
sub timeval {
  my %tmp = %{$_[0]};
  return
  pack("ll",
    $tmp{"tv_sec"}, $tmp{"tv_usec"}
  )
}
sub unp_timeval {
  my $i;
  my $tmp = shift;
  return {
    map {
      ("tv_sec","tv_usec")[$i++] =>
      $_
    }
    unpack("ll", substr($tmp, 0, 8, ""))
  }
}
unless(defined(&_SYS_IOCCOM_H_)) {
    sub _SYS_IOCCOM_H_ () {1;}
    sub IOCPARM_MASK () {0x1fff;}
    sub IOCPARM_LEN {
        local($x) = @_;
	    eval {((($x) >> 16) &  &IOCPARM_MASK)};
    }
    sub IOCBASECMD {
        local($x) = @_;
	    eval {(($x) & ~( &IOCPARM_MASK << 16))};
    }
    sub IOCGROUP {
        local($x) = @_;
	    eval {((($x) >> 8) & 0xff)};
    }
    sub IOCPARM_MAX () { &PAGE_SIZE;}
    sub IOC_VOID () {0x20000000;}
    sub IOC_OUT () {0x40000000;}
    sub IOC_IN () {0x80000000;}
    sub IOC_INOUT () {( &IOC_IN| &IOC_OUT);}
    sub IOC_DIRMASK () {0xe0000000;}
    sub _IOC {
        local($inout,$group,$num,$len) = @_;
	    eval {(($inout | (($len &  &IOCPARM_MASK) << 16) | (($group) << 8) | ($num)))};
    }
    sub _IO {
        local($g,$n) = @_;
	    eval { &_IOC( &IOC_VOID, ($g), ($n), 0)};
    }
    sub _IOR {
        local($g,$n,$t) = @_;
	    eval { &_IOC( &IOC_OUT, ($g), ($n), $sizeof{$t})};
    }
    sub _IOW {
        local($g,$n,$t) = @_;
	    eval { &_IOC( &IOC_IN, ($g), ($n), $sizeof{$t})};
    }
    sub _IOWR {
        local($g,$n,$t) = @_;
	    eval { &_IOC( &IOC_INOUT, ($g), ($n), $sizeof{$t})};
    }
    unless(defined(&_KERNEL)) {
	
    }
}
1;
unless(defined(&_NET_ETHERNET_H_)) {
    sub _NET_ETHERNET_H_ () {1;}
    sub ETHER_ADDR_LEN () {6;}
    sub ETHER_TYPE_LEN () {2;}
    sub ETHER_CRC_LEN () {4;}
    sub ETHER_HDR_LEN () {( &ETHER_ADDR_LEN*2+ &ETHER_TYPE_LEN);}
    sub ETHER_MIN_LEN () {64;}
    sub ETHER_MAX_LEN () {1518;}
    sub ETHER_IS_VALID_LEN {
        local($foo) = @_;
	    eval {(($foo) >=  &ETHER_MIN_LEN  && ($foo) <=  &ETHER_MAX_LEN)};
    }
    sub ETHERTYPE_PUP () {0x0200;}
    sub ETHERTYPE_IP () {0x0800;}
    sub ETHERTYPE_ARP () {0x0806;}
    sub ETHERTYPE_REVARP () {0x8035;}
    sub ETHERTYPE_VLAN () {0x8100;}
    sub ETHERTYPE_IPV6 () {0x86dd;}
    sub ETHERTYPE_LOOPBACK () {0x9000;}
    sub ETHERTYPE_TRAIL () {0x1000;}
    sub ETHERTYPE_NTRAILER () {16;}
    sub ETHERMTU () {( &ETHER_MAX_LEN- &ETHER_HDR_LEN- &ETHER_CRC_LEN);}
    sub ETHERMIN () {( &ETHER_MIN_LEN- &ETHER_HDR_LEN- &ETHER_CRC_LEN);}
    if(defined(&_KERNEL)) {
	sub ETHER_BPF_UNSUPPORTED () {0;}
	sub ETHER_BPF_SUPPORTED () {1;}
	sub _VLAN_INPUT {
	    local($eh, $m) = @_;
    	    eval q( &do {  &if ( &vlan_input_p !=  &NULL) {  &if ((* &vlan_input_p)($eh, $m) == -1) ($m)-> ($m_pkthdr->{rcvif}->{if_noproto})++; }  &else {  &m_free($m); ($m)-> ($m_pkthdr->{rcvif}->{if_noproto})++; } }  &while (0));
	}
	sub VLAN_INPUT {
	    local($eh, $m) = @_;
    	    eval q( &do {  &_VLAN_INPUT($eh, $m); }  &while (0));
	}
	sub _VLAN_INPUT_TAG {
	    local($eh, $m, $t) = @_;
    	    eval q( &do {  &if ( &vlan_input_tag_p !=  &NULL) {  &if ((* &vlan_input_tag_p)($eh, $m, $t) == -1) ($m)-> ($m_pkthdr->{rcvif}->{if_noproto})++; }  &else {  &m_free($m); ($m)-> ($m_pkthdr->{rcvif}->{if_noproto})++; } }  &while (0));
	}
	sub VLAN_INPUT_TAG {
	    local($eh, $m, $t) = @_;
    	    eval q( &do {  &_VLAN_INPUT_TAG($eh, $m, $t); }  &while (0));
	}
    } else {
	
    }
}
1;
unless(defined(&_NET_IF_VAR_H_)) {
    sub _NET_IF_VAR_H_ () {1;}
    if(defined(&__STDC__)) {
    }
    
    sub if_capabilities () { ($_u1->{uif_capabilities});}
    sub if_capenable () { ($_u2->{uif_capenable});}
    sub if_mtu () { ($if_data->{ifi_mtu});}
    sub if_type () { ($if_data->{ifi_type});}
    sub if_physical () { ($if_data->{ifi_physical});}
    sub if_addrlen () { ($if_data->{ifi_addrlen});}
    sub if_hdrlen () { ($if_data->{ifi_hdrlen});}
    sub if_metric () { ($if_data->{ifi_metric});}
    sub if_baudrate () { ($if_data->{ifi_baudrate});}
    sub if_hwassist () { ($if_data->{ifi_hwassist});}
    sub if_ipackets () { ($if_data->{ifi_ipackets});}
    sub if_ierrors () { ($if_data->{ifi_ierrors});}
    sub if_opackets () { ($if_data->{ifi_opackets});}
    sub if_oerrors () { ($if_data->{ifi_oerrors});}
    sub if_collisions () { ($if_data->{ifi_collisions});}
    sub if_ibytes () { ($if_data->{ifi_ibytes});}
    sub if_obytes () { ($if_data->{ifi_obytes});}
    sub if_imcasts () { ($if_data->{ifi_imcasts});}
    sub if_omcasts () { ($if_data->{ifi_omcasts});}
    sub if_iqdrops () { ($if_data->{ifi_iqdrops});}
    sub if_noproto () { ($if_data->{ifi_noproto});}
    sub if_lastchange () { ($if_data->{ifi_lastchange});}
    sub if_recvquota () { ($if_data->{ifi_recvquota});}
    sub if_xmitquota () { ($if_data->{ifi_xmitquota});}
    sub if_rawoutput {
        local($if, $m, $sa) = @_;
	    eval { &if_output($if, $m, $sa, 0)};
    }
    sub if_addrlist () { &if_addrhead;}
    sub if_list () { &if_link;}
    sub IFI_RECV () {1;}
    sub IFI_XMIT () {2;}
    sub IF_QFULL {
        local($ifq) = @_;
	    eval q((($ifq)-> &ifq_len >= ($ifq)-> &ifq_maxlen));
    }
    sub IF_DROP {
        local($ifq) = @_;
	    eval q((($ifq)-> &ifq_drops++));
    }
    sub IF_ENQUEUE {
        local($ifq, $m) = @_;
	    eval q({ ($m)-> &m_nextpkt = 0;  &if (($ifq)-> &ifq_tail == 0) ($ifq)-> &ifq_head = $m;  &else ($ifq)-> ($ifq_tail->{m_nextpkt}) = $m; ($ifq)-> &ifq_tail = $m; ($ifq)-> &ifq_len++; });
    }
    sub IF_PREPEND {
        local($ifq, $m) = @_;
	    eval q({ ($m)-> &m_nextpkt = ($ifq)-> &ifq_head;  &if (($ifq)-> &ifq_tail == 0) ($ifq)-> &ifq_tail = ($m); ($ifq)-> &ifq_head = ($m); ($ifq)-> &ifq_len++; });
    }
    sub IF_DEQUEUE {
        local($ifq, $m) = @_;
	    eval q({ ($m) = ($ifq)-> &ifq_head;  &if ($m) {  &if ((($ifq)-> &ifq_head = ($m)-> &m_nextpkt) == 0) ($ifq)-> &ifq_tail = 0; ($m)-> &m_nextpkt = 0; ($ifq)-> &ifq_len--; } });
    }
    if(defined(&_KERNEL)) {
	sub IF_ENQ_DROP {
	    local($ifq, $m) = @_;
    	    eval { &if_enq_drop($ifq, $m)};
	}
	if(defined( &__GNUC__)  && defined( &MT_HEADER)) {
	} else {
	    if(defined(&MT_HEADER)) {
	    }
	}
	sub IF_MINMTU () {72;}
	sub IF_MAXMTU () {65535;}
    }
    sub ifa_broadaddr () { &ifa_dstaddr;}
    if(defined(&notdef)) {
    }
    sub IFA_ROUTE () { &RTF_UP;}
    sub ifa_list () { &ifa_link;}
    if(defined(&_KERNEL)) {
	sub IFAFREE {
	    local($ifa) = @_;
    	    eval q( &do {  &if (($ifa)-> &ifa_refcnt <= 0)  &ifafree($ifa);  &else ($ifa)-> &ifa_refcnt--; }  &while (0));
	}
    }
}
1;
unless(defined(&_NETINET_IP_H_)) {
    sub _NETINET_IP_H_ () {1;}
    sub IPVERSION () {4;}
    if(defined(&_IP_VHL)) {
    } else {
	if((defined(&BYTE_ORDER) ? &BYTE_ORDER : 0) == (defined(&LITTLE_ENDIAN) ? &LITTLE_ENDIAN : 0)) {
	}
	if((defined(&BYTE_ORDER) ? &BYTE_ORDER : 0) == (defined(&BIG_ENDIAN) ? &BIG_ENDIAN : 0)) {
	}
    }
    sub IP_RF () {0x8000;}
    sub IP_DF () {0x4000;}
    sub IP_MF () {0x2000;}
    sub IP_OFFMASK () {0x1fff;}
    if(defined(&_IP_VHL)) {
	sub IP_MAKE_VHL {
	    local($v, $hl) = @_;
    	    eval {(($v) << 4| ($hl))};
	}
	sub IP_VHL_HL {
	    local($vhl) = @_;
    	    eval {(($vhl) & 0x0f)};
	}
	sub IP_VHL_V {
	    local($vhl) = @_;
    	    eval {(($vhl) >> 4)};
	}
	sub IP_VHL_BORING () {0x45;}
    }
    sub IP_MAXPACKET () {65535;}
    sub IPTOS_LOWDELAY () {0x10;}
    sub IPTOS_THROUGHPUT () {0x08;}
    sub IPTOS_RELIABILITY () {0x04;}
    sub IPTOS_MINCOST () {0x02;}
    sub IPTOS_CE () {0x01;}
    sub IPTOS_ECT () {0x02;}
    sub IPTOS_PREC_NETCONTROL () {0xe0;}
    sub IPTOS_PREC_INTERNETCONTROL () {0xc0;}
    sub IPTOS_PREC_CRITIC_ECP () {0xa0;}
    sub IPTOS_PREC_FLASHOVERRIDE () {0x80;}
    sub IPTOS_PREC_FLASH () {0x60;}
    sub IPTOS_PREC_IMMEDIATE () {0x40;}
    sub IPTOS_PREC_PRIORITY () {0x20;}
    sub IPTOS_PREC_ROUTINE () {0x00;}
    sub IPOPT_COPIED {
        local($o) = @_;
	    eval {(($o)&0x80)};
    }
    sub IPOPT_CLASS {
        local($o) = @_;
	    eval {(($o)&0x60)};
    }
    sub IPOPT_NUMBER {
        local($o) = @_;
	    eval {(($o)&0x1f)};
    }
    sub IPOPT_CONTROL () {0x00;}
    sub IPOPT_RESERVED1 () {0x20;}
    sub IPOPT_DEBMEAS () {0x40;}
    sub IPOPT_RESERVED2 () {0x60;}
    sub IPOPT_EOL () {0;}
    sub IPOPT_NOP () {1;}
    sub IPOPT_RR () {7;}
    sub IPOPT_TS () {68;}
    sub IPOPT_SECURITY () {130;}
    sub IPOPT_LSRR () {131;}
    sub IPOPT_SATID () {136;}
    sub IPOPT_SSRR () {137;}
    sub IPOPT_RA () {148;}
    sub IPOPT_OPTVAL () {0;}
    sub IPOPT_OLEN () {1;}
    sub IPOPT_OFFSET () {2;}
    sub IPOPT_MINOFF () {4;}
    if((defined(&BYTE_ORDER) ? &BYTE_ORDER : 0) == (defined(&LITTLE_ENDIAN) ? &LITTLE_ENDIAN : 0)) {
    }
    if((defined(&BYTE_ORDER) ? &BYTE_ORDER : 0) == (defined(&BIG_ENDIAN) ? &BIG_ENDIAN : 0)) {
    }
    sub IPOPT_TS_TSONLY () {0;}
    sub IPOPT_TS_TSANDADDR () {1;}
    sub IPOPT_TS_PRESPEC () {3;}
    sub IPOPT_SECUR_UNCLASS () {0x0000;}
    sub IPOPT_SECUR_CONFID () {0xf135;}
    sub IPOPT_SECUR_EFTO () {0x789a;}
    sub IPOPT_SECUR_MMMM () {0xbc4d;}
    sub IPOPT_SECUR_RESTR () {0xaf13;}
    sub IPOPT_SECUR_SECRET () {0xd788;}
    sub IPOPT_SECUR_TOPSECRET () {0x6bc5;}
    sub MAXTTL () {255;}
    sub IPDEFTTL () {64;}
    sub IPFRAGTTL () {60;}
    sub IPTTLDEC () {1;}
    sub IP_MSS () {576;}
}
1;
unless(defined(&_NET_IF_H_)) {
    sub _NET_IF_H_ () {1;}
    
    unless(defined(&_KERNEL)) {
	
    }
    sub IFNAMSIZ () {16;}
    sub IF_NAMESIZE () { &IFNAMSIZ;}
    sub IF_CLONE_INITIALIZER {
        local($name, $create, $destroy) = @_;
	    eval q({ { 0}, $name, $sizeof{$name} - 1, $create, $destroy });
    }
    sub IFF_UP () {0x1;}
    sub IFF_BROADCAST () {0x2;}
    sub IFF_DEBUG () {0x4;}
    sub IFF_LOOPBACK () {0x8;}
    sub IFF_POINTOPOINT () {0x10;}
    sub IFF_SMART () {0x20;}
    sub IFF_RUNNING () {0x40;}
    sub IFF_NOARP () {0x80;}
    sub IFF_PROMISC () {0x100;}
    sub IFF_ALLMULTI () {0x200;}
    sub IFF_OACTIVE () {0x400;}
    sub IFF_SIMPLEX () {0x800;}
    sub IFF_LINK0 () {0x1000;}
    sub IFF_LINK1 () {0x2000;}
    sub IFF_LINK2 () {0x4000;}
    sub IFF_ALTPHYS () { &IFF_LINK2;}
    sub IFF_MULTICAST () {0x8000;}
    sub IFF_CANTCHANGE () {( &IFF_BROADCAST| &IFF_POINTOPOINT| &IFF_RUNNING| &IFF_OACTIVE|  &IFF_SIMPLEX| &IFF_MULTICAST| &IFF_ALLMULTI| &IFF_SMART);}
    sub IFCAP_RXCSUM () {0x0001;}
    sub IFCAP_TXCSUM () {0x0002;}
    sub IFCAP_NETCONS () {0x0004;}
    sub IFCAP_HWCSUM () {( &IFCAP_RXCSUM |  &IFCAP_TXCSUM);}
    sub IFQ_MAXLEN () {50;}
    sub IFNET_SLOWHZ () {1;}
    sub ifr_addr () { ($ifr_ifru->{ifru_addr});}
    sub ifr_dstaddr () { ($ifr_ifru->{ifru_dstaddr});}
    sub ifr_broadaddr () { ($ifr_ifru->{ifru_broadaddr});}
    sub ifr_flags () { ($ifr_ifru->{ifru_flags});}
    sub ifr_prevflags () { ($ifr_ifru->{ifru_flags});}
    sub ifr_metric () { ($ifr_ifru->{ifru_metric});}
    sub ifr_mtu () { ($ifr_ifru->{ifru_mtu});}
    sub ifr_phys () { ($ifr_ifru->{ifru_phys});}
    sub ifr_media () { ($ifr_ifru->{ifru_media});}
    sub ifr_data () { ($ifr_ifru->{ifru_data});}
    sub ifr_reqcap () { ($ifr_ifru->{ifru_cap});}
    sub ifr_curcap () { ($ifr_ifru->{ifru_cap});}
    sub _SIZEOF_ADDR_IFREQ {
        local($ifr) = @_;
	    eval q((($ifr). ($ifr_addr->{sa_len}) > $sizeof{'sockaddr'} ? ($sizeof{'ifreq'} - $sizeof{'sockaddr'} + ($ifr). ($ifr_addr->{sa_len})) : $sizeof{'ifreq'}));
    }
    sub IFSTATMAX () {800;}
    sub ifc_buf () { ($ifc_ifcu->{ifcu_buf});}
    sub ifc_req () { ($ifc_ifcu->{ifcu_req});}
    sub IFLR_PREFIX () {0x8000;}
    if(defined(&_KERNEL)) {
	if(defined(&MALLOC_DECLARE)) {
	}
    }
    unless(defined(&_KERNEL)) {
    }
    if(defined(&_KERNEL)) {
	
    }
}
1;
unless(defined(&_SYS_SOCKET_H_)) {
    sub _SYS_SOCKET_H_ () {1;}
    
    sub _NO_NAMESPACE_POLLUTION () {1;}
    
    undef(&_NO_NAMESPACE_POLLUTION) if defined(&_NO_NAMESPACE_POLLUTION);
    if(defined(&_BSD_SOCKLEN_T_)) {
	undef(&_BSD_SOCKLEN_T_) if defined(&_BSD_SOCKLEN_T_);
    }
    sub SOCK_STREAM () {1;}
    sub SOCK_DGRAM () {2;}
    sub SOCK_RAW () {3;}
    sub SOCK_RDM () {4;}
    sub SOCK_SEQPACKET () {5;}
    sub SO_DEBUG () {0x0001;}
    sub SO_ACCEPTCONN () {0x0002;}
    sub SO_REUSEADDR () {0x0004;}
    sub SO_KEEPALIVE () {0x0008;}
    sub SO_DONTROUTE () {0x0010;}
    sub SO_BROADCAST () {0x0020;}
    sub SO_USELOOPBACK () {0x0040;}
    sub SO_LINGER () {0x0080;}
    sub SO_OOBINLINE () {0x0100;}
    sub SO_REUSEPORT () {0x0200;}
    sub SO_TIMESTAMP () {0x0400;}
    sub SO_ACCEPTFILTER () {0x1000;}
    sub SO_SNDBUF () {0x1001;}
    sub SO_RCVBUF () {0x1002;}
    sub SO_SNDLOWAT () {0x1003;}
    sub SO_RCVLOWAT () {0x1004;}
    sub SO_SNDTIMEO () {0x1005;}
    sub SO_RCVTIMEO () {0x1006;}
    sub SO_ERROR () {0x1007;}
    sub SO_TYPE () {0x1008;}
    sub SOL_SOCKET () {0xffff;}
    sub AF_UNSPEC () {0;}
    sub AF_LOCAL () {1;}
    sub AF_UNIX () { &AF_LOCAL;}
    sub AF_INET () {2;}
    sub AF_IMPLINK () {3;}
    sub AF_PUP () {4;}
    sub AF_CHAOS () {5;}
    sub AF_NS () {6;}
    sub AF_ISO () {7;}
    sub AF_OSI () { &AF_ISO;}
    sub AF_ECMA () {8;}
    sub AF_DATAKIT () {9;}
    sub AF_CCITT () {10;}
    sub AF_SNA () {11;}
    sub AF_DECnet () {12;}
    sub AF_DLI () {13;}
    sub AF_LAT () {14;}
    sub AF_HYLINK () {15;}
    sub AF_APPLETALK () {16;}
    sub AF_ROUTE () {17;}
    sub AF_LINK () {18;}
    sub pseudo_AF_XTP () {19;}
    sub AF_COIP () {20;}
    sub AF_CNT () {21;}
    sub pseudo_AF_RTIP () {22;}
    sub AF_IPX () {23;}
    sub AF_SIP () {24;}
    sub pseudo_AF_PIP () {25;}
    sub AF_ISDN () {26;}
    sub AF_E164 () { &AF_ISDN;}
    sub pseudo_AF_KEY () {27;}
    sub AF_INET6 () {28;}
    sub AF_NATM () {29;}
    sub AF_ATM () {30;}
    sub pseudo_AF_HDRCMPLT () {31;}
    sub AF_NETGRAPH () {32;}
    sub AF_MAX () {33;}
    sub SOCK_MAXADDRLEN () {255;}
    sub _SS_MAXSIZE () {128;}
    sub _SS_ALIGNSIZE () {($sizeof{"int64_t"});}
    sub _SS_PAD1SIZE () {( &_SS_ALIGNSIZE - $sizeof{'u_char'} - $sizeof{"sa_family_t"});}
    sub _SS_PAD2SIZE () {( &_SS_MAXSIZE - $sizeof{'u_char'} - $sizeof{"sa_family_t"} -  &_SS_PAD1SIZE -  &_SS_ALIGNSIZE);}
    sub PF_UNSPEC () { &AF_UNSPEC;}
    sub PF_LOCAL () { &AF_LOCAL;}
    sub PF_UNIX () { &PF_LOCAL;}
    sub PF_INET () { &AF_INET;}
    sub PF_IMPLINK () { &AF_IMPLINK;}
    sub PF_PUP () { &AF_PUP;}
    sub PF_CHAOS () { &AF_CHAOS;}
    sub PF_NS () { &AF_NS;}
    sub PF_ISO () { &AF_ISO;}
    sub PF_OSI () { &AF_ISO;}
    sub PF_ECMA () { &AF_ECMA;}
    sub PF_DATAKIT () { &AF_DATAKIT;}
    sub PF_CCITT () { &AF_CCITT;}
    sub PF_SNA () { &AF_SNA;}
    sub PF_DECnet () { &AF_DECnet;}
    sub PF_DLI () { &AF_DLI;}
    sub PF_LAT () { &AF_LAT;}
    sub PF_HYLINK () { &AF_HYLINK;}
    sub PF_APPLETALK () { &AF_APPLETALK;}
    sub PF_ROUTE () { &AF_ROUTE;}
    sub PF_LINK () { &AF_LINK;}
    sub PF_XTP () { &pseudo_AF_XTP;}
    sub PF_COIP () { &AF_COIP;}
    sub PF_CNT () { &AF_CNT;}
    sub PF_SIP () { &AF_SIP;}
    sub PF_IPX () { &AF_IPX;}
    sub PF_RTIP () { &pseudo_AF_RTIP;}
    sub PF_PIP () { &pseudo_AF_PIP;}
    sub PF_ISDN () { &AF_ISDN;}
    sub PF_KEY () { &pseudo_AF_KEY;}
    sub PF_INET6 () { &AF_INET6;}
    sub PF_NATM () { &AF_NATM;}
    sub PF_ATM () { &AF_ATM;}
    sub PF_NETGRAPH () { &AF_NETGRAPH;}
    sub PF_MAX () { &AF_MAX;}
    sub NET_MAXID () { &AF_MAX;}
    sub CTL_NET_NAMES () {{ { 0, 0}, { "unix",  &CTLTYPE_NODE }, { "inet",  &CTLTYPE_NODE }, { "implink",  &CTLTYPE_NODE }, { "pup",  &CTLTYPE_NODE }, { "chaos",  &CTLTYPE_NODE }, { "xerox_ns",  &CTLTYPE_NODE }, { "iso",  &CTLTYPE_NODE }, { "emca",  &CTLTYPE_NODE }, { "datakit",  &CTLTYPE_NODE }, { "ccitt",  &CTLTYPE_NODE }, { "ibm_sna",  &CTLTYPE_NODE }, { "decnet",  &CTLTYPE_NODE }, { "dec_dli",  &CTLTYPE_NODE }, { "lat",  &CTLTYPE_NODE }, { "hylink",  &CTLTYPE_NODE }, { "appletalk",  &CTLTYPE_NODE }, { "route",  &CTLTYPE_NODE }, { "link_layer",  &CTLTYPE_NODE }, { "xtp",  &CTLTYPE_NODE }, { "coip",  &CTLTYPE_NODE }, { "cnt",  &CTLTYPE_NODE }, { "rtip",  &CTLTYPE_NODE }, { "ipx",  &CTLTYPE_NODE }, { "sip",  &CTLTYPE_NODE }, { "pip",  &CTLTYPE_NODE }, { "isdn",  &CTLTYPE_NODE }, { "key",  &CTLTYPE_NODE }, { "inet6",  &CTLTYPE_NODE }, { "natm",  &CTLTYPE_NODE }, { "atm",  &CTLTYPE_NODE }, { "hdrcomplete",  &CTLTYPE_NODE }, { "netgraph",  &CTLTYPE_NODE }, };}
    sub NET_RT_DUMP () {1;}
    sub NET_RT_FLAGS () {2;}
    sub NET_RT_IFLIST () {3;}
    sub NET_RT_MAXID () {4;}
    sub CTL_NET_RT_NAMES () {{ { 0, 0}, { "dump",  &CTLTYPE_STRUCT }, { "flags",  &CTLTYPE_STRUCT }, { "iflist",  &CTLTYPE_STRUCT }, };}
    sub SOMAXCONN () {128;}
    sub MSG_OOB () {0x1;}
    sub MSG_PEEK () {0x2;}
    sub MSG_DONTROUTE () {0x4;}
    sub MSG_EOR () {0x8;}
    sub MSG_TRUNC () {0x10;}
    sub MSG_CTRUNC () {0x20;}
    sub MSG_WAITALL () {0x40;}
    sub MSG_DONTWAIT () {0x80;}
    sub MSG_EOF () {0x100;}
    sub MSG_COMPAT () {0x8000;}
    sub CMGROUP_MAX () {16;}
    sub CMSG_DATA {
        local($cmsg) = @_;
	    eval {(($cmsg) +  &_ALIGN($sizeof{'cmsghdr'}))};
    }
    sub CMSG_NXTHDR {
        local($mhdr, $cmsg) = @_;
	    eval q((( +  &_ALIGN(-> &cmsg_len) +  &_ALIGN > -> &msg_control + -> &msg_controllen) ?  &NULL : (($cmsg) +  &_ALIGN(($cmsg)-> &cmsg_len))));
    }
    sub CMSG_FIRSTHDR {
        local($mhdr) = @_;
	    eval q((($mhdr)-> &msg_control));
    }
    sub CMSG_SPACE {
        local($l) = @_;
	    eval {( &_ALIGN($sizeof{'cmsghdr'}) +  &_ALIGN($l))};
    }
    sub CMSG_LEN {
        local($l) = @_;
	    eval {( &_ALIGN($sizeof{'cmsghdr'}) + ($l))};
    }
    if(defined(&_KERNEL)) {
	sub CMSG_ALIGN {
	    local($n) = @_;
    	    eval { &_ALIGN($n)};
	}
    }
    sub SCM_RIGHTS () {0x01;}
    sub SCM_TIMESTAMP () {0x02;}
    sub SCM_CREDS () {0x03;}
    sub SHUT_RD () {0;}
    sub SHUT_WR () {1;}
    sub SHUT_RDWR () {2;}
    unless(defined(&_KERNEL)) {
	
    }
}
1;
unless(defined(&_net_nit_h)) {
    sub _net_nit_h () {1;}
    sub NITIFSIZ () {10;}
    sub NITBUFSIZ () {1024;}
    sub NITPROTO_RAW () {1;}
    sub NITPROTO_MAX () {2;}
    sub nh_info () { ($nh_un->{info});}
    sub nh_datalen () { ($nh_un->{datalen});}
    sub nh_dropped () { ($nh_un->{dropped});}
    sub nh_seqno () { ($nh_un->{seqno});}
    sub NT_NOTYPES () {(0);}
    sub NT_ALLTYPES () {(-1);}
    sub NF_PROMISC () {0x01;}
    sub NF_TIMEOUT () {0x02;}
    sub NF_BUSY () {0x04;}
    sub NIT_QUIET () {0;}
    sub NIT_CATCH () {1;}
    sub NIT_NOMBUF () {2;}
    sub NIT_NOCLUSTER () {3;}
    sub NIT_NOSPACE () {4;}
    sub NIT_SEQNO () {5;}
    sub NIT_MAXSTATE () {6;}
    if(defined( &KERNEL)  && defined( &NIT)) {
    }
}
1;
unless(defined(&_SYS_SOCKIO_H_)) {
    sub _SYS_SOCKIO_H_ () {1;}
    
    sub SIOCSHIWAT () { &_IOW(ord('s'), 0, 'int');}
    sub SIOCGHIWAT () { &_IOR(ord('s'), 1, 'int');}
    sub SIOCSLOWAT () { &_IOW(ord('s'), 2, 'int');}
    sub SIOCGLOWAT () { &_IOR(ord('s'), 3, 'int');}
    sub SIOCATMARK () { &_IOR(ord('s'), 7, 'int');}
    sub SIOCSPGRP () { &_IOW(ord('s'), 8, 'int');}
    sub SIOCGPGRP () { &_IOR(ord('s'), 9, 'int');}
    sub SIOCADDRT () { &_IOW(ord('r'), 10, 'ortentry');}
    sub SIOCDELRT () { &_IOW(ord('r'), 11, 'ortentry');}
    sub SIOCGETVIFCNT () { &_IOWR(ord('r'), 15, 'sioc_vif_req');}
    sub SIOCGETSGCNT () { &_IOWR(ord('r'), 16, 'sioc_sg_req');}
    sub SIOCSIFADDR () { &_IOW(ord('i'), 12, 'ifreq');}
    sub OSIOCGIFADDR () { &_IOWR(ord('i'), 13, 'ifreq');}
    sub SIOCGIFADDR () { &_IOWR(ord('i'), 33, 'ifreq');}
    sub SIOCSIFDSTADDR () { &_IOW(ord('i'), 14, 'ifreq');}
    sub OSIOCGIFDSTADDR () { &_IOWR(ord('i'), 15, 'ifreq');}
    sub SIOCGIFDSTADDR () { &_IOWR(ord('i'), 34, 'ifreq');}
    sub SIOCSIFFLAGS () { &_IOW(ord('i'), 16, 'ifreq');}
    sub SIOCGIFFLAGS () { &_IOWR(ord('i'), 17, 'ifreq');}
    sub OSIOCGIFBRDADDR () { &_IOWR(ord('i'), 18, 'ifreq');}
    sub SIOCGIFBRDADDR () { &_IOWR(ord('i'), 35, 'ifreq');}
    sub SIOCSIFBRDADDR () { &_IOW(ord('i'), 19, 'ifreq');}
    sub OSIOCGIFCONF () { &_IOWR(ord('i'), 20, 'ifconf');}
    sub SIOCGIFCONF () { &_IOWR(ord('i'), 36, 'ifconf');}
    sub OSIOCGIFNETMASK () { &_IOWR(ord('i'), 21, 'ifreq');}
    sub SIOCGIFNETMASK () { &_IOWR(ord('i'), 37, 'ifreq');}
    sub SIOCSIFNETMASK () { &_IOW(ord('i'), 22, 'ifreq');}
    sub SIOCGIFMETRIC () { &_IOWR(ord('i'), 23, 'ifreq');}
    sub SIOCSIFMETRIC () { &_IOW(ord('i'), 24, 'ifreq');}
    sub SIOCDIFADDR () { &_IOW(ord('i'), 25, 'ifreq');}
    sub SIOCAIFADDR () { &_IOW(ord('i'), 26, 'ifaliasreq');}
    sub SIOCALIFADDR () { &_IOW(ord('i'), 27, 'if_laddrreq');}
    sub SIOCGLIFADDR () { &_IOWR(ord('i'), 28, 'if_laddrreq');}
    sub SIOCDLIFADDR () { &_IOW(ord('i'), 29, 'if_laddrreq');}
    sub SIOCSIFCAP () { &_IOW(ord('i'), 30, 'ifreq');}
    sub SIOCGIFCAP () { &_IOWR(ord('i'), 31, 'ifreq');}
    sub SIOCADDMULTI () { &_IOW(ord('i'), 49, 'ifreq');}
    sub SIOCDELMULTI () { &_IOW(ord('i'), 50, 'ifreq');}
    sub SIOCGIFMTU () { &_IOWR(ord('i'), 51, 'ifreq');}
    sub SIOCSIFMTU () { &_IOW(ord('i'), 52, 'ifreq');}
    sub SIOCGIFPHYS () { &_IOWR(ord('i'), 53, 'ifreq');}
    sub SIOCSIFPHYS () { &_IOW(ord('i'), 54, 'ifreq');}
    sub SIOCSIFMEDIA () { &_IOWR(ord('i'), 55, 'ifreq');}
    sub SIOCGIFMEDIA () { &_IOWR(ord('i'), 56, 'ifmediareq');}
    sub SIOCSIFPHYADDR () { &_IOW(ord('i'), 70, 'ifaliasreq');}
    sub SIOCGIFPSRCADDR () { &_IOWR(ord('i'), 71, 'ifreq');}
    sub SIOCGIFPDSTADDR () { &_IOWR(ord('i'), 72, 'ifreq');}
    sub SIOCDIFPHYADDR () { &_IOW(ord('i'), 73, 'ifreq');}
    sub SIOCSLIFPHYADDR () { &_IOW(ord('i'), 74, 'if_laddrreq');}
    sub SIOCGLIFPHYADDR () { &_IOWR(ord('i'), 75, 'if_laddrreq');}
    sub SIOCSIFGENERIC () { &_IOW(ord('i'), 57, 'ifreq');}
    sub SIOCGIFGENERIC () { &_IOWR(ord('i'), 58, 'ifreq');}
    sub SIOCGIFSTATUS () { &_IOWR(ord('i'), 59, 'ifstat');}
    sub SIOCSIFLLADDR () { &_IOW(ord('i'), 60, 'ifreq');}
    sub SIOCIFCREATE () { &_IOWR(ord('i'), 122, 'ifreq');}
    sub SIOCIFDESTROY () { &_IOW(ord('i'), 121, 'ifreq');}
    sub SIOCIFGCLONERS () { &_IOWR(ord('i'), 120, 'if_clonereq');}
}
1;
unless(defined(&_SYS_SYSCTL_H_)) {
    eval 'sub _SYS_SYSCTL_H_ () {1;}' unless defined(&_SYS_SYSCTL_H_);
    
    
    sub CTL_MAXNAME () {12;}
    sub CTLTYPE () {0xf;}
    sub CTLTYPE_NODE () {1;}
    sub CTLTYPE_INT () {2;}
    sub CTLTYPE_STRING () {3;}
    sub CTLTYPE_QUAD () {4;}
    sub CTLTYPE_OPAQUE () {5;}
    sub CTLTYPE_STRUCT () { &CTLTYPE_OPAQUE;}
    sub CTLTYPE_UINT () {6;}
    sub CTLTYPE_LONG () {7;}
    sub CTLTYPE_ULONG () {8;}
    sub CTLFLAG_RD () {0x80000000;}
    sub CTLFLAG_WR () {0x40000000;}
    sub CTLFLAG_RW () {( &CTLFLAG_RD| &CTLFLAG_WR);}
    sub CTLFLAG_NOLOCK () {0x20000000;}
    sub CTLFLAG_ANYBODY () {0x10000000;}
    sub CTLFLAG_SECURE () {0x08000000;}
    sub CTLFLAG_PRISON () {0x04000000;}
    sub CTLFLAG_DYN () {0x02000000;}
    eval 'sub OID_AUTO () {(-1);}' unless defined(&OID_AUTO);
    if(defined(&_KERNEL)) {
	eval 'sub SYSCTL_HANDLER_ARGS () {\'sysctl_oid\' * &oidp,  &void * &arg1, \'int\'  &arg2, \'sysctl_req\' * &req;}' unless defined(&SYSCTL_HANDLER_ARGS);
	eval 'sub SYSCTL_IN {
	    local($r, $p, $l) = @_;
    	    eval q(( ($r->{newfunc}))($r, $p, $l));
	}' unless defined(&SYSCTL_IN);
	eval 'sub SYSCTL_OUT {
	    local($r, $p, $l) = @_;
    	    eval q(( ($r->{oldfunc}))($r, $p, $l));
	}' unless defined(&SYSCTL_OUT);
	eval 'sub SYSCTL_DECL {
	    local($name) = @_;
    	    eval { &extern \'sysctl_oid_list\'  &sysctl_$name &_children};
	}' unless defined(&SYSCTL_DECL);
	eval 'sub SYSCTL_CHILDREN {
	    local($oid_ptr) = @_;
    	    eval q( ($oid_ptr)-> &oid_arg1);
	}' unless defined(&SYSCTL_CHILDREN);
	eval 'sub SYSCTL_STATIC_CHILDREN {
	    local($oid_name) = @_;
    	    eval {( &sysctl_$oid_name &_children)};
	}' unless defined(&SYSCTL_STATIC_CHILDREN);
	eval 'sub SYSCTL_OID {
	    local($parent, $nbr, $name, $kind, $a1, $a2, $handler, $fmt, $descr) = @_;
    	    eval q( &static \'sysctl_oid\'  &sysctl__$parent &_$name = {  &sysctl_$parent &_children, { 0}, $nbr, $kind, $a1, $a2, $name, $handler, $fmt };  &DATA_SET( &sysctl_set,  &sysctl__$parent &_$name););
	}' unless defined(&SYSCTL_OID);
	eval 'sub SYSCTL_ADD_OID {
	    local($ctx, $parent, $nbr, $name, $kind, $a1, $a2, $handler, $fmt, $descr) = @_;
    	    eval q( &sysctl_add_oid($ctx, $parent, $nbr, $name, $kind, $a1, $a2, $handler, $fmt, $descr););
	}' unless defined(&SYSCTL_ADD_OID);
	eval 'sub SYSCTL_NODE {
	    local($parent, $nbr, $name, $access, $handler, $descr) = @_;
    	    eval q(\'sysctl_oid_list\'  &sysctl_$parent &_$name &_children;  &SYSCTL_OID($parent, $nbr, $name,  &CTLTYPE_NODE|$access, ( &void*) &sysctl_$parent &_$name &_children, 0, $handler, \\"N\\", $descr););
	}' unless defined(&SYSCTL_NODE);
	eval 'sub SYSCTL_ADD_NODE {
	    local($ctx, $parent, $nbr, $name, $access, $handler, $descr) = @_;
    	    eval q( &sysctl_add_oid($ctx, $parent, $nbr, $name,  &CTLTYPE_NODE|$access, 0, 0, $handler, \\"N\\", $descr););
	}' unless defined(&SYSCTL_ADD_NODE);
	eval 'sub SYSCTL_STRING {
	    local($parent, $nbr, $name, $access, $arg, $len, $descr) = @_;
    	    eval { &SYSCTL_OID($parent, $nbr, $name,  &CTLTYPE_STRING|$access, $arg, $len,  &sysctl_handle_string, \\"A\\", $descr)};
	}' unless defined(&SYSCTL_STRING);
	eval 'sub SYSCTL_ADD_STRING {
	    local($ctx, $parent, $nbr, $name, $access, $arg, $len, $descr) = @_;
    	    eval q( &sysctl_add_oid($ctx, $parent, $nbr, $name,  &CTLTYPE_STRING|$access, $arg, $len,  &sysctl_handle_string, \\"A\\", $descr););
	}' unless defined(&SYSCTL_ADD_STRING);
	eval 'sub SYSCTL_INT {
	    local($parent, $nbr, $name, $access, $ptr, $val, $descr) = @_;
    	    eval { &SYSCTL_OID($parent, $nbr, $name,  &CTLTYPE_INT|$access, $ptr, $val,  &sysctl_handle_int, \\"I\\", $descr)};
	}' unless defined(&SYSCTL_INT);
	eval 'sub SYSCTL_ADD_INT {
	    local($ctx, $parent, $nbr, $name, $access, $ptr, $val, $descr) = @_;
    	    eval q( &sysctl_add_oid($ctx, $parent, $nbr, $name,  &CTLTYPE_INT|$access, $ptr, $val,  &sysctl_handle_int, \\"I\\", $descr););
	}' unless defined(&SYSCTL_ADD_INT);
	eval 'sub SYSCTL_UINT {
	    local($parent, $nbr, $name, $access, $ptr, $val, $descr) = @_;
    	    eval { &SYSCTL_OID($parent, $nbr, $name,  &CTLTYPE_UINT|$access, $ptr, $val,  &sysctl_handle_int, \\"IU\\", $descr)};
	}' unless defined(&SYSCTL_UINT);
	eval 'sub SYSCTL_ADD_UINT {
	    local($ctx, $parent, $nbr, $name, $access, $ptr, $val, $descr) = @_;
    	    eval q( &sysctl_add_oid($ctx, $parent, $nbr, $name,  &CTLTYPE_UINT|$access, $ptr, $val,  &sysctl_handle_int, \\"IU\\", $descr););
	}' unless defined(&SYSCTL_ADD_UINT);
	eval 'sub SYSCTL_LONG {
	    local($parent, $nbr, $name, $access, $ptr, $val, $descr) = @_;
    	    eval { &SYSCTL_OID($parent, $nbr, $name,  &CTLTYPE_LONG|$access, $ptr, $val, \'sysctl_handle_long\', \\"L\\", $descr)};
	}' unless defined(&SYSCTL_LONG);
	eval 'sub SYSCTL_ADD_LONG {
	    local($ctx, $parent, $nbr, $name, $access, $ptr, $descr) = @_;
    	    eval q( &sysctl_add_oid($ctx, $parent, $nbr, $name,  &CTLTYPE_LONG|$access, $ptr, 0, \'sysctl_handle_long\', \\"L\\", $descr););
	}' unless defined(&SYSCTL_ADD_LONG);
	eval 'sub SYSCTL_ULONG {
	    local($parent, $nbr, $name, $access, $ptr, $val, $descr) = @_;
    	    eval { &SYSCTL_OID($parent, $nbr, $name,  &CTLTYPE_ULONG|$access, $ptr, $val, \'sysctl_handle_long\', \\"LU\\", $descr)};
	}' unless defined(&SYSCTL_ULONG);
	eval 'sub SYSCTL_ADD_ULONG {
	    local($ctx, $parent, $nbr, $name, $access, $ptr, $descr) = @_;
    	    eval q( &sysctl_add_oid($ctx, $parent, $nbr, $name,  &CTLTYPE_ULONG|$access, $ptr, 0, \'sysctl_handle_long\', \\"LU\\", $descr););
	}' unless defined(&SYSCTL_ADD_ULONG);
	eval 'sub SYSCTL_OPAQUE {
	    local($parent, $nbr, $name, $access, $ptr, $len, $fmt, $descr) = @_;
    	    eval { &SYSCTL_OID($parent, $nbr, $name,  &CTLTYPE_OPAQUE|$access, $ptr, $len,  &sysctl_handle_opaque, $fmt, $descr)};
	}' unless defined(&SYSCTL_OPAQUE);
	eval 'sub SYSCTL_ADD_OPAQUE {
	    local($ctx, $parent, $nbr, $name, $access, $ptr, $len, $fmt, $descr) = @_;
    	    eval q( &sysctl_add_oid($ctx, $parent, $nbr, $name,  &CTLTYPE_OPAQUE|$access, $ptr, $len,  &sysctl_handle_opaque, $fmt, $descr););
	}' unless defined(&SYSCTL_ADD_OPAQUE);
	eval 'sub SYSCTL_STRUCT {
	    local($parent, $nbr, $name, $access, $ptr, $type, $descr) = @_;
    	    eval { &SYSCTL_OID($parent, $nbr, $name,  &CTLTYPE_OPAQUE|$access, $ptr, $sizeof{\'type\'},  &sysctl_handle_opaque, \\"S,\\" $type, $descr)};
	}' unless defined(&SYSCTL_STRUCT);
	eval 'sub SYSCTL_ADD_STRUCT {
	    local($ctx, $parent, $nbr, $name, $access, $ptr, $type, $descr) = @_;
    	    eval q( &sysctl_add_oid($ctx, $parent, $nbr, $name,  &CTLTYPE_OPAQUE|$access, $ptr, $sizeof{\'type\'},  &sysctl_handle_opaque, \\"S,\\" $type, $descr););
	}' unless defined(&SYSCTL_ADD_STRUCT);
	eval 'sub SYSCTL_PROC {
	    local($parent, $nbr, $name, $access, $ptr, $arg, $handler, $fmt, $descr) = @_;
    	    eval { &SYSCTL_OID($parent, $nbr, $name, $access, $ptr, $arg, $handler, $fmt, $descr)};
	}' unless defined(&SYSCTL_PROC);
	eval 'sub SYSCTL_ADD_PROC {
	    local($ctx, $parent, $nbr, $name, $access, $ptr, $arg, $handler, $fmt, $descr) = @_;
    	    eval q( &sysctl_add_oid($ctx, $parent, $nbr, $name, $access, $ptr, $arg, $handler, $fmt, $descr););
	}' unless defined(&SYSCTL_ADD_PROC);
    }
    sub CTL_UNSPEC () {0;}
    sub CTL_KERN () {1;}
    sub CTL_VM () {2;}
    sub CTL_VFS () {3;}
    sub CTL_NET () {4;}
    sub CTL_DEBUG () {5;}
    sub CTL_HW () {6;}
    sub CTL_MACHDEP () {7;}
    sub CTL_USER () {8;}
    sub CTL_P1003_1B () {9;}
    sub CTL_MAXID () {10;}
    sub CTL_NAMES () {{ { 0, 0}, { "kern",  &CTLTYPE_NODE }, { "vm",  &CTLTYPE_NODE }, { "vfs",  &CTLTYPE_NODE }, { "net",  &CTLTYPE_NODE }, { "debug",  &CTLTYPE_NODE }, { "hw",  &CTLTYPE_NODE }, { "machdep",  &CTLTYPE_NODE }, { "user",  &CTLTYPE_NODE }, { "p1003_1b",  &CTLTYPE_NODE }, };}
    eval 'sub KERN_OSTYPE () {1;}' unless defined(&KERN_OSTYPE);
    eval 'sub KERN_OSRELEASE () {2;}' unless defined(&KERN_OSRELEASE);
    eval 'sub KERN_OSREV () {3;}' unless defined(&KERN_OSREV);
    eval 'sub KERN_VERSION () {4;}' unless defined(&KERN_VERSION);
    eval 'sub KERN_MAXVNODES () {5;}' unless defined(&KERN_MAXVNODES);
    eval 'sub KERN_MAXPROC () {6;}' unless defined(&KERN_MAXPROC);
    eval 'sub KERN_MAXFILES () {7;}' unless defined(&KERN_MAXFILES);
    eval 'sub KERN_ARGMAX () {8;}' unless defined(&KERN_ARGMAX);
    eval 'sub KERN_SECURELVL () {9;}' unless defined(&KERN_SECURELVL);
    eval 'sub KERN_HOSTNAME () {10;}' unless defined(&KERN_HOSTNAME);
    eval 'sub KERN_HOSTID () {11;}' unless defined(&KERN_HOSTID);
    eval 'sub KERN_CLOCKRATE () {12;}' unless defined(&KERN_CLOCKRATE);
    eval 'sub KERN_VNODE () {13;}' unless defined(&KERN_VNODE);
    eval 'sub KERN_PROC () {14;}' unless defined(&KERN_PROC);
    eval 'sub KERN_FILE () {15;}' unless defined(&KERN_FILE);
    eval 'sub KERN_PROF () {16;}' unless defined(&KERN_PROF);
    eval 'sub KERN_POSIX1 () {17;}' unless defined(&KERN_POSIX1);
    eval 'sub KERN_NGROUPS () {18;}' unless defined(&KERN_NGROUPS);
    eval 'sub KERN_JOB_CONTROL () {19;}' unless defined(&KERN_JOB_CONTROL);
    eval 'sub KERN_SAVED_IDS () {20;}' unless defined(&KERN_SAVED_IDS);
    eval 'sub KERN_BOOTTIME () {21;}' unless defined(&KERN_BOOTTIME);
    eval 'sub KERN_NISDOMAINNAME () {22;}' unless defined(&KERN_NISDOMAINNAME);
    eval 'sub KERN_UPDATEINTERVAL () {23;}' unless defined(&KERN_UPDATEINTERVAL);
    eval 'sub KERN_OSRELDATE () {24;}' unless defined(&KERN_OSRELDATE);
    eval 'sub KERN_NTP_PLL () {25;}' unless defined(&KERN_NTP_PLL);
    eval 'sub KERN_BOOTFILE () {26;}' unless defined(&KERN_BOOTFILE);
    eval 'sub KERN_MAXFILESPERPROC () {27;}' unless defined(&KERN_MAXFILESPERPROC);
    eval 'sub KERN_MAXPROCPERUID () {28;}' unless defined(&KERN_MAXPROCPERUID);
    eval 'sub KERN_DUMPDEV () {29;}' unless defined(&KERN_DUMPDEV);
    eval 'sub KERN_IPC () {30;}' unless defined(&KERN_IPC);
    eval 'sub KERN_DUMMY () {31;}' unless defined(&KERN_DUMMY);
    eval 'sub KERN_PS_STRINGS () {32;}' unless defined(&KERN_PS_STRINGS);
    eval 'sub KERN_USRSTACK () {33;}' unless defined(&KERN_USRSTACK);
    eval 'sub KERN_LOGSIGEXIT () {34;}' unless defined(&KERN_LOGSIGEXIT);
    eval 'sub KERN_MAXID () {35;}' unless defined(&KERN_MAXID);
    sub CTL_KERN_NAMES () {{ { 0, 0}, { "ostype",  &CTLTYPE_STRING }, { "osrelease",  &CTLTYPE_STRING }, { "osrevision",  &CTLTYPE_INT }, { "version",  &CTLTYPE_STRING }, { "maxvnodes",  &CTLTYPE_INT }, { "maxproc",  &CTLTYPE_INT }, { "maxfiles",  &CTLTYPE_INT }, { "argmax",  &CTLTYPE_INT }, { "securelevel",  &CTLTYPE_INT }, { "hostname",  &CTLTYPE_STRING }, { "hostid",  &CTLTYPE_UINT }, { "clockrate",  &CTLTYPE_STRUCT }, { "vnode",  &CTLTYPE_STRUCT }, { "proc",  &CTLTYPE_STRUCT }, { "file",  &CTLTYPE_STRUCT }, { "profiling",  &CTLTYPE_NODE }, { "posix1version",  &CTLTYPE_INT }, { "ngroups",  &CTLTYPE_INT }, { "job_control",  &CTLTYPE_INT }, { "saved_ids",  &CTLTYPE_INT }, { "boottime",  &CTLTYPE_STRUCT }, { "nisdomainname",  &CTLTYPE_STRING }, { "update",  &CTLTYPE_INT }, { "osreldate",  &CTLTYPE_INT }, { "ntp_pll",  &CTLTYPE_NODE }, { "bootfile",  &CTLTYPE_STRING }, { "maxfilesperproc",  &CTLTYPE_INT }, { "maxprocperuid",  &CTLTYPE_INT }, { "dumpdev",  &CTLTYPE_STRUCT }, { "ipc",  &CTLTYPE_NODE }, { "dummy",  &CTLTYPE_INT }, { "ps_strings",  &CTLTYPE_INT }, { "usrstack",  &CTLTYPE_INT }, { "logsigexit",  &CTLTYPE_INT }, };}
    sub CTL_VFS_NAMES () {{ { "vfsconf",  &CTLTYPE_STRUCT }, };}
    eval 'sub KERN_PROC_ALL () {0;}' unless defined(&KERN_PROC_ALL);
    eval 'sub KERN_PROC_PID () {1;}' unless defined(&KERN_PROC_PID);
    eval 'sub KERN_PROC_PGRP () {2;}' unless defined(&KERN_PROC_PGRP);
    eval 'sub KERN_PROC_SESSION () {3;}' unless defined(&KERN_PROC_SESSION);
    eval 'sub KERN_PROC_TTY () {4;}' unless defined(&KERN_PROC_TTY);
    eval 'sub KERN_PROC_UID () {5;}' unless defined(&KERN_PROC_UID);
    eval 'sub KERN_PROC_RUID () {6;}' unless defined(&KERN_PROC_RUID);
    eval 'sub KERN_PROC_ARGS () {7;}' unless defined(&KERN_PROC_ARGS);
    eval 'sub KIPC_MAXSOCKBUF () {1;}' unless defined(&KIPC_MAXSOCKBUF);
    eval 'sub KIPC_SOCKBUF_WASTE () {2;}' unless defined(&KIPC_SOCKBUF_WASTE);
    eval 'sub KIPC_SOMAXCONN () {3;}' unless defined(&KIPC_SOMAXCONN);
    eval 'sub KIPC_MAX_LINKHDR () {4;}' unless defined(&KIPC_MAX_LINKHDR);
    eval 'sub KIPC_MAX_PROTOHDR () {5;}' unless defined(&KIPC_MAX_PROTOHDR);
    eval 'sub KIPC_MAX_HDR () {6;}' unless defined(&KIPC_MAX_HDR);
    eval 'sub KIPC_MAX_DATALEN () {7;}' unless defined(&KIPC_MAX_DATALEN);
    eval 'sub KIPC_MBSTAT () {8;}' unless defined(&KIPC_MBSTAT);
    eval 'sub KIPC_NMBCLUSTERS () {9;}' unless defined(&KIPC_NMBCLUSTERS);
    eval 'sub HW_MACHINE () {1;}' unless defined(&HW_MACHINE);
    eval 'sub HW_MODEL () {2;}' unless defined(&HW_MODEL);
    eval 'sub HW_NCPU () {3;}' unless defined(&HW_NCPU);
    eval 'sub HW_BYTEORDER () {4;}' unless defined(&HW_BYTEORDER);
    eval 'sub HW_PHYSMEM () {5;}' unless defined(&HW_PHYSMEM);
    eval 'sub HW_USERMEM () {6;}' unless defined(&HW_USERMEM);
    eval 'sub HW_PAGESIZE () {7;}' unless defined(&HW_PAGESIZE);
    eval 'sub HW_DISKNAMES () {8;}' unless defined(&HW_DISKNAMES);
    eval 'sub HW_DISKSTATS () {9;}' unless defined(&HW_DISKSTATS);
    eval 'sub HW_FLOATINGPT () {10;}' unless defined(&HW_FLOATINGPT);
    eval 'sub HW_MACHINE_ARCH () {11;}' unless defined(&HW_MACHINE_ARCH);
    eval 'sub HW_MAXID () {12;}' unless defined(&HW_MAXID);
    sub CTL_HW_NAMES () {{ { 0, 0}, { "machine",  &CTLTYPE_STRING }, { "model",  &CTLTYPE_STRING }, { "ncpu",  &CTLTYPE_INT }, { "byteorder",  &CTLTYPE_INT }, { "physmem",  &CTLTYPE_UINT }, { "usermem",  &CTLTYPE_UINT }, { "pagesize",  &CTLTYPE_INT }, { "disknames",  &CTLTYPE_STRUCT }, { "diskstats",  &CTLTYPE_STRUCT }, { "floatingpoint",  &CTLTYPE_INT }, };}
    eval 'sub USER_CS_PATH () {1;}' unless defined(&USER_CS_PATH);
    eval 'sub USER_BC_BASE_MAX () {2;}' unless defined(&USER_BC_BASE_MAX);
    eval 'sub USER_BC_DIM_MAX () {3;}' unless defined(&USER_BC_DIM_MAX);
    eval 'sub USER_BC_SCALE_MAX () {4;}' unless defined(&USER_BC_SCALE_MAX);
    eval 'sub USER_BC_STRING_MAX () {5;}' unless defined(&USER_BC_STRING_MAX);
    eval 'sub USER_COLL_WEIGHTS_MAX () {6;}' unless defined(&USER_COLL_WEIGHTS_MAX);
    eval 'sub USER_EXPR_NEST_MAX () {7;}' unless defined(&USER_EXPR_NEST_MAX);
    eval 'sub USER_LINE_MAX () {8;}' unless defined(&USER_LINE_MAX);
    eval 'sub USER_RE_DUP_MAX () {9;}' unless defined(&USER_RE_DUP_MAX);
    eval 'sub USER_POSIX2_VERSION () {10;}' unless defined(&USER_POSIX2_VERSION);
    eval 'sub USER_POSIX2_C_BIND () {11;}' unless defined(&USER_POSIX2_C_BIND);
    eval 'sub USER_POSIX2_C_DEV () {12;}' unless defined(&USER_POSIX2_C_DEV);
    eval 'sub USER_POSIX2_CHAR_TERM () {13;}' unless defined(&USER_POSIX2_CHAR_TERM);
    eval 'sub USER_POSIX2_FORT_DEV () {14;}' unless defined(&USER_POSIX2_FORT_DEV);
    eval 'sub USER_POSIX2_FORT_RUN () {15;}' unless defined(&USER_POSIX2_FORT_RUN);
    eval 'sub USER_POSIX2_LOCALEDEF () {16;}' unless defined(&USER_POSIX2_LOCALEDEF);
    eval 'sub USER_POSIX2_SW_DEV () {17;}' unless defined(&USER_POSIX2_SW_DEV);
    eval 'sub USER_POSIX2_UPE () {18;}' unless defined(&USER_POSIX2_UPE);
    eval 'sub USER_STREAM_MAX () {19;}' unless defined(&USER_STREAM_MAX);
    eval 'sub USER_TZNAME_MAX () {20;}' unless defined(&USER_TZNAME_MAX);
    eval 'sub USER_MAXID () {21;}' unless defined(&USER_MAXID);
    sub CTL_USER_NAMES () {{ { 0, 0}, { "cs_path",  &CTLTYPE_STRING }, { "bc_base_max",  &CTLTYPE_INT }, { "bc_dim_max",  &CTLTYPE_INT }, { "bc_scale_max",  &CTLTYPE_INT }, { "bc_string_max",  &CTLTYPE_INT }, { "coll_weights_max",  &CTLTYPE_INT }, { "expr_nest_max",  &CTLTYPE_INT }, { "line_max",  &CTLTYPE_INT }, { "re_dup_max",  &CTLTYPE_INT }, { "posix2_version",  &CTLTYPE_INT }, { "posix2_c_bind",  &CTLTYPE_INT }, { "posix2_c_dev",  &CTLTYPE_INT }, { "posix2_char_term",  &CTLTYPE_INT }, { "posix2_fort_dev",  &CTLTYPE_INT }, { "posix2_fort_run",  &CTLTYPE_INT }, { "posix2_localedef",  &CTLTYPE_INT }, { "posix2_sw_dev",  &CTLTYPE_INT }, { "posix2_upe",  &CTLTYPE_INT }, { "stream_max",  &CTLTYPE_INT }, { "tzname_max",  &CTLTYPE_INT }, };}
    sub CTL_P1003_1B_ASYNCHRONOUS_IO () {1;}
    sub CTL_P1003_1B_MAPPED_FILES () {2;}
    sub CTL_P1003_1B_MEMLOCK () {3;}
    sub CTL_P1003_1B_MEMLOCK_RANGE () {4;}
    sub CTL_P1003_1B_MEMORY_PROTECTION () {5;}
    sub CTL_P1003_1B_MESSAGE_PASSING () {6;}
    sub CTL_P1003_1B_PRIORITIZED_IO () {7;}
    sub CTL_P1003_1B_PRIORITY_SCHEDULING () {8;}
    sub CTL_P1003_1B_REALTIME_SIGNALS () {9;}
    sub CTL_P1003_1B_SEMAPHORES () {10;}
    sub CTL_P1003_1B_FSYNC () {11;}
    sub CTL_P1003_1B_SHARED_MEMORY_OBJECTS () {12;}
    sub CTL_P1003_1B_SYNCHRONIZED_IO () {13;}
    sub CTL_P1003_1B_TIMERS () {14;}
    sub CTL_P1003_1B_AIO_LISTIO_MAX () {15;}
    sub CTL_P1003_1B_AIO_MAX () {16;}
    sub CTL_P1003_1B_AIO_PRIO_DELTA_MAX () {17;}
    sub CTL_P1003_1B_DELAYTIMER_MAX () {18;}
    sub CTL_P1003_1B_MQ_OPEN_MAX () {19;}
    sub CTL_P1003_1B_PAGESIZE () {20;}
    sub CTL_P1003_1B_RTSIG_MAX () {21;}
    sub CTL_P1003_1B_SEM_NSEMS_MAX () {22;}
    sub CTL_P1003_1B_SEM_VALUE_MAX () {23;}
    sub CTL_P1003_1B_SIGQUEUE_MAX () {24;}
    sub CTL_P1003_1B_TIMER_MAX () {25;}
    sub CTL_P1003_1B_MAXID () {26;}
    sub CTL_P1003_1B_NAMES () {{ { 0, 0}, { "asynchronous_io",  &CTLTYPE_INT }, { "mapped_files",  &CTLTYPE_INT }, { "memlock",  &CTLTYPE_INT }, { "memlock_range",  &CTLTYPE_INT }, { "memory_protection",  &CTLTYPE_INT }, { "message_passing",  &CTLTYPE_INT }, { "prioritized_io",  &CTLTYPE_INT }, { "priority_scheduling",  &CTLTYPE_INT }, { "realtime_signals",  &CTLTYPE_INT }, { "semaphores",  &CTLTYPE_INT }, { "fsync",  &CTLTYPE_INT }, { "shared_memory_objects",  &CTLTYPE_INT }, { "synchronized_io",  &CTLTYPE_INT }, { "timers",  &CTLTYPE_INT }, { "aio_listio_max",  &CTLTYPE_INT }, { "aio_max",  &CTLTYPE_INT }, { "aio_prio_delta_max",  &CTLTYPE_INT }, { "delaytimer_max",  &CTLTYPE_INT }, { "mq_open_max",  &CTLTYPE_INT }, { "pagesize",  &CTLTYPE_INT }, { "rtsig_max",  &CTLTYPE_INT }, { "nsems_max",  &CTLTYPE_INT }, { "sem_value_max",  &CTLTYPE_INT }, { "sigqueue_max",  &CTLTYPE_INT }, { "timer_max",  &CTLTYPE_INT }, };}
    if(defined(&_KERNEL)) {
    } else {
	
    }
}
1;
unless(defined(&_SYS_TIME_H_)) {
    sub _SYS_TIME_H_ () {1;}
    
    unless(defined(&_TIMESPEC_DECLARED)) {
	sub _TIMESPEC_DECLARED () {1;}
    }
    sub TIMEVAL_TO_TIMESPEC {
        local($tv, $ts) = @_;
	    eval q( &do { ($ts)-> &tv_sec = ($tv)-> &tv_sec; ($ts)-> &tv_nsec = ($tv)-> &tv_usec * 1000; }  &while (0));
    }
    sub TIMESPEC_TO_TIMEVAL {
        local($tv, $ts) = @_;
	    eval q( &do { ($tv)-> &tv_sec = ($ts)-> &tv_sec; ($tv)-> &tv_usec = ($ts)-> &tv_nsec / 1000; }  &while (0));
    }
    sub DST_NONE () {0;}
    sub DST_USA () {1;}
    sub DST_AUST () {2;}
    sub DST_WET () {3;}
    sub DST_MET () {4;}
    sub DST_EET () {5;}
    sub DST_CAN () {6;}
    if(defined(&_KERNEL)) {
	sub timespecclear {
	    local($tvp) = @_;
    	    eval q((($tvp)-> &tv_sec = ($tvp)-> &tv_nsec = 0));
	}
	sub timespecisset {
	    local($tvp) = @_;
    	    eval q((($tvp)-> &tv_sec || ($tvp)-> &tv_nsec));
	}
	sub timespeccmp {
	    local($tvp, $uvp, $cmp) = @_;
    	    eval q(((($tvp)-> &tv_sec == ($uvp)-> &tv_sec) ? (($tvp)-> &tv_nsec $cmp ($uvp)-> &tv_nsec) : (($tvp)-> &tv_sec $cmp ($uvp)-> &tv_sec)));
	}
	sub timespecadd {
	    local($vvp, $uvp) = @_;
    	    eval q( &do { ($vvp)-> &tv_sec += ($uvp)-> &tv_sec; ($vvp)-> &tv_nsec += ($uvp)-> &tv_nsec;  &if (($vvp)-> &tv_nsec >= 1000000000) { ($vvp)-> &tv_sec++; ($vvp)-> &tv_nsec -= 1000000000; } }  &while (0));
	}
	sub timespecsub {
	    local($vvp, $uvp) = @_;
    	    eval q( &do { ($vvp)-> &tv_sec -= ($uvp)-> &tv_sec; ($vvp)-> &tv_nsec -= ($uvp)-> &tv_nsec;  &if (($vvp)-> &tv_nsec < 0) { ($vvp)-> &tv_sec--; ($vvp)-> &tv_nsec += 1000000000; } }  &while (0));
	}
	sub timevalclear {
	    local($tvp) = @_;
    	    eval q(($tvp)-> &tv_sec = ($tvp)-> &tv_usec = 0);
	}
	sub timevalisset {
	    local($tvp) = @_;
    	    eval q((($tvp)-> &tv_sec || ($tvp)-> &tv_usec));
	}
	sub timevalcmp {
	    local($tvp, $uvp, $cmp) = @_;
    	    eval q(((($tvp)-> &tv_sec == ($uvp)-> &tv_sec) ? (($tvp)-> &tv_usec $cmp ($uvp)-> &tv_usec) : (($tvp)-> &tv_sec $cmp ($uvp)-> &tv_sec)));
	}
    }
    unless(defined(&_KERNEL)) {
	sub timerclear {
	    local($tvp) = @_;
    	    eval q(($tvp)-> &tv_sec = ($tvp)-> &tv_usec = 0);
	}
	sub timerisset {
	    local($tvp) = @_;
    	    eval q((($tvp)-> &tv_sec || ($tvp)-> &tv_usec));
	}
	sub timercmp {
	    local($tvp, $uvp, $cmp) = @_;
    	    eval q(((($tvp)-> &tv_sec == ($uvp)-> &tv_sec) ? (($tvp)-> &tv_usec $cmp ($uvp)-> &tv_usec) : (($tvp)-> &tv_sec $cmp ($uvp)-> &tv_sec)));
	}
	sub timeradd {
	    local($tvp, $uvp, $vvp) = @_;
    	    eval q( &do { ($vvp)-> &tv_sec = ($tvp)-> &tv_sec + ($uvp)-> &tv_sec; ($vvp)-> &tv_usec = ($tvp)-> &tv_usec + ($uvp)-> &tv_usec;  &if (($vvp)-> &tv_usec >= 1000000) { ($vvp)-> &tv_sec++; ($vvp)-> &tv_usec -= 1000000; } }  &while (0));
	}
	sub timersub {
	    local($tvp, $uvp, $vvp) = @_;
    	    eval q( &do { ($vvp)-> &tv_sec = ($tvp)-> &tv_sec - ($uvp)-> &tv_sec; ($vvp)-> &tv_usec = ($tvp)-> &tv_usec - ($uvp)-> &tv_usec;  &if (($vvp)-> &tv_usec < 0) { ($vvp)-> &tv_sec--; ($vvp)-> &tv_usec += 1000000; } }  &while (0));
	}
    }
    sub ITIMER_REAL () {0;}
    sub ITIMER_VIRTUAL () {1;}
    sub ITIMER_PROF () {2;}
    unless(defined(&CLOCK_REALTIME)) {
	sub CLOCK_REALTIME () {0;}
    }
    sub CLOCK_VIRTUAL () {1;}
    sub CLOCK_PROF () {2;}
    sub TIMER_RELTIME () {0x0;}
    unless(defined(&TIMER_ABSTIME)) {
	sub TIMER_ABSTIME () {0x1;}
    }
    if(defined(&_KERNEL)) {
    } else {
	
	
    }
}
1;
unless(defined(&_NET_BPF_H_)) {
    sub _NET_BPF_H_ () {1;}
    sub BPF_RELEASE () {199606;}
    sub BPF_ALIGNMENT () {$sizeof{'long'};}
    sub BPF_WORDALIGN {
        local($x) = @_;
	    eval q(((($x)+( &BPF_ALIGNMENT-1))&~( &BPF_ALIGNMENT-1)));
    }
    sub BPF_MAXINSNS () {512;}
    sub BPF_MAXBUFSIZE () {0x80000;}
    sub BPF_MINBUFSIZE () {32;}
    sub BPF_MAJOR_VERSION () {1;}
    sub BPF_MINOR_VERSION () {1;}
    sub BIOCGBLEN () { &_IOR(ord('B'),102, 'u_int');}
    sub BIOCSBLEN () { &_IOWR(ord('B'),102, 'u_int');}
    sub BIOCSETF () { &_IOW(ord('B'),103, 'bpf_program');}
    sub BIOCFLUSH () { &_IO(ord('B'),104);}
    sub BIOCPROMISC () { &_IO(ord('B'),105);}
    sub BIOCGDLT () { &_IOR(ord('B'),106, 'u_int');}
    sub BIOCGETIF () { &_IOR(ord('B'),107, 'ifreq');}
    sub BIOCSETIF () { &_IOW(ord('B'),108, 'ifreq');}
    sub BIOCSRTIMEOUT () { &_IOW(ord('B'),109, 'timeval');}
    sub BIOCGRTIMEOUT () { &_IOR(ord('B'),110, 'timeval');}
    sub BIOCGSTATS () { &_IOR(ord('B'),111, 'bpf_stat');}
    sub BIOCIMMEDIATE () { &_IOW(ord('B'),112, 'u_int');}
    sub BIOCVERSION () { &_IOR(ord('B'),113, 'bpf_version');}
    sub BIOCGRSIG () { &_IOR(ord('B'),114, 'u_int');}
    sub BIOCSRSIG () { &_IOW(ord('B'),115, 'u_int');}
    sub BIOCGHDRCMPLT () { &_IOR(ord('B'),116, 'u_int');}
    sub BIOCSHDRCMPLT () { &_IOW(ord('B'),117, 'u_int');}
    sub BIOCGSEESENT () { &_IOR(ord('B'),118, 'u_int');}
    sub BIOCSSEESENT () { &_IOW(ord('B'),119, 'u_int');}
    if(defined(&_KERNEL)) {
	sub SIZEOF_BPF_HDR () {($sizeof{'bpf_hdr'} <= 20? 18: $sizeof{'bpf_hdr'});}
    }
    sub DLT_NULL () {0;}
    sub DLT_EN10MB () {1;}
    sub DLT_EN3MB () {2;}
    sub DLT_AX25 () {3;}
    sub DLT_PRONET () {4;}
    sub DLT_CHAOS () {5;}
    sub DLT_IEEE802 () {6;}
    sub DLT_ARCNET () {7;}
    sub DLT_SLIP () {8;}
    sub DLT_PPP () {9;}
    sub DLT_FDDI () {10;}
    sub DLT_ATM_RFC1483 () {11;}
    sub DLT_RAW () {12;}
    sub DLT_SLIP_BSDOS () {15;}
    sub DLT_PPP_BSDOS () {16;}
    sub DLT_ATM_CLIP () {19;}
    sub DLT_PPP_SERIAL () {50;}
    sub DLT_C_HDLC () {104;}
    sub DLT_CHDLC () { &DLT_C_HDLC;}
    sub DLT_IEEE802_11 () {105;}
    sub DLT_LOOP () {108;}
    sub DLT_LINUX_SLL () {113;}
    sub BPF_CLASS {
        local($code) = @_;
	    eval {(($code) & 0x07)};
    }
    sub BPF_LD () {0x00;}
    sub BPF_LDX () {0x01;}
    sub BPF_ST () {0x02;}
    sub BPF_STX () {0x03;}
    sub BPF_ALU () {0x04;}
    sub BPF_JMP () {0x05;}
    sub BPF_RET () {0x06;}
    sub BPF_MISC () {0x07;}
    sub BPF_SIZE {
        local($code) = @_;
	    eval {(($code) & 0x18)};
    }
    sub BPF_W () {0x00;}
    sub BPF_H () {0x08;}
    sub BPF_B () {0x10;}
    sub BPF_MODE {
        local($code) = @_;
	    eval {(($code) & 0xe0)};
    }
    sub BPF_IMM () {0x00;}
    sub BPF_ABS () {0x20;}
    sub BPF_IND () {0x40;}
    sub BPF_MEM () {0x60;}
    sub BPF_LEN () {0x80;}
    sub BPF_MSH () {0xa0;}
    sub BPF_OP {
        local($code) = @_;
	    eval {(($code) & 0xf0)};
    }
    sub BPF_ADD () {0x00;}
    sub BPF_SUB () {0x10;}
    sub BPF_MUL () {0x20;}
    sub BPF_DIV () {0x30;}
    sub BPF_OR () {0x40;}
    sub BPF_AND () {0x50;}
    sub BPF_LSH () {0x60;}
    sub BPF_RSH () {0x70;}
    sub BPF_NEG () {0x80;}
    sub BPF_JA () {0x00;}
    sub BPF_JEQ () {0x10;}
    sub BPF_JGT () {0x20;}
    sub BPF_JGE () {0x30;}
    sub BPF_JSET () {0x40;}
    sub BPF_SRC {
        local($code) = @_;
	    eval {(($code) & 0x08)};
    }
    sub BPF_K () {0x00;}
    sub BPF_X () {0x08;}
    sub BPF_RVAL {
        local($code) = @_;
	    eval {(($code) & 0x18)};
    }
    sub BPF_A () {0x10;}
    sub BPF_MISCOP {
        local($code) = @_;
	    eval {(($code) & 0xf8)};
    }
    sub BPF_TAX () {0x00;}
    sub BPF_TXA () {0x80;}
    sub BPF_STMT {
        local($code, $k) = @_;
	    eval {{ ($code), 0, 0, $k }};
    }
    sub BPF_JUMP {
        local($code, $k, $jt, $jf) = @_;
	    eval {{ ($code), $jt, $jf, $k }};
    }
    if(defined(&_KERNEL)) {
    }
    sub BPF_MEMWORDS () {16;}
}
1;
unless(defined(&SYS_syscall)) {
    sub SYS_syscall () {	0;}
}
unless(defined(&SYS_exit)) {
    sub SYS_exit () {	1;}
}
unless(defined(&SYS_fork)) {
    sub SYS_fork () {	2;}
}
unless(defined(&SYS_read)) {
    sub SYS_read () {	3;}
}
unless(defined(&SYS_write)) {
    sub SYS_write () {	4;}
}
unless(defined(&SYS_open)) {
    sub SYS_open () {	5;}
}
unless(defined(&SYS_close)) {
    sub SYS_close () {	6;}
}
unless(defined(&SYS_wait4)) {
    sub SYS_wait4 () {	7;}
}
unless(defined(&SYS_link)) {
    sub SYS_link () {	9;}
}
unless(defined(&SYS_unlink)) {
    sub SYS_unlink () {	10;}
}
unless(defined(&SYS_chdir)) {
    sub SYS_chdir () {	12;}
}
unless(defined(&SYS_fchdir)) {
    sub SYS_fchdir () {	13;}
}
unless(defined(&SYS_mknod)) {
    sub SYS_mknod () {	14;}
}
unless(defined(&SYS_chmod)) {
    sub SYS_chmod () {	15;}
}
unless(defined(&SYS_chown)) {
    sub SYS_chown () {	16;}
}
unless(defined(&SYS_break)) {
    sub SYS_break () {	17;}
}
unless(defined(&SYS_getfsstat)) {
    sub SYS_getfsstat () {	18;}
}
unless(defined(&SYS_getpid)) {
    sub SYS_getpid () {	20;}
}
unless(defined(&SYS_mount)) {
    sub SYS_mount () {	21;}
}
unless(defined(&SYS_unmount)) {
    sub SYS_unmount () {	22;}
}
unless(defined(&SYS_setuid)) {
    sub SYS_setuid () {	23;}
}
unless(defined(&SYS_getuid)) {
    sub SYS_getuid () {	24;}
}
unless(defined(&SYS_geteuid)) {
    sub SYS_geteuid () {	25;}
}
unless(defined(&SYS_ptrace)) {
    sub SYS_ptrace () {	26;}
}
unless(defined(&SYS_recvmsg)) {
    sub SYS_recvmsg () {	27;}
}
unless(defined(&SYS_sendmsg)) {
    sub SYS_sendmsg () {	28;}
}
unless(defined(&SYS_recvfrom)) {
    sub SYS_recvfrom () {	29;}
}
unless(defined(&SYS_accept)) {
    sub SYS_accept () {	30;}
}
unless(defined(&SYS_getpeername)) {
    sub SYS_getpeername () {	31;}
}
unless(defined(&SYS_getsockname)) {
    sub SYS_getsockname () {	32;}
}
unless(defined(&SYS_access)) {
    sub SYS_access () {	33;}
}
unless(defined(&SYS_chflags)) {
    sub SYS_chflags () {	34;}
}
unless(defined(&SYS_fchflags)) {
    sub SYS_fchflags () {	35;}
}
unless(defined(&SYS_sync)) {
    sub SYS_sync () {	36;}
}
unless(defined(&SYS_kill)) {
    sub SYS_kill () {	37;}
}
unless(defined(&SYS_getppid)) {
    sub SYS_getppid () {	39;}
}
unless(defined(&SYS_dup)) {
    sub SYS_dup () {	41;}
}
unless(defined(&SYS_pipe)) {
    sub SYS_pipe () {	42;}
}
unless(defined(&SYS_getegid)) {
    sub SYS_getegid () {	43;}
}
unless(defined(&SYS_profil)) {
    sub SYS_profil () {	44;}
}
unless(defined(&SYS_ktrace)) {
    sub SYS_ktrace () {	45;}
}
unless(defined(&SYS_getgid)) {
    sub SYS_getgid () {	47;}
}
unless(defined(&SYS_getlogin)) {
    sub SYS_getlogin () {	49;}
}
unless(defined(&SYS_setlogin)) {
    sub SYS_setlogin () {	50;}
}
unless(defined(&SYS_acct)) {
    sub SYS_acct () {	51;}
}
unless(defined(&SYS_sigaltstack)) {
    sub SYS_sigaltstack () {	53;}
}
unless(defined(&SYS_ioctl)) {
    sub SYS_ioctl () {	54;}
}
unless(defined(&SYS_reboot)) {
    sub SYS_reboot () {	55;}
}
unless(defined(&SYS_revoke)) {
    sub SYS_revoke () {	56;}
}
unless(defined(&SYS_symlink)) {
    sub SYS_symlink () {	57;}
}
unless(defined(&SYS_readlink)) {
    sub SYS_readlink () {	58;}
}
unless(defined(&SYS_execve)) {
    sub SYS_execve () {	59;}
}
unless(defined(&SYS_umask)) {
    sub SYS_umask () {	60;}
}
unless(defined(&SYS_chroot)) {
    sub SYS_chroot () {	61;}
}
unless(defined(&SYS_msync)) {
    sub SYS_msync () {	65;}
}
unless(defined(&SYS_vfork)) {
    sub SYS_vfork () {	66;}
}
unless(defined(&SYS_sbrk)) {
    sub SYS_sbrk () {	69;}
}
unless(defined(&SYS_sstk)) {
    sub SYS_sstk () {	70;}
}
unless(defined(&SYS_vadvise)) {
    sub SYS_vadvise () {	72;}
}
unless(defined(&SYS_munmap)) {
    sub SYS_munmap () {	73;}
}
unless(defined(&SYS_mprotect)) {
    sub SYS_mprotect () {	74;}
}
unless(defined(&SYS_madvise)) {
    sub SYS_madvise () {	75;}
}
unless(defined(&SYS_mincore)) {
    sub SYS_mincore () {	78;}
}
unless(defined(&SYS_getgroups)) {
    sub SYS_getgroups () {	79;}
}
unless(defined(&SYS_setgroups)) {
    sub SYS_setgroups () {	80;}
}
unless(defined(&SYS_getpgrp)) {
    sub SYS_getpgrp () {	81;}
}
unless(defined(&SYS_setpgid)) {
    sub SYS_setpgid () {	82;}
}
unless(defined(&SYS_setitimer)) {
    sub SYS_setitimer () {	83;}
}
unless(defined(&SYS_swapon)) {
    sub SYS_swapon () {	85;}
}
unless(defined(&SYS_getitimer)) {
    sub SYS_getitimer () {	86;}
}
unless(defined(&SYS_getdtablesize)) {
    sub SYS_getdtablesize () {	89;}
}
unless(defined(&SYS_dup2)) {
    sub SYS_dup2 () {	90;}
}
unless(defined(&SYS_fcntl)) {
    sub SYS_fcntl () {	92;}
}
unless(defined(&SYS_select)) {
    sub SYS_select () {	93;}
}
unless(defined(&SYS_fsync)) {
    sub SYS_fsync () {	95;}
}
unless(defined(&SYS_setpriority)) {
    sub SYS_setpriority () {	96;}
}
unless(defined(&SYS_socket)) {
    sub SYS_socket () {	97;}
}
unless(defined(&SYS_connect)) {
    sub SYS_connect () {	98;}
}
unless(defined(&SYS_getpriority)) {
    sub SYS_getpriority () {	100;}
}
unless(defined(&SYS_bind)) {
    sub SYS_bind () {	104;}
}
unless(defined(&SYS_setsockopt)) {
    sub SYS_setsockopt () {	105;}
}
unless(defined(&SYS_listen)) {
    sub SYS_listen () {	106;}
}
unless(defined(&SYS_gettimeofday)) {
    sub SYS_gettimeofday () {	116;}
}
unless(defined(&SYS_getrusage)) {
    sub SYS_getrusage () {	117;}
}
unless(defined(&SYS_getsockopt)) {
    sub SYS_getsockopt () {	118;}
}
unless(defined(&SYS_readv)) {
    sub SYS_readv () {	120;}
}
unless(defined(&SYS_writev)) {
    sub SYS_writev () {	121;}
}
unless(defined(&SYS_settimeofday)) {
    sub SYS_settimeofday () {	122;}
}
unless(defined(&SYS_fchown)) {
    sub SYS_fchown () {	123;}
}
unless(defined(&SYS_fchmod)) {
    sub SYS_fchmod () {	124;}
}
unless(defined(&SYS_setreuid)) {
    sub SYS_setreuid () {	126;}
}
unless(defined(&SYS_setregid)) {
    sub SYS_setregid () {	127;}
}
unless(defined(&SYS_rename)) {
    sub SYS_rename () {	128;}
}
unless(defined(&SYS_flock)) {
    sub SYS_flock () {	131;}
}
unless(defined(&SYS_mkfifo)) {
    sub SYS_mkfifo () {	132;}
}
unless(defined(&SYS_sendto)) {
    sub SYS_sendto () {	133;}
}
unless(defined(&SYS_shutdown)) {
    sub SYS_shutdown () {	134;}
}
unless(defined(&SYS_socketpair)) {
    sub SYS_socketpair () {	135;}
}
unless(defined(&SYS_mkdir)) {
    sub SYS_mkdir () {	136;}
}
unless(defined(&SYS_rmdir)) {
    sub SYS_rmdir () {	137;}
}
unless(defined(&SYS_utimes)) {
    sub SYS_utimes () {	138;}
}
unless(defined(&SYS_adjtime)) {
    sub SYS_adjtime () {	140;}
}
unless(defined(&SYS_setsid)) {
    sub SYS_setsid () {	147;}
}
unless(defined(&SYS_quotactl)) {
    sub SYS_quotactl () {	148;}
}
unless(defined(&SYS_nfssvc)) {
    sub SYS_nfssvc () {	155;}
}
unless(defined(&SYS_statfs)) {
    sub SYS_statfs () {	157;}
}
unless(defined(&SYS_fstatfs)) {
    sub SYS_fstatfs () {	158;}
}
unless(defined(&SYS_getfh)) {
    sub SYS_getfh () {	161;}
}
unless(defined(&SYS_getdomainname)) {
    sub SYS_getdomainname () {	162;}
}
unless(defined(&SYS_setdomainname)) {
    sub SYS_setdomainname () {	163;}
}
unless(defined(&SYS_uname)) {
    sub SYS_uname () {	164;}
}
unless(defined(&SYS_sysarch)) {
    sub SYS_sysarch () {	165;}
}
unless(defined(&SYS_rtprio)) {
    sub SYS_rtprio () {	166;}
}
unless(defined(&SYS_semsys)) {
    sub SYS_semsys () {	169;}
}
unless(defined(&SYS_msgsys)) {
    sub SYS_msgsys () {	170;}
}
unless(defined(&SYS_shmsys)) {
    sub SYS_shmsys () {	171;}
}
unless(defined(&SYS_pread)) {
    sub SYS_pread () {	173;}
}
unless(defined(&SYS_pwrite)) {
    sub SYS_pwrite () {	174;}
}
unless(defined(&SYS_ntp_adjtime)) {
    sub SYS_ntp_adjtime () {	176;}
}
unless(defined(&SYS_setgid)) {
    sub SYS_setgid () {	181;}
}
unless(defined(&SYS_setegid)) {
    sub SYS_setegid () {	182;}
}
unless(defined(&SYS_seteuid)) {
    sub SYS_seteuid () {	183;}
}
unless(defined(&SYS_stat)) {
    sub SYS_stat () {	188;}
}
unless(defined(&SYS_fstat)) {
    sub SYS_fstat () {	189;}
}
unless(defined(&SYS_lstat)) {
    sub SYS_lstat () {	190;}
}
unless(defined(&SYS_pathconf)) {
    sub SYS_pathconf () {	191;}
}
unless(defined(&SYS_fpathconf)) {
    sub SYS_fpathconf () {	192;}
}
unless(defined(&SYS_getrlimit)) {
    sub SYS_getrlimit () {	194;}
}
unless(defined(&SYS_setrlimit)) {
    sub SYS_setrlimit () {	195;}
}
unless(defined(&SYS_getdirentries)) {
    sub SYS_getdirentries () {	196;}
}
unless(defined(&SYS_mmap)) {
    sub SYS_mmap () {	197;}
}
unless(defined(&SYS___syscall)) {
    sub SYS___syscall () {	198;}
}
unless(defined(&SYS_lseek)) {
    sub SYS_lseek () {	199;}
}
unless(defined(&SYS_truncate)) {
    sub SYS_truncate () {	200;}
}
unless(defined(&SYS_ftruncate)) {
    sub SYS_ftruncate () {	201;}
}
unless(defined(&SYS___sysctl)) {
    sub SYS___sysctl () {	202;}
}
unless(defined(&SYS_mlock)) {
    sub SYS_mlock () {	203;}
}
unless(defined(&SYS_munlock)) {
    sub SYS_munlock () {	204;}
}
unless(defined(&SYS_undelete)) {
    sub SYS_undelete () {	205;}
}
unless(defined(&SYS_futimes)) {
    sub SYS_futimes () {	206;}
}
unless(defined(&SYS_getpgid)) {
    sub SYS_getpgid () {	207;}
}
unless(defined(&SYS_poll)) {
    sub SYS_poll () {	209;}
}
unless(defined(&SYS___semctl)) {
    sub SYS___semctl () {	220;}
}
unless(defined(&SYS_semget)) {
    sub SYS_semget () {	221;}
}
unless(defined(&SYS_semop)) {
    sub SYS_semop () {	222;}
}
unless(defined(&SYS_msgctl)) {
    sub SYS_msgctl () {	224;}
}
unless(defined(&SYS_msgget)) {
    sub SYS_msgget () {	225;}
}
unless(defined(&SYS_msgsnd)) {
    sub SYS_msgsnd () {	226;}
}
unless(defined(&SYS_msgrcv)) {
    sub SYS_msgrcv () {	227;}
}
unless(defined(&SYS_shmat)) {
    sub SYS_shmat () {	228;}
}
unless(defined(&SYS_shmctl)) {
    sub SYS_shmctl () {	229;}
}
unless(defined(&SYS_shmdt)) {
    sub SYS_shmdt () {	230;}
}
unless(defined(&SYS_shmget)) {
    sub SYS_shmget () {	231;}
}
unless(defined(&SYS_clock_gettime)) {
    sub SYS_clock_gettime () {	232;}
}
unless(defined(&SYS_clock_settime)) {
    sub SYS_clock_settime () {	233;}
}
unless(defined(&SYS_clock_getres)) {
    sub SYS_clock_getres () {	234;}
}
unless(defined(&SYS_nanosleep)) {
    sub SYS_nanosleep () {	240;}
}
unless(defined(&SYS_minherit)) {
    sub SYS_minherit () {	250;}
}
unless(defined(&SYS_rfork)) {
    sub SYS_rfork () {	251;}
}
unless(defined(&SYS_openbsd_poll)) {
    sub SYS_openbsd_poll () {	252;}
}
unless(defined(&SYS_issetugid)) {
    sub SYS_issetugid () {	253;}
}
unless(defined(&SYS_lchown)) {
    sub SYS_lchown () {	254;}
}
unless(defined(&SYS_getdents)) {
    sub SYS_getdents () {	272;}
}
unless(defined(&SYS_lchmod)) {
    sub SYS_lchmod () {	274;}
}
unless(defined(&SYS_netbsd_lchown)) {
    sub SYS_netbsd_lchown () {	275;}
}
unless(defined(&SYS_lutimes)) {
    sub SYS_lutimes () {	276;}
}
unless(defined(&SYS_netbsd_msync)) {
    sub SYS_netbsd_msync () {	277;}
}
unless(defined(&SYS_nstat)) {
    sub SYS_nstat () {	278;}
}
unless(defined(&SYS_nfstat)) {
    sub SYS_nfstat () {	279;}
}
unless(defined(&SYS_nlstat)) {
    sub SYS_nlstat () {	280;}
}
unless(defined(&SYS_fhstatfs)) {
    sub SYS_fhstatfs () {	297;}
}
unless(defined(&SYS_fhopen)) {
    sub SYS_fhopen () {	298;}
}
unless(defined(&SYS_fhstat)) {
    sub SYS_fhstat () {	299;}
}
unless(defined(&SYS_modnext)) {
    sub SYS_modnext () {	300;}
}
unless(defined(&SYS_modstat)) {
    sub SYS_modstat () {	301;}
}
unless(defined(&SYS_modfnext)) {
    sub SYS_modfnext () {	302;}
}
unless(defined(&SYS_modfind)) {
    sub SYS_modfind () {	303;}
}
unless(defined(&SYS_kldload)) {
    sub SYS_kldload () {	304;}
}
unless(defined(&SYS_kldunload)) {
    sub SYS_kldunload () {	305;}
}
unless(defined(&SYS_kldfind)) {
    sub SYS_kldfind () {	306;}
}
unless(defined(&SYS_kldnext)) {
    sub SYS_kldnext () {	307;}
}
unless(defined(&SYS_kldstat)) {
    sub SYS_kldstat () {	308;}
}
unless(defined(&SYS_kldfirstmod)) {
    sub SYS_kldfirstmod () {	309;}
}
unless(defined(&SYS_getsid)) {
    sub SYS_getsid () {	310;}
}
unless(defined(&SYS_setresuid)) {
    sub SYS_setresuid () {	311;}
}
unless(defined(&SYS_setresgid)) {
    sub SYS_setresgid () {	312;}
}
unless(defined(&SYS_aio_return)) {
    sub SYS_aio_return () {	314;}
}
unless(defined(&SYS_aio_suspend)) {
    sub SYS_aio_suspend () {	315;}
}
unless(defined(&SYS_aio_cancel)) {
    sub SYS_aio_cancel () {	316;}
}
unless(defined(&SYS_aio_error)) {
    sub SYS_aio_error () {	317;}
}
unless(defined(&SYS_aio_read)) {
    sub SYS_aio_read () {	318;}
}
unless(defined(&SYS_aio_write)) {
    sub SYS_aio_write () {	319;}
}
unless(defined(&SYS_lio_listio)) {
    sub SYS_lio_listio () {	320;}
}
unless(defined(&SYS_yield)) {
    sub SYS_yield () {	321;}
}
unless(defined(&SYS_thr_sleep)) {
    sub SYS_thr_sleep () {	322;}
}
unless(defined(&SYS_thr_wakeup)) {
    sub SYS_thr_wakeup () {	323;}
}
unless(defined(&SYS_mlockall)) {
    sub SYS_mlockall () {	324;}
}
unless(defined(&SYS_munlockall)) {
    sub SYS_munlockall () {	325;}
}
unless(defined(&SYS___getcwd)) {
    sub SYS___getcwd () {	326;}
}
unless(defined(&SYS_sched_setparam)) {
    sub SYS_sched_setparam () {	327;}
}
unless(defined(&SYS_sched_getparam)) {
    sub SYS_sched_getparam () {	328;}
}
unless(defined(&SYS_sched_setscheduler)) {
    sub SYS_sched_setscheduler () {	329;}
}
unless(defined(&SYS_sched_getscheduler)) {
    sub SYS_sched_getscheduler () {	330;}
}
unless(defined(&SYS_sched_yield)) {
    sub SYS_sched_yield () {	331;}
}
unless(defined(&SYS_sched_get_priority_max)) {
    sub SYS_sched_get_priority_max () {	332;}
}
unless(defined(&SYS_sched_get_priority_min)) {
    sub SYS_sched_get_priority_min () {	333;}
}
unless(defined(&SYS_sched_rr_get_interval)) {
    sub SYS_sched_rr_get_interval () {	334;}
}
unless(defined(&SYS_utrace)) {
    sub SYS_utrace () {	335;}
}
unless(defined(&SYS_sendfile)) {
    sub SYS_sendfile () {	336;}
}
unless(defined(&SYS_kldsym)) {
    sub SYS_kldsym () {	337;}
}
unless(defined(&SYS_jail)) {
    sub SYS_jail () {	338;}
}
unless(defined(&SYS_sigprocmask)) {
    sub SYS_sigprocmask () {	340;}
}
unless(defined(&SYS_sigsuspend)) {
    sub SYS_sigsuspend () {	341;}
}
unless(defined(&SYS_sigaction)) {
    sub SYS_sigaction () {	342;}
}
unless(defined(&SYS_sigpending)) {
    sub SYS_sigpending () {	343;}
}
unless(defined(&SYS_sigreturn)) {
    sub SYS_sigreturn () {	344;}
}
unless(defined(&SYS___acl_get_file)) {
    sub SYS___acl_get_file () {	347;}
}
unless(defined(&SYS___acl_set_file)) {
    sub SYS___acl_set_file () {	348;}
}
unless(defined(&SYS___acl_get_fd)) {
    sub SYS___acl_get_fd () {	349;}
}
unless(defined(&SYS___acl_set_fd)) {
    sub SYS___acl_set_fd () {	350;}
}
unless(defined(&SYS___acl_delete_file)) {
    sub SYS___acl_delete_file () {	351;}
}
unless(defined(&SYS___acl_delete_fd)) {
    sub SYS___acl_delete_fd () {	352;}
}
unless(defined(&SYS___acl_aclcheck_file)) {
    sub SYS___acl_aclcheck_file () {	353;}
}
unless(defined(&SYS___acl_aclcheck_fd)) {
    sub SYS___acl_aclcheck_fd () {	354;}
}
unless(defined(&SYS_extattrctl)) {
    sub SYS_extattrctl () {	355;}
}
unless(defined(&SYS_extattr_set_file)) {
    sub SYS_extattr_set_file () {	356;}
}
unless(defined(&SYS_extattr_get_file)) {
    sub SYS_extattr_get_file () {	357;}
}
unless(defined(&SYS_extattr_delete_file)) {
    sub SYS_extattr_delete_file () {	358;}
}
unless(defined(&SYS_aio_waitcomplete)) {
    sub SYS_aio_waitcomplete () {	359;}
}
unless(defined(&SYS_getresuid)) {
    sub SYS_getresuid () {	360;}
}
unless(defined(&SYS_getresgid)) {
    sub SYS_getresgid () {	361;}
}
unless(defined(&SYS_kqueue)) {
    sub SYS_kqueue () {	362;}
}
unless(defined(&SYS_kevent)) {
    sub SYS_kevent () {	363;}
}
unless(defined(&SYS_MAXSYSCALL)) {
    sub SYS_MAXSYSCALL () {	364;}
}
1;
unless(defined(&_SYS_TYPES_H_)) {
    sub _SYS_TYPES_H_ () {1;}
    
    
    
    unless(defined(&_POSIX_SOURCE)) {
    }
    if(defined(&__alpha__)) {
    } else {
    }
    if(defined(&_KERNEL)) {
	sub offsetof {
	    local($type, $field) = @_;
    	    eval { &__offsetof($type, $field)};
	}
    } else {
	sub udev_t () { &dev_t;}
	unless(defined(&_POSIX_SOURCE)) {
	    sub major {
	        local($x) = @_;
    		eval {(((($x) >> 8)&0xff))};
	    }
	    sub minor {
	        local($x) = @_;
    		eval {((($x)&0xffff00ff))};
	    }
	    sub makedev {
	        local($x,$y) = @_;
    		eval {(((($x) << 8) | ($y)))};
	    }
	}
    }
    
    if(defined(&_BSD_CLOCK_T_)) {
	undef(&_BSD_CLOCK_T_) if defined(&_BSD_CLOCK_T_);
    }
    if(defined(&_BSD_CLOCKID_T_)) {
	undef(&_BSD_CLOCKID_T_) if defined(&_BSD_CLOCKID_T_);
    }
    if(defined(&_BSD_SIZE_T_)) {
	undef(&_BSD_SIZE_T_) if defined(&_BSD_SIZE_T_);
    }
    if(defined(&_BSD_SSIZE_T_)) {
	undef(&_BSD_SSIZE_T_) if defined(&_BSD_SSIZE_T_);
    }
    if(defined(&_BSD_TIME_T_)) {
	undef(&_BSD_TIME_T_) if defined(&_BSD_TIME_T_);
    }
    if(defined(&_BSD_TIMER_T_)) {
	undef(&_BSD_TIMER_T_) if defined(&_BSD_TIMER_T_);
    }
    unless(defined(&_POSIX_SOURCE)) {
	sub NBBY () {8;}
	unless(defined(&FD_SETSIZE)) {
	    sub FD_SETSIZE () {1024;}
	}
	sub NFDBITS () {($sizeof{"fd_mask"} *  &NBBY);}
	unless(defined(&howmany)) {
	    sub howmany {
	        local($x, $y) = @_;
    		eval q(((($x) + (($y) - 1)) / ($y)));
	    }
	}
	sub _fdset_mask {
	    local($n) = @_;
    	    eval {(1<< (($n) %  &NFDBITS))};
	}
	sub FD_SET {
	    local($n, $p) = @_;
    	    eval q((($p)-> $fds_bits[($n)/ &NFDBITS] |=  &_fdset_mask($n)));
	}
	sub FD_CLR {
	    local($n, $p) = @_;
    	    eval q((($p)-> $fds_bits[($n)/ &NFDBITS] &= ~ &_fdset_mask($n)));
	}
	sub FD_ISSET {
	    local($n, $p) = @_;
    	    eval q((($p)-> $fds_bits[($n)/ &NFDBITS] &  &_fdset_mask($n)));
	}
	sub FD_COPY {
	    local($f, $t) = @_;
    	    eval { &bcopy($f, $t, $sizeof{($f)})};
	}
	sub FD_ZERO {
	    local($p) = @_;
    	    eval { &bzero($p, $sizeof{($p)})};
	}
	unless(defined(&_KERNEL)) {
	    unless(defined(&_FTRUNCATE_DECLARED)) {
		sub _FTRUNCATE_DECLARED () {1;}
	    }
	    unless(defined(&_LSEEK_DECLARED)) {
		sub _LSEEK_DECLARED () {1;}
	    }
	    unless(defined(&_MMAP_DECLARED)) {
		sub _MMAP_DECLARED () {1;}
	    }
	    unless(defined(&_TRUNCATE_DECLARED)) {
		sub _TRUNCATE_DECLARED () {1;}
	    }
	}
    }
}
1;

1;
__END__

=head1 NAME
 
Packet::Definitions - internal module to be used by Packet

=head1 SYNOPSIS

  # you really shouldn't be using this.  really.
  use Packet::Definitions;

  my ($int_size, $ifreq_struct_size) = $Packet::Definitions::sizeof("int", "ifreq");
  my $sockaddr_struct_size           = $Packet::Definitions::sizeof("sockaddr");
  my $AF_INET                        = &Packet::Definitions::AF_INET;

=head1 DESCRIPTION
 
L<Packet::Definitions> is an internal module used by Packet to provide the
size of types, typedefs, and structs and also provide definitions
from standard C headers.

=head1 AUTHORS 
  
Samy Kamkar     <cp5@LucidX.com>
    
Todd Caine      <tcaine@eli.net>
    
=head1 SEE ALSO
    
Packet.pm

=cut

