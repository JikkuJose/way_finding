# p2_utility.rb
# Do not submit this file
# Do not modify this file as well. 

# reads a CSV file and returns an array of strings - each line in the CSV file as one string
def read_file(file)
	lines = IO.readlines(file)
	if lines != nil
		for i in 0 .. lines.length-1
			lines[i] = lines[i].sub("\n","")
		end
		return lines[0..lines.length-1]
	end
	return nil
end

# takes in file_name (CSV file) to read plane 
# used by Q1
def get_plane(file_name)
  a = []
  read_file("data/"+file_name).each{ |line|
    temp = line.chomp.split(",").map {|x| x.to_i }
    a << temp
  }
  return a
end

# used by Q1
# prints out in a nice grid an arrays of 1s and 0s with top marker and left marker
def print_plane(p)
  print "  "
  for i in 0...p[0].length # print top row of numbers
    print (i%10).to_s
  end
  puts
  
  for i in 0...p.length
    print (i%10).to_s + " "  # print leftmost number
    for j in 0...p[i].length
      print p[i][j].to_s # same cell content
    end
    puts # newline
  end 
  puts  
end

# used by Q1
# compares 2 arrays and prints out the grids with different cells marked by a dot
def print_plane_with_changed_cells(a, answer)
  # show changed cells
  
  print "  "
  for i in 0...a[0].length # print top row of numbers
    print (i%10).to_s
  end
  puts
  
  for i in 0...a.length
    print (i%10).to_s + " "  # print leftmost number
    for j in 0...a[i].length
      if (a[i][j] == answer[i][j])
        print a[i][j].to_s # same cell content
      else
        print "." # different cell content
      end
    end
    puts # newline
  end 
  puts  
end

# used by Q2
# reads from CSV file containing graph info and returns an adj matrix
def get_adj_matrix(file_name)
  lines = read_file("data/"+file_name)
  number_of_nodes = lines[0].to_i  # first line is number of nodes for this graph
  lines.shift # remove first line
  
  # create adj_matrix
  adj_matrix = Array.new(number_of_nodes){Array.new(number_of_nodes)}
  
  # process subsequent lines
  lines.each{ |line|
    temp = line.chomp.split(",").map {|x| x.to_i }
    origin_node_ID      = temp[0]
    destination_node_ID = temp[1]
    distance            = temp[2]
    
    # insert into adj_matrix (both ways)
    adj_matrix[origin_node_ID][destination_node_ID] = distance
    adj_matrix[destination_node_ID][origin_node_ID] = distance
  }
  return adj_matrix
end

# used by Q2
# returns the distance in a path (chain of nodes) in a graph
# you may use this method if desired. This method is available on the submission server
# adj_matrix is the adj matrix of a graph, path is an array of node IDs
# this method returns nil if there is a "disconnect" in path
def get_distance(adj_matrix, path)
  tot_distance = 0
  prev_node = path.first
  
  for i in 1...path.length
    current_node = path[i]
    distance = adj_matrix[prev_node][current_node]
    return nil if (distance == nil) # something is wrong in path. no connect between 2 nodes
    tot_distance += distance
    prev_node = path[i]
  end
  
  return tot_distance
end

# used by Q3
# returns the total time (touring time + travelling time) in a path (chain of nodes) in a graph
# EXCLUDING the touring time for the first and last nodes.
#
# you may use this method if desired. This method is available on the submission server
#
# adj_matrix is the adj matrix of a graph; node_times is a 1D array showing the touring time of each node; path is an array of node IDs
# this method returns nil if there is a "disconnect" in path, or if there is something wrong with node_times
def get_time(adj_matrix, node_times, path)
  tot_distance = 0
  prev_node = path.first # first node ID
  tot_touring_time = 0
  
  for i in 1...path.length
    current_node = path[i]
    
    # distance
    distance = adj_matrix[prev_node][current_node]
    return nil if (distance == nil) # something is wrong in path. no connect between 2 nodes
    tot_distance += distance
    
    # touring time
    touring_time = node_times[current_node]
    return nil if (touring_time == nil) # something is wrong ... missing value in node_times
    if (i!=path.length-1) # don't include touring time if we are dealing with last node
      tot_touring_time += touring_time
    end
    
    prev_node = path[i]
  end
    
  # return sum of travelling time and touring time in path
  return (tot_distance + tot_touring_time)
end

# used by Q3
# returns the total value of all nodes in a path (chain of nodes) in a graph
# EXCEPT the first and last nodes in the path (node values for the origin and destination
# are not counted).
#
# you may use this method if desired. This method is available on the submission server
# 
# adj_matrix is the adj matrix of a graph; node_values is a 1D array showing the values of each node; path is an array of node IDs
# this method does NOT check if the path is a valid path.
# this method returns nil if node_values or path is "faulty"
def get_value(node_values, path)
  tot_value = 0
  
  for i in 1..path.length-2  # exclude path[0] (1st node) and path[path.length-1] (last node)
    value = node_values[path[i]]
    return nil if (value == nil) # something is wrong in node_values or path
    tot_value += value
  end  
  
  return tot_value
end

# used by Q3
# reads from CSV file containing either node values or touring times and returns an array consisting of [values], [times]
def get_value_time(file_name)
  values = []
  times = []
  
  read_file("data/"+file_name).each{ |line|
    temp = line.chomp.split(",").map {|x| x.to_i }
    node_id      = temp[0]   # node ID
    node_value   = temp[1]   # value of this node
    touring_time = temp[2]   # touring time of this node
    
    values[node_id] = node_value
    times[node_id] = touring_time
  }
  return [values, times]
end
