# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

def dual(cards1,cards2,stock1,stock2,round)
    
    ####
    STDERR.puts "CARD1:"+cards1.join(",")
    STDERR.puts "CARD2:"+cards2.join(",")
    STDERR.puts "STOCK1:"+stock1.join(",")
    STDERR.puts "STOCK2:"+stock2.join(",")
    
    card1 = cards1.shift
    card2 = cards2.shift
    
    if card1 == card2 then
        # war occur.
        STDERR.puts "WAR OCCUR"
        if cards1.length<4 and cards2.length<4 then
            return "PAT",0
        elsif cards1.length<4 then
            #return "2",round
            return "PAT",0
        elsif cards2.length<4 then
            #return "1",round
            return "PAT",0
        end
        
        stock1 << card1 << cards1.shift << cards1.shift << cards1.shift
        stock2 << card2 << cards2.shift << cards2.shift << cards2.shift
        
        return dual(cards1,cards2,stock1,stock2,round)
    elsif card1 > card2 then
        if !stock1.empty? then
            stock1.each { |val| cards1 << val }
            stock1.clear
        end
        cards1.push card1
        if !stock2.empty? then
            stock2.each { |val| cards1 << val }
            stock2.clear
        end
        cards1.push card2
        round+=1
    else
        if !stock1.empty? then
            stock1.each { |val| cards2 << val }
            stock1.clear
        end
        cards2.push card1
        if !stock2.empty? then
            stock2.each { |val| cards2 << val }
            stock2.clear
        end
        cards2.push card2
        round+=1
    end
    
    if cards1.empty? and cards2.empty? then
        return "PAT",0
    elsif cards1.empty? then
        return "2",round
    elsif cards2.empty? then
        return "1",round
    end
    
    return dual(cards1,cards2,stock1,stock2,round)
end

def convert(token)
   initial = token[0,1]
   case initial
   when "K" then initial = "13"
   when "Q" then initial = "12"
   when "J" then initial = "11"
   when "A" then initial = "14"
   when "1" then initial = "10" # '1'0 -> 1 -> 10
   end
   
   initial.to_i
end

cards1 = []
cards2 = []
stock1 = []
stock2 = []

$n = gets.to_i # the number of cards for player 1
$n.times do
    cards1.push convert gets.chomp # the n cards of player 1
end
$m = gets.to_i # the number of cards for player 2
$m.times do
    cards2.push convert gets.chomp # the m cards of player 2
end

result,round=dual(cards1,cards2,stock1,stock2,0)

out=result
out=out+" "+round.to_s if round > 0

puts out

# Write an action using puts
# To debug: STDERR.puts "Debug messages..."

#puts "PAT"# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

def dual(cards1,cards2,stock1,stock2,round)
    
    ####
    STDERR.puts "CARD1:"+cards1.join(",")
    STDERR.puts "CARD2:"+cards2.join(",")
    STDERR.puts "STOCK1:"+stock1.join(",")
    STDERR.puts "STOCK2:"+stock2.join(",")
    
    card1 = cards1.shift
    card2 = cards2.shift
    
    if card1 == card2 then
        # war occur.
        STDERR.puts "WAR OCCUR"
        if cards1.length<4 and cards2.length<4 then
            return "PAT",0
        elsif cards1.length<4 then
            #return "2",round
            return "PAT",0
        elsif cards2.length<4 then
            #return "1",round
            return "PAT",0
        end
        
        stock1 << card1 << cards1.shift << cards1.shift << cards1.shift
        stock2 << card2 << cards2.shift << cards2.shift << cards2.shift
        
        return dual(cards1,cards2,stock1,stock2,round)
    elsif card1 > card2 then
        if !stock1.empty? then
            stock1.each { |val| cards1 << val }
            stock1.clear
        end
        cards1.push card1
        if !stock2.empty? then
            stock2.each { |val| cards1 << val }
            stock2.clear
        end
        cards1.push card2
        round+=1
    else
        if !stock1.empty? then
            stock1.each { |val| cards2 << val }
            stock1.clear
        end
        cards2.push card1
        if !stock2.empty? then
            stock2.each { |val| cards2 << val }
            stock2.clear
        end
        cards2.push card2
        round+=1
    end
    
    if cards1.empty? and cards2.empty? then
        return "PAT",0
    elsif cards1.empty? then
        return "2",round
    elsif cards2.empty? then
        return "1",round
    end
    
    return dual(cards1,cards2,stock1,stock2,round)
end

def convert(token)
   initial = token[0,1]
   case initial
   when "K" then initial = "13"
   when "Q" then initial = "12"
   when "J" then initial = "11"
   when "A" then initial = "14"
   when "1" then initial = "10" # '1'0 -> 1 -> 10
   end
   
   initial.to_i
end

cards1 = []
cards2 = []
stock1 = []
stock2 = []

$n = gets.to_i # the number of cards for player 1
$n.times do
    cards1.push convert gets.chomp # the n cards of player 1
end
$m = gets.to_i # the number of cards for player 2
$m.times do
    cards2.push convert gets.chomp # the m cards of player 2
end

result,round=dual(cards1,cards2,stock1,stock2,0)

out=result
out=out+" "+round.to_s if round > 0

puts out

# Write an action using puts
# To debug: STDERR.puts "Debug messages..."

#puts "PAT"
