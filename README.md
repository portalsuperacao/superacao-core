# Superação Core

App para fornecer gestão dos trios para o programa **Anjos do Superação** e
demais funções administrativas para o Portal Superação.

# API

## Código de ativação:

- GET: /activate
  - Para obter um código de ativação válido, entre no container RoR e pegue um código ainda não usado, via:

  ```
    $ rails c # console Rails
    $ ActivationCode.all[0] # primeiro elemento (use o atributo 'code')

  ```

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
$ rake db:seed
```


### Issues

Problema no carregamento do **guard** devido ao bundler. Executar no container:

```
bundle_path=$(which bundle)
sed -i -e "s/activate_bin_path/bin_path/g" $bundle_path
```
