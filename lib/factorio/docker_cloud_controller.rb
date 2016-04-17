require 'base64'
require 'docker_cloud'
require './lib/factorio/operations/start'
require './lib/factorio/operations/world_info'
require './lib/factorio/operations/stop'

module Factorio
  module Server
    class << self
      def world_file_exist?(world_name)
        return true unless config.factorio.file_check?
        
        File.exists? File.join(config.factorio.save_path, world_name)
      end

      def download_file(uri, path)
        open(path, 'wb') do |file|
          open(uri) { |raw| file.write(raw.read) }
        end
      end

      def create_controller(user, apikey)
        @controller = FactorioContarinerController.new(user, apikey)
      end

      def controller
        @controller
      end

      def config
        Slappy::configuration
      end
    end

    class FactorioContarinerController
      include Factorio::Server::Start
      include Factorio::Server::WorldList
      include Factorio::Server::Stop

      attr_accessor :docker_cloud_client, :service_name

      def initialize(user, apikey, service_name='factorio')
        @service_name = service_name
        @docker_cloud_client = DockerCloud::Client.new(user, apikey)
      end

      def autholized?
        begin
          p docker_cloud_client.nodes.all #通信が発生すればなんでもいい
        rescue
          return false
        end
        true
      end

      def service
        @service ||= service! 
      end

      # Always API call
      def service!
        temp = docker_cloud_client.services.all.find { |s| s.name == service_name }
        @service = docker_cloud_client.services.get(temp.uuid)
      end

    end
  end
end
