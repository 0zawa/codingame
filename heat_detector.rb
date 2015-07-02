STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

# W: width of the building.
# H: height of the building.
$W, $H = gets.split(" ").collect {|x| x.to_i}
$N = gets.to_i # maximum number of turns before game over.
$X0, $Y0 = gets.split(" ").collect {|x| x.to_i}

STDERR.puts "W:"+$W.to_s+",H:"+$H.to_s

x=$X0
y=$Y0
x_min=0
x_max=$W
y_min=0
y_max=$H

# game loop
loop do
    $BOMB_DIR = gets.chomp # the direction of the bombs from batman's current location (U, UR, R, DR, D, DL, L or UL)
    
    STDERR.puts "X_old:"+x.to_s+",Y_old:"+y.to_s
    
    # Write an action using puts
    # To debug: STDERR.puts "Debug messages..."
    if $BOMB_DIR.include?("L") then
        x_max=x
        x = x - [((x-x_min)/2.0).round,1.0].max
    elsif $BOMB_DIR.include?("R") then
        x_min = x
        x = x + [((x_max-x)/2.0).round,1.0].max
    end
    
    if $BOMB_DIR.include?("U") then
        y_max=y
        y = y - [((y-y_min)/2.0).round,1.0].max
    elsif $BOMB_DIR.include?("D") then
        y_min = y
        y = y + [((y_max-y)/2.0).round,1.0].max
    end
    
    STDERR.puts "B:"+$BOMB_DIR+",X:"+x.to_s+",Y:"+y.to_s
    
    puts x.to_i.to_s+" "+y.to_i.to_s
    #puts "0 0" # the location of the next window Batman should jump to.
end

