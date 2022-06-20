isdir("plots") || mkdir("plots")

using Plots

function plotRegression(a,k,val,x,y,it_helper,cost_helper;plot_interval=1)
    append!(it_helper,k)
    append!(cost_helper,val)
    if k%plot_interval==0
        d=length(a)
        p=scatter(x,y, legend=false)
        x2=0:1:12
        if d==2
            y2=[a[1]+a[2]*j for j in x2]
        else
            y2=[a[1]+a[2]*j+a[3]*j^2 for j in x2]
        end
        xlims!(0,12)
        ylims!(0,10)
        plot!(p,x2,y2)
        savefig(p, "plots/$k"*".png")
    end
end