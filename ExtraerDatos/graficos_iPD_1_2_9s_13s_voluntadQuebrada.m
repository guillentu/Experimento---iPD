% ----------- ¿Cuanto tarda en dejar la palanca D? -----------------------------

%clear all
close all
%load "iPD_1_2_9s_13s/datosCargadoWorkspace20160423";
load "iPD_1_2_9s_13s/datos_errores_y_tiempos"
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


% Histograma en D
vVoluntades=zeros(_combC+_iniFin,_nSujetos);
for i=1:_nSujetos
  vVoluntades(:,i)=mean(voluntad(:,expXsuj(i)-9:expXsuj(i),i),2);
%  figure;
%  h=bar(vVoluntades(:,i)','*c');
%  set (h, "linewidth", 3);
%  xlabel("eventos D entre C - C");
%  ylabel("ocurrecia por eventos");
%  title(strcat("voluntad por D - Sujeto: ",_txtSujetos(i,:)));
endfor
vVoluntadesC=zeros(_combC+_iniFin+_fallas,_nSujetos);
for i=1:_nSujetos
  vVoluntadesC(:,i)=mean(voluntadC(:,expXsuj(i)-9:expXsuj(i),i),2);
endfor
for i=1:_nSujetos
  figure;
  h=bar([vVoluntadesC([1:17 31 32],i),vVoluntades([1:17 31 32],i)],'*c');
  set (h, "linewidth", 2);
  set (h(1), 'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
  set (h(2), 'facecolor', 'r', 'edgecolor','k', "linewidth", 2);
  xlabel("eventos D entre C - C");
  ylabel("ocurrecia por eventos");
  title(strcat("voluntad por D - Sujeto: ",_txtSujetos(i,:)));
  axis ("tic[yz]", "labely[xyz]");
  t=text(-0.06+[1:length(vPtr([1:17 31 32],1))], 1*ones(1,length(vPtr([1:17 31 32],1))) , vPtrC([1:17 31 32],:));
  set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
  t=text(0.28+[1:length(vPtr([1:17 31 32],1))], 1*ones(1,length(vPtr([1:17 31 32],1))) , vPtr([1:17 31 32],:));
  set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
endfor
% SEPARAR ENTRE COOPERADORES Y NO
% Histograma en D
_criterio=.70;
graficos_iPD_1_2_9s_13s_12Ratas_medias_y_medianas % se obtienen los sujetos que superan el .75 porciento de cooperación
_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos); % Obtiene los indices de los no coop

figure;
j=0;
for i=_sujetosCooperadores
  j++;
  subplot(3,3,j)
  h=bar(vVoluntades(:,i)'./([30*[1./[1:28]] 1 1 30 30]),'*c');
  set (h, "linewidth", 2);
  xlabel("eventos D entre C - C");
  ylabel("ocurrecia por eventos");
  aux=strcat("voluntad por D Coops: ",_txtSujetos(i,:));
  aux=strcat(aux," - ");
  title(strcat(aux,_criterio));
endfor
figure;
j=0;
for i=_sujetosNocooperadores
  j++;
  subplot(3,3,j)
  h=bar(vVoluntades(:,i)'./([30*[1./[1:28]] 1 1 30 30]),'*c');
  set (h, "linewidth", 2);
  xlabel("eventos D entre C - C");
  ylabel("ocurrecia por eventos");
  aux=strcat("voluntad por D NO Coops: ",_txtSujetos(i,:));
  aux=strcat(aux," - ");
  title(strcat(aux,_criterio));
endfor

%%%%%%%%%%%%%% SOLO COOPERADORES Voluntad por D
voluntadMedia=mean(vVoluntades(:,_sujetosCooperadores),2);
voluntadStd=sem(vVoluntades(:,_sujetosCooperadores),2);
voluntadMediaC=mean(vVoluntadesC(:,_sujetosCooperadores),2);
voluntadStdC=sem(vVoluntadesC(:,_sujetosCooperadores),2);
figure;
h=errorbar([1:length(_dejarD)],voluntadMedia, voluntadStd,'*b');
set (h, "linewidth", 2);
hold on;
h=bar(voluntadMedia,"facecolor", "none","edgecolor","m");
hold off;
set (h, "linewidth", 2);
xlabel("eventos D entre C - C");
ylabel("ocurrecia por eventos");
title(strcat("voluntad por D - Promedio Sujetos Cooperadores"));
ptr="21";
vPtr="";
for r=1:(length(_dejarD(1:_combD))-2) % 2 por q esta enccerado entre 2 - 2
  ptr=strcat(ptr(1:(length(ptr)-1)),"12");
  vPtr=[vPtr; ptr];
endfor
vPtr=[vPtr; "29";"30";"11.12..";"..211.1"];
axis ("tic[yz]", "labely[xyz]");
%set(gca, 'XTick', 1:4, 'XTickLabel', t);
t=text(0.5+[1:length(vPtr(:,1))], 0.5*ones(1,length(vPtr(:,1))) , vPtr);
set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
%xlabel ('horizontal alignment');
%%%%%%%%%%%%%% SOLO NO cooperadores Voluntad por D
voluntadMedia=mean(vVoluntades(:,_sujetosNocooperadores),2);
voluntadStd=sem(vVoluntades(:,_sujetosNocooperadores),2);
voluntadMediaC=mean(vVoluntadesC(:,_sujetosNocooperadores),2);
voluntadStdC=sem(vVoluntadesC(:,_sujetosNocooperadores),2);
figure;
h=errorbar([1:length(_dejarD)],voluntadMedia, voluntadStd,'*b');
set (h, "linewidth", 2);
hold on;
h=bar(voluntadMedia,"facecolor", "none","edgecolor","m");
hold off;
set (h, "linewidth", 2);
xlabel("eventos D entre C - C");
ylabel("ocurrecia por eventos");
title(strcat("Voluntad por D - Promedio Sujetos No Cooperadores"));
%ptr="21";
%vPtr="";
%for r=1:(length(_dejarD(1:_combD))-2) % 2 por q esta enccerado entre 2 - 2
%  ptr=strcat(ptr(1:(length(ptr)-1)),"12");
%  vPtr=[vPtr; ptr];
%endfor
%vPtr=[vPtr; "29";"30";"11.12..";"..211.1"];
axis ("tic[yz]", "labely[xyz]");
%set(gca, 'XTick', 1:4, 'XTickLabel', t);
t=text(0.5+[1:length(vPtr(:,1))], 0.5*ones(1,length(vPtr(:,1))) , vPtr);
set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
%xlabel ('horizontal alignment');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SOLO COOPERADORES Voluntad por D y por C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
voluntadMedia=mean(vVoluntades(:,_sujetosCooperadores),2);
voluntadStd=sem(vVoluntades(:,_sujetosCooperadores),2);
voluntadMediaC=mean(vVoluntadesC(:,_sujetosCooperadores),2);
voluntadStdC=sem(vVoluntadesC(:,_sujetosCooperadores),2);
%voluntadMediaTot=zeros(length(voluntadMedia)+length(voluntadMediaC),1);
%voluntadMediaTot(2*(1:length(voluntadMedia)))=voluntadMedia;
%voluntadMediaTot(1:2:2*length(voluntadMediaC))=voluntadMediaC;
%voluntadStdTot(2*(1:length(voluntadMedia)))=voluntadStd;
%voluntadStdTot(1:2:2*length(voluntadMediaC))=voluntadStdC;
figure;
%h=errorbar([1:length(voluntadMediaTot)],voluntadMediaTot, voluntadStdTot,'*b');
%h=errorbar(voluntadMediaC(1:32,1),voluntadStdC(1:32,1),'*b',voluntadMedia(1:32,1),  voluntadStd,'*r');
h=errorbar(-.18+[1:length(voluntadMediaC(1:32,1))],voluntadMediaC(1:32,1),voluntadStdC(1:32,1),'*b',.18+[1:length(voluntadMedia(1:32,1))],voluntadMedia(1:32,1),voluntadStd(1:32,1),'*g');
set (h(1), "linewidth", 2);
set (h(2), "linewidth", 2);
legend ('C errbar', 'D errbar');
hold on;
%h=bar(voluntadMediaTot,"facecolor", "none","edgecolor","m");
h=bar([voluntadMediaC(1:32,1),voluntadMedia(1:32,1)],"facecolor", "none","edgecolor","m");
hold off;
set (h(1), 'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
set (h(2), 'facecolor', 'r', 'edgecolor','k', "linewidth", 2);
%set (h, "linewidth", 2);
xlabel("eventos D y C");
ylabel("ocurrecia por eventos");
title(strcat("Promedio Sujetos Cooperadores"));
%%errorbar(-.5+[1:length(voluntadMediaC(1:32,1))],voluntadMediaC(1:32,1),voluntadStdC(1:32,1),'*b',[1:length(voluntadMedia(1:32,1))],voluntadMedia(1:32,1),voluntadStd(1:32,1),'*g');
%%errorbar([1:length(voluntadMedia(1:32,1))],voluntadMedia(1:32,1),voluntadStd(1:32,1),'*g');
%ptr="21";
%vPtr="";
%for r=1:(length(_dejarD(1:_combD))-2) % 2 por q esta enccerado entre 2 - 2
%  ptr=strcat(ptr(1:(length(ptr)-1)),"12");
%  vPtr=[vPtr; ptr];
%endfor
%ptr="12";
%vPtrC="";
%for r=1:(length(_dejarC(1:_combC))-2) % 2 por q esta enccerado entre 2 - 2
%  ptr=strcat(ptr(1:(length(ptr)-1)),"21");
%  vPtrC=[vPtrC; ptr];
%endfor
%vPtr=[vPtr; "29";"30";"11.12..";"..211.1"];
%vPtrC=[vPtrC; "29";"30";"22.21..";"..122.2"];
%vPtrTot(2*(1:length(voluntadMedia)),:)=vPtr;
%vPtrTot((1:2:2*length(voluntadMediaC)),:)=vPtrC(1:(length(vPtrC)-1),:);
axis ("tic[yz]", "labely[xyz]");
%set(gca, 'XTick', 1:4, 'XTickLabel', t);
%t=text(0.5+[1:length(vPtrTot(:,1))], 0.5*ones(1,length(vPtrTot(:,1))) , vPtrTot);
vPtrTot2=[ vPtrC vPtr]
t=text(-0.06+[1:length(vPtr(:,1))], 1*ones(1,length(vPtr(:,1))) , vPtrC);
set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
t=text(0.28+[1:length(vPtr(:,1))], 1*ones(1,length(vPtr(:,1))) , vPtr);
set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
%t=text(0.5+[1:length(vPtrTot(:,1))], 0.5*ones(1,length(vPtrTot2(:,1))) , vPtrTot2);
%set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SOLO NO COOP Voluntad por D y por C 
voluntadMedia=mean(vVoluntades(:,_sujetosNocooperadores),2);
voluntadStd=sem(vVoluntades(:,_sujetosNocooperadores),2);
voluntadMediaC=mean(vVoluntadesC(:,_sujetosNocooperadores),2);
voluntadStdC=sem(vVoluntadesC(:,_sujetosNocooperadores),2);
figure;
h=errorbar(-.18+[1:length(voluntadMediaC(1:32,1))],voluntadMediaC(1:32,1),voluntadStdC(1:32,1),'*b',.18+[1:length(voluntadMedia(1:32,1))],voluntadMedia(1:32,1),voluntadStd(1:32,1),'*g');
set (h(1), "linewidth", 2);
set (h(2), "linewidth", 2);
legend ('C errbar', 'D errbar');
hold on;
h=bar([voluntadMediaC(1:32,1),voluntadMedia(1:32,1)],"facecolor", "none","edgecolor","m");
hold off;
set (h(1), 'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
set (h(2), 'facecolor', 'r', 'edgecolor','k', "linewidth", 2);
xlabel("eventos D y C");
ylabel("ocurrecia por eventos");
title(strcat("Promedio Sujetos NO Cooperadores ( ultimas 10s)"));
axis ("tic[yz]", "labely[xyz]");
t=text(-0.06+[1:length(vPtr(:,1))], 1*ones(1,length(vPtr(:,1))) , vPtrC);
set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
t=text(0.28+[1:length(vPtr(:,1))], 1*ones(1,length(vPtr(:,1))) , vPtr);
set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Voluntad por D de los No Cooperadores
voluntadDStdC=sem(vVoluntades(:,_sujetosCooperadores),2);
voluntadDMediaC=mean(vVoluntades(:,_sujetosCooperadores),2);
voluntadDMediaD=mean(vVoluntades(:,_sujetosNocooperadores),2);
voluntadDStdD=sem(vVoluntades(:,_sujetosNocooperadores),2);
%
voluntadCMediaC=mean(vVoluntadesC(:,_sujetosCooperadores),2);
voluntadCStdC=sem(vVoluntadesC(:,_sujetosCooperadores),2);
voluntadCMediaD=mean(vVoluntadesC(:,_sujetosNocooperadores),2);
voluntadCStdD=sem(vVoluntadesC(:,_sujetosNocooperadores),2);
figure;
h=errorbar([1:length(_dejarD)],voluntadDMediaD, voluntadDStdD,'*b');
set (h, "linewidth", 2);
hold on;
h=bar(voluntadDMediaD,"facecolor", "none","edgecolor","m");
hold off;
set (h, "linewidth", 2);
xlabel("eventos D entre C - C");
ylabel("ocurrecia por eventos");
title(strcat("Promedio cooperadores y No cooperadores - Voluntad por D"));
axis ("tic[yz]", "labely[xyz]");
t=text(0.5+[1:length(vPtr(:,1))], 0.5*ones(1,length(vPtr(:,1))) , vPtr);
set(t, "HorizontalAlignment","left","VerticalAlignment", "bottom", "Rotation",90)

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

% cuanto comen por cada eventos
voluntadDfood=zeros(length(_dejarD),nfields(todo),_nSujetos);
voluntadCfood=zeros(length(_dejarC),nfields(todo),_nSujetos);
for i=1:_nSujetos
  for j=1:expXsuj(i) 
    auxfoodD=voluntad(1:30,j ,i)'*2;
    if voluntad(31,j ,i)>=1 % |11..12..
      auxfoodD=[auxfoodD 2];
    else
      auxfoodD=[auxfoodD 0];
    endif
    if voluntad(32,j ,i)>=1 % ..211..1|
      auxfoodD=[auxfoodD 2];
    else
      auxfoodD=[auxfoodD voluntad(32,j ,i)*2];
    endif
    sum(auxfoodD)
    voluntadDfood(:,j,i)=auxfoodD;
    auxfoodC=[];
    auxfoodC=voluntadC(1:31,j ,i)'.*([0:29 1]);
    if voluntadC(32,j ,i)>=1
      auxfoodC=[auxfoodC voluntadC(32,j ,i)-1];
    else
      auxfoodC=[auxfoodC voluntadC(32,j ,i)];
    endif
    voluntadCfood(:,j,i)=auxfoodC;
    sum(auxfoodC)
    sum(auxfoodD)+sum(auxfoodC)
    food(j,i)
  endfor
endfor

%sum(auxfoodC)
%sum(auxfoodD)+sum(auxfoodC)

%j=expXsuj(i)-_ultimosX+1;

%todo.(indice(j+1,:))(i)._respuestasEXP(1:30)
%todo.(indice(j+1,:))(i)._respuestasOPO(1:30)

%gg=vVoluntadesC(1:30,i)'.*([0:29 1 1]
%sum(gg-([zeros(1,30) 1 1]))


% PONER EN PORCENTAJES RESPECTO A UNA CANTIDAD TEORICA QUE es...
%   Dividir todos los casos maximos por eventos









%%%% TODOS JUNTOS
%figure();hold on;
%for i=1:_nSujetos
%  inicioAux=1;%expXsuj(i)-_ultimosX+1;
%  finAux=expXsuj(i);
%  h=plot([inicioAux:finAux],sincro(1,inicioAux:finAux,i),_colores(i,:));
%  set(h, "linewidth", 2);
%  xlabel("n de sesiones");
%  ylabel("trials que presiono´ primero");
%  title("Cantidad de trial por Sesion donde presiono primero"); 
% grid on;
%endfor
%legend(_txtSujetos(:,:),4);
%hold off;

%%%% DE A UNO
%for i=1:_nSujetos
%  figure();
%  inicioAux=1;%expXsuj(i)-_ultimosX+1;
%  finAux=expXsuj(i);
%  h=plot([inicioAux:finAux],sincro(1,inicioAux:finAux,i) + sincro(2,inicioAux:finAux,i),_colores(2,:),
%         [inicioAux:finAux],sincro(3,inicioAux:finAux,i),_colores(3,:),
%         [inicioAux:finAux],sincro(4,inicioAux:finAux,i),_colores(4,:),
%         [inicioAux:finAux],sincro(1,inicioAux:finAux,i) + sincro(2,inicioAux:finAux,i) +
%                            sincro(3,inicioAux:finAux,i) + sincro(4,inicioAux:finAux,i),_colores(5,:),
%         [inicioAux:finAux],sincro(5,inicioAux:finAux,i),_colores(6,:));
%  set(h, "linewidth", 2);
%  xlabel("n de sesiones");
%  ylabel("palanqueos por trials");
%  title(strcat("Cantidad de trial por Sesion don presiono primero. Sujeto: ",_txtSujetos(i,:))); 
%  legend("palanqueo 1ro + igual","palanqueo 2do","errores","Total","Alterna");
%  grid on;
%  axis ([0,expXsuj(i)+12,0,31], "square");
%endfor

  