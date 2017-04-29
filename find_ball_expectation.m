%master script to run how long it takes to make balls uniformly colored
%the basic idea is to enumerate all possible non-degenerate states of the system
%and calculate pmat, the transition probability matrix between them
%then the probability of being in some state after n steps is pmat^n*p_start
%in our case, the first step always converts the second ball to the first ball
%so effectively start with [2,1,1,1...] balls per color, and number of colors
%is number of balls-1.
%
%To get the expectation, you can then loop over n and take the difference
%if p_n = pmat^n*p0, then p_n-p_(n-1) is the differential probability after n steps
%the expectation is then just them sum of n*(p_n(end)-p_(n-1)(end)) since the
%way I have set the matrix up sets the final uniformly-colored state to be the last one
%In the code, while we're at things, I also calculate the standard deviation because why not, it's free.

%set # of balls
nball=10;
%generate the states and the transition probability matrix.
[pmat,states]=generate_transition_matrix(nball);

%just verify that the first state is the usual starting position of (2,1,1,...)
to_check=ones(size(states,1),1);to_check(1)=2;
assert(all(to_check==states(:,1)));

%and verify final states is (n,0,0,...)
to_check=0*to_check;to_check(1)=nball;
assert(all(to_check==states(:,end)));

%set the initial probability to be all in the first state
p0=0*pmat(:,1);p0(1)=1;
tol=1e-10;
expval=0;
iter=1;
myvar=0;
while (p0(end)<1-tol),
  iter=iter+1;
  p_tmp=pmat*p0;
  dp=p_tmp(end)-p0(end);
  expval=expval+dp*iter;
  myvar=myvar+dp*iter*iter;
  p0=p_tmp;
end
sig=sqrt(myvar-expval^2);
disp(['Balls are uniform after ' num2str(expval) ' turns on average, with standard deviation ' num2str(sig) ' and convergence to tol after ' num2str(iter) ' steps.'])