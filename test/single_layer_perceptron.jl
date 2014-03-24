include( "../src/single_layer_perceptron/single_layer_perceptron.jl")

#SingleLayerPerceptron unit testing
@test SingleLayerPerceptron.score(SingleLayerPerceptron.Perceptron(3), [1.0, 2.0, 3.0 ]) ==  (1/(1+exp(-2.0)))
