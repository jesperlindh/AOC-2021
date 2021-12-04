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

function get_position(commands::Vector{Command})
    horizontal_position = 0
    depth = 0

    for command in commands
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

function read_file(file_name)
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
println(position)
println(position[1] * position[2])
