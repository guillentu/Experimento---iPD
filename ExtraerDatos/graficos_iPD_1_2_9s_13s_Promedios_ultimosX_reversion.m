%-------------------------------------------------------------------
%------- Alternar Random - Control ITI - Castigo
%clear all
%close all
%load "iPD_1_2_9s_13s/datosCargadoWorkspace20160423";

%%% !!!!!  LLAMAR DESDE MARKOV_CD !!!!  O LUEGO DE CORRERLO PARA QUE LAS VARIABLES SEAN CREADAS

datos=zeros(2,fin);



% se promedia solo los que siguen con IPD

% Estructura de datos por sujeto
%_sujetos=[];
%for i=1:_nSujetos
%  _sujetos.(indiceSujetos(i,:))=[];
%endfor
_sujetos=[];
for j=inicio:(numfields(todo)-8)
  for i=1:_nSujetos
    if expXsuj(i)>=j
      _sujetos.(indiceSujeto(i,:)).(indice(j+1,:))=todo.(indice(j+1,:))(i);
    endif
  endfor
endfor


% se promedia solo los que siguen con IPD
%_cooperacion=[];
%_nada=[];
%for j=inicio:fin
%  _coop=zeros(1,_nSujetos);
%  _nadaAux=zeros(1,_nSujetos); 
%  for i=1:_nSujetos
%    if _iniSujExp(i)-1+expXsuj(i)>=j
%      _coop(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(_trialIni:_trialFin)==2));
%    endif
%  endfor
%  _cooperacion=[_cooperacion; _coop];
%  for i=_vSujetos
%    if expXsuj(i)>=j
%      _nadaAux(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(_trialIni:_trialFin)==0));
%    endif
%  endfor
%  _nada=[_nada; _nadaAux];
%endfor

%_criterio=.50;
graficos_iPD_1_2_9s_13s_12Ratas_reversion_medias_y_medianas_reversionBETA % se obtienen los sujetos que superan el .75 porciento de cooperación

%%%%%  COOPERACION ESTABLE - PLATEAU 
_ps2=zeros(2,_nSujetos);
_values=zeros(_nSujetos,1);
%for i=_vSujetos
%  finAux=_iniSujExp(i)-1+expXsuj(i);
%  inicioAux=finAux-_ultimosX+1;
%  x=[1:_ultimosX]';%[inicio:fin]';
%  y=_promediosC(inicioAux:finAux,i);
%  F = [ ones(length(x),1) x];
%  [p,e_var,r,p_var,y_var] = LinearRegression(F,y(:,1));
%  yFit = F*p;
%  e_var
%  _ps2(1,i)=[1 5]*p;
%  %_ps2(1,i)
%  [_values(i) index]=max(abs(_ps2(1,i)-_promediosC(inicioAux:finAux,i)));
%  %mean(y)
%%  figure();
%%  plot(x,y(:,1),'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%%  title('Behavior Stability - Lineal Regresion');
%%  xlabel("session");
%%  ylabel("% of cooperation");
%%  legend(strcat('C choice ',_txtSujetos(i,:)),'fit','+/-95% Desv. Std');
%%  axis([0 10 0.2 1.3])
%%  grid on
%endfor

%%%%%%%%%%%5 COOPERADORES Y NO COOPERADORES %%%%%%%%%%%%%%%%%%%%
%_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
aux1=find(QQTotmarkov(1,1,:)(:)>_criterio);%   P(c|c) 
aux2=find(QQTotmarkov(2,1,:)(:)>_criterio);%   P(c|d)
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
%_sujetosCooperadores=_vSujetos1(logical(pasan));
_sujetosCooperadores=find(_mediaXsujeto>_criterio)
%_sujetosCooperadores=find(aux1>_criterio); % indice de sujetos que pasaron el criterios 
_sujetosNocooperadores=complemento(_sujetosCooperadores,_vSujetos); % Obtiene los indices de los no coop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

_trialsOK=30*ones(length([inicio:fin]),_nSujetos);
_promediosC=zeros(length([inicio:fin]),_nSujetos);

_promediosC=_cooperacion./(_trialsOK-_nada);
%sum(_nada(:,_sujetosCooperadores),1)
_media=sum(_promediosC');%/_nSujetos; % CHEQUEAR MEDIA con menos sujetos

inicioAux=inicio;
finAux=fin;
for j=inicio:fin
  _media(j)=_media(j)/length(find(expXsuj>=j));
endfor


inicioAux=inicio;
finAux=fin;
% PLOT sujeto uno x uno
figure();hold on;
for i=_sujetosCooperadores%1:_nSujetos
  finAux=_iniSujExp(i)-1+expXsuj(i);
  inicioAux=finAux-_ultimosX+1;
  h=plot([inicioAux:finAux],_promediosC(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  hh=xlabel("n de sesiones");set(hh, "fontsize", 14);
  hh=ylabel("% de cooperacion");set(hh, "fontsize", 14);
  hh=title(strcat("Cooperation ",num2str(_criterio,2)));
  set(hh, "fontsize", 14);
  grid on;
endfor
legend(_txtSujetos(_sujetosCooperadores,:),4);

figure();
for i=_sujetosCooperadores%1:_nSujetos
  finAux=_iniSujExp(i)-1+expXsuj(i);
  inicioAux=finAux-_ultimosX+1;
  h=plot([1:length(_promediosC(inicioAux:finAux,i))],_promediosC(inicioAux:finAux,i),_colores(i,:));set(h, "linewidth", 2);hold on;
  hh=xlabel("sessions(Last ten sessions)");set(hh, "fontsize", 14);
  hh=ylabel("% of cooperacion");set(hh, "fontsize", 14);
  %hh=title(strcat("Cooperacion en iPD en sujetos que alcanzaron Criterio: ",num2str(_criterio,2)));
  axis([1 length(_promediosC(inicioAux:finAux,i)) 0 1]);set(hh, "fontsize", 14);
  grid on;
endfor
legend(_txtSujetos(_sujetosCooperadores,:),4);

figure();hold on;
for i=_sujetosNocooperadores%1:_nSujetos
  finAux=_iniSujExp(i)-1+expXsuj(i);
  inicioAux=finAux-_ultimosX+1;
  h=plot([inicioAux:finAux],_promediosC(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  xlabel("sesiones (Last ten sessions)");
  ylabel("% de cooperacion");
  %title(strcat("Cooperacion en iPDen Sujetos que No alcanzaron Criterio: ",num2str(_criterio,2)));
  grid on;
endfor
legend(_txtSujetos(_sujetosNocooperadores,:),4);

figure();hold on;
for i=_sujetosNocooperadores%1:_nSujetos
  finAux=_iniSujExp(i)-1+expXsuj(i);
  inicioAux=finAux-_ultimosX+1;
  h=plot([1:length(_promediosC(inicioAux:finAux,i))],_promediosC(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  hh=xlabel("n de sesiones");set(hh, "fontsize", 14);
  hh=ylabel("% de cooperacion");set(hh, "fontsize", 14);
  hh=title(strcat("Cooperacion en iPDen Sujetos que No alcanzaron Criterio: ",num2str(_criterio,2)));
  axis([1 length(_promediosC(inicioAux:finAux,i)) 0 1]);set(hh, "fontsize", 14);
  grid on;
endfor
legend(_txtSujetos(_sujetosNocooperadores,:),4);

% Kluskal-Wallis ANOVA one-way a lo largo de un juego (ultimas 10sesiones) entre los promedios de cooperacion 
% test de independencia entre muestras o individuos
_proporcionC=30*_cooperacion./(_trialsOK-_nada);
% los datos deben ser mayores a 5 para que el test funcione bien
x=[];
for i=1:length(_sujetosCooperadores)
  x=[x _proporcionC([expXsuj(_sujetosCooperadores(i))-9:expXsuj(_sujetosCooperadores(i))],_sujetosCooperadores(i))];
endfor
%[pVal,k,DF]=kruskal_wallis_test(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),x(:,6),x(:,7))
