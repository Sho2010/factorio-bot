require 'open-uri'
require 'pry'

module Slappy
  class << self
    def download_file(uri, world_name)
      path = File.join(Slappy.configuration.factorio.save_path, world_name)
      open(path, 'wb') do |local_file|
        open(uri, 'rb'){|download| local_file.write(download.read) }
      end
    end
  end
end
