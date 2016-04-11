require 'docker_cloud'
require 'json'

module Factorio
  module Server
    module Start
      def update_world_name()
        #TODO: update docker cloud service WORLD_NAME ENV
      end

      def start(world_name, force=false)
        # TODO: check world file exists
        # TODO: check stoped container slot 
        # check_container if force

        update_world_name
        # TODO: redeploy container
      end

      private

      def update_world_request_body(world_name)
        body = {container_envvars: [{key: "WORLD_NAME" , value: world_name}] }
        body.to_json
      end
    end
  end
end

