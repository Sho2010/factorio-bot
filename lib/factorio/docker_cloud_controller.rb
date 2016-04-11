require 'base64'
require 'docker_cloud'

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
    end

    class FactorioContarinerController

      attr_accessor :client, :config

      def initialize()
        @client = DockerCloud::Client.new(ENV['DOCKER_CLOUD_USER'], ENV['DOCKER_CLOUD_API_KEY'])
      end

      def autholized?
        begin
          p @client.nodes.all #通信が発生すればなんでもいい
        rescue
          return false
        end
        true
      end

    end
  end
end
