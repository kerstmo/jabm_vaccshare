for i in infected_agents
    if (ITERATION - agent_dict["$i"].time_infected) > DURATION_INFECTION
        agent_dict["$i"].state = "recovered"
        agent_dict["$i"].in_quar = false
        agent_dict["$i"].time_recov = ITERATION

        STATETISTICS["infected"] = STATETISTICS["infected"]-1
        STATETISTICS["recovered"] = STATETISTICS["recovered"]+1
        STATETISTICS["hh_isolation"] = STATETISTICS["hh_isolation"]-1

        deleteat!(infected_agents, findall(x->x== i,infected_agents))
    end
end
