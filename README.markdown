Q2. The way finding function should identify the **shortest path from an
origin node to a destination node**. For this function, we ***do not
need to consider node value or node touring time***; instead, we are
only interested in the **travel time between nodes**.

Requirements:

-   Write a method called **find\_way** that takes 3 arguments, and
    > **returns an array of node sequence that corresponds to the
    > shortest path**.

> **find\_way(adj\_matrix, origin, dest)**

-   **adj\_matrix**: a 2D array storing edge travel times between any
    two nodes in the graph; **adj\_matrix\[i\]\[j\]** is the travel time
    from node **i** to node **j**. If it’s not possible to directly
    travel from **i** to **j**, **adj\_matrix\[i\]\[j\]** will be set to
    **nil** to represent ∞.

-   **origin**: the origin node ID.

-   **dest**: the destination node ID.

> This method should return an array of nodes representing the sequence
> of nodes that corresponds to the shortest path connecting the origin
> and destination (both origin and destination should also be in the
> returned array). In the event that there is no path connecting the
> origin and destination, your method should return **nil**.

For example, for the graph in Figure 2, the **adj\_matrix** is defined
as:

|       | **0** | **1** | **2** | **3** | **4** | **5** | **6** | **7** | **8** | **9** |
|-------|-------|-------|-------|-------|-------|-------|-------|-------|-------|-------|
| **0** | ∞     | 3     | 10    | 7     | 8     | ∞     | ∞     | ∞     | ∞     | ∞     |
| **1** | 3     | ∞     | ∞     | ∞     | 6     | ∞     | 9     | 5     | ∞     | ∞     |
| **2** | 10    | ∞     | ∞     | 5     | ∞     | ∞     | ∞     | ∞     | ∞     | ∞     |
| **3** | 7     | ∞     | ∞     | ∞     | 4     | 5     | ∞     | ∞     | ∞     | ∞     |
| **4** | 8     | 6     | ∞     | 4     | ∞     | 3     | 4     | ∞     | ∞     | 5     |
| **5** | ∞     | ∞     | ∞     | 5     | 3     | ∞     | ∞     | ∞     | ∞     | 7     |
| **6** | ∞     | 9     | ∞     | ∞     | 4     | ∞     | ∞     | 6     | 8     | 6     |
| **7** | ∞     | 5     | ∞     | ∞     | ∞     | ∞     | 6     | ∞     | 11    | ∞     |
| **8** | ∞     | ∞     | ∞     | ∞     | ∞     | ∞     | 8     | 11    | ∞     | 3     |
| **9** | ∞     | ∞     | ∞     | ∞     | 5     | 7     | 6     | ∞     | 3     | ∞     |

Suppose the origin is node **0** and the destination is node **8**, the
returned shortest path sequence should be: **\[0, 4, 9, 8\]**, with path
length equaling 16 time units.

You are given the following files for this exercise:

| File name                 | Description                                                                         | Comments                                                                                                                                                                                                                                                         |
|---------------------------|-------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **p2q2.rb**               | Contains the **find\_way** method that you will write.                              
                                                                                                                  
                             Also contains a **test** method that you can use to test your **find\_way** method.  | You need to modify and submit this file. This is the only file that you may submit. Do not modify the file name or the method signature of **find\_way** in the file.                                                                                            |
| **p2\_utility.rb**        | Contains accessory methods.                                                         | Do not submit this file.                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                   You may use **get\_distance** that can be found here.                                                                                                                                                                                                             |
| **data/g\_&lt;?&gt;.csv** | CSV files that represent graphs that can be used by **test**.                       | The first line in this CSV file indicates the number of nodes in this graph. (Node IDs will always start from 0, and continue sequentially. e.g. a 10-node graph will have nodes with IDs 0, 1, 2… 9.) Each subsequent line contains information in this format: 
                                                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                   nodeX, nodeY, dist betw nodes in time units                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                   The distance between 2 nodes is always the same regardless of whether one is travelling from the first node to the second, or vice versa.                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                   This CSV file will be read and constructed into an **adj\_matrix** array and passed into the **find\_way** method.                                                                                                                                                
                                                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                   | File name   | Node num | Comments              |                                                                                                                                                                                                                
                                                                                                                   |-------------|----------|-----------------------|                                                                                                                                                                                                                
                                                                                                                   | g\_10.csv   | 10       | Graph shown in fig 2. |                                                                                                                                                                                                                
                                                                                                                   | g\_100a.csv | 100      | Low density           |                                                                                                                                                                                                                
                                                                                                                   | g\_100b.csv | 100      | Medium density        |                                                                                                                                                                                                                
                                                                                                                   | g\_500a.csv | 500      | Low density           |                                                                                                                                                                                                                
                                                                                                                   | g\_500b.csv | 500      | Medium density        |                                                                                                                                                                                                                |

Your task:

-   Edit **p2q2.rb** provided to meet the requirements. Ensure that your
    solution works correctly with **g\_10.csv**

Assessment:

-   You will be graded for correctness and time taken. There will always
    be only one correct shortest distance, but there could be more than
    one correct path that results in that shortest distance.

**Q3 \[20 marks\] Tour Planning**

The tour planning function should recommend a sequence of attraction
nodes to visit, with the objective of maximizing collected node values,
yet subject to the time limitation. More specifically, given a pair of
origin and destination nodes and the limit on the total time a user can
spend, this function should return an array of nodes that represents the
recommended tour. Note that all nodes in the array, except for the
origin and the destination nodes, will be visited and incur touring
times to receive node values. Also note that a node should appear at
most once in the returned array. The only exception is the situation
whereby the origin node is the same as the destination node, in which
case that origin/destination node is visited twice to form a circular
path.

Requirements:

-   Write a method called **plan\_tour** that takes 6 parameters and
    > returns an array of nodes representing the recommended tour.

> **plan\_tour(adj\_matrix, node\_values, node\_times, origin, dest,
> time\_limit)**

-   **adj\_matrix**: the same as defined in Q2.

-   **node\_values**: an array storing values for all nodes. (e.g.
    **\[7, 1, 0, 2\]** means that the values for nodes 0, 1, 2 and 3 are
    7, 1, 0 and 2 respectively.)

-   **node\_times**: an array storing touring time for all nodes. (e.g.
    **\[3, 6, 4, 4\]** means that the touring times for nodes 0, 1, 2
    and 3 are 3, 6, 4 and 4 time units respectively.)

-   **origin**: the origin node ID.

-   **dest**: the destination node ID.

-   **time\_limit**: the maximum amount of time the user can spend
    before reaching destination. The total time taken on your
    recommended tour includes both the (i) touring time at each node in
    your path, NOT counting the touring time at the origin and
    destination nodes, and (ii) travelling time between nodes in
    your tour. This total time should not exceed **time\_limit**.

> The function should return an array of node IDs representing the
> sequence of nodes that corresponds to the recommended tour (both
> origin and destination should also be in the returned array). Like Q2,
> in the event where there is no path connecting the origin and
> destination, or no path that satisfies the **time\_limit** (meaning
> that it is impossible to recommend a tour), your method should return
> **nil**.

You are given the following files for this exercise:

| File name                  | Description                                                                          | Comments                                                                                                                                                                                                                |
|----------------------------|--------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **p2q3.rb**                | Contains the **plan\_tour** method that you will write.                              
                                                                                                                    
                              Also contains a **test** method that you can use to test your **plan\_tour** method.  | You need to modify and submit this file. This is the only file that you may submit. Do not modify the file name or the method signature of **plan\_tour** in the file.                                                  |
| **p2\_utility.rb**         | Contains accessory methods.                                                          | Do not submit this file.                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                                              
                                                                                                                     You may use **get\_time** and **get\_value** that can be found here.                                                                                                                                                     |
| **data/g\_&lt;?&gt;.csv**  
                             
 **data/vt\_&lt;?&gt;.csv**  | CSV files that represent graphs that can used by **test**.                           | **vt\_10.csv** contains data about the values and touring times at each node for a 10-node graph, and can be used with any 10-node graph (e.g. **g\_10.csv**). **vt\_100.csv** can be used with any 100-node graph etc. 
                                                                                                                                                                                                                                                                                                                                              
                                                                                                                     Format of **vt\_&lt;?&gt;.csv**:                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                              
                                                                                                                     node ID, value, touring time                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                              
                                                                                                                     These CSV files will be read and constructed into **adj\_matrix**, **node\_values** and **node\_times**, and passed into your **plan\_tour** method.                                                                     
                                                                                                                                                                                                                                                                                                                                              
                                                                                                                     Other CSVs that represent larger graphs are provided.                                                                                                                                                                    |

Your task:

-   Edit **p2q3.rb**

-   Submit a PDF/Word file containing up to ONE page describing
    your algorithm.

Assessment:

-   You will be graded for correctness and time taken. Your solution is
    considered “correct” if:

1.  the **time\_limit** for your recommended tour is not exceeded, and

2.  your tour begins and ends at the given origin and destination nodes,
    and

3.  your tour is a valid one (the nodes in the recommended sequence
    are connected)
