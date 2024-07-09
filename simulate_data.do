* Define the program
program define simulate_mean_diff
    * Declare input parameters
    args mean1 sd1 mean2 sd2 n

    * Clear the existing data
    clear

    * Set the seed for reproducibility (optional)
    set seed 12345

    * Generate data for group 1
    set obs `n'
    gen group1 = rnormal(`mean1', `sd1')

    * Generate data for group 2
    set obs `=2*`n''
    replace group1 = . in `=`n'+1'/`=2*`n''
    gen group2 = rnormal(`mean2', `sd2') in `=`n'+1'/`=2*`n''

    * Combine the two groups into one variable
    gen combined = group1
    replace combined = group2 in `=`n'+1'/`=2*`n''
    gen group = 1 in 1/`n'
    replace group = 2 in `=`n'+1'/`=2*`n''

    * Calculate the mean difference between groups
    by group: summarize combined
    scalar mean_diff = r(mean)[2] - r(mean)[1]

    * Display the mean difference
    display "Mean difference between groups: " mean_diff
end

simulate_mean_diff 10 2 15 3 100


* Define the program
program define simulate_mean_diff
    * Declare input parameters
    args mean1 sd1 mean2 sd2 n

    * Clear the existing data
    clear

    * Set the seed for reproducibility (optional)
    set seed 12345

    * Generate data for group 1
    set obs `n'
    gen group = 1
    gen binary = runiform() < 0.22
    gen group1 = rnormal(`mean1', `sd1')
    replace group1 = 0 if binary == 1

    * Generate data for group 2
    set obs `=2*`n''
    replace group = 2 in `=`n'+1'/`=2*`n''
    replace binary = runiform() < 0.22 in `=`n'+1'/`=2*`n''
    gen group2 = rnormal(`mean2', `sd2') in `=`n'+1'/`=2*`n''
    replace group2 = 0 if binary == 1

    * Combine the two groups into one variable
    gen combined = group1
    replace combined = group2 in `=`n'+1'/`=2*`n''

    * Calculate the mean difference between groups
    by group: summarize combined
    scalar mean_diff = r(mean)[2] - r(mean)[1]

    * Display the mean difference
    display "Mean difference between groups: " mean_diff
end


simulate_mean_diff 10 2 15 3 100

