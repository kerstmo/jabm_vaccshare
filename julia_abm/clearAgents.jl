
# reset running variables after each realisation
vaccinated_agents = []
infected_agents = []

# reset agents to default
for i in 1:POP_SIZE
    agent_dict[("agent_$i")].state = "susceptible"
    agent_dict[(("agent_$i"))].in_quar = false
    agent_dict[(("agent_$i"))].time_infected = -1
    agent_dict[(("agent_$i"))].time_recov = -1
    agent_dict[(("agent_$i"))].contacts_hh = []
    agent_dict[(("agent_$i"))].contacts_other = []
    agent_dict[(("agent_$i"))].vaccinated = false
end


# for (key,value) in agent_dict
#     value.state = "susceptible"
#     value.in_quar = false
#     value.time_infected = -1
#     value.time_recov = -1
#     value.contacts_hh = []
#     value.contacts_other = []
#     value.vaccinated = false
# end
