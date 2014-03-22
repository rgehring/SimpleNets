using SimpleNets
using Base.Test  

# write your own tests here
@test 1 == 1

println("Test SingleLayerPerceptron has been included")
@test SimpleNets.SingleLayerPerceptron.HELP == "Single layer perceptron, offers train, score, and validate public methods"


