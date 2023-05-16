
# install neovim
```
sudo dnf install epel-release
sudo dnf install neovim 
```

# check os matrice
```
cat ./etc/os-release
lsb_release -dirc # for debian
free -h # check memory
nproc # check cpu cores
lsblk # check storage
df -h

```

# install zsh
```
echo $SHELL
getent passwd {user}
sudo apt update && sudo install zsh

chsh -s $(which zsh) <<EOF
password
EOF
sudo dnf install util-linux-user -y # if chsh command not found

su {user} <<EOF
password
0
EOF

sudo dnf install git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# edit ~/.zshrc
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

ZSH_THEME="powerlevel10k/powerlevel10k"

sudo dnf install neovim

su {user}
>>following the steps

#edit comment out always show context


```

# install ansible
```
sudo dnf install ansible -y
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

# update ip in config files and run ansible to create k8s cluster
```
ansible-playbook -i ./hosts  01_...yml --extra-vars "my_hosts=all"

```


# TODO 
- Prometheus
- Grafana
- KubeSphere
- set images repo/ Nexus



