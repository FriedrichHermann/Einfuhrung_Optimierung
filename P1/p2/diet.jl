using JuMP, GLPK
using Printf

#Daten
dishes = Dict(
        "Pasta"=>Dict("Preis"=>0.75, "Kalorien"=>208, "Eiweiß"=>6, "Kohlenhydrate"=>19, "Fett"=>12, "Zucker"=>1, "Salz"=>0.5),
        "Pizza"=>Dict("Preis"=>0.75, "Kalorien"=>211, "Eiweiß"=>8, "Kohlenhydrate"=>32, "Fett"=>15, "Zucker"=>4, "Salz"=>1),
        "Grill"=>Dict("Preis"=>1.25, "Kalorien"=>175, "Eiweiß"=>15, "Kohlenhydrate"=>9, "Fett"=>10, "Zucker"=>4, "Salz"=>0.7),
        "Wok"=>Dict("Preis"=>0.75, "Kalorien"=>120, "Eiweiß"=>2, "Kohlenhydrate"=>5, "Fett"=>7, "Zucker"=>2, "Salz"=>0.5),
        "Studitopf"=>Dict("Preis"=>0.33, "Kalorien"=>90, "Eiweiß"=>4, "Kohlenhydrate"=>15, "Fett"=>2, "Zucker"=>2, "Salz"=>0.5),
        "Fisch"=>Dict("Preis"=>1.0, "Kalorien"=>140, "Eiweiß"=>10, "Kohlenhydrate"=>2, "Fett"=>9, "Zucker"=>1.5, "Salz"=>0.3),
        "Salat"=>Dict("Preis"=>0.75, "Kalorien"=>100, "Eiweiß"=>2, "Kohlenhydrate"=>5, "Fett"=>7, "Zucker"=>4, "Salz"=>0.5),
        "Dessert"=>Dict("Preis"=>0.75, "Kalorien"=>160, "Eiweiß"=>4, "Kohlenhydrate"=>20, "Fett"=>8, "Zucker"=>18, "Salz"=>0.3),
        )
nutrition = Dict("Kalorien"=>Dict("min"=>700,"max"=>1000),
            "Eiweiß"=>Dict("min"=>30),
            "Fett"=>Dict("max"=>50),
            "Zucker"=>Dict("max"=>30),
            "Kohlenhydrate"=>Dict("min"=>80,"max"=>120),
            "Salz"=>Dict("max"=>3)
            )

model = Model(GLPK.Optimizer)
set_optimizer_attribute(model, "msg_lev", GLPK.GLP_MSG_ALL)
#Variablen

@variable(model, 4.0>= x[keys(dishes)] >= 0.0)


#Nebenbedingungen
for (k,v) in nutrition
    if "min" in keys(v)
        @constraint(model, sum([v2[k]*x[k2] for (k2,v2) in dishes])>= v["min"])#Summiere die Kalorienanzahl mit der Anzahl der gerichte gegeben durch x[k2] gegeben 
    end
    if "max" in keys(v)
        @constraint(model, sum([v2[k]*x[k2] for (k2,v2) in dishes])<= v["max"])
    end

end
@constraint(model, x["Salat"]>=1)

#Zielfunktion
@objective(model, Min, sum([v["Preis"]*x[k] for (k,v) in dishes]))#...

#Optimieren
JuMP.optimize!(model)

#Lösung
println(JuMP.value.(x))
println(JuMP.value(x["Salat"]))

for (k,v) in dishes
    @printf("%s %s\n",JuMP.value.(x[k]),k)
end

JuMP.value.(x)