"""
Julia introduction
--------------------------------------------------------
Execute code lines/blocks by pressing shift+enter.
See what every block does.
There are some errors in the code to show what not to do.
Keep in mind that julia executes everything in order,
so changes that you make are permanent. In order to
start clean again, stop julia and start it again."""

using Printf #add standard module

@printf("Hello %s!","world") #formatted print

#Basic arithmetic
pi+2 #addition
3*5 #multiplication
7-3 #subtraction
6/4 #division
5÷3 #integer division
2^10 #exponentiation
5%3 #remainder

#Comparisons
5<=7 #less than or equal
(8<9) && (3>=2) #and
(8<9) && ~ (2==2) #and, not
(8>9) || (2==3) #or

#variable assignment and formatted print
a = 5
b = 3
@printf("The value of a*b is %i",a*b)

#iterables
typeof(1:2:10)
Vector(1.5:2.5:10)
Vector(1:2:9)
Vector(10:-1:1)

#vectors
v = [6,5,4,-2]
typeof(v)
length(v)
v[1]
v[2.1]
v[4]=2
3 in v
append!(v,1)
insert!(v,4,3)
v[1:2:5]

#matrix and vector calculations
A = [-1 1; 2 1]
b = [0, 3]
A*b #matrix multiplication
A\b #solve system of linear equations

#tuples
t = (1,"two",3.0)
typeof(t)
3 in t
"three" in t
t[1]="one"

#sets
s = Set([1,3,4,5])
union!(s,[2,3,5])
intersect(Set([1,2,3]),Set([3,4,5]))

#dictionaries
d = Dict("name"=>"Hella Wahnsinn","office"=>"2021")
haskey(d,"name")
d["name"]
d["position"]="Wasserrutschen-Testerin"
d

#conditionals
a = 5
if a>=7
    println("a is large") #print a separate line containing text
elseif a<=2
    println("a is small")
else
    println("a is neither large nor small")
end

#loops
i=1
while i <= 10
    @printf("%i*7=%i\n",i,i*7)
    i+=1
end

for entry in d
    println(entry)
end

squares = [i^2 for i in 1:6]
gap = [i for i in 1:10 if (i<=3)|(i>6)]

#functions
function greet(name="Sir/Madam")
    @printf("Hey, %s! How are you?",name)
end
greet("Stefan")
greet()

function f(x)
    return x .^ 2 .+ 1
end
f(5)
f([1 2;3 4])

function solveSysOfLinEqs(A::Array{Int64,2},x::Vector{Int64})
    return A\x
end
solveSysOfLinEqs(1,2)
solveSysOfLinEqs([1 2 3;1 -1 1;0 0 1],[0,6,3])

function g(x)
    y = x + 1
    z = x - 1
    return y,z
end
t1, t2 = g(4)
t3, t4, t5 = g(2)

import files
include("fancyFunction.jl")
fancyFunction()


M = [1 0 3;1 -2 0;1 -2 1]
det(M)
using LinearAlgebra
det(M)
