require 'docker_cloud'

module Factorio
  module Server
    module WorldList

      def world_list
        service!.containers.select{ |c|
          c.state == "Running"
        }.map{ |c|
          WorldInfo.create_from_container(c)
        }
      end

      class WorldInfo
        class << self
          def create_from_container(container)
            world_name = container.env_vars.find {|env| env[:key] == 'WORLD_NAME' }[:value]
            WorldInfo.new(name: world_name,
                          ip: container.node.public_ip,
                          port: container.container_ports.first.outer_port)
          end
        end

        attr_reader :name, :ip , :port

        def initialize(name: '', ip: '', port: '')
          @name = name; @ip = ip; @port = port
        end

        def to_s
          "(#{name}) #{ip}:#{port}"
        end

      end
    end
  end
end
