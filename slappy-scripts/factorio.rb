require 'pry'
require 'open-uri'
require 'active_support'
require 'active_support/core_ext'

hello do
  controller = Factorio::Server.create_controller(
    Slappy.configuration.docker.user,
    Slappy.configuration.docker.apikey
  )

  raise 'DockerCloud authlized error.'  unless controller.autholized?
end

respond 'start (.*)', from: { channel: '#bot-test' } do |event|
  say '最初のオプションがURIじゃないっぽ' unless event.matches[1] =~ URI::regexp

  world_name = File.basename(event.matches[1].delete('<>'))
  say "#{world_name}でfactorio serverを起動。" 

  begin
    Factorio::Server.controller.start(world_name)
    say '起動した。ちょっと待って'
  rescue => e
    say "起動失敗した: #{e}"
  end

end

respond 'list', from: { channel: '#bot-test' } do |event|
  say Factorio::Server.controller.world_list.join('\n'), channel: event.channel
end

