# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

$n = gets.to_i
$vs = gets.chomp

values_str = $vs.split(" ")
values = values_str.map{|s| s.to_i}


cur_max     = 0
diff_max    = 0

values.each do |value|
    if cur_max <= value then
        cur_max = value
        next
    end
    diff = cur_max - value
    if diff > 0 then
        if diff_max < diff then
            diff_max = diff
        end
    end
end

#STDERR.puts "diff_max:"+diff_max.to_s

# Write an action using puts
# To debug: STDERR.puts "Debug messages..."

puts (diff_max*-1).to_s
