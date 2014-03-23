
#Validations.isMonotonic acceptance tests
@test SimpleNets.Validations.isMonotonic( x -> 2*x ) 
@test !SimpleNets.Validations.isMonotonic( x -> -2*x ) 



