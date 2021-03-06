%

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
  else
    _vSujetos=_vSujetosNull;
  endif
  for i=_vSujetos
    %todo.(indice(j+1,:))(i)._respuestasEXP=[2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1];
   if i==1 && (j==4||j==23)
   todo.(indice(j+1,:))(i)._respuestasEXP=[2 2 2 0 0 2 2 2 2 2 2 2 2 2 2 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1];
   else
   todo.(indice(j+1,:))(i)._respuestasEXP=[2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
   endif
    %todo.(indice(j+1,:))(i)._respuestasEXP=[1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2];
    %todo.(indice(j+1,:))(i)._respuestasOPO=[1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2];
    todo.(indice(j+1,:))(i)._respuestasOPO=[2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
    %todo.(indice(j+1,:))(i)._respuestasOPO=[2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1];
  endfor
endfor



stdQ=[];

for i=1:_nSujetos
  aux=[];
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX;
  for j=primero:ultimo % experimentos
    aux=[aux;vec(matricesQxExp.(indiceSujeto(i,:)).(indice(j+1,:))')'];
    %reshape(ee,4,4)'
    %matricesQxExp.(indiceSujeto(i,:)).(indice(j+1,:))
  endfor
  v_std=std(aux,0);
  stdQ.(indiceSujeto(i,:))=reshape(v_std,4,4)';
  %plot(median(aux(:,6)))
  %hist (aux(:,6), 15, "facecolor", "r", "edgecolor", "b");
endfor
%matricesQxExp.Q01.
%std (x) = sqrt ( 1/(N-1) SUM_i (x(i) - mean(x))^2 )



for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX;
  figure()
  plot([primero:ultimo],T(i,primero:ultimo),'--ob',[primero:ultimo],C(i,primero:ultimo),'--or',[primero:ultimo],P(i,primero:ultimo),'-->k',[primero:ultimo],S(i,primero:ultimo),'--.m');
  xlabel("n de sesiones");
  ylabel("% Tasa de comportamientos");
  title(strcat("Estrategias probabilistica en iPD: ",_txtSujetos(i,:)));
  legend("T=D-C","C=C-C","P=D-D","S=C-D");
  grid on;
endfor

% HACER:   struct de T R P S para cada sujeto por sesion
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX;
  figure()
  plot([primero:ultimo],T(i,primero:ultimo),'--ob',[primero:ultimo],C(i,primero:ultimo),'--or',[primero:ultimo],P(i,primero:ultimo),'-->k',[primero:ultimo],S(i,primero:ultimo),'--.m');
  xlabel("n de sesiones");
  ylabel("% Tasa de comportamientos");
  title(strcat("Estrategias probabilistica en iPD: ",_txtSujetos(i,:)));
  legend("T=D-C","C=C-C","P=D-D","S=C-D");
  grid on;
endfor


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pasan=zeros(1,4);
frec_obs=zeros(4,2,_nSujetos);
for j=1:4 %Estados
  for i=1:_nSujetos
    if sum(probTotalN(j,:,i))!=0
      frec_obs(j,:,i)=probTotalN(j,:,i)./sum(probTotalN(j,:,i));
    endif
  endfor
endfor
_porX=100;
frec_teo= _porX*0.5
% P(c|T) prob
aa=zeros(1,_nSujetos);
for i=_sujetosCooperadores
  aa(i)=(_porX*frec_obs(1,1,i)-frec_teo).^2./frec_teo;
endfor
chi_2_coop = sum(aa(_sujetosCooperadores),3); 
% El chi2cdf(11.0705,5)=0.95 La funcion da P(X2 < x) inverso a la tabla
if (1-chi2cdf(chi_2_coop,5))<0.05 % Con correccion de Bonferroni 0.05/5
  pasan(1)=1;
endif


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aa=zeros(4,_nSujetos);
frec_teo=zeros(4,1,_nSujetos);
frec_teo= sum(probxExpTotal(:,:,:),2)./2;%     Se suman y div x 2 todos las eleciones luego de T
% componentes de la sumatoria  (Oi-Ei)^2/Ei
aa=(probxExpTotal(:,1,:)-frec_teo).^2./frec_teo;
% sumatoria del Chi 2
chi_2_coop = zeros(4,1);% sum(aa([1 2 4],1,_sujetosCooperadores),3)
chi_2_coop(1) = sum(aa(1,1,_sujetosCooperadores),3);
chi_2_coop(2) = sum(aa(2,1,_sujetosCooperadores),3);
chi_2_coop(3) = sum(aa(3,1,_sujetosCooperadores([2:4 6])),3); % SALVANDO ESTADOS DONDE NUCA SE REALIZARON ELECCIONES
chi_2_coop(4) = sum(aa(4,1,_sujetosCooperadores),3);

chi_2_coop
_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos); % Obtiene los indices de los no coop
chi_2_nocoop = sum(aa(:,1,_sujetosNocooperadores),3)

pasanCoop=zeros(1,4);
pasanNocoop=zeros(1,4);
% Sin correccion de Bonferroni
freedom=6;
for i=1:4
  if i==3 % Salvando la no existencia de estado P en sujetos 3A y 10A
    freedom=4-1;
  else
    freedom=6-1;
  endif
  if (1-chi2cdf(chi_2_coop(i),freedom))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanCoop(i)=1;% Se rechaza la HIP NULA
  endif
endfor

for i=1:4
  if (1-chi2cdf(chi_2_nocoop(i),freedom))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanNocoop(i)=1;% Se rechaza la HIP NULA
  endif
endfor
% Con Correccion de Bonferroni
pasanCoopBon=zeros(1,4);
pasanNocoopBon=zeros(1,4);
for i=1:4
  if i==3 % Salvando la no existencia de estado P en sujetos 3A y 10A
    freedom=4-1;
  else
    freedom=6-1;
  endif
  if (1-chi2cdf(chi_2_coop(i),freedom))<(0.05/(freedom+1)) %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanCoopBon(i)=1;% Se rechaza la HIP NULA
  endif
endfor

for i=1:4
  if (1-chi2cdf(chi_2_nocoop(i),freedom))<(0.05/(freedom+1)) %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanNocoopBon(i)=1;% Se rechaza la HIP NULA
  endif
endfor
% Da casi todo significativo, indicando que las probabilidades de eleción no provienen de problaciones aleatorias.


probEleccion=zeros(size(probxExpTotal));
for i=1:_nSujetos
  for j=1:4
    if sum(probxExpTotal(j,:,i),2)!=0
      probEleccion(j,:,i)=probxExpTotal(j,:,i)./sum(probxExpTotal(j,:,i),2);
    endif
  endfor
endfor
_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];
_colores=["--+k";"--om";"--*g";"--.r";"--xb";"--sc";"--^m";"--vg";"-->b";"--<c";"--pr";"--hr"];
figure;
for i=_sujetosCooperadores
  hold on;
  h=plot(probEleccion(:,1,i),_colores(i,:));
  set(h, "linewidth", 2);
endfor
plot(probEleccion(:,2,_sujetosCooperadores(5)),"--ok");
set(h, "linewidth", 1);
plot([.5 .5 .5 .5],"--r");
set(h, "linewidth", 2);  
legend(_txtSujetos(_sujetosCooperadores,:), 4);
xlabel("T=1 --- R=2 --- P=3 --- S=4");
ylabel("P(C|X)");
title("Probabilidad de elegir C dado cada estado");
hold off;

figure;
for i=_sujetosNocooperadores
  hold on;
  h=plot(probEleccion(:,1,i),_colores(i,:));
  set(h, "linewidth", 2);       
endfor
plot([.5 .5 .5 .5],"--r");
set(h, "linewidth", 2);  
legend(_txtSujetos(_sujetosNocooperadores,:));
xlabel("T=1 --- R=2 --- P=3 --- S=4");
ylabel("P(C|X)");
title("Probabilidad de elegir C dado cada estado- No alcanzaron Criterio");
hold off;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
freedomCoop=zeros(1,4);freedomNocoop=zeros(1,4);
_auxSujCoops=[]

_estados=["T";"R";"P";"S"];
for i=1:4
  _aux=[];
  for j=1:length(_sujetosCooperadores)
    if ~isnan(aa(i,1,_sujetosCooperadores(j))) % Salvando cuando el animal no estuvo en el estado X
      freedomCoop(i)++;
      _aux = [_aux, j];
    endif
  endfor
  _auxSujCoops.(_estados(i))=_aux
endfor

%%%%%%%%%%%%%%%%%%%% P(C|X) promediando las ultimas X sesiones %%%%%%
probxExpTotalN=zeros(4,2,_nSujetos);
probxExpTotal=zeros(4,2,_nSujetos);
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  for j=primero:ultimo
    for k=1:4
      if probxExp.(indiceSujeto(i,:)).(indice(j+1,:))!=0
        probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))=probxExp.(indiceSujeto(i,:)).(indice(j+1,:))/sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)),2);
        probxExpTotalN(:,:,i)=probxExpTotalN(:,:,i)+probxExpN.(indiceSujeto(i,:)).(indice(j+1,:));
        probxExpTotal(:,:,i)=probxExpTotal(:,:,i)+probxExp.(indiceSujeto(i,:)).(indice(j+1,:));
      endif
  endfor
endfor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    _nadaAux(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(_trialIni:_trialFin)==0));
  endfor
  _nada=[_nada; _nadaAux];
endfor

_trialsOK=30*ones(length([inicio:fin]),_nSujetos);
_promediosC=zeros(length([inicio:fin]),_nSujetos);

_promediosC=_cooperacion./(_trialsOK-_nada);

_media=sum(_promediosC');%/_nSujetos; % CHEQUEAR MEDIA con menos sujetos
inicioAux=inicio;
finAux=fin;
for j=inicio:fin
  _media(j)=_media(j)/length(find(expXsuj>=j));
endfor

_criterio=.65;
graficos_iPD_1_2_9s_13s_12Ratas_medias_y_medianas % se obtienen los sujetos que superan el .75 porciento de cooperación
_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos); % Obtiene los indices de los no coop

inicioAux=inicio;
finAux=fin;
% PLOT sujeto uno x uno
figure();hold on;
for i=_sujetosCooperadores%1:_nSujetos
  inicioAux=expXsuj(i)-_ultimosX+1;
  finAux=expXsuj(i);
  h=plot([inicioAux:finAux],_promediosC(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  xlabel("n de sesiones");
  ylabel("% de cooperacion");
  title("Cooperacion en iPD en sujetos que alcanzaron Criterio");
  
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
  title("Cooperacion en iPDen Sujetos que No alcanzaron Criterio");
  
  grid on;
endfor
legend(_txtSujetos(_sujetosNocooperadores,:),4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%clear all
close all
%load "iPD_1_2_9s_13s/datosCargadoWorkspace20160423";
load "iPD_1_2_9s_13s/datos_errores_y_tiempos"
%load "iPD_1_2_9s_13s/datosVariablesCOMIDA"
_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];
indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";
        "exp06";"exp07";"exp08";"exp09";"exp10";"exp11";
        "exp12";"exp13";"exp14";"exp15";"exp16";"exp17";
        "exp18";"exp19";"exp20";"exp21";"exp22";"exp23";
        "exp24";"exp25";"exp26";"exp27";"exp28";"exp29";
        "exp30";"exp31";"exp32";"exp33";"exp34";"exp35";
        "exp36";"exp37";"exp38";"exp39";"exp40";"exp41";
        "exp42";"exp43";"exp44";"exp45";"exp46";"exp47";
        "exp48";"exp49";"exp50";"exp51";"exp52";"exp53";
        "exp54";"exp55";"exp56";"exp57";"exp58"];

indiceSujeto=["Q01";"Q02";"Q03";"Q04";"Q05";"Q06";"Q07";"Q08";"Q09";"Q10";"Q11";"Q12"];
_colores=["--+k";"--om";"--*g";"--.r";"--xb";"--sc";"--^m";"--vg";"-->b";"--<c";"--pr";"--hr"];

_trialIni=1;
_trialFin=30;
% Experimentos por sujetos
expXsuj=zeros(1,_nSujetos);
for j=inicio:(nfields(todo)-8)
  for i=1:length(todo.(indice(j+1,:)))
    if length(todo.(indice(j+1,:))(i)._groupStr)!=0
      expXsuj(i)++;
    endif
  endfor
endfor

% ---------- Busqueda de secuencias sobre sesiones
% Secuancias
% 212 - 2112 - 21112 - 211112 - 211112...
% 212
% comienza en D 111111112 (indice 21)
% termina en  D 211111111 (indice 22)
% usar una while si es cero la cantidad o mayor a 29 unos BRAKE
_combD=30;_iniFin=2;
_combC=30;_fallas=1;
_iFallas=_combC+_iniFin+_fallas;
_dejarD=zeros(1,_combD+_iniFin);% 21 termino 1 y 22 empezo en 1
_dejarC=zeros(1,_combC+_iniFin+_fallas);% 31 termino 2 y 32 empezo en 2 y 33 nº de ceros
voluntad=zeros(length(_dejarD),nfields(todo),_nSujetos);
voluntadC=zeros(length(_dejarC),nfields(todo),_nSujetos);
for i=1:_nSujetos
  for j=1:expXsuj(i)
    t=num2str(todo.(indice(j+1,:))(i)._respuestasEXP(:))';
    t=t(1:30);
    _dejarC(_iFallas)=0;
    for k=sort(_trialIni:_trialFin,"descend")
      if ((todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)||(todo.(indice(j+1,:))(i)._respuestasOPO(k)==0))
        t(k)="";
        _dejarC(_iFallas)++;
      endif
    endfor
    % Dejar D
    ptr="21";
    for r=1:(length(_dejarD(1:_combD))-2) % 2 por q esta enccerado entre 2 - 2
      ptr=strcat(ptr(1:(length(ptr)-1)),"12");
      _dejarD(r)=length(findstr(t,ptr));
    endfor
    aa=1;
    _dejarD(31)=0;_dejarD(32)=0;
    while (aa<=length(t) && t(aa++)=="1")
      _dejarD(31)++;
    endwhile
    voluntad(:,j,i)=_dejarD;
    aa=length(t);
    while (aa>0 && t(aa--)=="1" && _dejarD(31)<length(t))
      _dejarD(32)++;
    endwhile
    voluntad(:,j,i)=_dejarD;
    % Dejar C
    ptr="12";
    for r=1:(length(_dejarC(1:_combC))-2) % 2 por q esta enccerado entre 1 - 1
      ptr=strcat(ptr(1:(length(ptr)-1)),"21");
      _dejarC(r)=length(findstr(t,ptr));
    endfor
    aa=1;
    _dejarC(31)=0;_dejarC(32)=0;
    while (aa<=length(t) && t(aa++)=="2")
      _dejarC(31)++;
    endwhile
    voluntadC(:,j,i)=_dejarC;
    aa=length(t);
    while (aa>0 && t(aa--)=="2" && _dejarC(31)<length(t))
      _dejarC(32)++;
    endwhile
    voluntadC(:,j,i)=_dejarC;
  endfor
endfor

ptr="21";
vPtr="";
for r=1:(length(_dejarD(1:_combD))-2) % 2 por q esta enccerado entre 2 - 2
  ptr=strcat(ptr(1:(length(ptr)-1)),"12");
  vPtr=[vPtr; ptr];
endfor
ptr="12";
vPtrC="";
for r=1:(length(_dejarC(1:_combC))-2) % 2 por q esta enccerado entre 2 - 2
  ptr=strcat(ptr(1:(length(ptr)-1)),"21");
  vPtrC=[vPtrC; ptr];
endfor
vPtr=[vPtr; "29";"30";"11.12..";"..211.1"];
vPtrC=[vPtrC; "29";"30";"22.21..";"..122.2"];

txt=[".  "];
for i=1:32
  txt=[txt;strcat(txt(length(txt(:,1)),:),".")];
endfor
txt=txt(sort([1:32],'descend'),:);
vPtr=strcat(vPtr,txt);
vPtrC=strcat(vPtrC,txt);

cuantoComeXexp;

vVoluntadDfood=zeros(32,_nSujetos);
vVoluntadCfood=zeros(32,_nSujetos);

% Histograma en D
vVoluntades=zeros(_combC+_iniFin,_nSujetos);
for i=1:_nSujetos
  vVoluntades(:,i)=mean(voluntad(:,expXsuj(i)-9:expXsuj(i),i),2);
  vVoluntadDfood(:,i)=mean(voluntadDfood(1:32,expXsuj(i)-9:expXsuj(i),i),2);
endfor
vVoluntadesC=zeros(_combC+_iniFin+_fallas,_nSujetos);
for i=1:_nSujetos
  vVoluntadesC(:,i)=mean(voluntadC(:,expXsuj(i)-9:expXsuj(i),i),2);
  vVoluntadCfood(:,i)=mean(voluntadCfood(1:32,expXsuj(i)-9:expXsuj(i),i),2);
endfor


for i=1:_nSujetos
%  figure;
%  h=bar([vVoluntadesC([1:17 31 32],i),vVoluntades([1:17 31 32],i)],'*c');
%  set (h, "linewidth", 2);
%  set (h(1), 'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
%  set (h(2), 'facecolor', 'r', 'edgecolor','k', "linewidth", 2);
%  xlabel("eventos D entre C - C");
%  ylabel("ocurrecia por eventos");
%  title(strcat("voluntad por D - Sujeto: ",_txtSujetos(i,:)));
%  axis ("tic[yz]", "labely[xyz]");
  auxPtr=strcat(vPtr,num2str(vVoluntadDfood(:,i),2))
%  auxPtrC=strcat(vPtrC,vVoluntadCfood(:,i));
%  %t=text(-0.06+[1:length(vPtr([1:17 31 32],1))], 1*ones(1,length(vPtr([1:17 31 32],1))) , vPtrC([1:17 31 32],:));
%  t=text(-0.06+[1:length(vPtr([1:17 31 32],1))], 1*ones(1,length(vPtr([1:17 31 32],1))) , auxPtrC([1:17 31 32],:));
%  set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
%  t=text(0.28+[1:length(vPtr([1:17 31 32],1))], 1*ones(1,length(vPtr([1:17 31 32],1))) , auxPtr([1:17 31 32],:));
%  set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
endfor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555

close all

% load "iPD_1_2_9s_13s/datosCargadoWorkspace20160423";

load "iPD_1_2_9s_13s/datos_modificados_sobre_errores";

%indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";
%        "exp06";"exp07";"exp08";"exp09";"exp10";"exp11";
%        "exp12";"exp13";"exp14";"exp15";"exp16";"exp17";
%        "exp18";"exp19";"exp20";"exp21";"exp22";"exp23";
%				"exp24";"exp25";"exp26";"exp27";"exp28";"exp29";
%				"exp30";"exp31";"exp32";"exp33";"exp34";"exp35";
%				"exp36";"exp37";"exp38";"exp39";"exp40";"exp41";
%        "exp42";"exp43";"exp44";"exp45";"exp46";"exp47";
%        "exp48";"exp49";"exp50";"exp51";"exp52";"exp53";
%        "exp54";"exp55";"exp56";"exp57";"exp58"];
%%%%%%%%todo.exp00=exp00;
%todo.exp01=exp01;todo.exp02=exp02;todo.exp03=exp03;todo.exp04=exp04;todo.exp05=exp05;
%todo.exp06=exp06;todo.exp07=exp07;todo.exp08=exp08;todo.exp09=exp09;todo.exp10=exp10;
%todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;todo.exp15=exp15;
%todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;todo.exp19=exp19,todo.exp20=exp20;
%todo.exp21=exp21;todo.exp22=exp22;todo.exp23=exp23;todo.exp24=exp24;todo.exp25=exp25;
%todo.exp26=exp26;todo.exp27=exp27;todo.exp28=exp28;todo.exp29=exp29;
%todo.exp30=exp30;todo.exp31=exp31;todo.exp32=exp32;todo.exp33=exp33;
%todo.exp34=exp34;todo.exp35=exp35;
%todo.exp36=exp36;todo.exp37=exp37;
%todo.exp38=exp38;todo.exp39=exp39;
%todo.exp40=exp40;todo.exp41=exp41;
%todo.exp42=exp42;todo.exp43=exp43;
%todo.exp44=exp44;todo.exp45=exp45;
%todo.exp46=exp46;todo.exp47=exp47;
%todo.exp48=exp48;todo.exp49=exp49;
%todo.exp50=exp50;todo.exp51=exp51;%todo.exp=exp;
%todo.exp52=exp52;todo.exp53=exp53;
%todo.exp54=exp54;todo.exp55=exp55;
%todo.exp56=exp56;todo.exp57=exp57;todo.exp58=exp58;

_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];

% PORCENTAJE DE COOPERACION
_nSujetos=12;
_vSujetosNull=[];
_vSujetos1=[1 2 3 4 5 6 7 8 9 10 11 12];% desde exp01
_vSujetos2=[2 6 8 9 10 11];% a partir del exp24
_vSujetos3=[2 6 8 9 11]; % a partir del exp30
_vSujetos4=[2 8 11]; % a partir del exp32
_vSujetos5=[8]; % a partir del exp34
_vSujetos=_vSujetos1;
_finAnalisis1=23;% valor inclusive de experimento  (1 3 4 5 7 12)
_finAnalisis2=29;%(10)
_finAnalisis3=31;%(6 9)
_finAnalisis4=33;%(2 11)
_finAnalisis5=50;%(9)
_iniAnalisis1=1;
_iniAnalisis2=1;
_iniAnalisis3=1;
_iniAnalisis4=1;
_iniAnalisis5=1;
_coop=zeros(1,_nSujetos);
_cooperacion=[];
_nada=[];
_nadaAux=zeros(1,_nSujetos);
_trialIni=1;
_trialFin=30;
inicio=01;
fin=50;
datos=zeros(2,fin);


% Experimentos por sujetos
expXsuj=zeros(1,_nSujetos);
for j=inicio:(nfields(todo)-8)
  for i=1:length(todo.(indice(j+1,:)))
    if length(todo.(indice(j+1,:))(i)._groupStr)!=0
      expXsuj(i)++;
    endif
  endfor
endfor
% Testeo ------------------------------
%for j=inicio:fin
%  if j<24
%    _vSujetos=_vSujetos1;
%  elseif (j>=24 && j<30)
%    _vSujetos=_vSujetos2;
%  elseif (j>=30 && j<32)
%    _vSujetos=_vSujetos3;
%  elseif (j>=32 && j<34)
%    _vSujetos=_vSujetos4;
%  elseif (j>=34)
%    _vSujetos=_vSujetos5;
%  else
%    _vSujetos=_vSujetosNull;
%  endif
%  for i=_vSujetos
%    %todo.(indice(j+1,:))(i)._respuestasEXP=[2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1];
%   %if i==1 && (j==4||j==23)
%   %todo.(indice(j+1,:))(i)._respuestasEXP=[2 2 2 0 0 2 2 2 2 2 2 2 2 2 2 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1];
%   %else
%   todo.(indice(j+1,:))(i)._respuestasEXP=ceil(2*rand(1,31));%[2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
%   %endif
%    %todo.(indice(j+1,:))(i)._respuestasEXP=[1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2];
%    %todo.(indice(j+1,:))(i)._respuestasOPO=[1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2];
%    todo.(indice(j+1,:))(i)._respuestasOPO=ceil(2*rand(1,31));%[2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
%    %todo.(indice(j+1,:))(i)._respuestasOPO=[2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1];
%  endfor
%endfor

%--------------------------------------

indiceSujeto=[];
%for i=1:_nSujetos
%  indiceSujeto=[indiceSujeto;strcat("Q",mat2str(i))];
%endfor
indiceSujeto=["Q01";"Q02";"Q03";"Q04";"Q05";"Q06";"Q07";"Q08";"Q09";"Q10";"Q11";"Q12"];
% Probabilidades de transicion de estados
%matricesQ1.Q1=[];matricesQ2.Q2=[];matricesQ3.Q3=[];matricesQ4.Q4=[];matricesQ5.Q5=[];matricesQ6.Q6=[];
%matricesQ7.Q7=[];matricesQ8.Q8=[];matricesQ9.Q9=[];matricesQ10.Q10=[];matricesQ11.Q11=[];matricesQ12.Q12=[];
matricesQxExp=[];
matricesQaux=[];
Q = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
%matricesQ.Q1=[];matricesQ.Q2=[];matricesQ.Q3=[];matricesQ.Q4=[];matricesQ.Q5=[];matricesQ.Q6=[];matricesQ.Q7=[];matricesQ.Q8=[];matricesQ.Q9=[];matricesQ.Q10=[];matricesQ.Q11=[];matricesQ.Q12=[];
for i=1:_nSujetos
  matricesQ.(indiceSujeto(i,:)) = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
  matricesQaux.(indiceSujeto(i,:)) = zeros(4,4);
endfor




% 
% Brief: Carga las matrices de transicion de estado de cada sujeto.
%        Es un promedio total 
%        Acumula las veces que aparece la transicion durante los 29 trials a lo
%        largo los inicio:fin de experimentos.
T=zeros(_nSujetos,length(inicio:fin));C=zeros(_nSujetos,length(inicio:fin));
P=zeros(_nSujetos,length(inicio:fin));S=zeros(_nSujetos,length(inicio:fin));
controlFallas=zeros(1,_nSujetos);
auxFallas=1;
for j=inicio:fin
  if j>48
  endif
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
  else
    _vSujetos=_vSujetosNull;
  endif
  for i=_vSujetos
    for k=_trialIni:_trialFin  % nºtrials x Exp.  TRAICIONAR DADO QUE
      if ((todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)||(todo.(indice(j+1,:))(i)._respuestasOPO(k)==0))
        if (k==1)
          ++controlFallas(i);%%%
        elseif (k==2) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)% k=1 y K=2 son ceros no se cuenta una falla auxiluar
            auxFallas+=1;  
          endif
          ++controlFallas(i);%%%
        elseif (k==3)
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-2)==0)&&(todo.(indice(j+1,:))(i)._respuestasEXP(k-1)==0)
            % nada
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)
            auxFallas+=1;
          else
            a="MIERDA!!!"
          endif
          ++controlFallas(i);%%%
        else
          auxFallas+=1;
          ++controlFallas(i);
        endif
      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==2)
        T(i,j-inicio+1)++; %TRAICIONAR DADO :
        if (k>1) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
            ++matricesQ.(indiceSujeto(i,:))(1,1);
            ++matricesQaux.(indiceSujeto(i,:))(1,1); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
            ++matricesQ.(indiceSujeto(i,:))(2,1);
            ++matricesQaux.(indiceSujeto(i,:))(2,1); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
            ++matricesQ.(indiceSujeto(i,:))(3,1);
            ++matricesQaux.(indiceSujeto(i,:))(3,1);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++matricesQ.(indiceSujeto(i,:))(4,1);
            ++matricesQaux.(indiceSujeto(i,:))(4,1); 
          endif  
        endif
        auxFallas=1;
      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==2)
        C(i,j-inicio+1)++; % COOPERACION MUTUA DADO :
        if (k>1) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
            ++matricesQ.(indiceSujeto(i,:))(1,2); 
            ++matricesQaux.(indiceSujeto(i,:))(1,2);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
            ++matricesQ.(indiceSujeto(i,:))(2,2);
            ++matricesQaux.(indiceSujeto(i,:))(2,2);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
            ++matricesQ.(indiceSujeto(i,:))(3,2);
            ++matricesQaux.(indiceSujeto(i,:))(3,2);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++matricesQ.(indiceSujeto(i,:))(4,2);
            ++matricesQaux.(indiceSujeto(i,:))(4,2); 
          endif
        endif
        auxFallas=1;
      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)=1)
        P(i,j-inicio+1)++; % NO COOPERACION MUTUA DADO :
        if (k>1) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %que Traiciono (imposible x TFT)%
            ++matricesQ.(indiceSujeto(i,:))(1,3);
            ++matricesQaux.(indiceSujeto(i,:))(1,3); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%Cooperacion mutua%
            ++matricesQ.(indiceSujeto(i,:))(2,3);
            ++matricesQaux.(indiceSujeto(i,:))(2,3); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
            ++matricesQ.(indiceSujeto(i,:))(3,3);
            ++matricesQaux.(indiceSujeto(i,:))(3,3);            
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++matricesQ.(indiceSujeto(i,:))(4,3);
            ++matricesQaux.(indiceSujeto(i,:))(4,3);             
          endif
        endif
        auxFallas=1;
      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==1)
        S(i,j-inicio+1)++; % ESTAFAR DADO :
        if (k>1) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
            ++matricesQ.(indiceSujeto(i,:))(1,4);
            ++matricesQaux.(indiceSujeto(i,:))(1,4);             
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%Cooperacion mutua%
            ++matricesQ.(indiceSujeto(i,:))(2,4);
            ++matricesQaux.(indiceSujeto(i,:))(2,4);             
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
            ++matricesQ.(indiceSujeto(i,:))(3,4);
            ++matricesQaux.(indiceSujeto(i,:))(3,4);            
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++matricesQ.(indiceSujeto(i,:))(4,4);
            ++matricesQaux.(indiceSujeto(i,:))(4,4);             
          endif
        endif
        auxFallas=1;
      endif
    endfor
    auxFallas=1;
    matricesQxExp.(indiceSujeto(i,:)).(indice(j+1,:))=matricesQaux.(indiceSujeto(i,:));
  endfor
  for i=1:_nSujetos
    matricesQaux.(indiceSujeto(i,:)) = zeros(4,4);
  endfor
endfor
TT=T;CC=C;
PP=P;SS=S;
% Analizando las ultimas X sesiones
_ultimosX=10;
%   Normalizacion para todos los sujetos en todos los experimentos
Q_antes=matricesQ;
for i=1:_nSujetos % Ceros para todos
  matricesQ.(indiceSujeto(i,:)) = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
endfor
%   Promedio total --------------------------------------
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  for v=primero:ultimo % matricesQ borrada arriba
        matricesQ.(indiceSujeto(i,:))=matricesQ.(indiceSujeto(i,:))+matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:));
  endfor
endfor 
%     Normalizacion
for i=1:_nSujetos
  for j=1:4
    if sum(matricesQ.(indiceSujeto(i,:))(j,:))!=0
      Q(j,:,i)=matricesQ.(indiceSujeto(i,:))(j,:)/sum(matricesQ.(indiceSujeto(i,:))(j,:));
      %Q(j,:,i)=matricesQ.(indiceSujeto(i,:))(j,:);%/sum(matricesQ.(indiceSujeto(i,:))(j,:));
    endif
  endfor
endfor
% matriz para inkscape
QQTotmarkovInk=zeros(4,4,_nSujetos);
for i=1:_nSujetos
  QQTotmarkovInk(:,:,i)=30*Q(:,:,i);
%   QQTotmarkovInk(1,1,i)=30*Q(1,1,i)+0;
%   QQTotmarkovInk(1,2,i)=30*Q(1,2,i)+0;
%   QQTotmarkovInk(2,1,i)=30*Q(2,1,i)+0;
%   QQTotmarkovInk(2,2,i)=30*Q(2,2,i)+0;
endfor
%-------------------------------------------------------
%   Normalización Individual --------------------------
QxExp_ante=matricesQxExp;
indQ=[];
for i=1:_nSujetos
  for v=1:nfields(matricesQxExp.(indiceSujeto(i,:))) % experimentos
    for j=1:4 %Estados TRPS
      if sum(matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:))!=0
         matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:)=matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:)/sum(matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:));
         %matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:)=matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:);%/sum(matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:));
      endif
    endfor
  endfor  
endfor
Q2=zeros(4,4,_nSujetos);
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  for v=primero:ultimo % matricesQ borrada arriba
        Q2(:,:,i)=Q2(:,:,i)+(matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))/length(primero:ultimo));
        %Q2(:,:,i)=Q2(:,:,i)+(matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:)));%/length(primero:ultimo));
  endfor
endfor
%     Normalizacion
%for i=1:_nSujetos
%  for j=1:4
%    if sum(Q(j,:,i))!=0
%      Q2(j,:,i)=Q2(j,:,i)/sum(Q2(j,:,i));
%    endif
%  endfor
%endfor
%-------------------------------------------------------
%--- Desviacion estandar de Q---------------------------
stdQ=[];
for i=1:_nSujetos
  aux=[];
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  for j=primero:ultimo % experimentos
    aux=[aux;vec(matricesQxExp.(indiceSujeto(i,:)).(indice(j+1,:))')'];
  endfor
  v_std=std(aux,0);%std (x) = sqrt ( 1/(N-1) SUM_i (x(i) - mean(x))^2 )
  stdQ.(indiceSujeto(i,:))=reshape(v_std,4,4)';
  %plot(median(aux(:,6)))
  %hist (aux(:,6), 15, "facecolor", "r", "edgecolor", "b");
endfor




T2(:,:)=T(:,:)/length(_trialIni:_trialFin);R2(:,:)=C(:,:)/length(_trialIni:_trialFin);P2(:,:)=P(:,:)/length(_trialIni:_trialFin);S2(:,:)=S(:,:)/length(_trialIni:_trialFin);
% Frecuencia de estados - una por una
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
%  figure()
%  plot([primero:ultimo],T2(i,primero:ultimo),'--ob',[primero:ultimo],R2(i,primero:ultimo),'--or',[primero:ultimo],P2(i,primero:ultimo),'-->k',[primero:ultimo],S2(i,primero:ultimo),'--.m');
%  xlabel(strcat("n de sesiones - Ultimas ",_ultimosX));
%  ylabel("% Proporcion entre estados");
%  title(strcat("Estrategias probabilistica en iPD: ",_txtSujetos(i,:)));
%  legend("T=D-C","R=C-C","P=D-D","S=C-D");
%  grid on;
endfor

% Frecuencia de estados - Promedio de las ultimas sesiones
T_mean=zeros(1,_nSujetos);R_mean=zeros(1,_nSujetos);P_mean=zeros(1,_nSujetos);S_mean=zeros(1,_nSujetos);
T_median=zeros(1,_nSujetos);R_median=zeros(1,_nSujetos);P_median=zeros(1,_nSujetos);S_median=zeros(1,_nSujetos);
T_std=zeros(1,_nSujetos);R_std=zeros(1,_nSujetos);P_std=zeros(1,_nSujetos);S_std=zeros(1,_nSujetos);
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  T_mean(i)=mean(T2(i,primero:ultimo));R_mean(i)=mean(R2(i,primero:ultimo));P_mean(i)=mean(P2(i,primero:ultimo));S_mean(i)=mean(S2(i,primero:ultimo));
  T_median(i)=median(T2(i,primero:ultimo));R_median(i)=median(R2(i,primero:ultimo));P_median(i)=median(P2(i,primero:ultimo));S_median(i)=median(S2(i,primero:ultimo));
  T_std(i)=std(T2(i,primero:ultimo));R_std(i)=std(R2(i,primero:ultimo));P_std(i)=std(P2(i,primero:ultimo));S_std(i)=std(S2(i,primero:ultimo));
%  figure;
%  %plot(1,T_mean(i), 2,R_mean(i) ,3, P_mean(i),4,S_mean(i));
%  h=errorbar(1,T_mean(i), T_std(i),'*r', 2,R_mean(i),R_std(i),'*b', 3,P_mean(i), P_std(i),'*m', 4,S_mean(i), S_std(i),'*c');
%  set (h, "linewidth", 3);
%  xlabel("Estados");
%  ylabel("% de ocurrencia");
%  title(strcat("Tasa de ocurrencia de cada estado en iPD: ",_txtSujetos(i,:)));
%  legend("T=D-C","R=C-C","P=D-D","S=C-D");
%  hold on
%  bar(1:4,[T_mean(i),R_mean(i),P_mean(i),S_mean(i)])
%  hold off
endfor

_criterio=.70;
graficos_iPD_1_2_9s_13s_12Ratas_medias_y_medianas % se obtienen los sujetos que superan el .75 porciento de cooperación
_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos);
QmediaC=zeros(4,4);
QmediaD=zeros(4,4);
for i=_sujetosCooperadores
  QmediaC=QmediaC+Q(:,:,i);
endfor
QmediaC=QmediaC./sum(QmediaC,2);

for i=_sujetosNocooperadores
  QmediaD=QmediaD+Q(:,:,i);
endfor
QmediaD=QmediaD./sum(QmediaD,2);


% promediar las tasas de cooperacion y tasas de estados de los animales que superaron el criterio
_mediaT=mean(T_mean(_sujetosCooperadores));
_mediaR=mean(R_mean(_sujetosCooperadores));
_mediaP=mean(P_mean(_sujetosCooperadores));
_mediaS=mean(S_mean(_sujetosCooperadores));
_semT=sem(T_mean(_sujetosCooperadores));
_semR=sem(R_mean(_sujetosCooperadores));
_semP=sem(P_mean(_sujetosCooperadores));
_semS=sem(S_mean(_sujetosCooperadores));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
%%%%%%%%%%%%%%%% CHI2 VIEJO  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
% utiliza frecuencias teoriacas la suma de las eleciones C y D para cada estados y 
% ls divide por dos.                  |
aa=zeros(4,_nSujetos);%               |
frec_teo=zeros(4,1,_nSujetos);%       |
frec_teo=sum(probxExpTotal(:,:,:),2)./2;%     Se suman y div x 2 todos las eleciones luego de T
% componentes de la sumatoria  (Oi-Ei)^2/Ei
aa=(probxExpTotal(:,1,:)-frec_teo).^2./frec_teo;
% sumatoria del Chi 2

_validosCoop=zeros(1,4);freedomNocoop=zeros(1,4);
_auxSujCoops=[];

_estados=["T";"R";"P";"S"];
for i=1:4
  _aux=[];
  for j=1:length(_sujetosCooperadores)
    if ~isnan(aa(i,1,_sujetosCooperadores(j))) % Salvando cuando el animal no estuvo en el estado X
      _validosCoop(i)++;
      _aux = [_aux, j];
    else
      printf("-- Sujeto %d NO VISITADO %s, valor=%d\n",_sujetosCooperadores(j),_estados(i),aa(i,1,_sujetosCooperadores(j)))
    endif
  endfor
  _auxSujCoops.(_estados(i))=_aux;
endfor
chi_2_coop = zeros(4,1);% sum(aa([1 2 4],1,_sujetosCooperadores),3)
for i=1:4
chi_2_coop(i) = sum(aa(i,1,_sujetosCooperadores(_auxSujCoops.(_estados(i)))));
endfor


chi_2_coop;
_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos); % Obtiene los indices de los no coop
chi_2_nocoop = sum(aa(:,1,_sujetosNocooperadores),3);

%-----------------STANDARD DESVIATION------------------------------------
_vecProbxExpTotal=[];
for i=1:_nSujetos
  _vecProbxExpTotal=[_vecProbxExpTotal probxExpTotal(:,1,i)]
endfor
_stdSujetosCoop=zeros(4,1)
for i=1:4
  _stdSujetosCoop(i,1)=std(_vecProbxExpTotal(i,_sujetosCooperadores(_auxSujCoops.(_estados(i)))),0,2);
endfor
_stdSujetosNocoop=std(_vecProbxExpTotal(:,_sujetosNocooperadores),0,2);

_stdSujetosCoop2=zeros(4,1);
_todoJuntoCoop=[];
for i=_sujetosCooperadores
  ultimo=expXsuj(i);
  primero=ultimo-_ultimosX+1;
  for j=primero:ultimo
    aux22=(probxExp.(indiceSujeto(i,:)).(indice(j+1,:))./sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:))))(:,1);
    _todoJuntoCoop=[_todoJuntoCoop aux22];
  endfor
endfor
_stdSujetosCoop2=std(_todoJuntoCoop,0,2);
%----------------------------------------

pasanCoop=zeros(1,4);
pasanNocoop=zeros(1,4);
% Sin correccion de Bonferroni
freedom=length(_sujetosNocooperadores)-1;
for i=1:4
  if (1-chi2cdf(chi_2_coop(i),_validosCoop(i)-1))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanCoop(i)=1;% Se rechaza la HIP NULA
  endif
endfor

for i=1:4
  if (1-chi2cdf(chi_2_nocoop(i),freedom))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanNocoop(i)=1;% Se rechaza la HIP NULA
  endif
endfor
% Con Correccion de Bonferroni
pasanCoopBon=zeros(1,4);
pasanNocoopBon=zeros(1,4);
for i=1:4
  if (1-chi2cdf(chi_2_coop(i),_validosCoop(i)-1))<(0.05/(_validosCoop(i))) %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanCoopBon(i)=1;% Se rechaza la HIP NULA
  endif
endfor

for i=1:4
  if (1-chi2cdf(chi_2_nocoop(i),freedom))<(0.05/(freedom+1)) %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanNocoopBon(i)=1;% Se rechaza la HIP NULA
  endif
endfor



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------
%
%[Ss I]=sort(_mediaXsujeto);
%figure;
%aux=I(find(sort(_mediaXsujeto)>0.5));
%%h=plot(_mediaXsujeto(I),_alimento(I),'ko', "markersize",12,"markerfacecolor",'c', "linewidth", 2);
%h=scatter(_mediaXsujeto(aux),_alimento(aux),20,(_delay4eat(aux)-_timeoutITI)./_timeoutLimit,"filled");
%ch=colormap(copper);
%colorbar('southoutside');
%set(h, "linewidth", 2);
%hh=xlabel("Among of C choice ");
%set(hh, "fontsize", 14);
%hh=ylabel("% Total Reward");
%set(hh, "fontsize", 14);
%hh=title("Reward versus Cooperation (Colorbar=Timeout)"); 
%set(hh, "fontsize", 14);
%grid off;%grid minor;
%t=text(-0.01*[1 1 1 1 1 1 1 -1]+_mediaXsujeto(aux),.08*[ 1 1 1 1 1 1 1 -1]+_alimento(aux),_txtSujetos(aux,:));
%%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .03*[1 1 1 1 1 1 1 1 1 1 1 -1]+_alimento(I) ,_txtSujetos(I,:));
%%axis('auto');
%axis([.49 1.02 0 1.15]);
%hold on;
%%h=plot(_mediaXsujeto(I(length(I))),_alimento(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),_idealSujeto(2,[1 3 4 5 6 7]),15,probC([1 3 4 5 6 7])','s',"filled");
%%h=plot(probC([1 3 4 5]),_idealSujeto(1,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 
%        0.04*[.5 .5 .5 .5 2.9 2.9]+_idealSujeto(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 
%       -0.025*[1.2 1 1 1 -3.2 -3.2]+_idealSujeto(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;
%
%
%% grafico Cooperacion Versus R
%[Ss I]=sort(_mediaXsujeto);
%figure;
%aux=I(find(sort(_mediaXsujeto)>0.5));
%h=scatter(_mediaXsujeto(aux),R_mean(aux),20,((_delay4eat(aux)-_timeoutITI)./_timeoutLimit),"filled");
%ch=colormap(copper);
%colorbar('southoutside');
%set(h, "linewidth", 2);
%hh=xlabel("Among of C choice ");
%set(hh, "fontsize", 14);
%hh=ylabel("% Mutual Cooperation");
%set(hh, "fontsize", 14);
%hh=title("Cooperation Versus Mutual Cooperation (Colorbar=Timeout)"); 
%set(hh, "fontsize", 14);
%grid off;%grid minor;
%%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .08*[1 1 1 1 1 1 1 1 1 1 1 -1]+R_mean(I),_txtSujetos(I,:));
%t=text(-0.01*[1 1 1 1 1 1 1 -1]+_mediaXsujeto(aux),.08*[-1 -1 -1 1 1 1 1 -1]+R_mean(aux),_txtSujetos(aux,:));
%axis([0 1.05 -.04 1.05]);
%hold on;
%h=scatter(probC([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(probC([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 
%        0.04*[.5 .5 .5 .5 2.4 2.4]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 
%       -0.025*[1.2 1 1 1  -2.3 -2.3]+QQideales(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;
%
%% grafico Reward Versus R
%[Ss I]=sort(R_mean);
%figure;
%aux=I(find(sort(R_mean)>0.4));
%h=scatter(_alimento(aux),R_mean(aux),20,((_delay4eat(aux)-_timeoutITI)./_timeoutLimit),"filled");
%ch=colormap(copper);
%colorbar('southoutside');
%set(h, "linewidth", 2);
%hh=xlabel("% of maximal Reward");
%set(hh, "fontsize", 14);
%hh=ylabel("% Mutual Cooperation");
%set(hh, "fontsize", 14);
%hh=title("Reward Versus Mutual Cooperation (Colorbar=Timeout)"); 
%set(hh, "fontsize", 14);
%grid off;%grid minor;
%t=text(-0.01*[1 1 1 1 1 3 1 -1] + _alimento(aux),.07*[1 1 1 1 1 0.2 1 .5] + R_mean(aux)',_txtSujetos(aux,:))';
%%axis('auto');
%axis([.49 1.1 0 1.1]);
%hold on;
%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(0.025*[.51 .51 .51 .51 -.8 -.5]+ _idealSujeto(1,[1 3 4 5 6 7]), 
%        0.04*[.5 .5 .5 .5 1.4 1.4]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[.51 .51 .51 .51 -.8 -.5]+ _idealSujeto(1,[1 3 4 5 6 7]), 
%       -0.025*[1.2 1 1 1  1.9 1.9]+ QQideales(1,[1 3 4 5 6 7]),
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.62,-0.38,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;
%
%% Tasa de alimentacion
%%_foodRate= _alimento(1:_nSujetos)./(_delay4eat);%_vDelay4eat(1));
%%_delay2eat=_delay4eat;
%%[Ss I]=sort(_foodRate);
%%figure;
%%h=plot(_mediaXsujeto(I),100.*_delay2eat(I)./_timeOutMedia,'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%hold on;
%%set(h, "linewidth", 2);
%%hh=xlabel("Among of C choice ");
%%set(hh, "fontsize", 14);
%%hh=ylabel("Delay to eat [seconds]");
%%set(hh, "fontsize", 14);
%%hh=title("Cooperation versus Delay to eat"); 
%%set(hh, "fontsize", 14);
%%%h=plot(_mediaXsujeto(I),_delay2eat(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%grid on;
%%t=text(-0.02*[1 1 1 1 1 1 1 1 1 1 1 1]+_mediaXsujeto(I), 0.15*[1 1 -1 1 1 1 1 1 1 1 1 -1]+_delay2eat(I) ,_txtSujetos(I,:));
%%axis('auto');
%%hold on;
%%h=plot(probC([1 3 4 5]),100/120.*_idealSujeto(2,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
%%t=text(0.025*ones(1,length(probC([1 3 4 5])))+ probC([1 3 4 5])', 
%%        100/_timeOutMedia.*_idealSujeto(2,[1 3 4 5]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D"});
%%hold off;
%
%% Alimentacion Versus Delay to eat
%_delay2eat=(_delay4eat-_timeoutITI)./_timeoutLimit;
%[Ss I]=sort(_alimento);
%hhh=figure;
%aux=I(find(sort(_alimento)>0.8));
%h=scatter(_delay2eat(aux),_alimento(aux),20, _mediaXsujeto(aux),"filled");
%ch=colormap(copper);
%h=colorbar('southoutside');
%hold on;
%%h=errorbar(_delay2eat(I(find(sort(_alimento)>0.8)))./_timeOutMedia,_alimento(I(find(sort(_alimento)>0.8))),,'*k');
%%set(hhh, "linewidth", 2);
%hh=ylabel("% of total Reward");
%set(hh, "fontsize", 14);
%hh=xlabel("% total acumulated Timeout per sessions");
%set(hh, "fontsize", 14);
%hh=title("Reward versus Timeout to eat (colorbar=cooperation)"); 
%set(hh, "fontsize", 14);
%grid on;
%t=text(0.02*[-1 -1 -1 -1 -1 -1 -1 -1]+_delay2eat(aux)./_timeoutLimit,-0.04*[1 1 1 1 1.2 -1 1 -1]+_alimento(aux),_txtSujetos(aux,:));
%%axis('auto');
%axis([-.04, 1.1, .5, 1.1], "square");
%hold on;
%h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,probC([1 3 4 5 6 7]),'s',"filled");
%h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(-0.10*[1 1 1 1 1 1]+(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
%       0.05*ones(1,length(probC([1 3 4 5 6 7])))+ _idealSujeto(1,[1 3 4 5 6 7]), 
%       {"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%
%t=text(-0.10*[1 1 1 1 1 1]+ (_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
%       0.03*[1 1 1 1 1 1]+ _idealSujeto(1,[1 3 4 5 6 7]),
%       {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"}); 
%t=text(0.2,0.22,{"Normalized amoung of C choice"},"fontsize",14);       
%hold off;
%
%
%
%
%%% tiempos promedio por ensayor
%%[S I]=sort(_effectiveness);
%%figure;
%%h=plot(30*_mediaXsujeto(I),_effectiveness(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%set(h, "linewidth", 2);
%%hh=xlabel("Among of C choice ");
%%set(hh, "fontsize", 14);
%%hh=ylabel("Effectiveness [time required/spend]");
%%set(hh, "fontsize", 14);
%%hh=title("Effectiveness versus Cooperation"); 
%%set(hh, "fontsize", 14);
%%grid on;
%%t=text(-0.60*[1 1 1 1 1 1 1 1 1 1 1 -1]+30*_mediaXsujeto(I), 0.02*[1 -1 1 1 1 1 1 1 1 1 1 .5]+_effectiveness(I) ,_txtSujetos(I,:));
%%axis([1 ,30, 0, 1],'auto');
%%hold on;
%%h=plot(30*_mediaXsujeto(I(length(I))),_effectiveness(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%%hold off;
%
%%% Food versus FoodRate
%%[S I]=sort(_alimento(1:_nSujetos));
%%figure;
%%h=plot(_alimento(I),_foodRate(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%set(h, "linewidth", 2);
%%hh=xlabel("Food Harvested [Pellet]");
%%set(hh, "fontsize", 14);
%%hh=ylabel("Food rate [Pellets/trial]");
%%set(hh, "fontsize", 14);
%%hh=title("Food Rate versus Food Harvested"); 
%%set(hh, "fontsize", 14);
%%grid on;
%%t=text(-0.60*[1 1 1 1 1 1 1 1 1 1 1 -1]+_alimento(I), 0.02*[1 -1 1 1 1 1 1 1 1 1 1 .5]+_foodRate(I) ,_txtSujetos(I,:));
%%axis([1 ,30, 0, 1],'auto');
%%hold on;
%%h=plot(_alimento(I(length(I))),_foodRate(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%%hold off;
%
%%%
%
%%[Ss I]=sort(_alimento(1:_nSujetos));
%%[x, y, z] = sphere(50);
%%x=x./50;y=y./50;z=z./50;
%%figure;
%%
%%for i=I
%%  mesh((_delay4eat(i))+x, _mediaXsujeto(i)+y, _alimento(i)+z);hold on;set(h, "linewidth", 2);hold on;
%%endfor
%%figure;
%%for i=I
%%  contourc((_delay4eat(i))+x, _mediaXsujeto(i)+y, _alimento(i)+z);
%%endfor
%figure;
%contour(_delay4eat, _mediaXsujeto, _alimento);
%%&stem3((_delay4eat(i))+x, _mediaXsujeto(i)+y, _alimento(i)+z,"markersize",20,"markerfacecolor",'none', "linewidth", 3);
%hold off;
%hh=zlabel("FOOD");set(hh, "fontsize", 14);
%hh=ylabel("MEDIA DE COOPERACION");set(hh, "fontsize", 14);
%hh=xlabel("DELAY TO EAT [Seconds]");set(hh, "fontsize", 14);
%hh=title("Delay and Cooperation and Food Harvested"); 
%set(hh, "fontsize", 14);
%
%figure;
%x = randn (100, 1);
%y = randn (100, 1);
%c = x .* y;
%scatter (x, y, 20, c, 'filled');
%
%x = 1:100;
%y = 1:100;
%scatter(_alimento,_delay4eat,20, _mediaXsujeto,"filled");
%
%%_criterio=.5;
%graficos_iPD_1_2_9s_13s_12Ratas_medias_y_medianas % se obtienen los sujetos que superan el .75 porciento de cooperación
%_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
%
%
%QmarkovmediaC=zeros(2,2);
%QmarkovmediaD=zeros(2,2);
%for i=_sujetosCooperadores
%  QmarkovmediaC=QmarkovmediaC+QQTotmarkov(:,:,i);
%endfor
%QmarkovmediaC=QmarkovmediaC./sum(QmarkovmediaC,2);
%
%for i=_sujetosNocooperadores
%  QmarkovmediaD=QmarkovmediaD+QQTotmarkov(:,:,i);
%endfor
%QmarkovmediaD=QmarkovmediaD./sum(QmarkovmediaD,2);
%
%
%
%%%%%% Calculo de coeficiente de preferencia  %%%%%%%%%%%%%%%%%%%%%%%%%
%
%_selfish=foodMedia./_timeOutMedia;
%
%_selfishInf=_alimento.*_delay4eat;
%
%_selfishtheor=_idealSujeto(1,:)*30./_idealSujeto(2,:);
%
%hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}
%hold on;
%scatter(_selfish,ones(1,_nSujetos),20,"filled");
%t=text(-0.002+_selfish,0.013+ones(1,_nSujetos),_txtSujetos(:,:),"fontsize",14);
%h=scatter(_selfishtheor([1 2 3 5 6]),ones(1,length(_selfishtheor([1 2 3 5 6]))),25,'r');
%set(h, "linewidth", 2);  
%t=text(-0.005+_selfishtheor([1 2 3 5 6]),-0.013+ones(1,length(_selfishtheor([1 2 3 5 6]))),
%                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD"},"fontsize",12);
%t=text([0.26 0.27 0.26 0.27],[1.055 1.055 1.045 1.045],
%       {num2str(_vRefuerzos(1));num2str(_vRefuerzos(2));num2str(_vRefuerzos(3));num2str(_vRefuerzos(4))},"fontsize",13);                                     
%t=text(0.005+[0.26 0.27 0.26 0.27],-0.005+[1.055 1.055 1.045 1.045],
%       {num2str(_vDelay4eat(1));num2str(_vDelay4eat(2));num2str(_vDelay4eat(3));num2str(_vDelay4eat(4))},"fontsize",13);
%hold off;
%ylabel("");
%xlabel("Coefficient of preference");
%
%
%name=strcat("figura_iPD_1_2_9s_13s/fig_finales/coefficientOfPreference",_txtSujetos(i,:));
%name=strcat(name,".png");
%print(hhh, name);

%probC=zeros(1,_nSujetos);
%%probC=_mediaXsujeto;
%probD=zeros(1,_nSujetos);
%%probD=1-_mediaXsujeto;
%
%for i=1:_nSujetos
%  probC(i)=QQTotmarkov(2,1,i)/(1+QQTotmarkov(2,1,i)-QQTotmarkov(1,1,i));
%endfor
%probD=1-probC;
%
%N=1; % numero de trials
%_alimento_MK=zeros(1,_nSujetos); %                      
%for i=_vSujetos   % vec [a b;c d] -> [a c b d] = [c|c c|d d|c d|d]              mal[c|c d|c c|d d|d]
%  %                           R S T P
%  _alimento_MK(i)=N*_vRefuerzos([1 4 2 3])*(vec(QQTotmarkov(:,:,i)).*[probC(i);probD(i);probC(i);probD(i)]);
%endfor
%
%_delay4eat_MK=zeros(1,_nSujetos);
%for i=_vSujetos   % vec [a b;c d] -> [a c b d] = [c|c c|d d|c d|d]
%  _delay4eat_MK(i)=30*_vDelay4eat([1 4 2 3])*(vec(QQTotmarkov(:,:,i)).*[probC(i);probD(i);probC(i);probD(i)]);
%endfor
%
%for i=1:_nSujetos
%  hhh=figure;
%  h=errorbar([1:4],vec(QQTotmarkov(:,:,i))',vec(QQTotmarkovSem(:,:,i))','*k');
%  hold on;set(h, "linewidth", 2);     
%  h=bar([1:4],vec(QQTotmarkov(:,:,i)),'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
%  h=plot([0:5],[.5 .5 .5 .5 .5 .5],"--r");
%  axis ("tic[yz]", "labely[xyz]");
%  set(h, "linewidth", 2);  
%  legend("SEM","MEAN");
%  %hh=xlabel("T=1 --- R=2 --- P=3 --- S=4");set(hh, "fontsize", 14);
%  hh=ylabel("P(C|X)");set(hh, "fontsize", 14);
%  hh=title(strcat("Probability of Cooperation given last choose: ",_txtSujetos(i,:)));
%  set(hh, "fontsize", 14);
%  axis ("tic[yz]", "labely[xyz]");
%  t=text([1:4], -.04*ones(1,4), {"P(c|c)"; "P(c|d)";"P(d|c)";"P(d|d)"},"fontsize",14);
%  axis([0 5 0 1]);
%  hold off;grid on;
%  %name=strcat("figura_iPD_1_2_9s_13s/fig_finales/prob_C_dado_X/",_txtSujetos(i,:));
%  %name=strcat(name,".png");
%  %print(hhh, name);
%endfor
%
%
%
%for i=1:_nSujetos
%  hhh=figure;
%  %h=errorbar([1:4],vec(probxExpTotal_CD_N(j,:,i))',vec()','*k');
%  hold on;set(h, "linewidth", 2);     
%  h=bar([1:4],vec(probxExpTotal_CD_N(:,:,i)),'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
%  h=plot([0:5],[.5 .5 .5 .5 .5 .5],"--r");
%  axis ("tic[yz]", "labely[xyz]");
%  set(h, "linewidth", 2);  
%  legend("SEM","MEAN");
%  %hh=xlabel("T=1 --- R=2 --- P=3 --- S=4");set(hh, "fontsize", 14);
%  hh=ylabel("P(C|X)");set(hh, "fontsize", 14);
%  hh=title(strcat("Probability of Cooperation given last choose: ",_txtSujetos(i,:)));
%  set(hh, "fontsize", 14);
%  axis ("tic[yz]", "labely[xyz]");
%  t=text([1:4], -.04*ones(1,4), {"P(c|c)"; "P(c|d)";"P(d|c)";"P(d|d)"},"fontsize",14);
%  axis([0 5 0 1]);
%  hold off;grid on;
%  %name=strcat("figura_iPD_1_2_9s_13s/fig_finales/prob_C_dado_X/",_txtSujetos(i,:));
%  %name=strcat(name,".png");
%  %print(hhh, name);
%endfor
%


%[Ss I]=sort(_mediaXsujeto);
%figure;
%aux=I(find(sort(_mediaXsujeto)>0.5));
%h=scatter(_mediaXsujeto(aux),R_mean(aux),20,((_timeOutMedia(aux)-_timeoutITI)./_timeoutLimit),"filled");
%ch=colormap(copper);
%colorbar('southoutside');
%set(h, "linewidth", 2);
%hh=xlabel("Among of C choice ");
%set(hh, "fontsize", 14);
%hh=ylabel("% Mutual Cooperation");
%set(hh, "fontsize", 14);
%hh=title("Cooperation Versus Mutual Cooperation (Colorbar=Timeout)"); 
%set(hh, "fontsize", 14);
%grid off;%grid minor;
%%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .08*[1 1 1 1 1 1 1 1 1 1 1 -1]+R_mean(I),_txtSujetos(I,:));
%t=text(-0.01*[1 1 1 1 1 1 1 -1]+_mediaXsujeto(aux),.08*[-1 -1 -1 1 1 1 1 -1]+R_mean(aux),_txtSujetos(aux,:));
%axis([0 1.05 -.04 1.05]);
%hold on;
%h=scatter(probC([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(probC([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 
%        0.04*[.5 .5 .5 .5 2.4 2.4]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 
%       -0.025*[1.2 1 1 1  -2.3 -2.3]+QQideales(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;


%%%%%%%%%%%ultimos graficos%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%for i=1:_nSujetos
%  hhh=figure;
%  h=errorbar([1:4],vec(probxExpTotal_CD_N(:,:,i))',vec(probEleccionSem(:,1,i))','*k');
%  hold on;set(h, "linewidth", 2);     
%  h=bar([1:4],vec(probxExpTotal_CD_N(:,:,i)),'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
%  h=plot([0:5],[.5 .5 .5 .5 .5 .5],"--r");
%  axis ("tic[yz]", "labely[xyz]");
%  set(h, "linewidth", 2);  
%  legend("SEM","MEAN");
%  %hh=xlabel("T=1 --- R=2 --- P=3 --- S=4");set(hh, "fontsize", 14);
%  hh=ylabel("P(C|X)");set(hh, "fontsize", 14);
%  hh=title(strcat("Probability of Cooperation given last choose: ",_txtSujetos(i,:)));
%  set(hh, "fontsize", 14);
%  axis ("tic[yz]", "labely[xyz]");
%  t=text([1:4], -.04*ones(1,4), {"P(c|c)"; "P(c|d)";"P(d|c)";"P(d|d)"},"fontsize",14);
%  axis([0 5 0 1]);
%  hold off;grid on;
%  name=strcat("figura_iPD_1_2_9s_13s/fig_finales/prob_C_dado_X/",_txtSujetos(i,:));
%  name=strcat(name,".png");
%  print(hhh, name);
%endfor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%% grafico Alimentos versus Cooperacion
%[Ss I]=sort(_mediaXsujeto);
%figure;
%aux=I(find(sort(_mediaXsujeto)>0.5));
%%h=plot(_mediaXsujeto(I),_alimento(I),'ko', "markersize",12,"markerfacecolor",'c', "linewidth", 2);
%h=scatter(_mediaXsujeto(aux),foodMedia(aux),20,(_timeOutMedia(aux)-_timeoutITI)./_timeoutLimit,"filled");
%ch=colormap(copper);
%colorbar('southoutside');
%set(h, "linewidth", 2);
%hh=xlabel("Among of C choice ");
%set(hh, "fontsize", 14);
%hh=ylabel("% Total Reward");
%set(hh, "fontsize", 14);
%hh=title("Reward versus Cooperation (Colorbar=Timeout)"); 
%set(hh, "fontsize", 14);
%grid off;%grid minor;
%t=text(-0.01*[1 1 1 1 1 1 1 -1]+_mediaXsujeto(aux),.08*[ 1 1 1 1 1 1 1 -1]+foodMedia(aux),_txtSujetos(aux,:));
%%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .03*[1 1 1 1 1 1 1 1 1 1 1 -1]+foodMedia(I) ,_txtSujetos(I,:));
%%axis('auto');
%axis([.49 1.02 0 1.15]);
%hold on;
%%h=plot(_mediaXsujeto(I(length(I))),foodMedia(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%h=scatter(probC2([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(probC2([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),_idealSujeto(2,[1 3 4 5 6 7]),15,probC([1 3 4 5 6 7])','s',"filled");
%%h=plot(probC([1 3 4 5]),_idealSujeto(1,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC2([1 3 4 5 6 7])', 
%        0.04*[.5 .5 .5 .5 2.9 2.9]+_idealSujeto(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC2([1 3 4 5 6 7])', 
%       -0.025*[1.2 1 1 1 -3.2 -3.2]+_idealSujeto(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;
%
%
%% grafico Cooperacion Versus R
%[Ss I]=sort(_mediaXsujeto);
%figure;
%aux=I(find(sort(_mediaXsujeto)>0.5));
%h=scatter(_mediaXsujeto(aux),R_mean(aux),20,((_timeOutMedia(aux)-_timeoutITI)./_timeoutLimit),"filled");
%ch=colormap(copper);
%colorbar('southoutside');
%set(h, "linewidth", 2);
%hh=xlabel("Among of C choice ");
%set(hh, "fontsize", 14);
%hh=ylabel("% Mutual Cooperation");
%set(hh, "fontsize", 14);
%hh=title("Cooperation Versus Mutual Cooperation (Colorbar=Timeout)"); 
%set(hh, "fontsize", 14);
%grid off;%grid minor;
%%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .08*[1 1 1 1 1 1 1 1 1 1 1 -1]+R_mean(I),_txtSujetos(I,:));
%t=text(-0.01*[1 1 1 1 1 1 1 -1]+_mediaXsujeto(aux),.08*[-1 -1 -1 1 1 1 1 -1]+R_mean(aux),_txtSujetos(aux,:));
%axis([.49 1.05 -.04 1.15]);
%hold on;
%h=scatter(probC2([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(probC2([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC2([1 3 4 5 6 7])', 
%        0.04*[.5 .5 .5 .5 2.4 2.4]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC2([1 3 4 5 6 7])', 
%       -0.025*[1.2 1 1 1  -2.3 -2.3]+QQideales(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.6,-0.44,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;
%
%% grafico Reward Versus R
%[Ss I]=sort(R_mean);
%figure;
%aux=I(find(sort(R_mean)>0.4));
%h=scatter(foodMedia(aux),R_mean(aux),20,((_timeOutMedia(aux)-_timeoutITI)./_timeoutLimit),"filled");
%ch=colormap(copper);
%colorbar('southoutside');
%set(h, "linewidth", 2);
%hh=xlabel("% of maximal Reward");
%set(hh, "fontsize", 14);
%hh=ylabel("% Mutual Cooperation");
%set(hh, "fontsize", 14);
%hh=title("Reward Versus Mutual Cooperation (Colorbar=Timeout)"); 
%set(hh, "fontsize", 14);
%grid off;%grid minor;
%t=text(-0.01*[1 1 1 1 1 3 1 -1] + foodMedia(aux),.07*[1 1 1 1 1 0.2 1 .5] + R_mean(aux),_txtSujetos(aux,:));
%%axis('auto');
%axis([.49 1.1 0 1.1]);
%hold on;
%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(0.025*[.51 .51 .51 .51 -.8 -.5]+ _idealSujeto(1,[1 3 4 5 6 7]), 
%        0.04*[.5 .5 .5 .5 1.4 1.4]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[.51 .51 .51 .51 -.8 -.5]+ _idealSujeto(1,[1 3 4 5 6 7]), 
%       -0.025*[1.2 1 1 1  1.9 1.9]+ QQideales(1,[1 3 4 5 6 7]),
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.62,-0.38,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;
%
%% Tasa de alimentacion
%%_foodRate= foodMedia(1:_nSujetos)./(_timeOutMedia);%_vDelay4eat(1));
%%_delay2eat=_timeOutMedia;
%%[Ss I]=sort(_foodRate);
%%figure;
%%h=plot(_mediaXsujeto(I),100.*_delay2eat(I)./_timeOutMedia,'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%hold on;
%%set(h, "linewidth", 2);
%%hh=xlabel("Among of C choice ");
%%set(hh, "fontsize", 14);
%%hh=ylabel("Delay to eat [seconds]");
%%set(hh, "fontsize", 14);
%%hh=title("Cooperation versus Delay to eat"); 
%%set(hh, "fontsize", 14);
%%%h=plot(_mediaXsujeto(I),_delay2eat(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%grid on;
%%t=text(-0.02*[1 1 1 1 1 1 1 1 1 1 1 1]+_mediaXsujeto(I), 0.15*[1 1 -1 1 1 1 1 1 1 1 1 -1]+_delay2eat(I) ,_txtSujetos(I,:));
%%axis('auto');
%%hold on;
%%h=plot(probC([1 3 4 5]),100/120.*_idealSujeto(2,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
%%t=text(0.025*ones(1,length(probC([1 3 4 5])))+ probC([1 3 4 5])', 
%%        100/_timeOutMedia.*_idealSujeto(2,[1 3 4 5]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D"});
%%hold off;
%
%% Alimentacion Versus Delay to eat
%_delay2eat=(_timeOutMedia-_timeoutITI)./_timeoutLimit;
%[Ss I]=sort(foodMedia);
%hhh=figure;
%aux=I(find(sort(foodMedia)>0.8));
%h=scatter(_delay2eat(aux),foodMedia(aux),20, _mediaXsujeto(aux),"filled");
%ch=colormap(copper);
%h=colorbar('southoutside');
%hold on;
%%h=errorbar(_delay2eat(I(find(sort(foodMedia)>0.8)))./_timeOutMedia,foodMedia(I(find(sort(foodMedia)>0.8))),,'*k');
%%set(hhh, "linewidth", 2);
%hh=ylabel("% of total Reward");
%set(hh, "fontsize", 14);
%hh=xlabel("% total acumulated Timeout per sessions");
%set(hh, "fontsize", 14);
%hh=title("Reward versus Timeout to eat (colorbar=cooperation)"); 
%set(hh, "fontsize", 14);
%grid on;
%t=text(0.02*[-1 -1 -1 -1 -1 -1 -1 -1]+_delay2eat(aux)./_timeoutLimit,-0.04*[1 1 1 1 1.2 -1 1 -1]+foodMedia(aux),_txtSujetos(aux,:));
%%axis('auto');
%axis([-.04, 1.1, .5, 1.1], "square");
%hold on;
%h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,probC([1 3 4 5 6 7])','s',"filled");
%h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(-0.10*[1 1 1 1 1 1]+(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
%       0.05*ones(1,length(probC([1 3 4 5 6 7])))+ _idealSujeto(1,[1 3 4 5 6 7]), 
%       {"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%
%t=text(-0.10*[1 1 1 1 1 1]+ (_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
%       0.03*[1 1 1 1 1 1]+ _idealSujeto(1,[1 3 4 5 6 7]),
%       {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"}); 
%t=text(0.2,0.22,{"Normalized amoung of C choice"},"fontsize",14);       
%hold off;
%
%
%
%
%%% tiempos promedio por ensayor
%%[S I]=sort(_effectiveness);
%%figure;
%%h=plot(30*_mediaXsujeto(I),_effectiveness(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%set(h, "linewidth", 2);
%%hh=xlabel("Among of C choice ");
%%set(hh, "fontsize", 14);
%%hh=ylabel("Effectiveness [time required/spend]");
%%set(hh, "fontsize", 14);
%%hh=title("Effectiveness versus Cooperation"); 
%%set(hh, "fontsize", 14);
%%grid on;
%%t=text(-0.60*[1 1 1 1 1 1 1 1 1 1 1 -1]+30*_mediaXsujeto(I), 0.02*[1 -1 1 1 1 1 1 1 1 1 1 .5]+_effectiveness(I) ,_txtSujetos(I,:));
%%axis([1 ,30, 0, 1],'auto');
%%hold on;
%%h=plot(30*_mediaXsujeto(I(length(I))),_effectiveness(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%%hold off;
%
%%% Food versus FoodRate
%%[S I]=sort(foodMedia(1:_nSujetos));
%%figure;
%%h=plot(foodMedia(I),_foodRate(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%set(h, "linewidth", 2);
%%hh=xlabel("Food Harvested [Pellet]");
%%set(hh, "fontsize", 14);
%%hh=ylabel("Food rate [Pellets/trial]");
%%set(hh, "fontsize", 14);
%%hh=title("Food Rate versus Food Harvested"); 
%%set(hh, "fontsize", 14);
%%grid on;
%%t=text(-0.60*[1 1 1 1 1 1 1 1 1 1 1 -1]+foodMedia(I), 0.02*[1 -1 1 1 1 1 1 1 1 1 1 .5]+_foodRate(I) ,_txtSujetos(I,:));
%%axis([1 ,30, 0, 1],'auto');
%%hold on;
%%h=plot(foodMedia(I(length(I))),_foodRate(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%%hold off;
%
%%%
%
%%[Ss I]=sort(foodMedia(1:_nSujetos));
%%[x, y, z] = sphere(50);
%%x=x./50;y=y./50;z=z./50;
%%figure;
%%
%%for i=I
%%  mesh((_timeOutMedia(i))+x, _mediaXsujeto(i)+y, foodMedia(i)+z);hold on;set(h, "linewidth", 2);hold on;
%%endfor
%%figure;
%%for i=I
%%  contourc((_timeOutMedia(i))+x, _mediaXsujeto(i)+y, foodMedia(i)+z);
%%endfor
%figure;
%contour(_timeOutMedia, _mediaXsujeto, foodMedia);
%%&stem3((_timeOutMedia(i))+x, _mediaXsujeto(i)+y, foodMedia(i)+z,"markersize",20,"markerfacecolor",'none', "linewidth", 3);
%hold off;
%hh=zlabel("FOOD");set(hh, "fontsize", 14);
%hh=ylabel("MEDIA DE COOPERACION");set(hh, "fontsize", 14);
%hh=xlabel("DELAY TO EAT [Seconds]");set(hh, "fontsize", 14);
%hh=title("Delay and Cooperation and Food Harvested"); 
%set(hh, "fontsize", 14);
%
%figure;
%x = randn (100, 1);
%y = randn (100, 1);
%c = x .* y;
%scatter (x, y, 20, c, 'filled');
%
%x = 1:100;
%y = 1:100;
%scatter(foodMedia,_timeOutMedia,20, _mediaXsujeto,"filled");
%
%%_criterio=.5;
%%graficos_iPD_1_2_9s_13s_12Ratas_medias_y_medianas % se obtienen los sujetos que superan el .75 porciento de cooperación
%_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
%
%
%QmarkovmediaC=zeros(2,2);
%QmarkovmediaD=zeros(2,2);
%for i=_sujetosCooperadores
%  QmarkovmediaC=QmarkovmediaC+QQTotmarkov(:,:,i);
%endfor
%QmarkovmediaC=QmarkovmediaC./sum(QmarkovmediaC,2);
%
%for i=_sujetosNocooperadores
%  QmarkovmediaD=QmarkovmediaD+QQTotmarkov(:,:,i);
%endfor
%QmarkovmediaD=QmarkovmediaD./sum(QmarkovmediaD,2);
%
%

%%%%% Calculo de coeficiente de preferencia  %%%%%%%%%%%%%%%%%%%%%%%%%

_selfish=foodMedia./((_timeOutMedia)./_timeoutLimit);

_selfishInf=foodMedia.*_timeOutMedia;

_selfishtheor=_idealSujeto(1,:)./((_idealSujeto(2,:))./_timeoutLimit);

hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}

t=text(-0.002+_selfish(_sujetosCooperadores),0.06*[1 1 1 1 1 1.8 1 1]+ones(1,length(_sujetosCooperadores)),_txtSujetos(_sujetosCooperadores,:),"fontsize",14);
hold on;
%h=scatter(_selfishtheor([1 2 3 5 6]),ones(1,length(_selfishtheor([1 2 3 5 6]))),25,'r');
%set(h, "linewidth", 2);  
h=scatter(_selfish(_sujetosCooperadores),ones(1,length(_sujetosCooperadores)),17,"k","filled");
h=scatter(_selfishtheor([1 2 3 5 6 7]),ones(1,length(_selfishtheor([1 2 3 5 6 7]))),25,'r');
t=text(-0.005*[1 1 1 11 1 1]+_selfishtheor([1 2 3 5 6 7]),-0.007+ones(1,length(_selfishtheor([1 2 3 5 6 7]))),...
                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD","CCCD"},"fontsize",12);
%t=text([0.26 0.27 0.26 0.27],[1.055 1.055 1.045 1.045],
%       {num2str(_vRefuerzos(1));num2str(_vRefuerzos(2));num2str(_vRefuerzos(3));num2str(_vRefuerzos(4))},"fontsize",13);                                     
%t=text(0.005+[0.26 0.27 0.26 0.27],-0.005+[1.055 1.055 1.045 1.045],
%       {num2str(_vDelay4eat(1));num2str(_vDelay4eat(2));num2str(_vDelay4eat(3));num2str(_vDelay4eat(4))},"fontsize",13);
plot([1 1], [1.05 0.95], '--k');
axis([.73 1.86 .95 1.05]);
%ylabel("");
xlabel("Coefficient of preference");
hold off;

%name="figura_iPD_1_2_9s_13s/fig_finales/coefficientOfPreference.png";%strcat("figura_iPD_1_2_9s_13s/fig_finales/coefficientOfPreference",".png");
%print(hhh, name);



%-------  coopMedia/timeout
_timeoutLimit=15*13+15*5;
_selfish=_mediaXsujeto./((_timeOutMedia)./_timeoutLimit);

_selfishInf=_mediaXsujeto.*_timeOutMedia;

_selfishtheor=probC2'./((_idealSujeto(2,:))./_timeoutLimit);

hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}

t=text(-0.002+_selfish,-0.05*[1 .6 1 1 1 1 1 1 1 1.8 1 1 ]+foodMedia,_txtSujetos,"fontsize",14);
hold on;
%h=scatter(_selfishtheor([1 2 3 5 6]),ones(1,length(_selfishtheor([1 2 3 5 6]))),25,'r');
%set(h, "linewidth", 2);  
h=scatter(_selfish,foodMedia,17,"k","filled");
h=scatter(_selfishtheor([1 2 3 5 6]),_idealSujeto(1,[1 2 3 5 6]),25,'k'); set(h, "linewidth", 3);

t=text(-0.01*[1 1 5 -1 1]+_selfishtheor([1 2 3 5 6]),0.05*[ 2 1 1.5 1 1 ]'+probC2([1 2 3 5 6]),...
                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD"},"fontsize",12);
%axis([.3 .85 .95 1.05]);
ylabel("Cooperation [%]");
xlabel("Coefficient of preference Coop/timeOut");
hold off;

%-------  coopMedia/timeout

_selfish=_mediaXsujeto./((_timeOutMedia)./_timeoutLimit);

_selfishInf=_mediaXsujeto.*_timeOutMedia;

_selfishtheor=probC2'./((_idealSujeto(2,:))./_timeoutLimit);

hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}

t=text(foodMedia,-0.002+_selfish,_txtSujetos,"fontsize",14);
hold on;
%h=scatter(_selfishtheor([1 2 3 5 6]),ones(1,length(_selfishtheor([1 2 3 5 6]))),25,'r');
%set(h, "linewidth", 2);  
h=scatter(foodMedia,_selfish,17,"k","filled");
h=scatter(_idealSujeto(1,[1 2 3 5 6 7]),_selfishtheor([1 2 3 5 6 7]),25,'k');set(h, "linewidth", 3);
t=text(0.00*[ 2 1 1.5 1 1 1]+_idealSujeto(1,[1 2 3 5 6 7]),-0.00*[1 1 5 -1 1 1]+_selfishtheor([1 2 3 5 6 7]),...
                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD","CCCD"},"fontsize",12);
%axis([.3 .85 .95 1.05]);
xlabel("Reward [%] GG");
ylabel("Coefficient of preference Coop/timeOut");
hold off;


%-------  coopMedia/timeout INFINITY

%_selfish=_mediaXsujeto./((_timeOutMedia)./_timeoutLimit);
%_selfishInf
_selfish=log(_mediaXsujeto./((_timeOutMedia-_timeoutITI)./_timeoutLimit));

_selfishtheor=log(probC2'./((_idealSujeto(2,:)-_timeoutITI)./_timeoutLimit));

hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}

t=text(foodMedia,-0.002+_selfish,_txtSujetos,"fontsize",14);
hold on;
%h=scatter(_selfishtheor([1 2 3 5 6]),ones(1,length(_selfishtheor([1 2 3 5 6]))),25,'r');
%set(h, "linewidth", 2);  
h=scatter(foodMedia,_selfish,17,"k","filled");
h=scatter(_idealSujeto(1,[1 2 3 5 6 7]),_selfishtheor([1 2 3 5 6 7]),25,'k');set(h, "linewidth", 3);
t=text(0.00*[ 2 1 1.5 1 1 1]+_idealSujeto(1,[1 2 3 5 6 7]),-0.00*[1 1 5 -1 1 1]+_selfishtheor([1 2 3 5 6 7]),...
                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD","CCCD"},"fontsize",12);
%axis([.3 .85 .95 1.05]);
xlabel("Reward [%]");
ylabel("Coefficient of preference Coop/timeOut");
hold off;




