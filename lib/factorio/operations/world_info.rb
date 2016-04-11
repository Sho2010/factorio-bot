require 'docker_cloud'

module Factorio
  module Server
    module WorldList
      class WorldInfo
        class << self
          def create_from_container(container)
            world_name = container.env_vars.find {|env| env[:key] == 'WORLD_NAME' }[:value]
            WorldInfo.new(name: world_name, ip: container.node.public_ip, port: container.container_ports.first.outer_port)
          end
        end

        attr_reader :name, :ip , :port
        def initialize(name: '', ip: '', port: '')
          @name = name; @ip = ip; @port = port
        end

        def world_list(service_name)
          factorio_containers = @client.services.all.
              select{|s| s.name.start_with?(service_name)}.
              map{|s| @client.services.get(s.uuid).containers.first }.
              map{|container| WorldInfo.create_from_container(container) }
        end

        def to_s
          "(#{name}) #{ip}:#{port}"
        end
      end
    end
  end
end
