require 'pry'
require 'open-uri'
require 'active_support'
require 'active_support/core_ext'

# def get_file(url, world_name: Factorio::Server.random_world_name)
# end

controller = Factorio::ServerController.new

respond 'start (.*)', from: { channel: '#bot-test' } do |event|
  # linkの場合<http://example.com>の形式でtextがくる。
  world_name = args[1].present? ? args[1] : File.basename(args[0].delete('<>'))

  Factorio::Server.start(args[0], world_name)

  # say '立ち上げた、ちょっと待ってから `list` でIPだして', channel: event.channel
  say world_name 
end

respond 'list', from: { channel: '#bot-test' } do |event|
  say controller.world_list.join("\n"), channel: event.channel
end
