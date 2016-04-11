module Slappy
  module Factorio
    class Slappy::Configuration
      attr_accessor :factorio
    end

    def self.extended(config)
      config.factorio = Slappy::Factorio::Configuration.new
    end

    class Configuration
      attr_accessor :save_path, :mod_path, :service_name

      def save_path
        @save_path || ENV['FACTORIO_SAVE_PATH']
      end

      def mod_path
        @mod_path || ENV['FACTORIO_MOD_PATH']
      end

      def service_name 
        @service_name || ENV['DOCKERCLOUD_SERVICE_NAME']
      end

    end
  end
end
