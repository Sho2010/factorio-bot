require 'pry'
require 'open-uri'
require 'active_support'
require 'active_support/core_ext'

controller = Factorio::Server::FactorioContarinerController.new
raise "DockerCloud authlized error."  unless controller.autholized?

respond 'start (.*)', from: { channel: '#bot-test' } do |event|
  world_name = args[1].present? ? args[1] : File.basename(args[0].delete('<>'))
  Factorio::Server.start(args[0], world_name)

  # say '立ち上げた、ちょっと待ってから `list` でIPだして', channel: event.channel
  say world_name 
end

respond 'list', from: { channel: '#bot-test' } do |event|
  say controller.world_list.join("\n"), channel: event.channel
end

