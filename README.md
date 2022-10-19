# jabm_vaccshare
simple julia-based abm that detemines requred vaccshare to condemn virus outbreak



QUICK RUN:
execute entire julia_abm/main.jl file



GENERAL IDEA:

the exercise's aim is to determine a vaccshare for which in 50% of a set of simulation runs an
outbreak of an infectious disease is condemned (cumulative infections <1000).

The vaccination share is thus altered over several runs until the target condition (condemn outbreak)
is satisfied. As each simulation is based on several random elements (i.e. contact network, infection events), each run
comprises x simulations with identical parameters but different seeds.

The vaccination share of a run is determined by bisectional search: If in <50% of the the subsequent run's simulations the
condition was fulfilled, the vaccinashion share for the net run is either increased or decreased. If 50% of the Seeds of a run fullfill the condition (and 50% do not), the run's vaccination share is found to be the result.

Note that for an exact result, using 30 seeds per run might not suffice.
However, increasing the number of simulations per run also increases computing time.  

Output is written to a timestamped output directory.

main.jl steers the simulation. Parameters can be altered to adapt to specific questions.



PARAMETERS:

    POP_SIZE = population size
    HH_SIZE =  fixed household sze for all households
    HH_NUMBER = determined by division
    MAX_CONTACTS_OTHER = number of contacts with agents outside hh. inside hh alla gents have contact by assumption

    PROBA_TRANS_HH = transmission probability for household contacts
    PROBA_TRANS_OTHER = transmission probability for non-household contacts
    DURATION_INFECTION = how long in state I
    BEGIN_ISOLATION = at which day of I starts isolation?

    INIT_INF_SHARE = which share of populations has initial infection to start pandemic?
    EDGE_PROBA = which share of runs should fulfill target condition?
    OUTBREAK_CAP = what is the max number of tolerated infected

    SEX = ["female", "male"]

    SEEDS = collect(1:30) how many realisations shoudl be computed? many -> more precise, few -> faster
    OUTPUT_LOCATION = "./julia_abm/output"


    global RUN = running varible
    global upper_bound = initial upper bound vaccshare. change only by educated guess
    global lower_bound = initial upper bound vaccshare. change only by educated guess
    global this_seed = initialise seedcounter
    global cumInfCollector = [] initialise list that store the cumulative infections of all seeds in one run. used to calculate, how many seeds of one run meet the condition.
    vacc_share = initial vacc share
