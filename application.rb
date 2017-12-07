require_relative 'robot'

VALID_COMMANDS = %w[PLACE MOVE LEFT RIGHT REPORT EXIT]

place_robot_hint =  "Place your robot using PLACE X,Y,F command or type EXIT\n"
list_of_commands_hint = "Available Commands: #{VALID_COMMANDS.join(',')} \n"

robot = Robot.new

def valid_command?(command)
  VALID_COMMANDS.include?(command.split(' ').first)
end

puts list_of_commands_hint

while command = gets
  command.chomp!
  command, args = command.split(' ')
  args = args.nil? ? [] : args.split(',')

  unless valid_command?(command)
    puts list_of_commands_hint
    next
  end

  if (!robot.placed? && command != 'PLACE') || (command == 'PLACE' && args.size != 3)
    puts place_robot_hint
    next
  end

  break if command == 'EXIT'

  if command == 'REPORT'
    puts robot.public_send(command.downcase, *args)
  else
    robot.public_send(command.downcase, *args)
  end
end
