STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

# nbFloors: number of floors
# width: width of the area
# nbRounds: maximum number of rounds
# exitFloor: floor on which the exit is found
# exitPos: position of the exit on its floor
# nbTotalClones: number of generated clones
# nbAdditionalElevators: ignore (always zero)
# nbElevators: number of elevators
$nbFloors, $width, $nbRounds, $exitFloor, $exitPos, $nbTotalClones, $nbAdditionalElevators, $nbElevators = gets.split(" ").collect {|x| x.to_i}

elevs = Hash.new

$nbElevators.times do
    # elevatorFloor: floor on which this elevator is found
    # elevatorPos: position of the elevator on its floor
    $elevatorFloor, $elevatorPos = gets.split(" ").collect {|x| x.to_i}
    elevs[$elevatorFloor] = $elevatorPos
end

blocked_floor = Hash.new

# game loop
first=true
loop do
    # cloneFloor: floor of the leading clone
    # clonePos: position of the leading clone on its floor
    # direction: direction of the leading clone: LEFT or RIGHT
    $cloneFloor, $clonePos, $direction = gets.split(" ")
    $cloneFloor = $cloneFloor.to_i
    $clonePos = $clonePos.to_i
    
    # Write an action using puts
    # To debug: STDERR.puts "Debug messages..."

    # 最上階で目的地と違う方向に進んでいたらBLOCK
    # エレベータ階でエレベータと違う方向に進んでいたらBLOCK
    # それ以外はWAIT
    elevPos = nil
    elevPos = elevs[$cloneFloor] if elevs.key?($cloneFloor)
    
    act = "WAIT"
    
    #if first then
    #    first=false
    #    puts "WAIT"
    if blocked_floor.key?($cloneFloor) then
        # do nothing.
    elsif $cloneFloor==$exitFloor then
        if $direction == "LEFT" then
            if $clonePos < $exitPos then
                blocked_floor[$cloneFloor] = true
                act = "BLOCK"
            end
        elsif $direction == "RIGHT" then
            if $clonePos > $exitPos then
                blocked_floor[$cloneFloor] = true
                act = "BLOCK"
            end
        end
    elsif !elevPos.nil? then
        #if elevPos == $clonePos then
        #    puts "WAIT"
        if $direction == "LEFT" then
            if $clonePos < elevPos then
                blocked_floor[$cloneFloor] = true
                act = "BLOCK"
            end
        elsif $direction == "RIGHT" then
            if $clonePos > elevPos then
                blocked_floor[$cloneFloor] = true
                act = "BLOCK"
            end
        end
    end
    
    puts act
end
