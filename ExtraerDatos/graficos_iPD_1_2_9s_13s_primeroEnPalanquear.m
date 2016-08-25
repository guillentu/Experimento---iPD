% ----------- ¿Quien palanqueo primero? -----------------------------

clear all
close all
%load "iPD_1_2_9s_13s/datosCargadoWorkspace20160423";
load "iPD_1_2_9s_13s/datos_errores_y_tiempos"

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
%-- PARA CORREGIR DATOS EN VENTANA ----------------------
%_file ="lista-iPD_1_2_9s_13s.txt"; 
%_fid = fopen (_file);   %abre el archivo
%%  _fileStr=fgetl(_fid);         %lee lineas
%jj=0;
%while(feof(_fid)==0)
%  txt=fgetl(_fid);
%  ++jj;
%  aux=extraerDatos_iPD_abril_corregido(txt);
%  %ghj.indice(j+1,:)=aux;
%  for i = 1:length(aux)
%     if length(aux(i)._groupStr)!=0
%      todo.(indice(jj+1,:))(i)._ventanas2=aux(i)._ventanas;
%    endif
%  endfor
%endwhile 
%fclose(_fid);
%--------- FIN -------------------------------------------
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

% los tiempos estan en cuenta regresiva 45seg.
% en estructura de tiempos la componente 2da es del experimental
% tiempo ventanas + derecha(opo C) - izquierda (opo D)

%Cantidad  de veces que presiono´ primero la palanca
sincro=[]
for i=1:_nSujetos
  for j=1:expXsuj(i)
    contador_1ro=0;contador_2do=0;contador_igual=0;
    for k=_trialIni:_trialFin
      
      if ((todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)||(todo.(indice(j+1,:))(i)._respuestasOPO(k)==0))
        if (k==1)
        elseif (k==2) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)% k=1 y K=2 son ceros no se cuenta una falla auxiluar
            auxFallas+=1;  
          endif
        elseif (k==3)
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-2)==0)&&(todo.(indice(j+1,:))(i)._respuestasEXP(k-1)==0)
            % nada
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)
            auxFallas+=1;
          else
            a="MIERDA!!!"
          endif
        else
          auxFallas+=1;
        endif
      elseif todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2
        auxOPO=max(todo.(indice(j+1,:))(i)._ventanas2(k,:));% primer palanqueo correcto
        auxEXP=todo.(indice(j+1,:))(i)._reloj(2,k);
        if auxEXP > auxOPO % Experimental palanqueo primero
          contador_1ro++;
        elseif auxEXP = auxOPO
          contador_igual++;
        elseif auxEXP < auxOPO
          contador_2do++;
        else
          error=1
        endif
      
      else
        
      endif
    endfor
    sincro.(indiceSujeto(i,:)).(indice(j+1,:))=