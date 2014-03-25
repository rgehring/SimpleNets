module SingleLayerPerceptron
  include( "../util/validations.jl" )
  HELP = "Single layer perceptron, offers a Perceptron type with train, score, and validate public methods"
  
  invlogit(x) = 1 / (1 + exp(-x))
  
  type Perceptron
    #public attributes
    activation_function::Function
    bias::Float64
    bias_term::Bool
    weights::Array{Float64}
    learning_rate::Float64
    
    # constructor validations
    function Perceptron( activation_function, bias, bias_term, weights, learning_rate)
      if !Validations.isMonotonic(activation_function)  
        error("nonmonotonic activation function supplied to instantiate perceptron" )
      end
      return new(activation_function, bias, bias_term, weights, learning_rate )
    end
  end
  Perceptron(n::Int64) = Perceptron(invlogit, 0.0, true, fill!(Array(Float64, n), 1.0/n), 0.001 )
  
  # PUBLIC API IMPLEMENTATION 
  function score(nn::Perceptron, x::Array{Float64})
    #weights dot with x
    if nn.bias_term
      return nn.activation_function( dot(nn.weights,x ) + nn.bias )
    else
      return nn.activation_function( dot(nn.weights,x )  )
    end
  end
  
  function train!(nn::Perceptron, x::Array{Float64}, y::Float64 )
    #Simple gradient descent
    nn.weights += nn.learning_rate*(y-score(nn,x))*x
    if nn.bias_term
      nn.bias += nn.learning_rate*(y-score(nn,x))
    end
  end

  # PUBLIC API  
  export HELP, Perceptron, train, score
 

end

