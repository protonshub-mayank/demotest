class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def direction
    commands = params[:commands] 

    robot_placed = false
    x = nil
    y = nil
    direction = nil

    commands.each do |command|
      command_array = command.split(" ")
      command_name = command_array[0]
      case command_name
      when 'PLACE'
        x,y,direction = command_array[1].split(",")
        robot_placed = true
      when 'MOVE'
        x,y = move(x, y, direction) if robot_placed
      when 'LEFT'
        direction = left(direction) if robot_placed
      when 'RIGHT'
        direction = right(direction) if robot_placed
      when 'REPORT'
        break if robot_placed
      end       
    end
    return  render json: {location: [x, y , direction]}
  end

  private
  def move(x, y, direction)
    x2 = x.to_i
    y2 = y.to_i 
    case direction
    when 'NORTH'
      y2 = y2 + 1 if y2 + 1 <= 5
    when 'SOUTH'
      y2 = y2 - 1 if y2 - 1 >= 0
    when 'EAST'
      x2 = x2 + 1 if x2 + 1 <= 5
    when 'WEST'
      x2 = x2 - 1 if x2 - 1 >= 0
    end
    [x2, y2]
  end

  def left(direction)
    directions[directions.find_index(direction) - 1]
  end  


  def right(direction)
    directions[directions.find_index(direction) + 1]
  end  

  def directions
    ['NORTH', 'EAST', 'SOUTH', 'WEST']
  end  
end
