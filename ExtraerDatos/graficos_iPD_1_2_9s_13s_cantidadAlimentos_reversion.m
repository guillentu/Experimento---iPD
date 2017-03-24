% Necesita:
% estructura 'todos'
% Frecuencis TT CC SS PP
% _vRefuerzos
% QQTotmarkov creada en markov_CD
% _vSujetos
%clear all
%close all
%load "iPD_1_2_9s_13s/datos_modificados_sobre_errores";
%load "iPD_1_2_9s_13s/datosVariablesCOMIDA"


%indiceSujeto=["Q01";"Q02";"Q03";"Q04";"Q05";"Q06";"Q07";"Q08";"Q09";"Q10";"Q11";"Q12"];
_colores=["--+k";"--om";"--*g";"--.r";"--xb";"--sc";"--^m";"--vg";"-->b";"--<c";"--pr";"--hr"];
ptrn={"1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"};

% Experimentos por sujetos
expXsuj=zeros(1,_nSujetos);
for j=inicio:(numfields(todo))      %%%     AGREGAR _INISUJEXP   %%%%%%%%%
  for i=1:length(todo.(indice(j+1,:)))
    if length(todo.(indice(j+1,:))(i)._groupStr)!=0
      expXsuj(i)++;
    endif
  endfor
endfor

food=[];
for i=1:_nSujetos
  food(:,i)=[TT(i,:).*_vRefuerzos(2) + CC(i,:).*_vRefuerzos(1) + PP(i,:).*_vRefuerzos(3) + SS(i,:).*_vRefuerzos(4)];
endfor
foodMedia=zeros(1,_nSujetos);
foodSem=zeros(1,_nSujetos);
for i=_vSujetos
  inicioAux=(_iniSujExp(i)-1) + expXsuj(i)-(_ultimosX-1);
  finAux=_iniSujExp(i)-1 + expXsuj(i);
  foodMedia(i) = mean(food(inicioAux:finAux,i));
  foodSem(i) = sem(food(inicioAux:finAux,i));
endfor

%%%%%%%%%%%%%%%%  TIMTEOUT   %%%%%%%%%%%%%%%%55
_timeOut=[];
for i=1:_nSujetos
  _timeOut(:,i)=30*[TT(i,:).*_vDelay4eat(2) + ...
                    CC(i,:).*_vDelay4eat(1) + ...
                    PP(i,:).*_vDelay4eat(3) + ...
                    SS(i,:).*_vDelay4eat(4)];
endfor

_timeOutMedia=zeros(1,_nSujetos);
_timeOutSem=zeros(1,_nSujetos);
for i=_vSujetos
  inicioAux=(_iniSujExp(i)-1 + expXsuj(i))-(_ultimosX-1);
  finAux=_iniSujExp(i)-1 + expXsuj(i);
  _timeOutMedia(i) = mean(_timeOut(inicioAux:finAux,i));
  _timeOutSem(i) = sem((_timeOut(inicioAux:finAux,i)-_timeoutITI)./_timeoutLimit);
endfor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hhh=figure;
%h=errorbar([1:_nSujetos],foodMedia/30,foodSem/30,'*b');set (h, "linewidth", 2);
h=errorbar(1:length(_vSujetos),foodMedia(_vSujetos),foodSem(_vSujetos),'*b');set (h, "linewidth", 2);
hold on;
axis("tic[yz]", "labely[xyz]");
%h=bar(foodMedia/30,"facecolor", "g","edgecolor","k");set (h, "linewidth", 2);
h=bar(foodMedia(_vSujetos),"facecolor", "g","edgecolor","k");set (h, "linewidth", 2);
hh=xlabel("Sujets - Last 10 sesions");set(hh, "fontsize", 14);
hh=ylabel("% total reward");set(hh, "fontsize", 14);
hh=title(" Mean of reward");set(hh, "fontsize", 14);
t=text(-.1+[1:length(_vSujetos)], 0.55*ones(1,length(_vSujetos)) , ptrn(_vSujetos),"fontsize",14);
axis([0,5,0.5,1.05],"square");legend("SEM","MEAN");
hold off;
name=strcat("figura_iPD_1_2_9s_13s/fig_finales/mean_reward_reversion",".png");
print(hhh, name);
%%%%%%%%%%%%%%%%  GRAPH OF TIMTEOUT   %%%%%%%%%%%%%%%%55
hhh=figure;
h=errorbar([1:length(_vSujetos)],(_timeOutMedia(_vSujetos)-_timeoutITI)./_timeoutLimit,_timeOutSem(_vSujetos),'*b');
set (h, "linewidth", 2);
hold on;
axis("tic[yz]", "labely[xyz]");
h=bar((_timeOutMedia(_vSujetos)-_timeoutITI)./_timeoutLimit,"facecolor", "g","edgecolor","k");set (h, "linewidth", 2);
hh=xlabel("Sujets - Last 10 sesions");set(hh, "fontsize", 14);
hh=ylabel("% Timeout");set(hh, "fontsize", 14);
hh=title(" Mean of timeout");set(hh, "fontsize", 14);
t=text(-.25+[1:length(_vSujetos)], 0.05*ones(1,length(_vSujetos)) , ptrn(_vSujetos), "fontsize", 14);
axis([0,5,0,.5],"square");
legend("SEM","MEAN");
hold off;
name=strcat("figura_iPD_1_2_9s_13s/fig_finales/mean_timeout_reversion",".png");
print(hhh, name);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TODOS JUNTOS
figure();hold on;
for i=_vSujetos
  inicioAux=_iniSujExp(i)-1 + expXsuj(i)-_ultimosX+1;
  finAux=_iniSujExp(i) - 1 + expXsuj(i);
  h=plot([inicioAux:finAux],food(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  xlabel("n de sesiones");
  ylabel("Cantidad de Alimento");
  title("Cantidad de alimento obtenido"); 
  grid on;
endfor
legend(_txtSujetos(_vSujetos,:),4);
hold off;

%_criterio=.5;
aux=_vSujetos;
graficos_iPD_1_2_9s_13s_12Ratas_reversion_medias_y_medianas_reversionBETA; % se obtienen los sujetos que superan el .75 porciento de cooperación
_vSujetos=aux;
%%%%%%%CRITERIO %%%% COOPERADORES Y NO COOPERADORES %%%%%%%%%%%%%%%%%%%%
%_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
aux1=find(_mediaXsujeto>_criterio);%  
aux2=find(_mediaXsujeto>_criterio);%  
%aux1=find(QQTotmarkov(1,1,:)(:)>_criterio);%   P(c|c) 
%aux2=find(QQTotmarkov(2,1,:)(:)>_criterio);%   P(c|d)
if length(aux1)>length(aux2)
  aux3=ismember(aux1,aux2)
  aux1=aux1(aux3)
else
  aux3=ismember(aux2,aux1)
  aux1=aux2(aux3)  
endif
% chi_2 a sujetos que pasaron el criterio general (prob de c dado c o d mayor a la azar 0.5)
frec_teo=100*[.5];
for i=aux1
  chi_2_xSujetos(i)=sum((100*QQTotmarkov(:,1,i)-frec_teo).^2./frec_teo); % dos
  sum((100*QQTotmarkov(:,1,i)-frec_teo).^2./frec_teo)
endfor
pasan=zeros(1,_nSujetos);
freedom=1;
% Nivel de signidicacia Sin correccion de Bonferroni
for i=aux1
  if (1-chi2cdf(chi_2_xSujetos(i),freedom))<0.05 
    pasan(i)=1;% Se rechaza la HIP NULA
  endif
endfor

_sujetosCooperadores=find(_mediaXsujeto>_criterio)
%_sujetosCooperadores=_vSujetos1(logical(pasan));
%_sujetosCooperadores=find(aux1>_criterio); % indice de sujetos que pasaron el criterios 
_sujetosNocooperadores=complemento(_sujetosCooperadores,_vSujetos); % Obtiene los indices de los no coop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
%_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos); % Obtiene los indices de los no coop

% SOLO LOS COOPERADORES SUPERARON EL CRITERIO
figure();hold on;
for i=_sujetosCooperadores%1:_nSujetos
  inicioAux=_iniSujExp(i)-1 + expXsuj(i)-_ultimosX+1;
  finAux=_iniSujExp(i) - 1 + expXsuj(i);
  h=plot([1:_ultimosX],food(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  xlabel("n de sesiones");
  ylabel("Cantidad de Alimento");
  title(strcat("Cantidad de alimento obtenido - Sujetos en Criterio: ",num2str(_criterio))); 
  grid on;
endfor
legend(_txtSujetos(_sujetosCooperadores,:),4);
%axis ([1, 10, 1, 33], "square");
hold off;
%SOLO LOS NO COOPERADORES NO SUPERARON EL CRITERIO
if length(_sujetosNocooperadores)>1
  figure();hold on;
  for i=_sujetosNocooperadores%1:_nSujetos
    inicioAux=expXsuj(i)-_ultimosX+1;
    finAux=expXsuj(i);
    h=plot([1:_ultimosX],food(inicioAux:finAux,i),_colores(i,:));
    set(h, "linewidth", 2);
    xlabel("n de sesiones");
    ylabel("Cantidad de Alimento");
    title(strcat("Cantidad de alimento obtenido - Sujetos fuera de criterio: ",num2str(_criterio))); 
    grid on;
  endfor
  legend(_txtSujetos(_sujetosNocooperadores,:),4);
  %axis ([1, 10, 1, 33], "square");
  hold off;
endif
%

%foodTotal= sum(food(:,_sujetosCooperadores),2);
%plot([1:50],foodTotal)
