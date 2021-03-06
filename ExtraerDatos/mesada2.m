

_vRefuerzos=[1 2 0 0];
_vDelay4eat=[5 5 13 9];%[cc dc cd dd] [R T S P]
%_timeoutLimit=10*0+10*8+10*4;%10*5+10*13+10*9;% 270s en 30trials  %195; %13*15 or T+29*P=
%_timeoutITI=30*5;
_foodLimit=_vRefuerzos(2)*15+0*15;% food por T y por S, alterna
N=30;
% alimento de sujetos ideales   markov       prob estaren C o D
probC2=zeros(1,7); % [alternador; cooperador; CyD de a pares; la mitad coop] 
probC2=[.5;1;0.5;.5;.5;2/3;3/4];
probD2=zeros(1,7);
probD2=1-probC2;
%         {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}          R     S     T  P
QQideales=[[0; 1 ;1; 0],[1; 0; 0; 0],[.5; .5; .5; .5],[14/15; 0; 1/15; 1],[2/3;1/3;1/3;2/3],[.5; 1; .5; 0],[2/3; 1; 1/3; 0]];
_idealSujeto=zeros(2,length(probC2));% row 1 alimetno - row 2 delay to eat
for i=1:length(probC2)
%  _idealSujeto(1,i)= N *_vRefuerzos([1 4 2 3])*(vec((reshape(QQideales(:,i),2,2))^100).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
%  _idealSujeto(2,i)= 30*_vDelay4eat([1 4 2 3])*(vec((reshape(QQideales(:,i),2,2))^100).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
  %                                 % R  S .T P      % [R S T P]
  _idealSujeto(1,i)=N*_vRefuerzos([1 4 2 3])*(QQideales(:,i).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
endfor
for i=1:length(probC2)
  _idealSujeto(2,i)=30*_vDelay4eat([1 4 2 3])*(QQideales(:,i).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
endfor
%probC2([1 2 4 6 7])'
%_idealSujeto(:,[1 2 4 6 7])

%i=1
%_vRefuerzos([1 4 2 3])*(vec((reshape(QQideales(:,i),2,2))^100).*[probC2(i);probD2(i);probC2(i);probD2(i)])
%(reshape(QQideales(:,i),2,2))^100
%vec(ans)
%ans.*[probC2(i);probD2(i);probC2(i);probD2(i)]
%_vRefuerzos([1 4 2 3])*ans
%for ag=[1 6]
%  n=1000;
%  agente1=zeros(1,n);
%  agente1_reward=zeros(1,n);
%  agente1(find(rand(1,n)<=probC2(ag)))=1;
% %length(find(agente1==1))
%  if agente1(1)==1
%    agente1_reward(1)=_vRefuerzos(1);
%  else
%    agente1_reward(1)=_vRefuerzos(2);
%  endif
%  for k=2:n
%    if agente1(k)==1 && agente1(k-1)==1
%      agente1_reward(k)=_vRefuerzos(1);
%    elseif agente1(k)==0 && agente1(k-1)==1
%      agente1_reward(k)=_vRefuerzos(2);
%    elseif agente1(k)==1 && agente1(k-1)==0
%      agente1_reward(k)=_vRefuerzos(3);
%    elseif agente1(k)==0 && agente1(k-1)==0
%      agente1_reward(k)=_vRefuerzos(4);
%    endif
%  endfor
%    sum(agente1_reward)/n/_vRefuerzos(1)
%endfor

% combinatoria con repeticion de 30 elementos, 15 iguales y 15 iguales
n=6;

_timeoutLimit=5*5+5*13;%10*5+10*13+10*9;% 270s en 30trials  %195; %13*15 or T+29*P=
             %10*P  o 9*P+1*8
_timeoutITI=n*5;
_foodLimit=_vRefuerzos(2)*5+_vRefuerzos(3)*5;% food por T y por S, alterna

perm=factorial(n)/(factorial(n/2)*factorial(n/2));
%aux=perms([1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2]);
%aux=perms([1 1 1 1 1 2 2 2 2 2]);
%agente1=unique(aux,'rows'); % Existen 'perm' distintas jugadas con 50% de cooperacion
agente1_reward=zeros(perm,1); % cada jugada tiene una refuerzo caracteristico
agente1_timeout=zeros(perm,1); % idem
for i=1:perm
  if agente1(i,1)==2
    agente1_reward(i)=_vRefuerzos(1);
    agente1_timeout(i)+=_vDelay4eat(1);
  else
    agente1_reward(i)=_vRefuerzos(2);
    agente1_timeout(i)+=_vDelay4eat(2);
  endif
  for k=2:n
    if agente1(i,k)==2 && agente1(i,k-1)==2
      agente1_reward(i)+=_vRefuerzos(1);% R
      agente1_timeout(i)+=_vDelay4eat(1);%R
    elseif agente1(i,k)==1 && agente1(i,k-1)==2
      agente1_reward(i)+=_vRefuerzos(2); %T
      agente1_timeout(i)+=_vDelay4eat(2);%T
    elseif agente1(i,k)==2 && agente1(i,k-1)==1
      agente1_reward(i)+=_vRefuerzos(3); %S
      agente1_timeout(i)+=_vDelay4eat(3);%S
    elseif agente1(i,k)==1 && agente1(i,k-1)==1
      agente1_reward(k)+=_vRefuerzos(4); %P
      agente1_timeout(i)+=_vDelay4eat(4);%P
    endif
  endfor
  %sum(agente1_reward)/n/_vRefuerzos(1)
endfor

agente1_reward=agente1_reward/_foodLimit;
agente1_timeout=agente1_timeout/_timeoutLimit;

scatter(agente1_timeout(77), agente1_reward(77),18,'r')

%
%agente2=[];
%agente2(1,:)=ceil(randperm(n)/(n/2));
%next=2;
%while size(agente2)(1)<=perm
%  agente2(next,:)=ceil(randperm(n)/(n/2));
%  i=1
%  while i<next && i>0
%    if isequal(agente2(next,:),agente2(i,:))
%      igual++;
%      i=-1;
%    endif
%    if i~=-1
%      next++;
%    endif
%  endwhile
%endwhile
%
%    agente2(next,:)=ceil(randperm(n)/(n/2));
%    [r c]=size(agente2);
%    for j=1:(r-1)
%    if isequal(agente2(1,:),agente2(next,:))
%      next++;
%    endif
    

