
using JuMP, GLPK

model = Model(GLPK.Optimizer)

set_optimizer_attribute(model, "meth", GLPK.GLP_DUAL)
set_optimizer_attribute(model, "msg_lev", GLPK.GLP_MSG_ALL)

# Define variables

# Add Constraints

# Define objective function

# Optimize

# Print Solution
