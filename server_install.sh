#! /bin/sh
#########   Hello    ########
# This is a script to install the tools necessary to rapidly stand up a CPT hunt sensor. 
# As of now, there are no configuration file modificaitons. These will come in a later script. 
#############################

#########   Notes   #########
# The version on the splunk forwarder may very well change. Simply log into splunk to download the 
# the universal forwarder, and copy the wget script form the download page, and replace it below
#############################

######## How to Use ##########
# After a succesful install of CentOS or RHEL on the sensor server, 
# use SCP to move this over to the server, or drag and drop from a usb if available
# SCP Syntax : scp ./insall_script.sh cpt@<server_ip>:/home/cpt/Desktop/install_script.sh
# Then on the sensor server, change the permissions to allow the script to run:
# chmod 0700 /home/cpt/Desktop/install_script.sh
##############################

# standard update to packages for fresh isntall
sudo yum update
sudo yum upgrade

# snort install
sudo yum install -y gcc flex bison zlib libpcap pcre libdnet tcpdump
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum install -y libnghttp2
sudo yum install -y https://www.snort.org/downloads/snort/snort-2.9.17-1.centos8.x86_64.rpm

# creat a link for Snort
sudo ln -s /usr/lib64/libgdnet.so.1 /usr/lib64/libdnet.1

# zeek
sudo wget -P /etc/yum.repos.d/  https://download.opensuse.org/repositories/security:zeek/CentOS_8/security:zeek.repo 
sudo yum -y install dnf-plugins-core cmake gcc-c++ openssl-devel swig zlib-devel gdb zeek-core
sudo dnf -y --enablerepo=PowerTools install libpcap-devel
sudo yum -y install zeek-devel
sudo yum -y install zeek

sudo /opt/zeek/bin/zeekctl install


# splunk
wget -O splunkforwarder-8.1.0.1-24fd52428b5a-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.0.1&product=universalforwarder&filename=splunkforwarder-8.1.0.1-24fd52428b5a-linux-2.6-x86_64.rpm&wget=true'
sudo rpm -i splunkforwarder-*.rpm
sudo /opt/splunkforwarder/bin/splunk status

