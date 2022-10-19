
##############################################
    ###   CONSTRUCT CONTACT PATTERNS   ###
##############################################

# nur die infected werden durchgeloopt. dann wird jeder haushalt-kontakt durchsimuliert. dann
# x=10 random andere kontakte. die anderen kontakte sind so gestaltet, dass jeder andere kontakt
# wiederum max 10 kontakte mit infektiösen agenten haben kann (oder weniger).
# contacts werden jede runde neu zufällig gezogen.


for i in infected_agents
    global hh_contacts = []
    global other_contacts = []
    local this_household_id = agent_dict["$i"].household_id
    hh_contacts =  copy(household_dict["household_$this_household_id"].member_ids)
    deleteat!(hh_contacts, findall(x->x== i,hh_contacts)) # i has not contact with herselves
    if agent_dict["$i"].in_quar == false
        while length(other_contacts) < MAX_CONTACTS_OTHER
            new_contact = string("agent_", floor(Int, rand(Uniform(1,POP_SIZE))))

            if new_contact ∉ other_contacts &&
                new_contact != i &&
                agent_dict["$new_contact"].in_quar == false &&
                length(agent_dict["$new_contact"].contacts_other) < MAX_CONTACTS_OTHER

                push!(other_contacts, new_contact)
            end

        end
    end

    agent_dict["$i"].contacts_other = other_contacts
    agent_dict["$i"].contacts_hh = hh_contacts
    other_contacts = nothing
end
