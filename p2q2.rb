# Team ID: <replace with GxTy>
# Team Member Name 1: <replace with name>
# Team Member Name 2: <replace with name>

# Project 2 q2
load "p2_utility.rb"
include Math

def find_shortest_path matrix, last_col_indx, distance, origin, dest, acc
  if origin == dest
    return acc  + [dest]
  end
  shortest_path = nil
  shortest_distance = distance
  distance_for_path_so_far = get_distance(matrix, acc)
  0.upto(last_col_indx) do |col|
    #skip node if we visited already
    unless acc.include?(col)
      unless matrix[origin][col].nil?
        if shortest_distance.nil? || (shortest_distance > distance_for_path_so_far) #skip paths that already longer than shortest distance found so far
		  #find origin change to col
          path  = find_shortest_path matrix, last_col_indx, shortest_distance, col, dest, acc + [origin]
          unless path.nil?
            found_distance = get_distance(matrix, path)
            unless found_distance.nil?
             if shortest_distance.nil? || (found_distance < shortest_distance)
                shortest_path = path
                shortest_distance = found_distance
             end
            end
          end
        end
      end
    end
  end
  shortest_path
end
# TODO: Fill up this method
def find_way(matrix, origin, dest)
  return find_shortest_path matrix, matrix.length - 1, nil, origin, dest, []
end

# You can call the test method to check if your find_way method works correctly
#   file_name: name of file in data folder to read from (e.g.: "g_10.csv")
#   origin: node ID of origin node (e.g.: 0)
#   dest  : node ID of destination node (e.g.: 50). The origin and dest should be different.
# call this method like this: test("g_10.csv", 0, 50)
def test(file_name, origin, dest)

  adj_matrix = get_adj_matrix(file_name) # to be populated from CSV

  # uncomment this if you want to check the contents of adj_matrix
  #adj_matrix.each{|x| puts x.inspect}

  number_of_nodes = adj_matrix.length

  # check that origin and dest are valid
  if origin < 0 or origin >= number_of_nodes
    puts "Error : Origin should be between 0 and #{number_of_nodes-1} (inclusive)"
    return
  elsif dest < 0 or dest >= number_of_nodes
    puts "Error : Dest should be between 0 and #{number_of_nodes-1} (inclusive)"
    return
  elsif origin == dest
    puts "Error : Origin should not be the same as dest."
    return
  end

  # perform your magic
  adj_matrix_clone = Marshal.load(Marshal.dump(adj_matrix)) # create a clone of adj_matrix, just in case your find_way method changes it
  startTime = Time.now
  answer = find_way(adj_matrix_clone, origin, dest)
  puts "Execution time: #{Time.now - startTime} seconds." # display time lapsed
  puts

  # print your answer
  puts "Your shortest path :" + answer.inspect

  # basic checks
  if answer.first != origin
    puts "Error : the first node in your path does not match the origin"
  elsif answer.last != dest
    puts "Error : the last node in your path does not match the destination"
  else # show distance
    distance = get_distance(adj_matrix, answer)
    puts "Distance of your path : #{distance}"
  end
end
