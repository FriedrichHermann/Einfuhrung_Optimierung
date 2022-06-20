#import Pkg
Pkg.add("Plots")

using JuMP, GLPK
include("plot_avocados.jl")

#Daten
x = [0.7181605285383736, 0.08764583609329546, 0.6873377713321047, 0.8692837347783728, 0.10688426069040857, 0.9562476655606642, 0.36752395902154866, 0.08713753089405563, 0.32435838047848553, 0.8728888866488402, 0.9893527802110371, 0.3473504998822199, 0.1582294984875201, 0.5609875639400048, 0.5739010929250554, 0.3319930016127923, 0.15504597405512444, 0.397091005361379, 0.555747887449981, 0.6436380738371807]
y = [0.21457607046602512, 0.5733232848600001, 0.2727469792832373, 0.8889074369683123, 0.6987221796438585, 0.7566706450735956, 0.9707642938059458, 0.0788691060067368, 0.6622743679320247, 0.8869902547533794, 0.3516292880656171, 0.8013897305503865, 0.738718955279899, 0.22961152754523018, 0.37144642988617416, 0.8982668841507324, 0.5840582720369314, 0.512163423757648, 0.9187036809697926, 0.2721054227038202]
good = [true, false, true, true, false, true, false, false, false, true, true, false, false, true, true, false, false, false, false, true]

n = length(x)

avocados = [Dict("x"=>x[i],"y"=>y[i],"good"=>good[i]) for i in 1:n]

model = Model(GLPK.Optimizer)
set_optimizer_attribute(model, "msg_lev", GLPK.GLP_MSG_ALL)

#Variablen
@variable(model, 1.0>=a[1:2]>=-1.0)
@variable(model, beta[1:2])#(beta+,beta-)

#Nebenbedingungen
for p in avocados
    if p["good"] == true
        @constraint(model, p["x"]*a[1]+p["y"]*a[2]<=beta[1])
    else 
        @constraint(model, p["x"]*a[1]+p["y"]*a[2]>=beta[2])
    end
end
#Zielfunktion
@objective(model, Max, beta[2]-beta[1])

JuMP.optimize!(model)

#Lösung

a_val = JuMP.value.(a)
beta_val = JuMP.value.(beta)

plot_avocados(avocados, a_val, beta_val)