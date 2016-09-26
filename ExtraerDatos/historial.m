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
