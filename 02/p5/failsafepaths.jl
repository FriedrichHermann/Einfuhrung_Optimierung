using JuMP, GLPK
using Cairo, Fontconfig
using GraphPlot, Graphs
using Plots

model = Model(GLPK.Optimizer)

set_optimizer_attribute(model, "msg_lev", GLPK.GLP_MSG_ALL)

n = 16
nodes = 0:n-1 # s entspricht 0, t entspricht n-1
arcs = [[0,1],[0,2],[0,3],[0,4],[0,5],[1,12],[1,13],[2,4],[2,13],[3,13],[4,6],[4,7],[5,6],[6,7],[6,13],[7,14],[8,15],[8,10],[9,15],[10,15],[11,15],[12,15],[13,11],[13,7],[14,8],[14,9],[14,10],[14,11]]

# Variablen
@variable(model, 1>=x[arcs]>=0)
@variable(model, F)

# Nebenbedingungen
constraints=Dict() # s entspricht 0, t entspricht n-1
constraints[0] = @constraint(model, sum(x[a] for a in arcs if a[1]==0)-sum(x[a] for a in arcs if a[2]==0)-F==0)
constraints[n-1] = #...
for i in 1:n-2
    #...
end

# Zielfunktion

# Optimieren

# Visualisieren
#dualSols = Dict(k=>JuMP.dual(v) for (k,v) in constraints if JuMP.dual(v)>0)
#g = DiGraph([[i,j] in arcs ? 1 : 0 for i in nodes,j in nodes])
#membership = [n in keys(dualSols) ? 2 : 1 for n in nodes]
#nodecolor = [colorant"lightseagreen", colorant"orange"]
#nodefillc = nodecolor[membership]
#gplot(g, nodefillc=nodefillc, nodelabel=[["s"];1:n-2;["t"]])

# Alternative, falls "gplot" keine Ausgabe erzeugt:
#gplothtml(g, nodefillc=nodefillc, nodelabel=[["s"];1:n-2;["t"]])