%-------------------------------------------------------------------
%------- 


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

% se promedia solo los que siguen con IPD
for j=inicio:fin
  _coop=zeros(1,_nSujetos);
  _nadaAux=zeros(1,_nSujetos);
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
  %plot([1:_nSujetos],_media(j));
endfor


%   Promedio total de las ultimas 10 sesiones --------------------------------------
_mediaXsujeto=zeros(1,_nSujetos);
_medianaXsujeto=zeros(1,_nSujetos);
_stdXsujeto=zeros(1,_nSujetos);
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  _mediaXsujeto(i)=mean(_promediosC(primero:ultimo,i));
  _mediaFallasXsujeto(i)=mean(_nada(primero:ultimo,i));
  _medianaXsujeto(i)=median(_promediosC(primero:ultimo,i));
  _stdXsujeto(i)=sem(_promediosC(primero:ultimo,i));
endfor 
figure; 
h=errorbar([1:12],_mediaXsujeto, _stdXsujeto,'*c');
set (h, "linewidth", 3);
hh=xlabel("Sujetos 1A-2A-3A-4A-5A-6A-7A-8A-9A-10A-3B-4B");set(hh, "fontsize", 14);
hh=ylabel("% de palanca C");set(hh, "fontsize", 14);
hh=title("Media - Porcentaje de eleccion de palanca Cooperar");set(hh, "fontsize", 14);
hold on
bar([1:12],_mediaXsujeto);
h2=plot([1:12],_criterio*ones(1,12),'--r');
set (h2, "linewidth", 3);
plot([1:12],.5*ones(1,12),'--k');
hold off

figure; 
h=errorbar([1:12],_medianaXsujeto, _stdXsujeto,'*c');
set (h, "linewidth", 3);
hh=xlabel("Sujetos 1A-2A-3A-4A-5A-6A-7A-8A-9A-10A-3B-4B");set(hh, "fontsize", 14);
hh=ylabel("% de palanca C");set(hh, "fontsize", 14);
hh=title("Mediana - Porcentaje de eleccion de palanca Cooperar");set(hh, "fontsize", 14);
hold on
bar([1:12],_medianaXsujeto);
h2=plot([1:12],_criterio*ones(1,12),'--r');
set (h2, "linewidth", 3);
plot([1:12],.5*ones(1,12),'--k');
hold off

