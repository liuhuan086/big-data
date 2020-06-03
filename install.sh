var=$(pwd)
yum install epel-release -y
yum install sshpass -y
yum install ansible -y
ansible-playbook -i $var/hosts site.yml
