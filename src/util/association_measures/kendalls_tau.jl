module KendallsTau

  # comparator to sort by x,y pairs
  function twokeylt(x::Array{Float64}, y::Array{Float64} )
    if x[1] != y[1]
      return x[1] < y[1]
    else
      return x[2] < y[2]
    end
  end 

  function mergeandbubblecount!(data::Array{Array{Float64,1},1}, start::Int64, stop::Int64 ) 
    #println( replace(replace( string(" start: ", start, " stop: ", stop, " data: " , data), "\n\n", "-"),"\n",",") )
    temp = Array(Array{Float64,1}, (stop-start+1))
    i = start
    j = convert(Int64, floor(((stop+start)/2)+1))
    counter = 1
    nswaps = 0 
    while ( i <= convert(Int64, floor((stop+start)/2) )  ) && (j <= stop )
      #println(string("i=", i, " j=", j, " counter=", counter) ) 
      #right side is out of order
      if data[j][2] < data[i][2]
        #copy the right data to the temp array
        temp[counter] = data[j]
        counter+=1
        #add the number of bubble swaps you wouldve needed
        nswaps += ( j - i  )
        #move the pointer
        j+=1
        #merge the last element in if sort is done
        if j > stop 
          temp[counter:(stop-start+1)] = data[i:convert(Int64, floor((stop+start)/2))]
        end
      else 
        #copy the left data to the temp array
        temp[counter] = data[i]
        counter+=1
        #move the pointer
        i +=  1
        #merge the last element in if sort is done
        if i > floor((stop+start)/2) 
          temp[counter:(stop-start+1)] = data[j:stop]
        end
      end
    end
    #println( replace(replace( string(data[start:stop], " : ", temp), "\n\n", "-"),"\n",",") )
    data[start:stop]=temp
    #println( replace(replace( string("to: ",data[start:stop]), "\n\n", "-"),"\n",",") )
    return nswaps
  end   
  
  function sortandbubblecount!(data::Array{Array{Float64,1},1}, start::Int64, stop::Int64)
    # merge sorts data by second key and returns a count of bubble steps needed to do so   
    if start==stop
      return 0
    end
    
    # Conquer
    left_count = sortandbubblecount!(data, start, convert(Int64, floor( ((stop+start)/2) )) )
    right_count = sortandbubblecount!(data, convert(Int64, floor( ((stop+start)/2)+1)), stop )

    # Merge 
    this_count = mergeandbubblecount!(data, start, stop)  

    return left_count + right_count + this_count
  end

  function kendallstau(x::Array{Float64,1}, y::Array{Float64,1})
    data = Array{Float64,1}[ [x[i], y[i] ]  for i in 1:length(x)]

    #calculate denominator
    num_pairs = (length(x)*(length(x)-1.0)/2.0  )

    #initially sort the arrays
    sort!(data, lt=twokeylt )
    
    #count num ties on the left
    x_ties = 0
    x_and_y_ties = 0
    for i in 1:(length(data)-1)
      if data[i][1] == data[i+1][1]
        x_ties += 1
        if data[i][2] == data[i+1][2]
          x_and_y_ties += 1
        end
      end
    end

    # numerator: conordant - disconcordant
    # (n C 2)  = c + d + t
    # c - d = (n C 2) - t -2d 
    # t = num pairs over all x=x tie groups + same over y=y minus the overlap (set intersection)
    # d: sort the data by the key x, then
    # count how many swaps need to be made on the key y to be bubble sorted
    # PROBLEM: bubble sort is O(n2), we could actually just count c and d if we use that algorithm
    # SOLUTION: can compute the number of bubble sort swaps necessary 

    d = sortandbubblecount!(data, 1, length(data))
    
    #count num ties on the right
    y_ties = 0
    for i in 1:(length(data)-1)
      if data[i][2] == data[i+1][2]
        y_ties += 1
      end
    end

    return (num_pairs - x_ties -y_ties + x_and_y_ties - 2*d)/num_pairs

  end

  export kendallstau

end

