
## About

This will build a container for [Mosquitto](https://www.mosquitto.org). A MQTT broker.data.


## Maintainer

- [Nfrastack](https://www.nfrastack.com)


## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Installation](#installation)
  - [Prebuilt Images](#prebuilt-images)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
- [Environment Variables](#environment-variables)
  - [Base Images used](#base-images-used)
  - [Core Configuration](#core-configuration)
  - [Container Options](#container-options)
  - [Logging Options](#logging-options)
  - [Functionality Options](#functionality-options)
- [Users and Groups](#users-and-groups)
- [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support & Maintenance](#support--maintenance)
- [References](#references)
- [License](#license)


## Installation


### Prebuilt Images
Feature limited builds of the image are available on the [Github Container Registry](https://github.com/nfrastack/container-mosquitto/pkgs/container/container-mosquitto) and [Docker Hub](https://hub.docker.com/r/nfrastack/mosquitto).

To unlock advanced features, one must provide a code to be able to change specific environment variables from defaults. Support the development to gain access to a code.

To get access to the image use your container orchestrator to pull from the following locations:

```
ghcr.io/nfrastack/container-mosquitto:(image_tag)
docker.io/nfrastack/mosquitto:(image_tag)
```

Image tag syntax is:

`<image>:<optional tag>-<optional_distribution>_<optional_distribution_variant>`

Example:

`ghcr.io/nfrastack/container-mosquitto:latest` or

`ghcr.io/nfrastack/container-mosquitto:1.0`

* `latest` will be the most recent commit
* An otpional `tag` may exist that matches the [CHANGELOG](CHANGELOG.md) - These are the safest
* If it is built for multiple distributions there may exist a value of `alpine` or `debian`
* If there are multiple distribution variations it may include a version - see the registry for availability

Have a look at the container registries and see what tags are available.


#### Multi-Architecture Support

Images are built for `amd64` by default, with optional support for `arm64` and other architectures.


## Configuration


### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [compose.yml](examples/compose.yml) that can be modified for your use.

* Map [persistent storage](#persistent-storage) for access to configuration and data files for backup.
* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Make [networking ports](#networking) available for public access if necessary



### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory    | Description                    |
| ------------ | ------------------------------ |
| `/config/`   | (optional) Configuration files |
| `/data/`     | Volatile data                  |
| `/data/auth` | Authentication information     |
| `/data/db`   | Persistence DB                 |
| `/logs/`     | Logfiles for                   |


### Environment Variables


#### Base Images used

This image relies on a customized base image in order to work.
Be sure to view the following repositories to understand all the customizable options:

| Image                                                   | Description |
| ------------------------------------------------------- | ----------- |
| [OS Base](https://github.com/nfrastack/container-base/) | Base Image  |

Below is the complete list of available options that can be used to customize your installation.

* Variables showing an 'x' under the `Advanced` column can only be set if the containers advanced functionality is enabled.


#### Core Configuration


| Parameter                         | Description                              | Default              | Advanced |
| --------------------------------- | ---------------------------------------- | -------------------- | -------- |
| `MOSQUITTO_SETUP_MODE`            | Set to `AUTO`, `MANUAL`                  |                      |
| `LOG_LEVEL`                       | Log verbosity level                      | `all`               |
| `LOG_TYPE`                        | Log output type (BOTH/STDOUT/FILE)       | `BOTH`               |
| `LOG_PATH`                        | Path to log files                        | `/logs/`
| `LOG_FILE`                        | Log file name                            | `mosquitto.log`     |
| `LOG_CONNECTION_MESSAGES`         | Log connection messages (TRUE/FALSE)     | `TRUE`               |
| `LOG_ENABLE_TIMESTAMP`            | Enable timestamps in logs (TRUE/FALSE)   | `TRUE`               |
| `LOG_TIMESTAMP_FORMAT`            | Timestamp format for logs                | `%Y-%m-%dT%H:%M:%S ` |
| `CONFIG_PATH`                     | Path to configuration files              | `/config/`           |
| `CONFIG_FILE`                     | Mosquitto configuration file name        | `mosquitto.conf`     |
| `DATA_PATH`                       | Path to persistent data                  | `/data/`             |
| `ENABLE_PERSISTENCE`              | Enable persistence (TRUE/FALSE)          | `FALSE`              |
| `PERSISTENCE_PATH`                | Path to persistence database             | `${DATA_PATH}/db/`   |
| `PERSISTENCE_AUTOSAVE_INTERVAL`   | Autosave interval in seconds             | `1800`               |
| `PERSISTENCE_AUTOSAVE_ON_CHANGES` | Autosave on changes (TRUE/FALSE)         | `FALSE`              |
| `PERSISTENCE_FILE`                | Persistence database file name           | `mosquitto.db`       |
| `LISTEN_IP`                       | IP address to listen on                  | `0.0.0.0`            |
| `LISTEN_PORT`                     | Port to listen on                        | `1883`               |
| `LISTEN_TYPE`                     | Listener type (TCP/other)                | `TCP`                |
| `MOSQUITTO_GROUP`                 | Group to run Mosquitto as                | `mosquitto `         |
| `MOSQUITTO_USER`                  | User to run Mosquitto as                 | `mosquitto `         |
| `MOSQUITTO_SETUP_TYPE`            | Setup type (AUTO/MANUAL)                 | `AUTO`               |
| `SECURITY_ENABLE_ANONYMOUS`       | Allow anonymous connections (TRUE/FALSE) | `FALSE`              |
| `SECURITY_PASSWORD_FILE`          | Password file name                       | `auth.db `           |
| `SECURITY_PASSWORD_PATH`          | Path to password file                    | `${DATA_PATH}/auth/` |



## Users and Groups

| Type  | Name        | ID  |
| ----- | ----------- | --- |
| User  | `mosquitto` | 1883  |
| Group | `www-data`  | 1883  |


### Networking

| Port | Protocol | Description |
| ---- | -------- | ----------- |
| `188` | tcp      | mosquitto   |

* * *


## Maintenance


### Shell Access

For debugging and maintenance, `bash` and `sh` are available in the container.


## Support & Maintenance

- For community help, tips, and community discussions, visit the [Discussions board](/discussions).
- For personalized support or a support agreement, see [Nfrastack Support](https://nfrastack.com/).
- To report bugs, submit a [Bug Report](issues/new). Usage questions will be closed as not-a-bug.
- Feature requests are welcome, but not guaranteed. For prioritized development, consider a support agreement.
- Updates are best-effort, with priority given to active production use and support agreements.


## References

* https://mosquitto.org/


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

