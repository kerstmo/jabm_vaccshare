for i in infected_agents
    if (ITERATION - agent_dict["$i"].time_infected) == BEGIN_ISOLATION
         agent_dict["$i"].in_quar = true
         STATETISTICS["hh_isolation"] = STATETISTICS["hh_isolation"]+1
    end
end
