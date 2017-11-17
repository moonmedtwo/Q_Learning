
  R = [-1 -1 -1 -1  0 -1;
       -1 -1 -1  0 -1  100;
       -1 -1 -1  0 -1 -1;
       -1  0  0 -1  0 -1;
        0 -1 -1  0 -1  100
       -1  0 -1 -1  0  100];
  
  gam = 0.8;
  Q = zeros(6,6);
  for i=1:200
      state = ceil(6*rand(1));
      while(state ~= 6)
          indexes = find((R(state,:)>-1));
          % go to a random idx
          randInd = ceil(length(indexes)*rand(1));
          a = indexes(randInd);
          
          indexes = find((R(a,:)>-1));
          maxQ = -1; %% maximum Q value
          for index = 1:length(indexes)
             if(Q(a,indexes(index))>maxQ)
                 maxQ = Q(a,indexes(index));
             end
          end
          
          Q(state,a) = R(state,a) + gam*maxQ;
          state = a;
      end
  end