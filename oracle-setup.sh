#!/bin/bash

# syntax check
if [ $# -ne 1 ]
then
 echo -e "\nUsage: $0 <ORACLE SID> \n"
 exit 1;
fi;



#source variables
#if [ -f "configuration.sh" ]
#then
#  . configuration.sh
#else
#  echo -e "\nError: Invalid/missing environment config file 'configuration.sh'\n"
#  exit 1;
#fi

hostTag=$1
ansibleInv='/etc/ansible/hosts'

# provision AWS infrastructure (EC2 and EBS volumes)
echo "yes" | terraform apply

instanceID=`aws ec2 describe-tags --filters "Name=resource-type,Values=instance" "Name=value,Values=${hostTag}" | grep "ResourceId" | awk '{print $2}' | sed 's/"//g' | sed 's/,/ /g'`
echo ${instanceID}

publicIP=`aws ec2 describe-instances --instance-ids ${instanceID} | grep PublicIpAddress | awk '{print $2}' | sed 's/"//g' | sed 's/,/ /g' | sed 's/ //g'`


if [ `grep -w '${hostTag}' ${ansibleInv} | wc -l` -eq 0 ]
then
 echo "${hostTag} ansible_ssh_host=${publicIP} ansible_ssh_user=ec2-user ansible_connection=ssh" >> ${ansibleInv}
else 
 echo "Ansible inventory with '${hostTag}' already exist"
 exit 1;
fi

echo "yes" | ssh-add /scripts/keys/DevopsKey.pem

sleep 5m

# run Ansible playbook - provisioning
ansible-playbook pre-install.yml

