  dedicate_g12.m <- function(P, C, M, L) {
  # create an LP model with 0 constraints (we will add constraints later) 
  # and N decision variables - for N different bond prices
  pcLP <- make.lp(0,length(P))
  
  # set objective coefficients
  set.objfn(pcLP, P)
  
  # set objective direction
  lp.control(pcLP,sense = 'min')
  
  # add the constraints
  for (i in 1:length(L)) {
    expectedInflow <- (!(M < i))*C + (M == i)*100
    # print(expectedInflow)
    add.constraint(pcLP, expectedInflow, "=", L[i])
  }
  
  # label the constraints and variables
  varNames = c()
  for (i in 1:length(P)) {
    varNames[i] <- paste("Bond",i)
  }
  
  constraintNames = c()
  for (i in 1:length(L)) {
    constraintNames[i] <- paste("Year",i)
  }
  dimnames(pcLP) <- list(constraintNames, varNames)
  
  # solve the model, if this return 0 an optimal solution is found
  solve(pcLP)
  
  # this return the proposed solution
  get.variables(pcLP)
}


# ----------
# Test Case
# ----------

# Input vectors

# Prices P
P <- c(102, 99, 101, 98, 98, 104, 100, 101, 102, 94)

# Coupon Rates C
C <- c(5, 3.5, 5, 3.5, 4, 9, 6, 8, 9, 7)

# Maturity M 
M <- c(1, 2, 2, 3, 4, 5, 5, 6, 7, 8)

# Liabilities for time t => L
L <- c(12, 18, 20, 20, 16, 15, 12 ,10)*1000

# Function Call
dedicate_g12.m(P, C, M, L)