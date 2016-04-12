require 'docker_cloud'
require 'json'

module Factorio
  module Server
    module Start
      class ServerStartError < StandardError; end
      class ContainerFullError < StandardError; end

      # TODO: Implement me. force deploy container
      # def start!(world_name, stop_world) 
      #   fail ServerStartError, "world file not exists." unless Factorio::Server.world_file_exist? world_name
      # end

      def start(world_name)
        fail ServerStartError, "world file not exists." unless Factorio::Server.world_file_exist? world_name

        service!

        container = pick_deploy_target_container
        fail ContainerFullError, "empry container notfound." unless container

        puts container.uuid
        update_world_name(world_name)
        container.redeploy
      end

      private

      def update_world_name(world_name)
        # refs: https://docs.docker.com/apidocs/docker-cloud/#update-an-existing-service
        service.update( {container_envvars: [{key: 'WORLD_NAME', value: world_name}]} )
      end

      def pick_deploy_target_container
        service.containers.find {|container| container.state == "Stopped" } 
      end

      def update_world_request_body(world_name)
        body = {container_envvars: [{key: "WORLD_NAME" , value: world_name}] }
        body.to_json
      end
    end
  end
end

