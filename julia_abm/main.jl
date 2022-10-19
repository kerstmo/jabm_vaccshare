

# Develop a simple agent based model (SIR) with the following settings:
# -          10 000 population consisting of households (use households with 5 persons each),
# -          Persons can have contacts in the households (with all household members) and outside (10 per day)
# -          when people are infected/infectious, they still leave the household for 2 days and stay home afterwards until recovered (5 days)
# -          transmission probability is 0.1 per contact outside of household and 0.3 per person per day within household (there are no ways to limit transmission
#  Start simulation with 100 infected persons /
# random. X% of the population are vaccinated.

## For which X probability of an outbreak >1000 infected people is <50%? (no exact answer is needed, just approximate)



# import Pkg
# Pkg.add("Setfield")

using Distributions
using Random
using Setfield
using CSV
using DataFrames
using Tables
using Dates


init_output_writer=0

function randomchoice(a::Array)
    n = length(a)
    idx = rand(1:n)
    return a[idx]
end


function exit_condition_iteration(a,b)
    if a < b
        return true
    else
        return false
    end
end

function exit_condition_run(infections, infections_cap, edge_proba)
    if (length(findall(infections .> infections_cap))/length(infections)) != edge_proba ||
        round(upper_bound,digits=3) != round(lower_bound, digits=3)
        return true
    else
        return false
    end
end





##############################
    ###   PARAMETERS   ###
##############################

POP_SIZE = 10000
HH_SIZE = 5
HH_NUMBER = POP_SIZE/HH_SIZE
MAX_CONTACTS_OTHER = 10

PROBA_TRANS_HH = 0.3
PROBA_TRANS_OTHER = 0.1
DURATION_INFECTION = 5
BEGIN_ISOLATION = 3

INIT_INF_SHARE = 0.05 # 0.01==100 agents
EDGE_PROBA = 0.5
OUTBREAK_CAP = 1000

SEX = ["female", "male"]

SEEDS = collect(1:30)
OUTPUT_LOCATION = "./julia_abm/output"



###############################
    ###    MAIN LOOP    ###
###############################

# population remains same over runs. create once
include("./popSynth.jl")


# initialize running variables

global RUN = 1
global upper_bound = 1.0
global lower_bound = 0.0
global this_seed = -1
global cumInfCollector = []
vacc_share = 0.1


# main loop, runs until solution is found. one run includes n realisations with
# different seeds, 1 realisation consists of m iterations (until infnections==0
# or exit condition fulfilled)


while exit_condition_run(cumInfCollector, OUTBREAK_CAP, EDGE_PROBA)

    cumInfCollector = [] #list tahat stores max cum infs of any seed of one run.
                            # later used to check whether xx% (edgeproba) of
                            #realisations are below/above threshhold (mutate X
                            # and run again or exit with solution)


    for seed in SEEDS # triggers n realisations with same seed
        Random.seed!(seed)
        this_seed = seed
        include("./runner.jl") # handles one realisation
        include("./clearAgents.jl") # reset agents,statetistics etc to default for next run
        push!(cumInfCollector, get(STATETISTICS, "cumInf", -1 )) #cIC collects max cum inf of all n realisations.
                                                                # used to cehck whether exit condition is fulfilled
                                                                # ie less than xx% of simulations have more than y infections

    end


    # update bounds for bisectional search. bounds are vacc shares
    if (length(findall(cumInfCollector .> OUTBREAK_CAP))/length(cumInfCollector))>EDGE_PROBA
        lower_bound = vacc_share
    else
        upper_bound = vacc_share
    end

    global vacc_share = (upper_bound + lower_bound) / 2

    RUN += 1


end


println(string("HOORAY! SOLUTION FOUND: X = " , vacc_share))
