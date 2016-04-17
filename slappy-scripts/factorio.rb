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

respond 'start (.*)', from: { channel: 'G0L1ZHRME' } do |event|
  unless event.matches[1] =~ URI::regexp
    say '最初のオプションがURIじゃないっぽ', channel: event.channel
    return
  end

  say "ファイルをダウンロードしています。", channel: event.channel
  uri = event.matches[1].delete('<>')
  world_name = File.basename(uri).gsub(/\?.*$/, "")
  Slappy.download_file(uri, world_name)

  say "#{world_name}でfactorio serverを起動。", channel: event.channel

  begin
    Factorio::Server.controller.start(world_name)
    say '起動した。ちょっと待って', channel: event.channel
  rescue => e
    say "起動失敗した: #{e}", channel: event.channel
  end

end

respond 'list', from: { channel: 'G0L1ZHRME' } do |event|
  list = Factorio::Server.controller.world_list
  if list.empty?
    say '何も動いてないっぽい', channel: event.channel
  else
    say list.join("\n"), channel: event.channel
  end
end

respond 'stop (\d*)', from: { channel: 'G0L1ZHRME' } do |event|
  port = event.matches[1].to_i
  begin
    Factorio::Server.controller.stop(port)
    say '止めた。', channel: event.channel
  rescue => e
    say "停止失敗: #{e}", channel: event.channel
  end
end

respond 'hello' do |event|
  binding.pry
end
