using Plots

function plot_avocados(avocados,a_val,beta_val)
    append!(beta_val,(beta_val[1]+beta_val[2])/2)#mittlere Hyperebene
    x2=0:0.0001:1
    y2=[[(beta-a_val[1]*j)/a_val[2] for j in x2] for beta in beta_val]#transformiere (a,beta) zu (x,y)-Koordinaten
    
    p=scatter([a["x"] for a in avocados], [a["y"] for a in avocados], legend=false, color=[avocados[i]["good"] ? "light green" : "green" for i in 1:length(avocados)])#plotte Avocados
    plot!(p,x2,y2,color="red",line=reshape([:dash,:dash,:solid],1,3))#plotte Hyperebenen
    xlabel!("Zeit")
    ylabel!("Qualität")
    xlims!(0,1)
    ylims!(0,1)
end´