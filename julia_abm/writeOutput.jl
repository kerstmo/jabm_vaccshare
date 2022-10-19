
# create output that can be analyzed afterwards, eg in R or similar

if init_output_writer == 0
    output_file = DataFrame([[], [], [], [], [], [], [], [], [], [], []],
            ["Run", "Seed", "Iteration", "Sus", "Inf", "cumInf", "Rec", "Iso", "Vac", "VacShare","ProbaLess1000"])
    global output_dir_name  = string("output_", Dates.today(), Dates.format(now(), "_HHMM"))
    mkdir(string(OUTPUT_LOCATION, "/", output_dir_name))
    CSV.write(string(OUTPUT_LOCATION, "/",output_dir_name,"/", "infections"), output_file)
    global init_output_writer = 1
end

next_row = DataFrame([[RUN], [this_seed], [ITERATION], [get(STATETISTICS, "susceptible", -1 )],
                        [get(STATETISTICS, "infected", -1 )], [get(STATETISTICS, "cumInf", -1 )],
                        [get(STATETISTICS, "recovered", -1 )], [get(STATETISTICS, "hh_isolation", -1 )],
                        [get(STATETISTICS, "vaccinated", -1 )],
                        [round(get(STATETISTICS, "vaccinated", -1 )/POP_SIZE,digits=3)],
                        [length(findall(cumInfCollector .< OUTBREAK_CAP))/length(cumInfCollector)]],
        ["Run", "Seed", "Iteration", "Sus", "Inf", "cumInf", "Rec", "Iso", "Vac", "VacShare", "ProbaLess1000"])


CSV.write(string(OUTPUT_LOCATION, "/",output_dir_name, "/", "infections"), next_row, append = true)


# the_list = []
# for i in household_id_list
#         push!(the_list, length(household_dict[i].member_ids))
# end
#
# list2 = Int16.(the_list)
#
# using Distributions
# using StatsBase
# using StatsPlots
#
# using Statistics
# mean(list2)
# median(list2)
#
#
# a = boxplot(list2, leg=false;notch=true)
#
# StatsPlots.plot(a)
