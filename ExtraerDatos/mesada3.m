a=1
_vRefuerzos=[1 2 0 0];
_vDelay4eat=[5 5 13 9];%[cc dc cd dd] [R T S P]
%_timeoutLimit=10*0+10*8+10*4;%10*5+10*13+10*9;% 270s en 30trials  %195; %13*15 or T+29*P=
%_timeoutITI=30*5;
_foodLimit=_vRefuerzos(2)*15+0*15;% food por T y por S, alterna
%N=30;
%% alimento de sujetos ideales   markov       prob estaren C o D
%probC2=zeros(1,7); % [alternador; cooperador; CyD de a pares; la mitad coop] 
%probC2=[.5;1;0.5;.5;.5;2/3;3/4];
%probD2=zeros(1,7);
%probD2=1-probC2;
%%         {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}          R     S     T  P
%QQideales=[[0; 1 ;1; 0],[1; 0; 0; 0],[.5; .5; .5; .5],[14/15; 0; 1/15; 1],[2/3;1/3;1/3;2/3],[.5; 1; .5; 0],[2/3; 1; 1/3; 0]];
%_idealSujeto=zeros(2,length(probC2));% row 1 alimetno - row 2 delay to eat
%for i=1:length(probC2)
%%  _idealSujeto(1,i)= N *_vRefuerzos([1 4 2 3])*(vec((reshape(QQideales(:,i),2,2))^100).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
%%  _idealSujeto(2,i)= 30*_vDelay4eat([1 4 2 3])*(vec((reshape(QQideales(:,i),2,2))^100).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
%  %                                 % R  S .T P      % [R S T P]
%  _idealSujeto(1,i)=1*_vRefuerzos([1 4 2 3])*(QQideales(:,i).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
%endfor
%for i=1:length(probC2)
%  _idealSujeto(2,i)=1*_vDelay4eat([1 4 2 3])*(QQideales(:,i).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
%endfor


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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
_timeoutLimit=15*0+15*13;
_timeoutITI=30*5;
_foodLimit=2*15+0*15;% 
_delay2eat=(_timeOutMedia-_timeoutITI)./_timeoutLimit;
[Ss I]=sort(foodMedia);
hhh=figure;
aux=I(find(sort(foodMedia)));
h=scatter(_delay2eat(aux),foodMedia(aux),200, _mediaXsujeto(aux),"filled");
ch=colormap(gray);
h=colorbar('southoutside');
aux=I(find(sort(foodMedia)));
hold on;
%h=errorbar(_delay2eat(I(find(sort(foodMedia)>0.8)))./_timeOutMedia,foodMedia(I(find(sort(foodMedia)>0.8))),,'*k');
%set(hhh, "linewidth", 2);
hh=ylabel("% of total Reward");
set(hh, "fontsize", 16);
hh=xlabel("% total acumulated Timeout per sessions");
set(hh, "fontsize", 16);
hh=title("Reward versus Timeout to eat (colorbar=cooperation)"); 
set(hh, "fontsize", 16);

%t=text(0.02*[-1 -1 0 -1 -1 0 -1 -1]+_delay2eat(aux),-0.04*[1 1 1 1 1.2 -.8 1 -1]+foodMedia(aux),_txtSujetos(aux,:));
%axis('auto');
axis([-.04, 1.1, .5, 1.1]);
hold on;
h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,probC([1 3 4 5 6 7])','s',"filled");
h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
t=text(-0.10*[1 1 1 1 0.2 1.5]+(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
       0.05*ones(1,length(probC([1 3 4 5 6 7])))+ _idealSujeto(1,[1 3 4 5 6 7]), 
       {"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});

t=text(-0.10*[1 1 1 1 0.2 1.5]+ (_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
       0.03*[1 1 1 1 1 1]+ _idealSujeto(1,[1 3 4 5 6 7]),
       {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"}); 
t=text(0.1,0.3,{"Normalized amoung of C choice"},"fontsize",16);       
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=10000;
trials=30;
agente1=zeros(n,trials);
coop=[0.6];
color=['r';'b';'r';'b';'r';'b';'r';'b'];
_vAgente1_reward=[];
_vAgente1_timeout=[];
for trials=[30 200]
  _timeoutLimit=trials/2*_vDelay4eat(2)+trials/2*_vDelay4eat(3);
  _timeoutITI=trials*5;
  _foodLimit=_vRefuerzos(2)/(trials/2);% 
  iter=1
  coop(iter)
  Sss=[ones(ceil(trials*coop),1);zeros(floor(trials*(1-coop)),1)]+1;
  for i=1:n
    %[q w]=find((randperm(trials)/trials)<=coop(iter));
    agente1(i,randperm(length(Sss)))=Sss;
    %agente1(i,w)=2;
  endfor
  %agente1=unique(agente1,'rows');
  [r c]=size(agente1);
  agente1_reward=zeros(1,r);
  agente1_timeout=zeros(1,r);
  for i=1:r
    if agente1(i,1)==2
      agente1_reward(1)=_vRefuerzos(1);
    else
      agente1_reward(1)=_vRefuerzos(2);
    endif
    for k=2:trials
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
        agente1_reward(i)+=_vRefuerzos(4); %P
        agente1_timeout(i)+=_vDelay4eat(4);%P
      endif
    endfor
  endfor
  %sum(agente1_reward)/n/_vRefuerzos(1)
  _timeoutLimit=(trials/2)*0+(trials/2)*8;%10*5+10*13+10*9;% 270s en 30trials  %195; %13*15 or T+29*P=
               %10*P  o 9*P+1*8
  _timeoutITI=trials*5;
  %_foodLimit=_vRefuerzos(2)*5+_vRefuerzos(3)*5;% food por T y por S, alterna
  _foodLimit=_vRefuerzos(1)*(trials-1)+_vRefuerzos(2)*1;

  _vAgente1_reward=[ _vAgente1_reward; agente1_reward/_foodLimit];
  _vAgente1_timeout=[ _vAgente1_timeout; (agente1_timeout-_timeoutITI)/_timeoutLimit];
%  agente2_reward=uniagente1_reward/_foodLimit
  %figure();
%  hold on;
%  scatter(unique([]),(12-iter)*15,color(iter,:))
%  hold off;
  %print(hhh, "figura_iPD_1_2_9s_13s/reward_timeout_todos_simulados.png");
endfor
  %figure();
  hold on;
  vec=unique([_vAgente1_timeout(1,:)' _vAgente1_reward(1,:)'],'rows');
  scatter(vec(:,1),vec(:,2),(12-iter)*15,color(iter,:))
  vec=unique([_vAgente1_timeout(2,:)' _vAgente1_reward(2,:)'],'rows');
  scatter(vec(:,1),vec(:,2),(12-iter)*15,color(iter,:))
  hold off;
axis([-.04, 1.1, .5, 1.1]);

