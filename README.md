### How does it work? ###

The whole idea was to make it dockerized, as I found that more interesting than creating a pure VM per-se. Considering, the company is heading to the directions of Openshift (and therefore k8s).

I took the docker-compose file from [dockerhub](https://hub.docker.com/_/wordpress) I did not bother with changing the default values, as that was not the point of the excercise.

One thing I would change is to use [secrets](https://docs.docker.com/compose/use-secrets/) - Unused for simplicity, and also because they would have to be committed here anyway. For better safety, something like [Vault](https://www.vaultproject.io/) can be used.


### Backups ###
I had multiple ideas for backing up, the simplest one I came up with would be a cronjob. Of course I also wanted to dockerize this...




### Requirements ###
Make sure you have docker (and docker-compose) installed - I used docker-compose version 1.29.2

### Running ###
git pull\
docker-compose up -d\
Then you can access [Wordpress locally](http://localhost:8080/wp-admin/install.php)


### Clean up ###
docker-compose down
