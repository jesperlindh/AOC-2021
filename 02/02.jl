@enum Direction up down forward
direction_instances = instances(Direction)
direction_symbols = Symbol.(direction_instances)
direction_to_symbol = Dict(zip(direction_instances, direction_symbols))
symbol_to_direction = Dict(zip(direction_symbols, direction_instances))

function string_to_direction(value::AbstractString)
    return symbol_to_direction[Symbol(value)]
end

mutable struct Command
    direction::Direction
    value::Int8
end

function get_position(commands::Vector{Command})::Tuple{Int,Int}
    horizontal_position::Int = 0
    depth::Int = 0

    for command::Command in commands
        if command.direction == up
            depth -= command.value
        elseif command.direction == down
            depth += command.value
        elseif command.direction == forward
            horizontal_position += command.value
        end
    end

    return (horizontal_position, depth)
end

function get_position2(commands::Vector{Command})::Tuple{Int,Int}
    horizontal_position::UInt = 0
    depth::UInt = 0
    aim::Int = 0

    for command::Command in commands
        if command.direction == up
            aim -= command.value
        elseif command.direction == down
            aim += command.value
        elseif command.direction == forward
            horizontal_position += command.value
            if aim != 0
                depth += aim * command.value
            end
        end
    end

    return (horizontal_position, depth)
end

function read_file(file_name::AbstractString)::Vector{Command}
    commands = Command[]
    open(file_name, "r") do file
        for line in eachline(file)
            parts = split(line, " ")
            command = Command(string_to_direction(parts[1]), parse(Int8, parts[2]))
            push!(commands, command)
        end
    end
    return commands
end

commands = read_file("input")
position = get_position(commands)
position2 = get_position2(commands)
println(position)
println(position2)
println(position[1] * position[2])
println(position2[1] * position2[2])
