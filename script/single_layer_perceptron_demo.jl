using SimpleNets

#Simulate a data set

#Apply single layer perceptron learning to the dataset
p = SimpleNets.SingleLayerPerceptron.Perceptron(3);

steps = 0

while steps < 50

  #Suppose: y = 1 if 3x_1 + x_2 - x_3 -2 > 1
  x = [rand(3) for k = 1:100]

  #Train the model
  for example in x
    train!(p, example, convert(Float64, (3*example[1]+example[2] - example[3] -2 ) > 1 ) )
  end

  #Validate the score, print a goodness metric
  for example in x
    score(p, example)
  end

  println(goodness)

  steps += 1 

end
