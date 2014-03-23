module Validations

  function isMonotonic(toTest::Function)
    delta = 0.001
    x = 0.0
    y = toTest(x)
    while x < 1.0
      x += delta
      last_y = y
      y = toTest(x)
      if y < last_y
        return false
      end
    end
    return true
  end


  function kendallstau(x::Array{Float64}, y::Array{Float64})
    data = [x[i], y[i]  for i in 1:length(x)]

    # comparator to sort by x,y pairs
    function twokeylt(x::Array{Float64}, y::Array{Float64} )
      if x[1] != y[1]
        return x[1] < y[1]
      else
        return x[2] < y[2]
      end
    end 
    
    #calculate denominator
    num_pairs = (length(x)*(length(x)-1.0)/2.0  )

    #initially sort the arrays
    data.sort!(lt=twokeylt )
    
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

    function sortandbubblecount!(data, start, stop)
      # merge sorts data by second key and returns a count of bubble steps needed to do so   
      if start==stop
        return 0
      end
      
      # Conquer
      left_count = sortandbubblecount!(data, start, start-1+((stop-start)/2) )
      right_count = sortandbubblecount!(data, start+((stop-start)/2)+1, stop )

      # Merge 
      mergeandbubblecount!(data, start, stop)  

      return left_count + right_count + mergeandbubblecount(data, start, stop)
    end

    #calculate nc
    function mergeandbubblecount!(data, start, stop ) 
      temp = Array(Float64, (stop-start+1))
      i = start
      j = ((stop+start)/2)+1
      counter = 1
      nswaps = 0 
      while ( i <= (stop+start)/2 -1  ) && (j <= stop )
        #right side is out of order
        if data[j][2] < data[i][2]
          #copy the right data to the temp array
          temp[counter] = data[j]
          counter+=1
          #add the number of bubble swaps you wouldve needed
          nswaps += ( j - i + 1 )
          #move the pointer
          j+=1
        else 
          #copy the right data to the temp array
          temp[counter] = data[i]
          counter+=1
          #move the pointer
          i +=  1
        end
      end
      data[start:stop]=temp
      return nswaps
    end   

    d = sortandbubblecount(data, 1, length(data))
    
    #count num ties on the right
    y_ties = 0
    for i in 1:(length(data)-1)
      if data[i][2] == data[i+1][2]
        y_ties += 1
      end
    end

    return (num_pairs - x_ties -y_ties + x_and_y_ties - 2*d)/num_pairs

  end

   

end
