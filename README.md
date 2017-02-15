# Superação Core

This application handles the core elements of the methodology created by the Portal Superação, which provides psychological support to cancer patients during their cancer treatment.

It handles the matching, management of **overcomer** (patient) with his/her  **angel** (supporter) and support tickets to scale the platform in a self-managed way.

# Environments

## Dev

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

# License

GNU GPL v3.0
