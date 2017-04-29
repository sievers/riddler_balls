function[tot]=generate_states(nballs,ncol,nmax)
%generate all non-degenerate possible states for the colors of balls from the riddler
%uniform ball problem.  If you force the # of balls per color to be listed in 
%descending order then states will not be repeated.
%The actual generation is done recursively

if ~exist('ncol'), %if we just pass in a single argument, assume we're starting from usual position
  tot=generate_states(nballs,nballs-1,nballs);
  return;
end


if (ncol*nmax<nballs)
  %if we have more balls than we can place in our slots then quit
  tot=[];
  return
end


if (nballs<nmax),
  nmax=nballs;
end


if nballs==0,
  tot=zeros(ncol,1);
  return
end
if nballs==1,
  vec=zeros(ncol,1);
  vec(1)=1;
  tot=vec;
  return
end

tot=[];
for j=1:nmax,
  tmp=generate_states(nballs-j,ncol-1,j);
  if (~isempty(tmp)),
    nn=size(tmp,2);
    tmp=[repmat(j,[1 nn]);tmp];
    tot=[tot tmp];
  end

end
