# Name of the traffic control command.
TC=/sbin/tc

# The network interface we're planning on limiting bandwidth.
IF=wlan0             # Interface

# Download limit (in mega bits)
DNLD=1mbit          # DOWNLOAD Limit

# Upload limit (in mega bits)
UPLD=1mbit          # UPLOAD Limit

# IP address of the machine we are controlling
IP=192.168.0.188     # Host IP

# Filter options for limiting the intended interface.
U32="$TC filter add dev $IF protocol ip parent 1:0 prio 1 u32"

$TC qdisc add dev $IF root handle 1: htb default 30
$TC class add dev $IF parent 1: classid 1:1 htb rate $DNLD
$TC class add dev $IF parent 1: classid 1:2 htb rate $UPLD
$U32 match ip dst $IP/32 flowid 1:1
$U32 match ip src $IP/32 flowid 1:2
