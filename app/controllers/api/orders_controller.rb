module Api
  class OrdersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    # POST /api/robot/0/orders
    # request body
    # {
    #   commands: ["PLACE 0,0,NORTH", "MOVE", "REPORT"]
    # }
    #
    # success response
    # {
    #   location: [0,1,'NORTH']
    # }
    #
    # failure response
    # {
    #   error: "Invalid command: 'STAND'"
    # }

    def create
      commands = params[:commands]
      response = ProcessCommandService.new.call(commands)
      if response[:success]
        render json: { location: response[:data] }
      else
        render json: { error: response[:error] }, status: :unprocessable_entity
      end
    end
  end
end
