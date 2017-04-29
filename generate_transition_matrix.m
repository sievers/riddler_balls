function[pmat,states]=generate_transition_matrix(nballs)
%generate the transition matrix between possible states for the Riddler ball-coloring question


%first, get all possible non-degenerate states of the system
states=generate_states(nballs);
nstate=size(states,2);
pmat=zeros(nstate);

%loop over each state, find the possible states it can end up in from that state
%and with what probability
for j=1:nstate,
  [new_states,probs]=get_transition_prob(states(:,j));
  new_states=cell2mat(new_states);  
  kkmax=size(new_states,2);
  %loop over each possible state in the system, check to see if it is a state we could have ended up 
  %in from the current state, and if so, put in the relevant transition probability.
  %there is probably a more elegant way of doing this than the brute-force one,
  %maybe with some sort of hash, but I'm too lazy to work it out...
  for k=1:nstate,
    for kk=1:kkmax,
      if all(states(:,k)==new_states(:,kk)),
        pmat(k,j)=probs(kk);
      end
    end
  end
end


