%-------------------------------------------------------------------
%------- Alternar Random - Control ITI - Castigo
indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";
        "exp06";"exp07";"exp08";"exp09";"exp10";"exp11";
        "exp12";"exp13";"exp14";"exp15";"exp16";"exp17";
        "exp18";"exp19";"exp20";"exp21";"exp22";"exp23";
				"exp24";"exp25";"exp26";"exp27";"exp28";"exp29";
				"exp30";"exp31";"exp32";"exp33";"exp34";"exp35"];
%				"exp36";"exp37";"exp38";"exp39";"exp40"];

%todo.exp00=exp00;
todo.exp01=exp01;todo.exp02=exp02;todo.exp03=exp03;todo.exp04=exp04;todo.exp05=exp05;
todo.exp06=exp06;todo.exp07=exp07;todo.exp08=exp08;todo.exp09=exp09;todo.exp10=exp10;
todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;todo.exp15=exp15;
todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;todo.exp19=exp19,todo.exp20=exp20;
todo.exp21=exp21;todo.exp22=exp22;todo.exp23=exp23;todo.exp24=exp24;todo.exp25=exp25;
todo.exp26=exp26;todo.exp27=exp27;todo.exp28=exp28;todo.exp29=exp29;
todo.exp30=exp30;todo.exp31=exp31;todo.exp32=exp32;todo.exp33=exp33;
%todo.exp34=exp34;todo.exp35=exp35;todo.exp36=exp36;todo.exp37=exp37;
%todo.exp38=exp38;todo.exp39=exp39;todo.exp40=exp40;
%todo.exp=exp;

_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];

% PORCENTAJE DE COOPERACION
_nSujetos=12;
%_vSujetos=[1 2 3 4 5 6 7 8 9 10 11 12];% desde exp01
%_vSujetos=[2 6 8 9 10 11];% a partir del exp25
%_vSujetos=[2 6 8 9 11]; % a partir del exp30
_vSujetos=[2 8 11]; % a partir del exp32

_coop=zeros(1,_nSujetos);
_cooperacion=[];
_nada=[];
_nadaAux=zeros(1,_nSujetos);
inicio=1;
fin=33;
datos=zeros(2,fin);
% se promedia solo los que siguen con IPD
for j=inicio:fin
  _coop=zeros(1,_nSujetos);
  _nadaAux=zeros(1,_nSujetos);
  j
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
_promediosC=_cooperacion./(_trialsOK'-_nada');
_media=sum(_promediosC)/_nSujetos;
%Media  ARREGLAR LA SUMA SIN LOS NADA
%mediaG=sum(_cooperacion)/(_nSujetos*30-sum(_nada));

%media sin 1A
%media=sum((_cooperacion([2 3 4 5 6],:)./(5*30)));

%figure();
%plot([inicio:fin],_promediosC(1,:),'--+k',[inicio:fin],_promediosC(2,:),'--ok',[inicio:fin],_promediosC(3,:),'--*g',[inicio:fin],_promediosC(4,:),'--.g',[inicio:fin],_promediosC(5,:),'--xb',[inicio:fin],_promediosC(6,:),'--sb',[inicio:fin],_promediosC(7,:),'--^m',[inicio:fin],_promediosC(8,:),'--vm',[inicio:fin],_promediosC(9,:),'-->c',[inicio:fin],_promediosC(10,:),'--<c',[inicio:fin],_promediosC(11,:),'--pr',[inicio:fin],_promediosC(12,:),'--hr',[inicio:fin],_media,"r")
%xlabel("n de sesiones");
%ylabel("% de cooperacion");
%title("Cooperacion en iPD");
%legend('1A','2A','3A','4A','5A','6A','7A','8A','9A','10A','3B','4B');
%grid on
% una por una
for i=_vSujetos
  figure();
  plot([inicio:fin],_promediosC(i,:),'--ok');
  xlabel("n de sesiones");
  ylabel("% de cooperacion");
  title("Cooperacion en iPD");
  legend(_txtSujetos(i,:));
  grid on;
endfor
% Promedio de cooperacion sin outlayers




