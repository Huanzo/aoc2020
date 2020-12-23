function game(input)
    map = Array{Int}(undef, 1000000)

    for i = 1:1000000
        if i < length(input)
            map[input[i]] = input[i + 1]
        elseif i == length(input)
            map[input[end]] = maximum(input) + 1
        else
            map[i] = i + 1
        end
    end

    map[1000000] = input[1]

    curr = input[1]

    for i = 1:10000000
        p1 = map[curr]
        p2 = map[p1]
        p3 = map[p2]
        tmp = 0

        map[curr] = map[p3]

        tmp = curr == 1 ? 1000000 : curr - 1

        while tmp in [p1,p2,p3]
            tmp = tmp == 1 ? 1000000 : tmp - 1
        end

        map[p3] = map[tmp]
        map[tmp] = p1
        curr = map[curr]
    end
    map
end

input = [5, 6, 2, 8, 9, 3, 1, 4, 7]
out = game(input)
println(out[1] * out[out[1]])
