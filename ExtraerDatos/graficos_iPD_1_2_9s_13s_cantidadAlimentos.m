clear all
close all
load "iPD_1_2_9s_13s/datos_modificados_sobre_errores";

indiceSujeto=["Q01";"Q02";"Q03";"Q04";"Q05";"Q06";"Q07";"Q08";"Q09";"Q10";"Q11";"Q12"];
_colores=["--+k";"--om";"--*g";"--.r";"--xb";"--sc";"--^m";"--vg";"-->b";"--<c";"--pr";"--hr"];

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
food(:,i)=[T(i,:).*2 + C(i,:).*1 + P(i,:).*0 + S(i,:).*0];
endfor

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
_criterio=.65;
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
  title("Cantidad de alimento obtenido - Sujetos en Criterio"); 
  grid on;
endfor
legend(_txtSujetos(_sujetosCooperadores,:),4);
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
  title("Cantidad de alimento obtenido"); 
  grid on;
endfor
legend(_txtSujetos(_sujetosNocooperadores,:),4);
hold off;

%foodTotal= sum(food(:,_sujetosCooperadores),2);
%plot([1:50],foodTotal)