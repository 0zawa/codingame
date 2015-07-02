# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

class Node
    attr_accessor :id,:edges
    def initialize(id)
       @id = id
       @edges = Array.new
    end
    def addEdge(id_to)
        @edges << Edge.new(@id,id_to)
    end
    def traverse(nodes,from)
        max_cost = 0
        edges.each do |edge|
            next if edge.to == from
            if edge.cost > 0 then 
                cost = edge.cost
            else
                cost = nodes[edge.to].traverse(nodes,@id)
                edge.cost = cost
            end
            
            max_cost = [max_cost,cost].max
        end
        return max_cost+1
    end
    def getMaxCost
        max_cost = 0
        edges.each do |edge|
            max_cost = edge.cost if max_cost < edge.cost 
        end
        return max_cost
    end
end

class Edge
    attr_accessor :from,:to,:cost
    def initialize(from,to)
        @from = from
        @to     = to
        @cost   = -1
    end
end

class Graph
    attr_accessor :nodes
    def initialize
        @nodes = Hash.new
    end
    def addNode(id)
        if !@nodes.key?(id) then
            @nodes[id] = Node.new(id)
        end
   end
   def addEdge(id1,id2)
       @nodes[id1].addEdge(id2)
       @nodes[id2].addEdge(id1)
   end
   
   def traverse
        @nodes.each do |id,node|
            lv=node.traverse(self.nodes,id)
            STDERR.puts "lv:"+lv.to_s
        end
   end
   def getCost
       minCost = 1024*1024
       @nodes.each do |id,node|
            cost = node.getMaxCost
            minCost = [minCost,cost].min
        end
        return minCost
   end
end

graph = Graph.new

$n = gets.to_i # the number of adjacency relations
$n.times do
    # xi: the ID of a person which is adjacent to yi
    # yi: the ID of a person which is adjacent to xi
    $xi, $yi = gets.split(" ").collect {|x| x.to_i}
    graph.addNode($xi)
    graph.addNode($yi)
    graph.addEdge($xi,$yi)
end

graph.traverse
cost = graph.getCost

puts cost.to_s
# Write an action using puts
# To debug: STDERR.puts "Debug messages..."

#puts cost # The minimal amount of steps required to completely propagate the advertisement
