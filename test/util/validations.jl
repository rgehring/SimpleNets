include("../../src/util/validations.jl")
#Validations.isMonotonic acceptance tests
@test Validations.isMonotonic( x -> 2*x ) 
@test !Validations.isMonotonic( x -> -2*x ) 



