%-------------------------------------------------------------------
%------- Alternar Random - Control ITI - Castigo
close all; clear all

load "iPD_1_2_9s_13s/reversion/datosCargadoWorkspace20160427"

indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";
        "exp06";"exp07";"exp08";"exp09";"exp10";"exp11";
        "exp12";"exp13";"exp14";"exp15";"exp16";"exp17";
        "exp18";"exp19";"exp20";"exp21";"exp22";"exp23";
				"exp24";"exp25";"exp26";"exp27";"exp28";"exp29";
				"exp30";"exp31";"exp32";"exp33";"exp34";"exp35";
				"exp36";"exp37";"exp38";"exp39";"exp40";"exp41";
        "exp42";"exp43";"exp44";"exp45";"exp46";"exp47";
        "exp48";"exp49";"exp50";"exp51";"exp52"];

%todo.exp00=exp00;
todo.exp01=exp01;todo.exp02=exp02;todo.exp03=exp03;todo.exp04=exp04;todo.exp05=exp05;
todo.exp06=exp06;todo.exp07=exp07;todo.exp08=exp08;todo.exp09=exp09;todo.exp10=exp10;
todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;todo.exp15=exp15;
todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;todo.exp19=exp19,todo.exp20=exp20;
todo.exp21=exp21;todo.exp22=exp22;todo.exp23=exp23;todo.exp24=exp24;todo.exp25=exp25;
todo.exp26=exp26;todo.exp27=exp27;todo.exp28=exp28;todo.exp29=exp29;todo.exp30=exp30;
todo.exp31=exp31;todo.exp32=exp32;todo.exp33=exp33;todo.exp34=exp34;todo.exp35=exp35;
todo.exp36=exp36;todo.exp37=exp37;todo.exp38=exp38;todo.exp39=exp39;todo.exp40=exp40;
todo.exp41=exp41;todo.exp42=exp42;todo.exp43=exp43;todo.exp44=exp44;todo.exp45=exp45;
todo.exp46=exp46;todo.exp47=exp47;todo.exp48=exp48;
todo.exp49=exp49;todo.exp50=exp50;todo.exp51=exp51;todo.exp52=exp52;
%todo.exp=exp;

_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];

% PORCENTAJE DE COOPERACION
_nSujetos=12;


_vSujetos1=[3 7 12];% desde el exp01
_vSujetos2=[3 7 10 12];% desde el exp07  
_vSujetos3=[3 7 9 10 12];% desde el exp09
_vSujetos4=[3 7 9 12];% desde el exp25
_vSujetos5=[3 7 9];% desde el exp43
_iniSujExp=[0 0 1 0 0 0 1 0 9 7 0 1];
%_vSujetos=[10];
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
    _coop(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(1:30)==2));
  endfor
  _cooperacion=[_cooperacion; _coop];
  for i=_vSujetos
    _nadaAux(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(1:30)==0));
  endfor
  _nada=[_nada; _nadaAux];
endfor
_cooperacion=_cooperacion';
_trialsOK=30*ones(length([inicio:fin]),_nSujetos);
_promediosC=zeros(_nSujetos,length([inicio:fin]));
_promediosC(3,:)=_cooperacion(3,:)./(_trialsOK'-_nada')(3,:);
_promediosC(7,:)=_cooperacion(7,:)./(_trialsOK'-_nada')(7,:);
_promediosC(12,:)=_cooperacion(12,:)./(_trialsOK'-_nada')(12,:);
_promediosC(10,:)=_cooperacion(10,:)./(_trialsOK'-_nada')(10,:);
_promediosC(9,:)=_cooperacion(9,:)./(_trialsOK'-_nada')(9,:);
_media=sum(_promediosC)/_nSujetos; % CHEQUEAR MEDIA con menos sujetos

%Media  ARREGLAR LA SUMA SIN LOS NADA
%mediaG=sum(_cooperacion)/(_nSujetos*30-sum(_nada));

%media sin 1A
%media=sum((_cooperacion([2 3 4 5 6],:)./(5*30)));


%%%%%%% ACA 
[r c]=size(_promediosC);
if (r!=12)
  _promediosC=_promediosC'
Endif
_vSujetos=_vSujetos3;
%%%%%%%%    TODOS JUNTOS DESDE EL FINAL hasta -17 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure();
h=plot([1:18],_promediosC(3,(fin-17):fin),'--ok',[1:18],_promediosC(7,fin-17:fin),'--ok',...
             [1:18],_promediosC(10,[7:24]),'--ok',[1:18], _promediosC(9,[fin-17:fin]),'--ok');
set(h,"linewidth",2)
hh=xlabel("n of sesiones");set(hh,"fontsize",20);
hh=ylabel("% Cooperation");set(hh,"fontsize",20);
hh=title("Evolution of Cooperation en iPD");set(hh,"fontsize",20)
legend(_txtSujetos(3,:),_txtSujetos(7,:),_txtSujetos(10,:),_txtSujetos(9,:));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

