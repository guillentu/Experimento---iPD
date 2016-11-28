%-------------------------------------------------------------------
%------- Alternar Random - Control ITI - Castigo
%clear all
%close all
%load "iPD_1_2_9s_13s/datosCargadoWorkspace20160423";
load "iPD_1_2_9s_13s/datos_modificados_sobre_errores"

indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";
        "exp06";"exp07";"exp08";"exp09";"exp10";"exp11";
        "exp12";"exp13";"exp14";"exp15";"exp16";"exp17";
        "exp18";"exp19";"exp20";"exp21";"exp22";"exp23";
        "exp24";"exp25";"exp26";"exp27";"exp28";"exp29";
				"exp30";"exp31";"exp32";"exp33";"exp34";"exp35";
				"exp36";"exp37";"exp38";"exp39";"exp40";"exp41";
        "exp42";"exp43";"exp44";"exp45";"exp46";"exp47";
        "exp48";"exp49";"exp49";"exp50";"exp51";"exp52";
        "exp53";"exp54";"exp55";"exp56";"exp57";"exp58"];
%todo.exp00=exp00;
todo.exp01=exp01;todo.exp02=exp02;todo.exp03=exp03;todo.exp04=exp04;todo.exp05=exp05;
todo.exp06=exp06;todo.exp07=exp07;todo.exp08=exp08;todo.exp09=exp09;todo.exp10=exp10;
todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;todo.exp15=exp15;
todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;todo.exp19=exp19,todo.exp20=exp20;
todo.exp21=exp21;todo.exp22=exp22;todo.exp23=exp23;todo.exp24=exp24;todo.exp25=exp25;
todo.exp26=exp26;todo.exp27=exp27;todo.exp28=exp28;todo.exp29=exp29;
todo.exp30=exp30;todo.exp31=exp31;todo.exp32=exp32;todo.exp33=exp33;
todo.exp34=exp34;todo.exp35=exp35;
todo.exp36=exp36;todo.exp37=exp37;
todo.exp38=exp38;todo.exp39=exp39;
todo.exp40=exp40;todo.exp41=exp41;todo.exp42=exp42;todo.exp43=exp43;
todo.exp44=exp44;todo.exp45=exp45;
todo.exp46=exp46;todo.exp47=exp47;
todo.exp48=exp48;todo.exp49=exp49;
todo.exp50=exp50;todo.exp51=exp51;%todo.exp=exp;
todo.exp52=exp52;todo.exp53=exp53;
todo.exp54=exp54;todo.exp55=exp55;
todo.exp56=exp56;todo.exp57=exp57;todo.exp58=exp58;

_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];

% PORCENTAJE DE COOPERACION
_nSujetos=12;
_vSujetos1=[1 2 3 4 5 6 7 8 9 10 11 12];% desde exp01
_vSujetos2=[2 6 8 9 10 11];% a partir del exp24
_vSujetos3=[2 6 8 9 11]; % a partir del exp30
_vSujetos4=[2 8 11]; % a partir del exp32
_vSujetos5=[8]; % a partir del exp34
_vSujetos=_vSujetos1;
_coop=zeros(1,_nSujetos);
_cooperacion=[];
_nada=[];
_nadaAux=zeros(1,_nSujetos);
_trialIni=1;
_trialFin=30;
inicio=1;
fin=50;
datos=zeros(2,fin);


% Testeo ------------------------------
%for j=inicio:fin
%  for i=_vSujetos
    %todo.(indice(j+1,:))(i)._respuestasEXP=[2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2];
    %todo.(indice(j+1,:))(i)._respuestasEXP=[0 2 0 2 0 2 0 2 0 2 0 2 0 2 0 2 0 2 0 2 0 2 0 2 0 2 0 2 0 2];
%    todo.(indice(j+1,:))(i)._respuestasEXP=[2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];%0.533333
    %todo.(indice(j+1,:))(i)._respuestasOPO=[2 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2];
%    todo.(indice(j+1,:))(i)._respuestasOPO=[2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1];
%  endfor
%endfor
%--------------------------------------

% 

% se promedia solo los que siguen con IPD

indiceSujeto=["Q01";"Q02";"Q03";"Q04";"Q05";"Q06";"Q07";"Q08";"Q09";"Q10";"Q11";"Q12"];
_colores=["--+k";"--om";"--*g";"--.r";"--xb";"--sc";"--^m";"--vg";"-->b";"--<c";"--pr";"--hr"];

expXsuj=zeros(1,_nSujetos);
for j=inicio:(nfields(todo)-8)
  for i=1:length(todo.(indice(j+1,:)))
    if length(todo.(indice(j+1,:))(i)._groupStr)!=0
      expXsuj(i)++;
    endif
  endfor
endfor
% Estructura de datos por sujeto
%_sujetos=[];
%for i=1:_nSujetos
%  _sujetos.(indiceSujetos(i,:))=[];
%endfor
_sujetos=[];
for j=inicio:(nfields(todo)-8)
  for i=1:_nSujetos
    if expXsuj(i)>=j
      _sujetos.(indiceSujeto(i,:)).(indice(j+1,:))=todo.(indice(j+1,:))(i);
    endif
  endfor
endfor


% se promedia solo los que siguen con IPD
_cooperacion=[];
_nada=[];
for j=inicio:fin
  _coop=zeros(1,_nSujetos);
  _nadaAux=zeros(1,_nSujetos); 
  for i=1:_nSujetos
    if expXsuj(i)>=j
      _coop(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(_trialIni:_trialFin)==2));
    endif
  endfor
  _cooperacion=[_cooperacion; _coop];
  for i=_vSujetos
    if expXsuj(i)>=j
      _nadaAux(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(_trialIni:_trialFin)==0));
    endif
  endfor
  _nada=[_nada; _nadaAux];
endfor

_criterio=.50;
graficos_iPD_1_2_9s_13s_12Ratas_medias_y_medianas % se obtienen los sujetos que superan el .75 porciento de cooperación
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
_sujetosCooperadores=_vSujetos1(logical(pasan));
%_sujetosCooperadores=find(aux1>_criterio); % indice de sujetos que pasaron el criterios 
_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos); % Obtiene los indices de los no coop
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
  inicioAux=expXsuj(i)-_ultimosX+1;
  finAux=expXsuj(i);
  h=plot([inicioAux:finAux],_promediosC(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  hh=xlabel("n de sesiones");set(hh, "fontsize", 14);
  hh=ylabel("% de cooperacion");set(hh, "fontsize", 14);
  hh=title(strcat("Cooperacion en iPD en sujetos que alcanzaron Criterio: ",num2str(_criterio,2)));
  set(hh, "fontsize", 14);
  grid on;
endfor
legend(_txtSujetos(_sujetosCooperadores,:),4);

figure();hold on;
for i=_sujetosCooperadores%1:_nSujetos
  inicioAux=expXsuj(i)-_ultimosX+1;
  finAux=expXsuj(i);
  h=plot([1:10],_promediosC(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  hh=xlabel("n de sesiones");set(hh, "fontsize", 14);
  hh=ylabel("% de cooperacion");set(hh, "fontsize", 14);
  hh=title(strcat("Cooperacion en iPD en sujetos que alcanzaron Criterio: ",num2str(_criterio,2)));
  axis([1 10 0 1]);set(hh, "fontsize", 14);
  grid on;
endfor
legend(_txtSujetos(_sujetosCooperadores,:),4);

figure();hold on;
for i=_sujetosNocooperadores%1:_nSujetos
  inicioAux=expXsuj(i)-_ultimosX+1;
  finAux=expXsuj(i);
  h=plot([inicioAux:finAux],_promediosC(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  xlabel("n de sesiones");
  ylabel("% de cooperacion");
  title(strcat("Cooperacion en iPDen Sujetos que No alcanzaron Criterio: ",num2str(_criterio,2)));
  
  grid on;
endfor
legend(_txtSujetos(_sujetosNocooperadores,:),4);

figure();hold on;
for i=_sujetosNocooperadores%1:_nSujetos
  inicioAux=expXsuj(i)-_ultimosX+1;
  finAux=expXsuj(i);
  h=plot([1:10],_promediosC(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  hh=xlabel("n de sesiones");set(hh, "fontsize", 14);
  hh=ylabel("% de cooperacion");set(hh, "fontsize", 14);
  hh=title(strcat("Cooperacion en iPDen Sujetos que No alcanzaron Criterio: ",num2str(_criterio,2)));
  axis([1 10 0 1]);set(hh, "fontsize", 14);
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
[pVal,k,DF]=kruskal_wallis_test(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),x(:,6),x(:,7))