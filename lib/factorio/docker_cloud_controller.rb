require 'base64'
require 'docker_cloud'

module Factorio
  class ServerController 

    attr_accessor :client

    def initialize()
      @client = DockerCloud::Client.new(ENV['DOCKER_CLOUD_USER'], ENV['DOCKER_CLOUD_API_KEY'])
    end

    SERVICE_PREFIX = 'factorio-'
    SAVE_PATH = '/var/Factorio'

    def start(world_name)
      # service = client.services.all.find {|service| service.name == 'factorio-sho2010'}
      # client.services.start()
    end

    def stop(world_name)

    end

    def world_list 
      factorio_containers = @client.services.all.
        select{|s| s.name.start_with?(SERVICE_PREFIX)}.
        map{|s| @client.services.get(s.uuid).containers.first }.
        map{|container| WorldInfo.create_from_container(container) }
    end
  end
end
