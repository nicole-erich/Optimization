library(lpSolveAPI)


#create an LP model with 0 constraints (we will add constraints later) and 2 decision variables
modLP<-make.lp(0,10)

#set objective coefficients
set.objfn(modLP, c(102,99,101,98,98,104,100,101,102,94))

#set objective direction
lp.control(modLP,sense='min')

add.constraint(modLP,c(105,3.5,5,3.5,4,9,6,8,9,7), ">=",12000)
add.constraint(modLP,c(0,103.5,105,3.5,4,9,6,8,9,7), ">=",18000)
add.constraint(modLP,c(0,0,0,103.5,4,9,6,8,9,7), ">=",20000)
add.constraint(modLP,c(0,0,0,0,104,9,6,8,9,7), ">=",20000)
add.constraint(modLP,c(0,0,0,0,0,109,106,8,9,7), ">=",16000)
add.constraint(modLP,c(0,0,0,0,0,0,0,108,9,7), ">=",15000)
add.constraint(modLP,c(0,0,0,0,0,0,0,0,109,7), ">=",12000)
add.constraint(modLP,c(0,0,0,0,0,0,0,0,0,107), ">=",10000)

varNames <- c("X1","X2","X3","X4","X5","X6","X7","X8","X9","X10")
constraintNames <- c("Year1","Year2","Year3","Year4","Year5","Year6","Year7","Year8")
dimnames(modLP) <- list(constraintNames, varNames)

#solve the model, if this return 0 an optimal solution is found
solve(modLP)

#this return the proposed solution
get.objective(modLP)
get.variables(modLP)

