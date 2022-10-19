
# runner iterates epidemic days  (one realization!) as long as infected are left
# or exit condition is fulfilled. statetistics dictionary is created once.



################################################
    ###   CLEAR OR CREATE STATETISTICS   ###
################################################
# statetistics dict is updated along all infection/progression/etc events
# TODO: output to csv file on daily basis
# TODO: create further outputs (i.e. infector vs infected)

global STATETISTICS = nothing
global STATETISTICS = Dict([("susceptible", POP_SIZE),
                    ("infected", 0),
                    ("recovered", 0),
                    ("cumInf", 0),
                    ("hh_isolation", 0),
                    ("vaccinated", 0)])

global ITERATION = 0
include("./vaccinationModel.jl")
include("./initInfections.jl")

global ITERATION = 1
##############################################
    ###    Main Loop of one REALISATION ###
##############################################

# while STATETISTICS["cumInf"] < OUTBREAK_CAP
while exit_condition_iteration(STATETISTICS["cumInf"], OUTBREAK_CAP)
    include("./contactBuilder.jl")
    include("./quarantineModel.jl")
    include("./infectionModel.jl")
    include("./progressionModel.jl")
    include("./report.jl")

    include("./writeOutput.jl")

    global ITERATION += 1

    if STATETISTICS["infected"] == 0
        break
    end

end
