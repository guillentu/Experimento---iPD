%-------------------------------------------------------------------
%------- 


_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];

% PORCENTAJE DE COOPERACION
_vSujetos1=[3 7 12];% desde el exp01
_vSujetos2=[3 7 10 12];% desde el exp07  
_vSujetos3=[3 7 9 10 12];% desde el exp09
_vSujetos4=[3 7 9 12];% desde el exp25
_vSujetos5=[3 7 9];% desde el exp43
_iniSujExp=[0 0 1 0 0 0 1 0 9 7 0 1];
_vSujetos=_vSujetos2;
_coop=zeros(1,_nSujetos);
_cooperacion=[];
_nada=[];
_nadaAux=zeros(1,_nSujetos);
_trialIni=1;
_trialFin=30;
inicio=1;
fin=52;
datos=zeros(2,fin);

% se promedia solo los que siguen con IPD
for j=inicio:fin
  _coop=zeros(1,_nSujetos);
  _nadaAux=zeros(1,_nSujetos);
  if j<07
    _vSujetos=_vSujetos1;
  elseif (j>=07 && j<09)
    _vSujetos=_vSujetos2;
  elseif (j>=09 && j<25)
    _vSujetos=_vSujetos3;
  elseif (j>=25 && j<43)
    _vSujetos=_vSujetos4;
  elseif (j>=43)
    _vSujetos=_vSujetos5;
  endif
  for i=_vSujetos
    _coop(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(_trialIni:_trialFin)==2));
  endfor
  _cooperacion=[_cooperacion; _coop];
  for i=_vSujetos
    _nadaAux(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(_trialIni:_trialFin)==0));
  endfor
  _nada=[_nada; _nadaAux];
endfor

%_cooperacion=_cooperacion';
_trialsOK=30*ones(length([inicio:fin]),_nSujetos);
_promediosC=zeros(length([inicio:fin]),_nSujetos);

_promediosC=_cooperacion./(_trialsOK-_nada);

_media=sum(_promediosC');%/_nSujetos; % CHEQUEAR MEDIA con menos sujetos
inicioAux=inicio;
finAux=fin;
for j=inicio:fin
  if j<07
    _vSujetos=_vSujetos1;
  elseif (j>=07 && j<09)
    _vSujetos=_vSujetos2;
  elseif (j>=09 && j<25)
    _vSujetos=_vSujetos3;
  elseif (j>=25 && j<43)
    _vSujetos=_vSujetos4;
  elseif (j>=43)
    _vSujetos=_vSujetos5;
  endif
  _media(j)=_media(j)/length(_vSujetos);
  %plot([1:_nSujetos],_media(j));
endfor

_vSujetos=[3 7 9 10];
%   Promedio total de las ultimas 10 sesiones --------------------------------------
_mediaXsujeto=zeros(1,_nSujetos);
_medianaXsujeto=zeros(1,_nSujetos);
_stdXsujeto=zeros(1,_nSujetos);
for i=_vSujetos
  ultimo=_iniSujExp(i)-1 + expXsuj(i);
  primero=ultimo-_ultimosX+1;
  _mediaXsujeto(i)=mean(_promediosC(primero:ultimo,i));
  _mediaFallasXsujeto(i)=mean(_nada(primero:ultimo,i));
  _medianaXsujeto(i)=median(_promediosC(primero:ultimo,i));
  _stdXsujeto(i)=sem(_promediosC(primero:ultimo,i));
endfor

% MEDIA 
hhh=figure; 
errorbar([1:length(_vSujetos)],_mediaXsujeto(_vSujetos),_stdXsujeto(_vSujetos));
set (h, "linewidth", 3);
hh=ylabel("% of cooperation");set(hh, "fontsize", 14);
hh=title("Cooperation Mean");set(hh, "fontsize", 14);
hold on;
axis ("tic[yz]", "labely[xyz]");
bar(1:length(_vSujetos),_mediaXsujeto(_vSujetos));
h2=plot(1:length(_vSujetos),_criterio*ones(1,length(_vSujetos)),'--r');
set (h2, "linewidth", 3);
%plot([0  5],.5*ones(1,2),'--k');
legend("SEM","MEAN","half",0);
t=text([1:length(_vSujetos)]-0.1, .1*ones(1,length(_vSujetos)), _txtSujetos(_vSujetos,:),"fontsize",13);
hh=xlabel("Subjects");set(hh, "fontsize", 14);
axis([0 5 0 1.05]);
hold off;
%name=strcat("figura_iPD_1_2_9s_13s/fig_finales/cooperation_mean_reversion",".png");
%print(hhh, name);

% MEDIANA
hhh=figure
errorbar(1:length(_vSujetos),_medianaXsujeto(_vSujetos), _stdXsujeto(_vSujetos));
set (h, "linewidth", 3);
hh=xlabel("Subjects");set(hh, "fontsize", 14);
hh=ylabel("% of cooperation");set(hh, "fontsize", 14);
hh=title("Cooperation Median");set(hh, "fontsize", 14);
hold on;
bar(1:length(_vSujetos),_medianaXsujeto(_vSujetos));
h2=plot(1:length(_vSujetos),_criterio*ones(1,length(_vSujetos)),'--r');
set (h2, "linewidth", 3);
%plot([1:12],.5*ones(1,12),'--k');
legend("SEM","MEAN","half",0);
axis ("tic[yz]", "labely[xyz]");
t=text([1:length(_vSujetos)]-0.1, .1*ones(1,length(_vSujetos)), _txtSujetos(_vSujetos,:),"fontsize",13);
axis([0 5 0 1.05])
hold off;
name=strcat("figura_iPD_1_2_9s_13s/fig_finales/cooperation_median_reversion",".png");
print(hhh, name);


_vSujetos=_vSujetos3;
