### How does it work? ###

The whole idea was to make it dockerized, as I found that more interesting than creating a pure VM per-se. Considering, the company is heading to the directions of Openshift (and therefore k8s).

I took the docker-compose file from [dockerhub](https://hub.docker.com/_/wordpress) I did not bother with changing the default values, as that was not the point of the excercise.

One thing I would change is to use [secrets](https://docs.docker.com/compose/use-secrets/) - Unused for simplicity, and also because they would have to be committed here anyway. For better safety, something like [Vault](https://www.vaultproject.io/) can be used.
Later I have decided to use an .env file with variables.


### Backups ###
I had multiple ideas for backing up, the simplest one I came up with would be a cronjob. Of course I also wanted to dockerize this... So I made a backup container for this. It is sort of working in theory... I did not want to waste more time here.


### Requirements ###
Make sure you have docker (and docker-compose) installed - I used docker-compose version 1.29.2.

Originally I had thought about this way simpler, however overtime I came up with different ideas, custom images and I over-complicated it a little.
I wanted to upload the images to dockerhub, however they have a limit of 1 repository for the free tiers. 
**This means that the images have to be built locally.**

### Running ###
```
git pull
bash build_images.sh
docker-compose up -d
```
Then you can access [Wordpress locally](http://localhost:8080/wp-admin/install.php)

#### Accessing containers for more testing ####
One of the requiremets was an ssh access. I have made it so that you can ssh to the ansible container, such as:\
``` ssh -p 2222 xitest@localhost```
In your case, if you are running this in a VM and are trying to connect from a hypervisor PC, make sure the VM and Hypervisor are on a bridge network.
I also added sudo for this user, however with a password, so that you can test your password.

#### Firewalling ####
Since I have decided to make all of this dockerized, there wasn't much point in making a firewall for this. However, I have included the files for a simple ufw setup via a ansible-playbook. Iptables could also have been used, with a similar setup / end result.

### Clean up ###
docker-compose down\
docker rmi ...
