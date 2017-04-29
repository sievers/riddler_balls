Matlab/octave code to find the probability of getting all balls colored the same, from April 28 2017 Riddler.
Code enumerates all possible non-degenerate states of the system, and finds the transition probabilities
between the states.  Then multiplying by the transition matrix gives the new probability per state given
the old one.  It starts from the known ball distribution and watches the probabilities evolve.  While
it only reports on the expectation for the system to transition into the uniformly-colored state, having
the transition matrix means we have the full information on the system at every step, should one wish
to calculate something else.

And the answer for the average time when the balls become uniformly colored is (nball-1)^2.  To see this, set 
nball in find_ball_expectation.m and run the script, which will report how long it takes.
