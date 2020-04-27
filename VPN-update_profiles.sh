# Author: Filippo Falezza
# ¢ 2020 GPLv3
# 
# This script is to be executed from the folder where all the profiles to import are.
#
# DEFINE your username and password here:
USERNAME=username_here
PASSWORD=password_here
#
#
for file in $PWD/*.ovpn
do
	name="$(basename $file .ovpn)"
#	echo $file $name
	nmcli c del $name
	nmcli c import type openvpn file $file
	printf "set vpn.user-name $USERNAME\n set vpn.secrets password=$PASSWORD\n save\n quit\n"| nmcli c edit $name
done
