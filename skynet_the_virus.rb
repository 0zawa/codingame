

STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

#require 'marshal'

$max_cost = 1024*1024

class Node
   attr_accessor :id,:edges,:cost,:done,:from
   def initialize(id,cost)
      @id,@cost = id,cost
      @edges = Array.new
      @done = false
   end
   def addEdge(to,cost)
      @edges << Edge.new(to,cost) 
   end
   def remove_edge(_p1,_p2)
      STDERR.puts "before:"
      STDERR.puts edges
      edges.delete_if do |edge|
          ep1,ep2 = [@id,edge.toId].sort
          p1,p2 = [_p1,_p2].sort
          
          STDERR.puts "[@]"+ep1.to_s+"/"+ep2.to_s+"/"+p1.to_s+"/"+p2.to_s
          
          STDERR.puts (ep1==p1 && ep2==p2)
          
          ep1==p1 && ep2==p2
      end
      STDERR.puts "after:"
      STDERR.puts edges
   end
   def reset
       @cost = $max_cost
       @done = false
   end
end

class Edge
    attr_accessor :toId,:cost
    def initialize(toId,cost)
        @toId,@cost = toId,cost
    end
end

class Graph
    attr_accessor :nodes
    def initialize(args)
        @nodes = Hash.new
        args.each do |arg|
           from,to = arg[0],arg[1]
           construct(from,to)
       end
    end
    
    def construct(from,to)
        if ! @nodes.key? from then
            @nodes[from] = Node.new(from,$max_cost)
        end
        if ! @nodes.key? to then
            @nodes[to] = Node.new(to,$max_cost)
        end
        
        @nodes[from].addEdge(to,1)
        @nodes[to].addEdge(from,1)
    end
    
    def remove_edge(p1,p2)
        nodes.each do |id,node|
            node.remove_edge(p1,p2)
        end
    end
    def reset
        nodes.each do |id,node|
            node.reset
        end
    end
    
    def dijkstra(start)
        STDERR.puts "START:"+start.to_s # debug
        @nodes[start].cost = 0
        #n = @nodes[start]
        #STDERR.puts "N:"
        #STDERR.puts n
        
        count= 0
        loop do
            STDERR.puts "COUNT:"+count.to_s
            #STDERR.puts @nodes
            count+=1
            target = nil
            @nodes.each do |id,node|
                next if node.done
                if target.nil? then
                    target = node
                elsif target.cost > node.cost then
                    target = node
                end
            end
            
            break unless target
            #STDERR.puts "TARGET:"+target.id.to_s
            
            target.done = true
            target.edges.each do |edge|
                cost = target.cost + edge.cost
#STDERR.puts "[C]"+@nodes[edge.toId].cost.to_s
                if cost < @nodes[edge.toId].cost then
                    @nodes[edge.toId].cost = cost
                    @nodes[edge.toId].from = target.id
                end
            end
        end
        #STDERR.puts "NODES:" # debug
        #STDERR.puts @nodes # debug
    end
    
    def routes(start,goal)
        
        STDERR.puts "ST:"+start.to_s+",GL:"+goal.to_s
        
        route = Array.new
        route << goal
        
        current = goal
        loop do
            STDERR.puts "cur:"+current.to_s
            route << @nodes[current].from
            break if current == start
            current = @nodes[current].from
        end
        route
    end
        
end

# N: the total number of nodes in the level, including the gateways
# L: the number of links
# E: the number of exit gateways
$N, $L, $E = gets.split(" ").collect {|x| x.to_i}
STDERR.puts "N:"+$N.to_s+",L:"+$L.to_s+",E:"+$E.to_s

data=Array.new
$L.times do
    # N1: N1 and N2 defines a link between these nodes
    $N1, $N2 = gets.split(" ").collect {|x| x.to_i}
    STDERR.puts "N1:"+$N1.to_s+",N2:"+$N2.to_s
    data.push [$N1,$N2]
end

EIs = Array.new
$E.times do
    $EI = gets.to_i # the index of a gateway node
    STDERR.puts "EI:"+$EI.to_s
    EIs << $EI
end

STDERR.puts data
# game loop
#i=16

graph = Graph.new(data)

loop do
    $SI = gets.to_i # The index of the node on which the Skynet agent is positioned this turn
    STDERR.puts "SI:"+$SI.to_s
    
    routes_min = nil
    EIs.each do |ei|
        graph.reset
        graph.dijkstra($SI)
        routes = graph.routes($SI,ei)
        routes_min = routes if routes_min.nil?
        if routes_min.length > routes.length then
            routes_min = routes
        end
        STDERR.puts routes[0].to_s+"/"+routes[1].to_s
    end
    
    len = routes_min.length
    STDERR.puts routes_min[len-2].to_s+"|"+routes_min[len-3].to_s
    
    puts routes_min[len-2].to_s+" "+routes_min[len-3].to_s
    
    graph.reset
    graph.remove_edge(routes_min[len-2],routes_min[len-3])
    
    
    # Write an action using puts
    # To debug: STDERR.puts "Debug messages..."
    
    #puts "0 1" # Example: 0 1 are the indices of the nodes you wish to sever the link between
    #puts "1 2"
    
    #if (i%10)==0 then
    #    puts "0 10"
    #else
    #    puts "0 "+(i%10).to_s
    #end
    #i-=1
    
end

