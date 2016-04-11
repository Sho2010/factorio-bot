require 'pry'
require 'open-uri'
require 'active_support'
require 'active_support/core_ext'

hello do
  controller = Factorio::Server.create_controller(
    Slappy.configuration.docker.user,
    Slappy.configuration.docker.apikey
  )

  raise "DockerCloud authlized error."  unless controller.autholized?
end

respond 'start (.*)', from: { channel: '#bot-test' } do |event|
  say "最初のオプションがURIじゃないっぽ" unless event.matches[1] =~ URI::regexp

  # TODO: implement me
  # world_name = event.matches[2].present? ? args[1] : File.basename(args[0].delete('<>'))
  Factorio::Server.controller.start("world_name")
end

respond 'list', from: { channel: '#bot-test' } do |event|
  say Factorio::Server.controller.world_list.join("\n"), channel: event.channel
end

