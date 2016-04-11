module Slappy
  module DockerCloud
    class Slappy::Configuration
      attr_accessor :docker
    end

    def self.extended(config)
      config.docker = Slappy::DockerCloud::Configuration.new
    end

    class Configuration
      attr_accessor :user, :apikey, :service_name

      def user
        @user || ENV['DOCKERCLOUD_USER']
      end

      def apikey
        @user || ENV['DOCKERCLOUD_APIKEY']
      end

      def service_name
        @service_name || ENV['DOCKERCLOUD_SERVICE_NAME']
      end

    end
  end
end
