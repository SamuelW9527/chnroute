#!/bin/sh
mkdir -p ./pbr
cd ./pbr

#电信
wget --no-check-certificate -c -O ct.txt https://ispip.clang.cn/chinatelecom_cidr.txt
#联通
wget --no-check-certificate -c -O cu.txt https://ispip.clang.cn/unicom_cnc_cidr.txt
#移动
wget --no-check-certificate -c -O cm.txt https://ispip.clang.cn/cmcc_cidr.txt
#铁通
wget --no-check-certificate -c -O crtc.txt https://ispip.clang.cn/crtc_cidr.txt
#教育网
wget --no-check-certificate -c -O cernet.txt https://ispip.clang.cn/cernet_cidr.txt
#长城宽带/鹏博士
wget --no-check-certificate -c -O gwbn.txt https://ispip.clang.cn/gwbn_cidr.txt
#其他
wget --no-check-certificate -c -O other.txt https://ispip.clang.cn/othernet_cidr.txt

#电信ipv6
wget --no-check-certificate -c -O ctv6.txt https://ispip.clang.cn/chinatelecom_ipv6.txt
#联通ipv6
wget --no-check-certificate -c -O cuv6.txt https://ispip.clang.cn/unicom_cnc_ipv6.txt
#移动ipv6
wget --no-check-certificate -c -O cmv6.txt https://ispip.clang.cn/cmcc_ipv6.txt
#铁通ipv6
wget --no-check-certificate -c -O crtcv6.txt https://ispip.clang.cn/crtc_ipv6.txt
#教育网ipv6
wget --no-check-certificate -c -O cernetv6.txt https://ispip.clang.cn/cernet_ipv6.txt
#长城宽带/鹏博士ipv6
wget --no-check-certificate -c -O gwbnv6.txt https://ispip.clang.cn/gwbn_ipv6.txt
#其他ipv6
wget --no-check-certificate -c -O otherv6.txt https://ispip.clang.cn/othernet_ipv6.txt


######电信移动pbr
{
echo "/ip route rule"

for net in $(cat ct.txt) ; do
  echo "add dst-address=$net action=lookup table=CT"
done

for net in $(cat cu.txt) ; do
  echo "add dst-address=$net action=lookup table=CT"
done

for net in $(cat cm.txt) ; do
  echo "add dst-address=$net action=lookup table=CMCC"
done

for net in $(cat crtc.txt) ; do
  echo "add dst-address=$net action=lookup table=CMCC"
done

for net in $(cat cernet.txt) ; do
  echo "add dst-address=$net action=lookup table=CT"
done

for net in $(cat gwbn.txt) ; do
  echo "add dst-address=$net action=lookup table=CT"
done

for net in $(cat other.txt) ; do
  echo "add dst-address=$net action=lookup table=CT"
done
} > ../ros-pbr-CT-CMCC.rsc

######电信移动dpbr
{
echo "/ip firewall address-list"

for net in $(cat ct.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat cu.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat cm.txt) ; do
  echo "add list=dpbr-CMCC address=$net"
done

for net in $(cat crtc.txt) ; do
  echo "add list=dpbr-CMCC address=$net"
done

for net in $(cat cernet.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat gwbn.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat other.txt) ; do
  echo "add list=dpbr-CT address=$net"
done
} > ../ros-dpbr-CT-CMCC.rsc

######电信移动dpbr-ipv6
{
echo "/ipv6 firewall address-list"

for net in $(cat ctv6.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat cuv6.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat cmv6.txt) ; do
  echo "add list=dpbr-CMCC address=$net"
done

for net in $(cat crtcv6.txt) ; do
  echo "add list=dpbr-CMCC address=$net"
done

for net in $(cat cernetv6.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat gwbnv6.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat otherv6.txt) ; do
  echo "add list=dpbr-CT address=$net"
done
} > ../ros-dpbr-CT-CMCC-v6.rsc


######电信联通
{
echo "/ip firewall address-list"

for net in $(cat ct.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat cu.txt) ; do
  echo "add list=dpbr-CU address=$net"
done

for net in $(cat cm.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat crtc.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat cernet.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat gwbn.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat other.txt) ; do
  echo "add list=dpbr-CT address=$net"
done
} > ../ros-dpbr-CT-CU.rsc


######电信联通v6
{
echo "/ipv6 firewall address-list"

for net in $(cat ctv6.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat cuv6.txt) ; do
  echo "add list=dpbr-CU address=$net"
done

for net in $(cat cmv6.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat crtcv6.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat cernetv6.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat gwbnv6.txt) ; do
  echo "add list=dpbr-CT address=$net"
done

for net in $(cat otherv6.txt) ; do
  echo "add list=dpbr-CT address=$net"
done
} > ../ros-dpbr-CT-CU-v6.rsc


cd ..
rm -rf ./pbr
