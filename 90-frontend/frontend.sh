#!/bin/basH

dnf install ansible -y
#push
#ansible-playbook -i inventory.ini main.yaml
#pull
ansible-pull -i localhost, -U  https://github.com/yeguru/expense-ansible-roles-tf.git main.yaml -e COMPONENT=frontend -e ENVIRONMENT=$1