using Plots

include("gradmethod.jl")
include("linreg.jl")
include("quadreg.jl")
include("plotRegression.jl")

input_x = [0.0,0.0,1.0,1.0,1.0,2.0,2.0,3.0,3.0,3.0,3.0,4.0,4.0,5.0,7.0,7.0,7.0,8.0,9.0,10.0,10.0,10.0,10.0,12.0]

# lineare Daten
input_y = [1.6012866526220741, 1.5015376064319177, 2.851600577105896, 2.111696247956223, 2.9764020687865913, 3.3513113434886304, 3.59942475577427, 3.7235097833249995, 3.5148055602096, 3.66014747036617, 4.113504400683124, 3.9291700954259703, 3.9872257751936977, 4.868183059169645, 6.198596375207833, 6.26128996643533, 6.241403529293983, 6.951061112358586, 7.240241388431202, 7.82575098187948, 8.211298593166383, 7.933139590064186, 7.561161955940313, 9.24551524498352]
# quadratische Daten
#input_y = [1.5099938408279896, 1.1905379955388784, 3.381986283362724, 2.468133048550598, 2.9937073323460357, 4.321814974937679, 3.948252788158622, 5.297678179401629, 5.428747057511505, 5.447214441519653, 4.787326966723671, 5.702874194138286, 6.174847311389847, 6.7040827822186095, 7.0750669485151345, 7.174479384891915, 7.025297089870345, 7.337909194083374, 7.35369033240457, 6.981088864739032, 6.625168331422831, 6.68303356289051, 6.0447379343767755, 4.673375741732041]

# linearer (2d) Startpunkt
xs = [1.0,-10.0]
# quadratischer (3d) Startpunkt
#xs = [2.0,2.0,2.0]

# temporäre Daten zum Plotten
it_helper = []
cost_helper = []

# Probleminstanziierung
nlp = LinReg(input_x,input_y)
intermediate_callback(y, k, val) = plotRegression(y,k,val,input_x,input_y,it_helper,cost_helper;plot_interval=10)
gradmethod(nlp, xs; tol=1e-2, itmax=1000000,intermediate_callback=intermediate_callback)

# Plot für Iterationen/Kosten
plot(it_helper,cost_helper,legend=false,yaxis=:log)