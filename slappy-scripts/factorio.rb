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
  say '最初のオプションがURIじゃないっぽ', channel: event.channel unless event.matches[1] =~ URI::regexp

  say "ファイルをダウンロードしています。", channel: event.channel
  uri = event.matches[1].delete('<>')
  world_name = File.basename(uri)
  Slappy.download_file(uri, world_name)

  say "#{world_name}でfactorio serverを起動。", channel: event.channel

  begin
    Factorio::Server.controller.start(world_name)
    say '起動した。ちょっと待って', channel: event.channel
  rescue => e
    say "起動失敗した: #{e}", channel: event.channel
  end

end

respond 'list', from: { channel: '#bot-test' } do |event|
  say Factorio::Server.controller.world_list.join('\n'), channel: event.channel
end

