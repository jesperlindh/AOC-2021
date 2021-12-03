function find_depth(depths)
    increases = 0
    previous = maximum(depths) + 1
    for depth in depths
        if depth > previous
            increases += 1
        end
        previous = depth
    end

    return increases
end

function read_input()
    depths = Int16[]
    open("input", "r") do input_file
        for line in eachline(input_file)
            push!(depths, parse(Int16, line))
        end
    end
    return depths
end

depths = read_input()
increases = find_depth(depths)
println(increases)
