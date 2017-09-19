% ----------- ¿Cuanto tarda en dejar la palanca D? -----------------------------

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
  for j=expXsuj(i)-9:expXsuj(i)
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

%cuantoComeXexp;

vVoluntadDfood=zeros(32,_nSujetos);
vVoluntadCfood=zeros(32,_nSujetos);
vVoluntadDfoodSem=zeros(32,_nSujetos);
vVoluntadCfoodSem=zeros(32,_nSujetos);
% Histograma en D
vVoluntades=zeros(_combC+_iniFin,_nSujetos);
vVoluntadesSem=zeros(_combC+_iniFin,_nSujetos);
for i=1:_nSujetos
  vVoluntades(:,i)=mean(voluntad(:,expXsuj(i)-9:expXsuj(i),i),2);
  vVoluntadesSem(:,i)=sem(voluntad(:,expXsuj(i)-9:expXsuj(i),i),2);
  vVoluntadDfood(:,i)=mean(voluntadDfood(1:32,expXsuj(i)-9:expXsuj(i),i),2);
  vVoluntadDfoodSem(:,i)=sem(voluntadDfood(1:32,expXsuj(i)-9:expXsuj(i),i),2);
endfor
vVoluntadesC=zeros(_combC+_iniFin+_fallas,_nSujetos);
vVoluntadesCSem=zeros(_combC+_iniFin+_fallas,_nSujetos);
for i=1:_nSujetos
  vVoluntadesC(:,i)=mean(voluntadC(:,expXsuj(i)-9:expXsuj(i),i),2);  
  vVoluntadesCSem(:,i)=sem(voluntadC(:,expXsuj(i)-9:expXsuj(i),i),2);
  vVoluntadCfood(:,i)=mean(voluntadCfood(1:32,expXsuj(i)-9:expXsuj(i),i),2);
  vVoluntadCfoodSem(:,i)=sem(voluntadCfood(1:32,expXsuj(i)-9:expXsuj(i),i),2);
endfor


for i=1:_nSujetos
  figure;
  h=errorbar(-.18+[1:length(vVoluntadesC([1:17 31 32],1))],vVoluntadesC([1:17 31 32],i),vVoluntadesCSem([1:17 31 32],i),'*b',
            .18+[1:length(vVoluntades([1:17 31 32],1))],vVoluntades([1:17 31 32],i),vVoluntadesSem([1:17 31 32],i),'*g');
  set (h(1), "linewidth", 2);
  set (h(2), "linewidth", 2);
  legend ('C errbar', 'D errbar');
  hold on;
  h=bar([vVoluntadesC([1:17 31 32],i),vVoluntades([1:17 31 32],i)],'*c');
  set (h, "linewidth", 2);
  set (h(1), 'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
  set (h(2), 'facecolor', 'r', 'edgecolor','k', "linewidth", 2);
  xlabel("eventos D entre C - C");
  ylabel("ocurrecia por eventos");
  title(strcat("voluntad por D - Sujeto: ",_txtSujetos(i,:)));
  axis ("tic[yz]", "labely[xyz]");
  auxPtr=strcat(vPtr,num2str(vVoluntadDfood(:,i),2));
  auxPtrC=strcat(vPtrC,num2str(vVoluntadCfood(:,i),2));
  %t=text(-0.06+[1:length(vPtr([1:17 31 32],1))], 1*ones(1,length(vPtr([1:17 31 32],1))) , vPtrC([1:17 31 32],:));
  t=text(-0.06+[1:length(vPtr([1:17 31 32],1))], 1*ones(1,length(vPtr([1:17 31 32],1))) , auxPtrC([1:17 31 32],:));
  set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
  t=text(0.28+[1:length(vPtr([1:17 31 32],1))], 1*ones(1,length(vPtr([1:17 31 32],1))) , auxPtr([1:17 31 32],:));
  set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
endfor
% SEPARAR ENTRE COOPERADORES Y NO
% Histograma en D
_criterio=.70;
graficos_iPD_1_2_9s_13s_12Ratas_medias_y_medianas % se obtienen los sujetos que superan el .75 porciento de cooperación
_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos); % Obtiene los indices de los no coop

% Medias y SEM
voluntadDStdC  =sem (vVoluntades(:,_sujetosCooperadores),2);
voluntadDMediaC=mean(vVoluntades(:,_sujetosCooperadores),2);
voluntadDMediaD=mean(vVoluntades(:,_sujetosNocooperadores),2);
voluntadDStdD  =sem (vVoluntades(:,_sujetosNocooperadores),2);
%
voluntadDfoodMediaC=mean(vVoluntadDfood(:,_sujetosCooperadores),2);
voluntadDfoodSemC=sem(vVoluntadDfood(:,_sujetosCooperadores),2);
voluntadDfoodMediaD=mean(vVoluntadDfood(:,_sujetosNocooperadores),2);
voluntadDfoodSemD=sem(vVoluntadDfood(:,_sujetosNocooperadores),2);
%
voluntadCMediaC=mean(vVoluntadesC(:,_sujetosCooperadores),2);
voluntadCStdC=sem(vVoluntadesC(:,_sujetosCooperadores),2);
voluntadCMediaD=mean(vVoluntadesC(:,_sujetosNocooperadores),2);
voluntadCStdD=sem(vVoluntadesC(:,_sujetosNocooperadores),2);
%
voluntadCfoodMediaC=mean(vVoluntadCfood(:,_sujetosCooperadores),2);
voluntadCfoodSemC=sem(vVoluntadCfood(:,_sujetosCooperadores),2);
voluntadCfoodMediaD=mean(vVoluntadCfood(:,_sujetosNocooperadores),2);
voluntadCfoodSemD=sem(vVoluntadCfood(:,_sujetosNocooperadores),2);


%%%% SOLO COOPERADORES Voluntad por D y por C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
%h=errorbar([1:length(voluntadMediaTot)],voluntadMediaTot, voluntadStdTot,'*b');
%h=errorbar(voluntadMediaC(1:32,1),voluntadStdC(1:32,1),'*b',voluntadMedia(1:32,1),  voluntadStd,'*r');
h=errorbar(-.18+[1:length(voluntadCMediaC(1:32,1))],voluntadCMediaC(1:32,1),voluntadCStdC(1:32,1),'*b',
            .18+[1:length(voluntadDMediaC(1:32,1))],voluntadDMediaC(1:32,1),voluntadDStdC(1:32,1),'*g');
set (h(1), "linewidth", 2);
set (h(2), "linewidth", 2);
legend ('C errbar', 'D errbar');
hold on;
%h=bar(voluntadMediaTot,"facecolor", "none","edgecolor","m");
h=bar([voluntadCMediaC(1:32,1),voluntadDMediaC(1:32,1)],"facecolor", "none","edgecolor","m");
hold off;
set (h(1), 'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
set (h(2), 'facecolor', 'r', 'edgecolor','k', "linewidth", 2);
%set (h, "linewidth", 2);
xlabel("eventos D y C");
ylabel("ocurrecia por eventos");
title(strcat("Promedio Sujetos Cooperadores"));
axis ("tic[yz]", "labely[xyz]");
auxPtr=strcat(vPtr,num2str(voluntadDfoodMediaC,2));
auxPtrC=strcat(vPtrC,num2str(voluntadCfoodMediaC,2));
%set(gca, 'XTick', 1:4, 'XTickLabel', t);
%t=text(0.5+[1:length(vPtrTot(:,1))], 0.5*ones(1,length(vPtrTot(:,1))) , vPtrTot);
%vPtrTot2=[ vPtrC vPtr]
t=text(-0.06+[1:length(vPtr(:,1))], 1*ones(1,length(vPtr(:,1))) , vPtrC);
set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
t=text(0.28+[1:length(vPtr(:,1))], 1*ones(1,length(vPtr(:,1))) , vPtr);
set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
%t=text(0.5+[1:length(vPtrTot(:,1))], 0.5*ones(1,length(vPtrTot2(:,1))) , vPtrTot2);
%set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SOLO NO COOP Voluntad por D y por C 
figure;
h=errorbar(-.18+[1:length(voluntadCMediaD(1:32,1))],voluntadCMediaD(1:32,1),voluntadCStdD(1:32,1),'*b',
            .18+[1:length(voluntadDMediaD(1:32,1))],voluntadDMediaD(1:32,1),voluntadDStdD(1:32,1),'*g');
set (h(1), "linewidth", 2);
set (h(2), "linewidth", 2);
legend ('C errbar', 'D errbar');
hold on;
h=bar([voluntadCMediaD(1:32,1),voluntadDMediaD(1:32,1)],"facecolor", "none","edgecolor","m");
hold off;
set (h(1), 'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
set (h(2), 'facecolor', 'r', 'edgecolor','k', "linewidth", 2);
xlabel("eventos D y C");
ylabel("ocurrecia por eventos");
title(strcat("Promedio Sujetos NO Cooperadores ( ultimas 10s)"));
axis ("tic[yz]", "labely[xyz]");
auxPtr=strcat(vPtr,num2str(voluntadDfoodMediaC,2));
auxPtrC=strcat(vPtrC,num2str(voluntadCfoodMediaC,2));
t=text(-0.06+[1:length(vPtr(:,1))], 1*ones(1,length(vPtr(:,1))) , vPtrC);
set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
t=text(0.28+[1:length(vPtr(:,1))], 1*ones(1,length(vPtr(:,1))) , vPtr);
set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% SUPERPOSICION
h=figure;
%h=errorbar([1:length(_dejarD)],voluntadMedia, voluntadStd,'*b');
%h=errorbar(-.18+[1:length(_dejarD)],voluntadMedia2, voluntadStd2,'*b',.18+[1:length(_dejarD)],voluntadMedia2, voluntadStd2,'*b');

hold on;
h=bar([voluntadCMediaC(1:32,1),voluntadDMediaC(1:32,1)],"facecolor", "none","edgecolor","m");
%h=bar(voluntadMedia,"facecolor", "y","edgecolor","r");
set (h(1), 'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
set (h(2), 'facecolor', 'r', 'edgecolor','k', "linewidth", 2);
%set (h, "linewidth", 2);
%h=errorbar([1:length(_dejarD)],voluntadMedia2, voluntadStd2,'*g');
h=bar([voluntadCMediaD(1:32,1),voluntadDMediaD(1:32,1)],"facecolor", "none","edgecolor","m");
set (h(1), 'facecolor', 'none', 'edgecolor','c', "linewidth", 2);
set (h(2), 'facecolor', 'none', 'edgecolor','m', "linewidth", 2);
%h=bar(voluntadMedia2,"facecolor", "none","edgecolor","m");set (h, "linewidth", 2);

hold off;
xlabel("eventos D entre C - C");
ylabel("ocurrecia por eventos");
title(strcat("Diferencias entre los promedio entre grupos"));
h=legend ('Vol C Coop', 'Vol D Coop','Vol C No Coop','Vol D No Coop');
set (h, 'fontsize', 12);

