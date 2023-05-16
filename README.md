# ansible-k8s

# start up the server 
```
# on new terminal
cd ./k8s
vagrant up --provider=libvirt
```
```
# on new terminal
cd ./manager
vagrant up --provider=libvirt
vagrant ssh # log in to manager server to execute Ansible playbook following steps down below

```

# install ansible
```
sudo dnf install ansible -y
```

# setting ssh for log-in to server by public key
```
ssh-keygen
>enter til the end

ssh-copy-id -i ~/.ssh/id_rsa root@192.168.121.125
>yes
>password = admin

ansible -i hosts kworker -m ping  -u root
>expect to see "pong"
```

***Diagram***

         ---------------
         |***Manager***|
         | - Python    |      prepare cluster 
         | - Ansible   |---------------
         | + kk        |              |
         ---------------              |
               |                      |
       prepare | and create cluster   |
               V                      V
         ---------------       -------------------
         |***Kmaster***|  join |***Kworker1..n***|
         | - Python    |<------| - Python        |
         | + kubectl   |       |                 |
         | + kubeadm   |       |                 |
         ---------------       -------------------    


0. Test conection from manager to the cluster servers
   - update ./hosts and cluster-config-vxxx.yaml files before run:
```
ansible all -m ping -i ./hosts -b -u root 

```
1. prepare cluster servers 
```
ansible-playbook -i hosts 01_prepare-servers-playbook.yml --extra-vars "my_hosts=all"

```

2. create cluster 
   - run:
```
ansible-playbook -i hosts 02_create-cluster-playbook.yml --extra-vars "my_hosts=localhost"

```
   - test at master node :
```
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0

kubectl expose deployment web --type=NodePort --port=8080

kubectl get service web -o wide

kubectl get pod -o wide

curl http://<node-ip>:<node-port>
```


3. prepare more servers 
```
ansible-playbook -i hosts 03_prepare-more-servers-playbook.yml --extra-vars "my_hosts=kworker2"

```

4. add nodes to the cluster 
   - run:
```
ansible-playbook -i hosts 04_add-node-to-cluster.yaml --extra-vars "my_hosts=localhost"

```
   - test:
```
kubectl get service web -o wide

kubectl get pod -o wide

curl http://<node-ip>:<node-port>
```

5. delete node from cluster 
```
ansible-playbook -i hosts 05_delete-node-from-cluster.yaml --extra-vars "my_hosts=localhost"
```

6. delete cluster 
```
ansible-playbook -i hosts 06_delete-cluster.yaml --extra-vars "my_hosts=localhost"

```
