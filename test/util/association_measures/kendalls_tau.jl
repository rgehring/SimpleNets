include("../../../src/util/association_measures/kendalls_tau.jl")

# sortandbubblecount SORTS the data by column 2
data = Array{Float64,1}[ [1, 3],  [4, 2],  [5, 6], [7, 10], [9, 8]]
sorted_data = Array{Float64,1}[[4, 2],  [1, 3], [5, 6], [9, 8], [7, 10]]
bubble_swaps = KendallsTau.sortandbubblecount!(data, 1, 5)
@test data == sorted_data

#sortandbubblecount CORRECTLY MEASURES # bubble swaps needed
@test bubble_swaps == 2

#test the kendall's tau calculation
x = Float64[1,4,5,7,9]
y = Float64[3,2,6,10,8]
@test KendallsTau.kendallstau(x,y)==0.6


