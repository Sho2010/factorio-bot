require 'open-uri'
require 'pry'

module Slappy
  class << self
    def convert_dropbox(uri)
      uri.gsub("www.dropbox.com", 'dl.dropboxusercontent.com')
    end

    def download_file(uri, world_name)
      path = File.join(Slappy.configuration.factorio.save_path, world_name)
      _uri = convert_dropbox(uri)

      open(path, 'wb') do |local_file|
        open(_uri, 'rb'){|download| local_file.write(download.read) }
      end
    end
  end
end
