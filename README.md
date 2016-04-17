# Description
Control  factorio server container on the docker cloud through the slack.

# Premise

* That the [factorio server container](https://github.com/sho2010/factorio-docker) is running in the [docker cloud](https://cloud.docker.com).

* This container can shared server container savefile volume.

# Configuration

Basic Slack configuration refs: [Slappy](https://github.com/wakaba260/slappy#configure)

## Appended factorio bot configuration 

### MUST settings

~~~ruby
  #
  # factorio.save_path
  #     factorio save file directory
  #     Downloaded file write here.
  #     ENV['FACTORIO_SAVE_PATH']
  #
  # config.factorio.save_path = '/factorio/saves'

  #
  # user:
  #   DockerCloud user name
  #
  # config.docker_cloud.user = ENV['DOCKERCLOUD_USER']

  #
  # apikey:
  #   DockerCloud API key
  #
  # config.docker_cloud.apikey = ENV['DOCKERCLOUD_APIKEY']

  #
  # service_name
  #   docker cloud factorio server service name
  #
  # config.docker_cloud.service_name = 'factorio'

~~~

- - -

# Slack Usage

## Start
Deploy the upload data to the empty container.


~~~slack
factorio-bot start ${savedata_zip_URL}
~~~


## Stop

Stop the container of the specified port.
If you want to know the port number, please use the `list`.

~~~slack
factorio-bot stop ${container_port}
~~~

## List

Show running containers filename, ip and port.

~~~slack
factorio-bot list
~~~

- - -

![start](https://github.com/sho2010/factorio-bot/wiki/images/start.png)

- - -

![stop](https://github.com/sho2010/factorio-bot/wiki/images/stop2.png)

