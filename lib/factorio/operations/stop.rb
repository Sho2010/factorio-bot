require 'docker_cloud'
require 'json'

module Factorio
  module Server
    module Stop
      class ContainerStopError < StandardError; end

      def stop(port)
        fail ContainerStopError, "invalid port." unless (1..65536).cover?(port) 

        service!
        container = find_stop_target_container(port)
        fail ContainerStopError, "target container notfound." unless container
        container.stop
      end

      private

      def find_stop_target_container(port)
        service.containers.find {|container|
          container.state == "Running" &&
          container.container_ports&.first&.outer_port = port
        }
      end

    end
  end
end

