#######################################
    ### RANDOM Vaccination MODEL ###
#######################################

global vaccinated_agents = []
while length(vaccinated_agents) < round(vacc_share*POP_SIZE,digits=0)

    new_agent = string("agent_", floor(Int, rand(Uniform(1,POP_SIZE))))
    if new_agent ∉ vaccinated_agents && agent_dict["$new_agent"].state == "susceptible"
        push!(vaccinated_agents, new_agent)
        agent_dict["$new_agent"].vaccinated = true
        STATETISTICS["vaccinated"] = STATETISTICS["vaccinated"]+1
    end
end
