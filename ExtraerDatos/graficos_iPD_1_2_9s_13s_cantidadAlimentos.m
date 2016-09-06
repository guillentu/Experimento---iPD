%clear all
close all
load "iPD_1_2_9s_13s/datos_modificados_sobre_errores";

indiceSujeto=["Q01";"Q02";"Q03";"Q04";"Q05";"Q06";"Q07";"Q08";"Q09";"Q10";"Q11";"Q12"];
_colores=["--+k";"--om";"--*g";"--.r";"--xb";"--sc";"--^m";"--vg";"-->b";"--<c";"--pr";"--hr"];
ptrn={"1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"};
% Experimentos por sujetos
expXsuj=zeros(1,_nSujetos);
for j=inicio:(nfields(todo)-8)
  for i=1:length(todo.(indice(j+1,:)))
    if length(todo.(indice(j+1,:))(i)._groupStr)!=0
      expXsuj(i)++;
    endif
  endfor
endfor

food=[];
for i=1:_nSujetos
food(:,i)=[TT(i,:).*2 + CC(i,:).*1 + PP(i,:).*0 + SS(i,:).*0];
endfor
foodMedia=zeros(1,_nSujetos);
foodSem=zeros(1,_nSujetos);
for i=1:_nSujetos
  inicioAux=expXsuj(i)-_ultimosX+1;
  finAux=expXsuj(i);
  foodMedia(i) = mean(food(inicioAux:finAux,i));
  foodSem(i) = sem(food(inicioAux:finAux,i));
endfor
figure;
h=errorbar([1:_nSujetos],foodMedia,foodSem,'*b');
set (h, "linewidth", 2);
hold on;
h=bar(foodMedia,"facecolor", "none","edgecolor","g");
set (h, "linewidth", 2);
hold off;
xlabel("Sujetos - 10sesiones/30trials");
ylabel("Cantidad de alimento");
title("Promedio de la cantidad de alimento Obtenido");
t=text(-.25+[1:_nSujetos], -0.5*ones(1,_nSujetos) , ptrn);
axis ("tic[yz]", "labely[xyz]");axis([0,13,15,31],"square")
% TODOS JUNTOS
figure();hold on;
for i=1:_nSujetos
  inicioAux=expXsuj(i)-_ultimosX+1;
  finAux=expXsuj(i);
  h=plot([inicioAux:finAux],food(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  xlabel("n de sesiones");
  ylabel("Cantidad de Alimento");
  title("Cantidad de alimento obtenido"); 
  grid on;
endfor
legend(_txtSujetos(:,:),4);
hold off;

_criterio=.70;
graficos_iPD_1_2_9s_13s_12Ratas_medias_y_medianas % se obtienen los sujetos que superan el .75 porciento de cooperación
_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos); % Obtiene los indices de los no coop

% SOLO LOS COOPERADORES SUPERARON EL CRITERIO
figure();hold on;
for i=_sujetosCooperadores%1:_nSujetos
  inicioAux=expXsuj(i)-_ultimosX+1;
  finAux=expXsuj(i);
  h=plot([1:_ultimosX],food(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  xlabel("n de sesiones");
  ylabel("Cantidad de Alimento");
  title(strcat("Cantidad de alimento obtenido - Sujetos en Criterio: ",num2str(_criterio))); 
  grid on;
endfor
legend(_txtSujetos(_sujetosCooperadores,:),4);
axis ([1, 10, 1, 33], "square");
hold off;
%SOLO LOS NO COOPERADORES NO SUPERARON EL CRITERIO
figure();hold on;
for i=_sujetosNocooperadores%1:_nSujetos
  inicioAux=expXsuj(i)-_ultimosX+1;
  finAux=expXsuj(i);
  h=plot([1:_ultimosX],food(inicioAux:finAux,i),_colores(i,:));
  set(h, "linewidth", 2);
  xlabel("n de sesiones");
  ylabel("Cantidad de Alimento");
  title(strcat("Cantidad de alimento obtenido - Sujetos fuera de criterio: ",num2str(_criterio))); 
  grid on;
endfor
legend(_txtSujetos(_sujetosNocooperadores,:),4);
axis ([1, 10, 1, 33], "square");
hold off;

%foodTotal= sum(food(:,_sujetosCooperadores),2);
%plot([1:50],foodTotal)
