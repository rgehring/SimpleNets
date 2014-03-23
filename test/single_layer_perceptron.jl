#SingleLayerPerceptron unit testing
@test SimpleNets.SingleLayerPerceptron.score(SimpleNets.SingleLayerPerceptron.Perceptron(3), [1.0, 2.0, 3.0 ]) ==  (1/(1+exp(-2.0)))

