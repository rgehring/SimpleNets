module SimpleNets

  #SubModule File Includes
  include( "util/validations.jl" )
  include( "single_layer_perceptron/single_layer_perceptron.jl" )

  # Expose SubModule's Public API
  using .Validations
  using .SingleLayerPerceptron

end # module
