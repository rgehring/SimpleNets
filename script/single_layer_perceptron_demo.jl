using SimpleNets

#Simulate a data set

#Apply single layer perceptron learning to the dataset
p = SimpleNets.SingleLayerPerceptron.Perceptron(3)

steps = 50
batch_size = 10

all_x = Array(Array{Float64}, steps*batch_size)
all_x[ 1:steps*batch_size ]  = [rand(3) for k in 1:(steps*batch_size)]

all_y = Array(Float64, steps*batch_size)
counter=1
for example in all_x
  all_y[counter] = convert(Float64, (3*example[1]+example[2] - example[3] -2 ) > 1 )
  counter += 1
end

all_goodness = Array(Float64, steps)
step=1
while step < steps

  #Train the model
  counter = (step-1)*batch_size + 1
  for example in all_x[((step-1)*batch_size+1):(step*batch_size)]
    SimpleNets.SingleLayerPerceptron.train!(p, example, all_y[counter] )
    counter += 1
  end

  #Validate the score, print a goodness metric
  scores = Array(Float64, steps*batch_size)
  counter = 1
  for example in all_x
    scores[counter] = SimpleNets.SingleLayerPerceptron.score(p, example)
    counter += 1
  end

  #hopefully the goodness gets better as you train.
  goodness = SimpleNets.AssociationMeasures.kendallstau(all_y, scores)
  all_goodness[steps] = goodness
  println(string("step: " , step, " goodness: ", goodness))
  
  step += 1 

end


