
########################################################
    ###   DEFINE AGENT AND HOUSEHOLD STRUCTURE  ###
########################################################
# dictionary stores agent identifier as key and agent struct with properties
# as value. used to store infection, progression and other details. age is an
# example for sociodemographics atm and is not used in simulations yet. dict
# keys / agents are used for looping over entire populatioon as well. same for
# household


struct household
    household_id::Int
    member_ids
end

mutable struct agent
    agent_id::Int32
    household_id::Int32
    state::String
    in_quar::Bool
    time_infected::Int8
    time_recov::Int8
    contacts_hh
    contacts_other
    vaccinated::Bool
end



#############################################################
    ###   CONSTRUCT AGENTS WITH HOUSEHOLD STRUCTURE   ###
#############################################################
# agents are generated randomly in households of X agents each.
#TODO write out population as pop file


agent_dict = Dict()
household_dict = Dict()

for i in 1:HH_NUMBER

    local hh_agent_list = []
    household_number = floor(Int,i)

    for j in 1:HH_SIZE
        global agent_number = floor(Int,j+(i-1)*HH_SIZE)
        agent_dict[ ("agent_$agent_number") ] = agent(agent_number, i, "susceptible", false, -1, -1, [], [], false)
        push!(hh_agent_list, "agent_$agent_number")
    end
    household_dict[ ("household_$household_number") ] = household(household_number, hh_agent_list)
    hh_agent_list = nothing
end
