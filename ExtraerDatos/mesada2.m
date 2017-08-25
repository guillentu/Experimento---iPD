_vRefuerzos=[5 6 0 1];
_vDelay4eat=[5 5 9 13];%[cc dc cd dd] [R T S P]
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


n=16;
perm=2^16;
agente1=zeros(1,perm);
agente1_reward=zeros(1,perm);
agente1_timeout=zeros(1,perm);
for i=1:perm
agente1(find(rand(1,n)<=probC2(ag)))=1;

if agente1(1)==1
  agente1_reward(1)=_vRefuerzos(1);
else
  agente1_reward(1)=_vRefuerzos(2);
endif
for k=2:n
  if agente1(k)==1 && agente1(k-1)==1
    agente1_reward(k)=_vRefuerzos(1);
  elseif agente1(k)==0 && agente1(k-1)==1
    agente1_reward(k)=_vRefuerzos(2);
  elseif agente1(k)==1 && agente1(k-1)==0
    agente1_reward(k)=_vRefuerzos(3);
  elseif agente1(k)==0 && agente1(k-1)==0
    agente1_reward(k)=_vRefuerzos(4);
  endif
endfor
sum(agente1_reward)/n/_vRefuerzos(1)
  
    
    
