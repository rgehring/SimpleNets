module SimpleNets

  #SubModule File Includes
  include( "single_layer_perceptron/single_layer_perceptron.jl" )

  # Expose SubModule's Public API
  using .SingleLayerPerceptron

end # module
