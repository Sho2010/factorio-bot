require './lib/factorio/factorio_configuration.rb'
require './lib/factorio/docker_cloud_configuration.rb'

Slappy.configure do |config|
  ## Slappy Settings
  #
  # token:
  #   Slack API Token
  #
  # config.token = ENV['SLACK_TOKEN']

  # scripts_path_dir:
  #   Slappy scripts directory.
  #   Slappy load scripts in this directory.
  #
  # config.scripts_dir_path = 'slappy-scripts'

  # logger:
  #   Use logger object.
  #
  # config.logger = Logger.new(STDOUT)

  # logger.level:
  #   Specify logger level.
  #
  # config.logger.level = Logger::INFO

  # dsl:
  #   use dsl
  #
  #   param: :enabled or :disabled
  #
  # config.dsl = :enabled

  # stop_with_error:
  #   Select bot be stop when catch StandardError.
  #   If false, puts stack trace but be not stop when bot catch StandardError.
  #
  # config.stop_with_exception = true

  ## Default parameters
  #
  # There parameters use in say method when send to Slack.
  # Settings specified here will take precedence over those in method option
  # And other parameters give to method option if you want.
  #
  #   Official API document:
  #     https://api.slack.com/methods/chat.postMessage

  # username:
  #   Name of bot.
  #
  config.robot.username = 'factorio-bot'

  # channel:
  #   Channel, private group, or IM channel to send message to.
  #   Can be an encoded ID, or a name. See below for more details.
  #
  config.robot.channel = '#bot-test'

  # icon_emoji:
  #   emoji to use as the icon for this message. Overrides icon_url.
  #
  # config.robot.icon_emoji = nil

  # icon_url:
  #    URL to an image to use as the icon for this message
  #
  # config.robot.icon_url = nil
  #

  # factorio configures
  config.extend Slappy::Factorio
  # config.factorio.mod_path = '/var/factorio/mod'
  # config.factorio.save_path = '/var/factorio/saves'
  # config.factorio.service_name = 'factorio'


  # dockercloud configures
  config.extend Slappy::DockerCloud
  #
  # user:
  #   DockerCloud user name
  #
  # config.docker_cloud.user = ENV['DOCKERCLOUD_USRE']

  #
  # apikey:
  #   DockerCloud API key
  #
  # config.docker_cloud.apikey = ENV['DOCKERCLOUD_APIKEY']

  # service_name
  #   docker cloud factorio server service name
  #
  # config.docker_cloud.service_name = 'factorio'

end

