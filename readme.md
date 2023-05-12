
# install neovim
```
sudo dnf install epel-release
sudo dnf install neovim 
```

# setting ssh to server by public key
```
ssh-keygen
>enter til the end

ssh-copy-id -i ~/.ssh/id_rsa root@192.168.121.125
>yes
>password

ansible -i hosts kworker -m ping  -u root
>expect to see "pong"
```
