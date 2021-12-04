function find_increases(depths)
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

function get_windows(depths)
    windows = []
    window = 0
    for i = 1:(length(depths)-2)
        window = sum(depths[i:i+2])
        push!(windows, window)
    end

    return windows
end

depths = read_input()
increases = find_increases(depths)
windows = get_windows(depths)
increases_windows = find_increases(windows)
println(increases)
println(increases_windows)
