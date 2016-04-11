require 'base64'
require 'docker_cloud'
require './lib/factorio/operations/start'

module Factorio
  module Server
    class << self
      def world_file_exist?(world_name)
        config.factorio.save_path
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
    end

    class FactorioContarinerController
      include Factorio::Server::Start

      attr_accessor :docker_cloud_client

      def initialize(user, apikey)
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

    end
  end
end
