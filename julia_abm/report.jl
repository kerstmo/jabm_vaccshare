
# create REPL output of variables of interest
println("===================================")

println(string("Run ", RUN, " :: Seed ", this_seed, " :: Iteration ", ITERATION))
println(" - - - - ")
println(string("Agents susceptible: ", get(STATETISTICS, "susceptible", -1 )))
println(string("Agents infected: ", get(STATETISTICS, "infected", -1 )))
println(string("Agents recovered: ", get(STATETISTICS, "recovered", -1 )))
println(" - - - - ")
println(string("Agents vaccinated: ", get(STATETISTICS, "vaccinated", -1 )))
println(string("Agents isolated: ", get(STATETISTICS, "hh_isolation", -1 )))
println(" - - - - ")
println(string("Cumulative infections: ", get(STATETISTICS, "cumInf", -1 )))
println(string("Vaccination share: ", round(get(STATETISTICS, "vaccinated", -1 )/POP_SIZE,digits=3), " [",round(lower_bound, digits=3), "::", round(upper_bound,digits=3), "]" ))
println(string("Proba < 1000: ", length(findall(cumInfCollector .< OUTBREAK_CAP))/length(cumInfCollector)))

println("===================================")
println(" ")
