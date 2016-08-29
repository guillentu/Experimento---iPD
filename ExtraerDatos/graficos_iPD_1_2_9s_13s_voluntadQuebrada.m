% ----------- ¿Cuanto tarda en dejar la palanca D? -----------------------------

clear all
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
_dejarD=zeros(1,20+2);
voluntad=zeros(length(_dejarD),nfields(todo),_nSujetos);
for i=1:_nSujetos
  for j=1:expXsuj(i)
    contador_1ro=0;contador_2do=0;contador_igual=0;
    auxFallas=1;_contador_1ro=0;_contador_igual=0;_contador_2do=0;_error=0;_alterna=0;
    t=num2str(todo.(indice(j+1,:))(i)._respuestasEXP(:))';
    for k=sort(_trialIni:_trialFin,"descend")
      if ((todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)||(todo.(indice(j+1,:))(i)._respuestasOPO(k)==0))
        t(k)="";
      endif
    endfor
    ptr="21";
    for r=1:length(_dejarD)
      ptr=strcat(ptr(1:(length(ptr)-1)),"12");
      _dejarD(r)=length(findstr(t,ptr));
    endfor
     aa=length(t);   
    while (aa>0 & t(aa--)==1)
      _dejarD(21)++;
    endwhile
    aa=1;
    while (aa<=length(t) & t(aa++)==1)
      _dejarD(22)++;
    endwhile
    voluntad(:,j,i)=_dejarD;
  endfor
endfor
  
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

  