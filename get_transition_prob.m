function[new_states,probs]=get_transition_prob(state)
%find the transition probabilities from one state to another.
%I'm doing this brute-force, more elegant solutions certainly exist.
%in this case, loop over all populated colors, pull a ball, and 
%loop over all populated colors for the second ball.  Look at the final 
%state (sorted by ball count to ensure non-degeneracy), and add the transition
%probability in.  

new_states={};
probs=[];

imax=max(find(state));
nball=sum(state);
for j=1:imax,
  p0=state(j)/nball;
  tmp=state;
  tmp(j)=tmp(j)-1;
  for k=1:imax,
    p1=tmp(k)/(nball-1);
    new_state=state;
    new_state(j)=new_state(j)+1;
    new_state(k)=new_state(k)-1;
    new_state=sort(new_state,'descend');
    [new_states,probs]=add_new_state(new_state,p0*p1,new_states,probs);
  end
end


function[new_states,probs]=add_new_state(new_state,prob,new_states,probs)
if isempty(new_states),
  new_states={new_state};
  probs=prob;
  return;
end


for j=1:length(new_states),
  if all(new_states{j}==new_state),
    probs(j)=probs(j)+prob;
    return
  end
end
new_states(:,end+1)=new_state;
probs(end+1)=prob;

