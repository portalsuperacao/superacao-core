# Superação Core

This application handles the core elements of the methodology created by the Portal Superação, which provides psychological support to cancer patients during their cancer treatment.

It handles the matching, management of **overcomer** (patient) with his/her  **angel** (supporter) and support tickets to scale the platform in a self-managed way.

# Documentation

This project is using [swagger](http://swagger.io) for API documentation. The API uses [json-api](http://jsonapi.org/) standards, but the entities defined in the swagger does not reflect the json-api structure.

To access documentation, accesse **swagger-ui** at `http://localhost:4444` and load the swagger schema file at `http://localhost:3000/swagger` 

# Environments

## Dev

### Google Cloud Platform

#### Service: Storage

It's been used to upload images and make it available to the Firebase mobile app client. The same bucket is shared by Firebase and Google Cloud.  

Create your account and place the keys in `commons.env` file.

### Docker
```
$ docker-compose build
$ docker-compose up -d
$ docker exec -it <container-id> bash # to get container bash
```

### Rails init


```
$ docker exec -it <app-container-id> bash
$ rake db:create
$ rake db:migrate
$ rake db:seed
```


### Issues

Workaround for running `guard`:

```
bundle_path=$(which bundle)
sed -i -e "s/activate_bin_path/bin_path/g" $bundle_path
```

# Contributors

- [FIAP University](https://www.fiap.com.br) for supporting the development of mobile app
- Gabriela Besser - Founder, product design, UI/UX
- Michel Bottan - [@abmxer](http://github.com/abmxer)
- Andreza Medeiros - [@andrezacm](http://github.com/andrezacm)
- Victor Presumido - [@victorpre](http://github.com/victorpre)

# License

GNU GPL v3.0
