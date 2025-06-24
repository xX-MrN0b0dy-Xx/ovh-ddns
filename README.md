> [!NOTE]
>
> A GitHub Action that push a new monthly image has been setup only to always have the latest Alpine base image

A simple but effective containerized implementation of my script ([visible at this link](https://gist.github.com/xX-MrN0b0dy-Xx/74d3d769cad9bd7d905ce7ce33c034bb)) to update the Dynamic Public IP utilizing the OVH DDNS Service DynHost.

### Environment Variables
| Variable        | Description                                                                                   |
|-----------------|-----------------------------------------------------------------------------------------------|
| `HOSTNAME`      | OVH domain                                                                       |
| `LOGIN`         | DynHost username                                                                               |
| `PASSWORD`      | DynHost password                                                                              |
| `LOG_TYPE`      | Values can be either `'file'` or `'STDOUT'`. Nothing else is accepted. Default is `'STDOUT'`. |
| `REFRESH_TIME`  | Must be a positive integer in minutes. Script runs every `REFRESH_TIME` minutes. Default is `5`. |

### Supported architectures
| Architecture | Supported?|
|--------------|-----------|
| `x86`       | YES    |
| `x86_64`      | YES    |
| `armv7`        | YES    |
| `aarch64`      | YES    |


### Locally build the image
The image is available in the *GitHub Container Registry*, but if you want to locally build it in order to debug, or improve or whatever, just modify the docker compose substituting the line `image:` with:
```yaml
    build:
      context: .
      dockerfile: Dockerfile
    image: ovh-ddns:local-build
```

### Extra: Create a DynHost user from OVH Control Panel

From OVH dashboard you can create the DynHost user: 
1. Domain names/yourdomain.ovh/DynHost section
2. Manage Access
3. Create a username and the subdomain you wanna redirect the host
4. Then Add a DynHost record with the same subdomain and the current IP of the host

> Remember that for some TLD, redirection to domain.TLD is not possible (ie `.it` doesn't allow this, so if I need to redirect to a domain.it, I'd create `dyn.domain.it` and redirect to it. Then I'll redirect any subdomain to `dyn.domain.it` and I have my Nginx reverse proxy that listen for `dyn.domain.it`)