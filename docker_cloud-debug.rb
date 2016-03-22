require 'base64'
require 'docker_cloud'
require 'pry'

client = DockerCloud::Client.new(ENV['DOCKER_CLOUD_USER'], ENV['DOCKER_CLOUD_API_KEY'])

binding.pry
