#!/usr/bin/python -Wall
#coding:utf-8

import btdb

platform_name = "versatile"

def gen_cfg_platform(db):
    btdb.set_uint32     (db,"platform.cfg.size", 1)
    btdb.set_boolean    (db,"platform.cfg[0].is_host", 1)
    btdb.set_boolean    (db,"platform.cfg[0].is_init_console", 1)
    btdb.set_string     (db,"platform.cfg[0].tty_name", "/dev/ttyAMA0")
    btdb.set_boolean    (db,"platform.cfg[0].is_init_zram_swap", 1)
    btdb.set_string     (db,"platform.cfg[0].zram_disksize", "128M")
    btdb.set_string     (db,"platform.cfg[0].platform_name", platform_name)

    btdb.set_uint32     (db,"platform.cfg[0].raid.size", 1)
    btdb.set_string     (db,"platform.cfg[0].raid[0].name", "raid_hdd0")
    btdb.set_string     (db,"platform.cfg[0].raid[0].type", "btrfs_raid1")
    btdb.set_boolean    (db,"platform.cfg[0].raid[0].enabled", 1)
    btdb.set_uint32     (db,"platform.cfg[0].raid[0].device.size", 4)
    btdb.set_boolean    (db,"platform.cfg[0].raid[0].device[0].enabled", 1)
    btdb.set_string     (db,"platform.cfg[0].raid[0].device[0].path", "/dev/sdb")
    btdb.set_boolean    (db,"platform.cfg[0].raid[0].device[1].enabled", 1)
    btdb.set_string     (db,"platform.cfg[0].raid[0].device[1].path", "/dev/sdc")
    btdb.set_boolean    (db,"platform.cfg[0].raid[0].device[2].enabled", 0)
    btdb.set_string     (db,"platform.cfg[0].raid[0].device[2].path", "")
    btdb.set_boolean    (db,"platform.cfg[0].raid[0].device[3].enabled", 0)
    btdb.set_string     (db,"platform.cfg[0].raid[0].device[3].path", "")

    btdb.set_uint32     (db,"platform.cfg[0].partition.size", 1)
    btdb.set_string     (db,"platform.cfg[0].partition[0].name", "system")
    btdb.set_string     (db,"platform.cfg[0].partition[0].src", "/dev/sda1")
    btdb.set_string     (db,"platform.cfg[0].partition[0].dst", "/hdd/part1")
    btdb.set_string     (db,"platform.cfg[0].partition[0].type", "vfat")
    btdb.set_boolean    (db,"platform.cfg[0].partition[0].fixed", 1)
    btdb.set_boolean    (db,"platform.cfg[0].partition[0].enabled", 1)

    btdb.set_uint32     (db,"platform.cfg[0].partition.size", 2)
    btdb.set_string     (db,"platform.cfg[0].partition[1].name", "data")
    btdb.set_string     (db,"platform.cfg[0].partition[1].src", "/dev/sda2")
    btdb.set_string     (db,"platform.cfg[0].partition[1].dst", "/hdd/part2")
    btdb.set_string     (db,"platform.cfg[0].partition[1].type", "btrfs")
    btdb.set_boolean    (db,"platform.cfg[0].partition[1].fixed", 1)
    btdb.set_boolean    (db,"platform.cfg[0].partition[1].enabled", 1)

    btdb.set_uint32     (db,"platform.cfg[0].partition.size", 3)
    btdb.set_string     (db,"platform.cfg[0].partition[2].name", "persist")
    btdb.set_string     (db,"platform.cfg[0].partition[2].src", "/hdd/part2/persist")
    btdb.set_string     (db,"platform.cfg[0].partition[2].dst", "/persist")
    btdb.set_string     (db,"platform.cfg[0].partition[2].type", "binddir")
    btdb.set_boolean    (db,"platform.cfg[0].partition[2].fixed", 1)
    btdb.set_boolean    (db,"platform.cfg[0].partition[2].enabled", 1)

    btdb.set_uint32     (db,"platform.cfg[0].partition.size", 4)
    btdb.set_string     (db,"platform.cfg[0].partition[3].name", "vms")
    btdb.set_string     (db,"platform.cfg[0].partition[3].src", "/hdd/part2/VMs")
    btdb.set_string     (db,"platform.cfg[0].partition[3].dst", "/vmlist")
    btdb.set_string     (db,"platform.cfg[0].partition[3].type", "binddir")
    btdb.set_boolean    (db,"platform.cfg[0].partition[3].fixed", 0)
    btdb.set_boolean    (db,"platform.cfg[0].partition[3].enabled", 0)

    btdb.set_uint32     (db,"platform.cfg[0].partition.size", 5)
    btdb.set_string     (db,"platform.cfg[0].partition[4].name", "vmbase")
    btdb.set_string     (db,"platform.cfg[0].partition[4].src", "/hdd/part2/VMbase")
    btdb.set_string     (db,"platform.cfg[0].partition[4].dst", "/vmbase")
    btdb.set_string     (db,"platform.cfg[0].partition[4].type", "binddir")
    btdb.set_boolean    (db,"platform.cfg[0].partition[4].fixed", 0)
    btdb.set_boolean    (db,"platform.cfg[0].partition[4].enabled", 0)

    btdb.set_uint32     (db,"platform.cfg[0].partition.size", 6)
    btdb.set_string     (db,"platform.cfg[0].partition[5].name", "")
    btdb.set_string     (db,"platform.cfg[0].partition[5].src", "")
    btdb.set_string     (db,"platform.cfg[0].partition[5].dst", "")
    btdb.set_string     (db,"platform.cfg[0].partition[5].type", "")
    btdb.set_boolean    (db,"platform.cfg[0].partition[5].fixed", 0)
    btdb.set_boolean    (db,"platform.cfg[0].partition[5].enabled", 0)

    btdb.set_uint32     (db,"platform.cfg[0].partition.size", 7)
    btdb.set_string     (db,"platform.cfg[0].partition[6].name", "")
    btdb.set_string     (db,"platform.cfg[0].partition[6].src", "")
    btdb.set_string     (db,"platform.cfg[0].partition[6].dst", "")
    btdb.set_string     (db,"platform.cfg[0].partition[6].type", "")
    btdb.set_boolean    (db,"platform.cfg[0].partition[6].fixed", 0)
    btdb.set_boolean    (db,"platform.cfg[0].partition[6].enabled", 0)

    btdb.set_uint32     (db,"platform.cfg[0].partition.size", 8)
    btdb.set_string     (db,"platform.cfg[0].partition[7].name", "")
    btdb.set_string     (db,"platform.cfg[0].partition[7].src", "")
    btdb.set_string     (db,"platform.cfg[0].partition[7].dst", "")
    btdb.set_string     (db,"platform.cfg[0].partition[7].type", "")
    btdb.set_boolean    (db,"platform.cfg[0].partition[7].fixed", 0)
    btdb.set_boolean    (db,"platform.cfg[0].partition[7].enabled", 0)

    btdb.set_uint32     (db,"platform.cfg[0].partition.size", 9)
    btdb.set_string     (db,"platform.cfg[0].partition[8].name", "")
    btdb.set_string     (db,"platform.cfg[0].partition[8].src", "")
    btdb.set_string     (db,"platform.cfg[0].partition[8].dst", "")
    btdb.set_string     (db,"platform.cfg[0].partition[8].type", "")
    btdb.set_boolean    (db,"platform.cfg[0].partition[8].fixed", 0)
    btdb.set_boolean    (db,"platform.cfg[0].partition[8].enabled", 0)

    btdb.set_uint32     (db,"platform.cfg[0].partition.size", 10)
    btdb.set_string     (db,"platform.cfg[0].partition[9].name", "")
    btdb.set_string     (db,"platform.cfg[0].partition[9].src", "")
    btdb.set_string     (db,"platform.cfg[0].partition[9].dst", "")
    btdb.set_string     (db,"platform.cfg[0].partition[9].type", "")
    btdb.set_boolean    (db,"platform.cfg[0].partition[9].fixed", 0)
    btdb.set_boolean    (db,"platform.cfg[0].partition[9].enabled", 0)

def gen_cfg_vm_base_image(db):
    btdb.set_uint32     (db,"vmbsimg.cfg.size", 0)
    btdb.set_boolean    (db,"vmbsimg.cfg[0].autostart", 0)
    btdb.set_string     (db,"vmbsimg.cfg[0].name", "")
    btdb.set_string     (db,"vmbsimg.cfg[0].img_path", "")
    btdb.set_string     (db,"vmbsimg.cfg[0].img_dst", "")

def gen_cfg_vm(db):
    btdb.set_uint32     (db,"vm.cfg.size", 1)
    btdb.set_boolean    (db,"vm.cfg[0].autostart", 0)
    btdb.set_string     (db,"vm.cfg[0].base_path", "")
    btdb.set_string     (db,"vm.cfg[0].name", "vm000")
    btdb.set_string     (db,"vm.cfg[0].nethwaddr", btdb.generate_mac(platform_name, 0))
    btdb.set_string     (db,"vm.cfg[0].nethwlink", "br0")
    btdb.set_string     (db,"vm.cfg[0].nettype", "veth")

    btdb.set_uint32     (db,"vm.cfg.size", 2)
    btdb.set_boolean    (db,"vm.cfg[1].autostart", 0)
    btdb.set_string     (db,"vm.cfg[1].base_path", "")
    btdb.set_string     (db,"vm.cfg[1].name", "vm001")
    btdb.set_string     (db,"vm.cfg[1].nethwaddr", btdb.generate_mac(platform_name, 1))
    btdb.set_string     (db,"vm.cfg[1].nethwlink", "br0")
    btdb.set_string     (db,"vm.cfg[1].nettype", "veth")

    btdb.set_uint32     (db,"vm.cfg.size", 3)
    btdb.set_boolean    (db,"vm.cfg[2].autostart", 0)
    btdb.set_string     (db,"vm.cfg[2].base_path", "")
    btdb.set_string     (db,"vm.cfg[2].name", "vm002")
    btdb.set_string     (db,"vm.cfg[2].nethwaddr", btdb.generate_mac(platform_name, 2))
    btdb.set_string     (db,"vm.cfg[2].nethwlink", "br0")
    btdb.set_string     (db,"vm.cfg[2].nettype", "veth")
    
    btdb.set_uint32     (db,"vm.cfg.size", 4)
    btdb.set_boolean    (db,"vm.cfg[3].autostart", 0)
    btdb.set_string     (db,"vm.cfg[3].base_path", "")
    btdb.set_string     (db,"vm.cfg[3].name", "vm003")
    btdb.set_string     (db,"vm.cfg[3].nethwaddr", btdb.generate_mac(platform_name, 3))
    btdb.set_string     (db,"vm.cfg[3].nethwlink", "br0")
    btdb.set_string     (db,"vm.cfg[3].nettype", "veth")

    btdb.set_uint32     (db,"vm.cfg.size", 5)
    btdb.set_boolean    (db,"vm.cfg[4].autostart", 0)
    btdb.set_string     (db,"vm.cfg[4].base_path", "")
    btdb.set_string     (db,"vm.cfg[4].name", "vm004")
    btdb.set_string     (db,"vm.cfg[4].nethwaddr", btdb.generate_mac(platform_name, 4))
    btdb.set_string     (db,"vm.cfg[4].nethwlink", "br0")
    btdb.set_string     (db,"vm.cfg[4].nettype", "veth")

    btdb.set_uint32     (db,"vm.cfg.size", 6)
    btdb.set_boolean    (db,"vm.cfg[5].autostart", 0)
    btdb.set_string     (db,"vm.cfg[5].base_path", "")
    btdb.set_string     (db,"vm.cfg[5].name", "vm005")
    btdb.set_string     (db,"vm.cfg[5].nethwaddr", btdb.generate_mac(platform_name, 5))
    btdb.set_string     (db,"vm.cfg[5].nethwlink", "br0")
    btdb.set_string     (db,"vm.cfg[5].nettype", "veth")

    btdb.set_uint32     (db,"vm.cfg.size", 7)
    btdb.set_boolean    (db,"vm.cfg[6].autostart", 0)
    btdb.set_string     (db,"vm.cfg[6].base_path", "")
    btdb.set_string     (db,"vm.cfg[6].name", "vm006")
    btdb.set_string     (db,"vm.cfg[6].nethwaddr", btdb.generate_mac(platform_name, 6))
    btdb.set_string     (db,"vm.cfg[6].nethwlink", "br0")
    btdb.set_string     (db,"vm.cfg[6].nettype", "veth")

    btdb.set_uint32     (db,"vm.cfg.size", 8)
    btdb.set_boolean    (db,"vm.cfg[7].autostart", 0)
    btdb.set_string     (db,"vm.cfg[7].base_path", "")
    btdb.set_string     (db,"vm.cfg[7].name", "vm007")
    btdb.set_string     (db,"vm.cfg[7].nethwaddr", btdb.generate_mac(platform_name, 7))
    btdb.set_string     (db,"vm.cfg[7].nethwlink", "br0")
    btdb.set_string     (db,"vm.cfg[7].nettype", "veth")

    btdb.set_uint32     (db,"vm.cfg.size", 9)
    btdb.set_boolean    (db,"vm.cfg[8].autostart", 0)
    btdb.set_string     (db,"vm.cfg[8].base_path", "")
    btdb.set_string     (db,"vm.cfg[8].name", "vm008")
    btdb.set_string     (db,"vm.cfg[8].nethwaddr", btdb.generate_mac(platform_name, 8))
    btdb.set_string     (db,"vm.cfg[8].nethwlink", "br0")
    btdb.set_string     (db,"vm.cfg[8].nettype", "veth")

    btdb.set_uint32     (db,"vm.cfg.size", 10)
    btdb.set_boolean    (db,"vm.cfg[9].autostart", 0)
    btdb.set_string     (db,"vm.cfg[9].base_path", "")
    btdb.set_string     (db,"vm.cfg[9].name", "vm009")
    btdb.set_string     (db,"vm.cfg[9].nethwaddr", btdb.generate_mac(platform_name, 9))
    btdb.set_string     (db,"vm.cfg[9].nethwlink", "br0")
    btdb.set_string     (db,"vm.cfg[9].nettype", "veth")

def gen_cfg_network(db):
    btdb.set_uint32     (db,"network.cfg.size", 1)
    btdb.set_string     (db,"network.cfg[0].type", "generic")
    btdb.set_string     (db,"network.cfg[0].interface_name", "lo")
    btdb.set_boolean    (db,"network.cfg[0].is_up", 1)
    btdb.set_boolean    (db,"network.cfg[0].is_dhcp", 0)
    btdb.set_boolean    (db,"network.cfg[0].is_setup_ipaddress", 0)
    btdb.set_boolean    (db,"network.cfg[0].is_setup_hwaddress", 0)
    btdb.set_string     (db,"network.cfg[0].hwaddress", "")
    btdb.set_uint32     (db,"network.cfg[0].interfaces.size", 0)

    btdb.set_uint32     (db,"network.cfg.size", 2)
    btdb.set_string     (db,"network.cfg[1].type", "generic")
    btdb.set_string     (db,"network.cfg[1].interface_name", "eth0")
    btdb.set_boolean    (db,"network.cfg[1].is_up", 1)
    btdb.set_boolean    (db,"network.cfg[1].is_dhcp", 0)
    btdb.set_boolean    (db,"network.cfg[1].is_setup_ipaddress", 0)
    btdb.set_boolean    (db,"network.cfg[1].is_setup_hwaddress", 0)
    btdb.set_string     (db,"network.cfg[1].hwaddress", "")
    btdb.set_uint32     (db,"network.cfg[1].interfaces.size", 0)

    btdb.set_uint32     (db,"network.cfg.size", 3)
    btdb.set_string     (db,"network.cfg[2].type", "bridge")
    btdb.set_string     (db,"network.cfg[2].interface_name", "br0")
    btdb.set_boolean    (db,"network.cfg[2].is_up", 1)
    btdb.set_boolean    (db,"network.cfg[2].is_dhcp", 1)
    btdb.set_boolean    (db,"network.cfg[2].is_setup_ipaddress", 0)
    btdb.set_boolean    (db,"network.cfg[2].is_setup_hwaddress", 1)
    btdb.set_string     (db,"network.cfg[2].hwaddress", btdb.generate_mac(platform_name, 250))
    btdb.set_uint32     (db,"network.cfg[2].interfaces.size", 1)
    btdb.set_string     (db,"network.cfg[2].interfaces[0].name", "eth0")

    btdb.set_uint32     (db,"network.cfg.size", 4)
    btdb.set_string     (db,"network.cfg[3].type", "vlan")
    btdb.set_string     (db,"network.cfg[3].interface_name", "eth0.100")
    btdb.set_boolean    (db,"network.cfg[3].is_up", 1)
    btdb.set_boolean    (db,"network.cfg[3].is_dhcp", 0)
    btdb.set_boolean    (db,"network.cfg[3].is_setup_ipaddress", 0)
    btdb.set_boolean    (db,"network.cfg[3].is_setup_hwaddress", 0)
    btdb.set_string     (db,"network.cfg[3].hwaddress", "")
    btdb.set_uint32     (db,"network.cfg[3].interfaces.size", 0)

    btdb.set_uint32     (db,"network.cfg.size", 5)
    btdb.set_string     (db,"network.cfg[4].type", "bridge")
    btdb.set_string     (db,"network.cfg[4].interface_name", "br1")
    btdb.set_boolean    (db,"network.cfg[4].is_up", 1)
    btdb.set_boolean    (db,"network.cfg[4].is_dhcp", 0)
    btdb.set_boolean    (db,"network.cfg[4].is_setup_ipaddress", 1)
    btdb.set_boolean    (db,"network.cfg[4].is_setup_hwaddress", 1)
    btdb.set_string     (db,"network.cfg[4].hwaddress", btdb.generate_mac(platform_name, 251))
    btdb.set_uint32     (db,"network.cfg[4].interfaces.size", 1)
    btdb.set_string     (db,"network.cfg[4].interfaces[0].name", "eth0.100")
    btdb.set_string     (db,"network.cfg[4].interface_address", "192.168.200.254")
    btdb.set_string     (db,"network.cfg[4].interface_netmask", "255.255.255.0")

def gen_cfg_plugincmd(db):
    btdb.set_uint32     (db,"plugincmd.cfg.size", 1024)
    btdb.set_boolean    (db,"plugincmd.cfg[1].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[1].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[1].name", "raiddev")

    btdb.set_boolean    (db,"plugincmd.cfg[2].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[2].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[2].name", "mntbase")

    btdb.set_boolean    (db,"plugincmd.cfg[3].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[3].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[3].name", "netdev")

    btdb.set_boolean    (db,"plugincmd.cfg[4].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[4].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[4].name", "netssh")

    btdb.set_boolean    (db,"plugincmd.cfg[5].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[5].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[5].name", "netntp")

    btdb.set_boolean    (db,"plugincmd.cfg[6].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[6].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[6].name", "nethttp")

    btdb.set_boolean    (db,"plugincmd.cfg[7].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[7].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[7].name", "vmcontainer")

    btdb.set_boolean    (db,"plugincmd.cfg[8].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[8].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[8].name", "mntbasecount")

    btdb.set_boolean    (db,"plugincmd.cfg[9].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[9].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[9].name", "mntbaseget")

    btdb.set_boolean    (db,"plugincmd.cfg[10].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[10].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[10].name", "mntbaseset")

    btdb.set_boolean    (db,"plugincmd.cfg[11].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[11].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[11].name", "vmcount")

    btdb.set_boolean    (db,"plugincmd.cfg[12].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[12].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[12].name", "vmget")

    btdb.set_boolean    (db,"plugincmd.cfg[13].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[13].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[13].name", "vmset")

    btdb.set_boolean    (db,"plugincmd.cfg[14].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[14].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[14].name", "vmadd")

    btdb.set_boolean    (db,"plugincmd.cfg[15].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[15].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[15].name", "raiddevcount")

    btdb.set_boolean    (db,"plugincmd.cfg[16].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[16].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[16].name", "raiddevget")

    btdb.set_boolean    (db,"plugincmd.cfg[17].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[17].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[17].name", "raiddevset")

    btdb.set_boolean    (db,"plugincmd.cfg[18].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[18].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[18].name", "mkbtrfs")

    btdb.set_boolean    (db,"plugincmd.cfg[19].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[19].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[19].name", "mkbtrfs_status")

    btdb.set_boolean    (db,"plugincmd.cfg[20].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[20].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[20].name", "db_setbool_f")

    btdb.set_boolean    (db,"plugincmd.cfg[21].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[21].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[21].name", "db_getbool_f")

    btdb.set_boolean    (db,"plugincmd.cfg[22].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[22].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[22].name", "db_setuint32_f")

    btdb.set_boolean    (db,"plugincmd.cfg[23].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[23].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[23].name", "db_getuint32_f")

    btdb.set_boolean    (db,"plugincmd.cfg[24].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[24].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[24].name", "db_setstring_f")

    btdb.set_boolean    (db,"plugincmd.cfg[25].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[25].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[25].name", "db_getstring_f")

    btdb.set_boolean    (db,"plugincmd.cfg[26].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[26].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[26].name", "db_setbool_r")

    btdb.set_boolean    (db,"plugincmd.cfg[27].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[27].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[27].name", "db_getbool_r")

    btdb.set_boolean    (db,"plugincmd.cfg[28].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[28].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[28].name", "db_setuint32_r")

    btdb.set_boolean    (db,"plugincmd.cfg[29].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[29].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[29].name", "db_getuint32_r")

    btdb.set_boolean    (db,"plugincmd.cfg[30].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[30].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[30].name", "db_setstring_r")

    btdb.set_boolean    (db,"plugincmd.cfg[31].enabled", 1)
    btdb.set_boolean    (db,"plugincmd.cfg[31].fixed", 0)
    btdb.set_string     (db,"plugincmd.cfg[31].name", "db_getstring_r")

'''
def gen_cfg_test(db):
    btdb.set_uint32     (db,"test.cfg.size", 1)
    btdb.set_string     (db,"test.cfg[0].string", "王建民不是這樣用的")
'''
if __name__ == "__main__":
    db_name = platform_name + '.db'
    db = btdb.open(db_name)

    gen_cfg_platform(db)
    '''gen_cfg_mountfs(db)'''
    gen_cfg_network(db)
    gen_cfg_vm_base_image(db)
    gen_cfg_vm(db)
    gen_cfg_plugincmd(db)
    '''gen_cfg_test(db)'''

    btdb.close(db)

