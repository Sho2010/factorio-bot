module Slappy
  module Factorio
    class Slappy::Configuration
      attr_accessor :factorio
    end

    def self.extended(config)
      config.factorio = Slappy::Factorio::Configuration.new
    end

    class Configuration
      attr_accessor :save_path, :mod_path
      attr_writer :file_check

      def save_path
        @save_path || ENV['FACTORIO_SAVE_PATH']
      end

      def mod_path
        @mod_path || ENV['FACTORIO_MOD_PATH']
      end

      def file_check?
        !!@file_check
      end
    end
  end
end
