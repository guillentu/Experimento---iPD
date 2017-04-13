%-------------------------------------------------------------------
%------- Alternar Random - Control ITI - Castigo
clear all
close all
%load "iPD_1_2_9s_13s/datosCargadoWorkspace20160423";
%load "iPD_1_2_9s_13s/datos_modificados_sobre_errores"


_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];
%_colores=["--+k";"--om";"--*g";"--.r";"--xb";"--sc";"--^m";"--vg";"-->b";"--<c";"--pr";"--hr"];
_colores=["--+b";"--ob";"--*b";"--.b";"--xb";"--sb";"--^b";"--vb";"-->b";"--<b";"--pb";"--hb"];
ptrn={"1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"};

% PORCENTAJE DE COOPERACION
_nSujetos=12;
%_vSujetos1=[1 2 3 4 5 6 7 8 9 10 11 12];% desde exp01
%_vSujetos2=[2 6 8 9 10 11];% a partir del exp24
%_vSujetos3=[2 6 8 9 11]; % a partir del exp30
%_vSujetos4=[2 8 11]; % a partir del exp32
%_vSujetos5=[8]; % a partir del exp34
%%%% SOLOS cooperadores_vSujetos1=[3 7 12];% desde el exp01
_vSujetos2=[3 7 10 12];% desde el exp07  
_vSujetos3=[3 7 9 10 12];% desde el exp09
_vSujetos4=[3 7 9 12];% desde el exp25
_vSujetos5=[3 7 9];% desde el exp43
_iniSujExp=[0 0 1 0 0 0 1 0 9 7 0 1];
_coop=zeros(1,_nSujetos);
_cooperacion=[];
_nada=[];
_nadaAux=zeros(1,_nSujetos);
_trialIni=1;
_trialFin=30;
inicio=1;
fin=52;
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

_colores=["--+k";"--ok";"--*k";"--.k";"--xk";"--sk";"--^k";"--vk";"-->k";"--<k";"--pk";"--hk"];

_cooperacion=[];
_nada=[];
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
%for i=1:_vSujetos
%  _promediosC(i,:)=_cooperacion(i,:)./(_trialsOK-_nada)(i,:);
%endfor

_promediosC=_cooperacion./(_trialsOK-_nada);

_media=sum(_promediosC');%/_nSujetos; % CHEQUEAR MEDIA con menos sujetos
_semTodos=zeros(1,length(_media));
inicioAux=inicio;
finAux=fin;
for j=inicio:fin
  if j<24
    _vSujetos=_vSujetos1;  
  elseif (j>=24 && j<30)
    _vSujetos=_vSujetos2;
  elseif (j>=30 && j<32)
    _vSujetos=_vSujetos3;
  elseif (j>=32 && j<34)
    _vSujetos=_vSujetos4;
  elseif (j>=34)
    _vSujetos=_vSujetos5;
  endif
  _media(j)=_media(j)/length(_vSujetos);
  _semTodos(j)=sem(_promediosC(j,_vSujetos));
endfor

inicioAux=inicio;
finAux=fin;
% PLOT sujeto Todos juntos

figure();
hold on;
for i=[1 3 7 8 9 10 11 12]
  if i==1||i==3||i==4||i==5||i==7||i==12
    finAux=23;
  elseif i==10
    finAux=29;
  elseif i==6||i==9
    finAux=31;
  elseif i==2||i==11
    finAux=33;
  elseif i==8
    finAux=fin;
  endif
  
  %figure()
  h=plot([inicioAux:finAux],_promediosC(inicioAux:finAux,i),_colores(i,:));set (h, "linewidth", 1);
  
  
  
endfor
hh=plot(_media);set(hh, "linewidth", 3);
hh=plot(_media);set(hh, "linewidth", 3);
hh=plot(_media+_semTodos);set(hh, "linewidth", 3);
hh=plot(_media-_semTodos);set(hh, "linewidth", 3);
%x=[inicio:50]';
%y=(_media(inicio:50))';
%F = [ ones(length(x),1) x];
%[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
%yFit = F*p;
%%figure();
%%hh=plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%set(hh, "linewidth", 3);
xlabel("n de sesiones");
ylabel("% de cooperacion");
title("Cooperacion en iPD");
legend(_txtSujetos([1 3 7 8 9 10 11 12],:),4);
grid on;

hold off;

%%%%%%%%%%%%%%%%    todos alineados al final           %%%%%%%%%%%%%%%%%%%%%

_promediosC_EndAttached=_promediosC;

_shft=zeros(1,_nSujetos);
for i=1:_nSujetos
  shft(i)=length(find(_promediosC(:,i)==0));
  _promediosC_EndAttached(:,i)=shift(_promediosC(:,i),shft(i));
endfor
_media_EndAtached=sum(_promediosC_EndAttached,2);
_semTodos_EndAttached=zeros(size(_media_EndAtached));
b=shft;
bb=10000;bbb=10000;bbbb=10000;bbbbb=10000;
for j=inicio:fin
  if (j>min(bbbbb))
    _vSujetos=_vSujetos1;
  elseif j>min(bbbb)
    _vSujetos=_vSujetos2;
    bbbbb = bbbb(bbbb~=min(bbbb)) ;
  elseif j>min(bbb)
    _vSujetos=_vSujetos3;
    bbbb = bbb(bbb~=min(bbb)); 
  elseif j>min(bb)
    _vSujetos=_vSujetos4;
    bbb = bb(bb~=min(bb)) ;
  elseif j>min(b)
    _vSujetos=_vSujetos5;
     bb = b(b~=min(b));
  endif
  _media_EndAtached(j)=_media_EndAtached(j)/length(_vSujetos);
  _semTodos_EndAttached(j)=sem(_promediosC_EndAttached(j,_vSujetos));
endfor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure();
hold on;
finAux=max(shft);
for i=[1 3 7 8 9 10 11 12]
  
  h=plot(1:length([shft(3)+1:finAux]),_promediosC_EndAttached(shft(3)+1:finAux,i),_colores(i,:));set (h, "linewidth", 1);
endfor

hh=plot(_media_EndAtached(28:finAux));set(hh, "linewidth", 3);
hh=plot(_media_EndAtached(28:finAux)+_semTodos_EndAttached(28:finAux),'--r');set(hh, "linewidth", 3);
hh=plot(_media_EndAtached(28:finAux)-_semTodos_EndAttached(28:finAux),'--r');set(hh, "linewidth", 3);
%x=[inicio:50]';
%y=(_media(inicio:50))';
%F = [ ones(length(x),1) x];
%[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
%yFit = F*p;
%%figure();
%%hh=plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%set(hh, "linewidth", 3);
hhh=xlabel("n of sesiones");set(hhh, "fontsize", 14);
hhh=ylabel("% of cooperation");set(hhh, "fontsize", 14);
%title("Cooperacion en iPD");
strLegend=strcat({_txtSujetos([1 3 7 8 9 10 11 12],:)},{"Mean";"sem"});
%legend(,4);
t=text(13.5, 0.25, {"Last 10 sessions"},"fontsize",14);
hhh=plot(40*ones(1,length([0.05:0.02:0.95]))-shft(3),[0.05:0.02:0.95],'*m');set(hhh, "linewidth", 1);
grid on;

hold off;
