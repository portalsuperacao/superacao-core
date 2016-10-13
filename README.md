# Superação Core

App para fornecer gestão dos trios para o programa **Anjos do Superação** e
demais funções administrativas para o Portal Superação.

# Environments

## Dev

### Init containers
```
$ docker-compose build
$ docker-compose up -d
$ docker exec -it <container-id> bash # para obter bash da instância
```

### Init Rails


```
$ docker exec -it <container-mysql> bash
$ rake db:create
$ rake db:migrate
```
