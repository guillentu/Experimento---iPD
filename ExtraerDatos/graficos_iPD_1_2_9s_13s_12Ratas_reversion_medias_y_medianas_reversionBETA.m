%-------------------------------------------------------------------
%------- 
% Experimentos por sujetos
expXsuj=zeros(1,_nSujetos);
for j=inicio:(numfields(todo)-8)
  for i=1:length(todo.(indice(j+1,:)))
    if length(todo.(indice(j+1,:))(i)._groupStr)!=0
      expXsuj(i)++;
    endif
  endfor
endfor

_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];
_colores=["--+b";"--ob";"--*b";"--.b";"--xb";"--sb";"--^b";"--vb";"-->b";"--<b";"--pb";"--hb"];

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
figure; hold on;
for i=_vSujetos
  ultimo=_iniSujExp(i)-1+numfields(matricesQxExp.(indiceSujeto(i,:)))
  primero=ultimo-_ultimosX+1
  %ultimo=_iniSujExp(i)-1 + expXsuj(i);
  %primero=ultimo-_ultimosX+1;
  _mediaXsujeto(i)=mean(_promediosC(primero:ultimo,i));
  _mediaFallasXsujeto(i)=mean(_nada(primero:ultimo,i));
  _medianaXsujeto(i)=median(_promediosC(primero:ultimo,i));
  _stdXsujeto(i)=sem(_promediosC(primero:ultimo,i));
  plot([1:_ultimosX],_promediosC(primero:ultimo,i));
endfor
hold off;

% MEDIA 
hhh=figure; 
h=errorbar([1:length(_vSujetos)],_mediaXsujeto(_vSujetos),_stdXsujeto(_vSujetos),'*k');
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
errorbar([1:length(_vSujetos)],_medianaXsujeto(_vSujetos), _stdXsujeto(_vSujetos),'*k');
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


%_vSujetos=_vSujetos3;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%inicioAux=inicio;
%finAux=fin;
%% PLOT sujeto Todos juntos
%
%figure();
%hold on;
%for i=[3 7 9 10]
%  if i==1||i==3||i==4||i==5||i==7||i==12
%    finAux=23;
%  elseif i==10
%    finAux=29;
%  elseif i==6||i==9
%    finAux=31;
%  elseif i==2||i==11
%    finAux=33;
%  elseif i==8
%    finAux=fin;
%  endif
%  
%  %figure()
%  h=plot([inicioAux:finAux],_promediosC(inicioAux:finAux,i),_colores(i,:));set (h, "linewidth", 1);
%  
%  
%  
%endfor
%hh=plot(_media);set(hh, "linewidth", 3);
%hh=plot(_media);set(hh, "linewidth", 3);
%%hh=plot(_media+_semTodos);set(hh, "linewidth", 3);
%%hh=plot(_media-_semTodos);set(hh, "linewidth", 3);
%%x=[inicio:50]';
%%y=(_media(inicio:50))';
%%F = [ ones(length(x),1) x];
%%[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
%%yFit = F*p;
%%%figure();
%%%hh=plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%%set(hh, "linewidth", 3);
%xlabel("n de sesiones");
%ylabel("% de cooperacion");
%title("Cooperacion en iPD");
%legend(_txtSujetos([1 3 7 8 9 10 11 12],:),4);
%grid on;
%
%hold off;
%
%%%%%%%%%%%%%%%%%    todos alineados al final           %%%%%%%%%%%%%%%%%%%%%
