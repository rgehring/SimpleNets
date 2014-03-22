module SingleLayerPerceptron
  include( "../util/validations.jl" )
  HELP = "Single layer perceptron, offers train, score, and validate public methods"
  
  type NeuralNetwork
    initial_weight_function::Function
    learning_rate::Float64
    bias_term::Bool
    activation_function::Function
    weights::Array{Float64}
  
    #validations
    function NeuralNetwork(initial_weight_function, learning_rate, bias_term, activation_function, weights)
      if !Validations.isMonotonic(activation_function)  
        error("nonmonotonic activation function supplied to instantiate neural net" )
      end
    end
  end

  function score(nn, x)
  end

  #PUBLIC API
  export HELP

end

