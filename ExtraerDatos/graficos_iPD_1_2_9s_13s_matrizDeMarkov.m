%-------------------------------------------------------------------
%------- IPD + TFT
% Analisis de las ultimas 10 sesiones
clear all
close all
load "iPD_1_2_9s_13s/datosCargadoWorkspace20160423";

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
%todo.exp00=exp00;
todo.exp01=exp01;todo.exp02=exp02;todo.exp03=exp03;todo.exp04=exp04;todo.exp05=exp05;
todo.exp06=exp06;todo.exp07=exp07;todo.exp08=exp08;todo.exp09=exp09;todo.exp10=exp10;
todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;todo.exp15=exp15;
todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;todo.exp19=exp19,todo.exp20=exp20;
todo.exp21=exp21;todo.exp22=exp22;todo.exp23=exp23;todo.exp24=exp24;todo.exp25=exp25;
todo.exp26=exp26;todo.exp27=exp27;todo.exp28=exp28;todo.exp29=exp29;
todo.exp30=exp30;todo.exp31=exp31;todo.exp32=exp32;todo.exp33=exp33;
todo.exp34=exp34;todo.exp35=exp35;
todo.exp36=exp36;todo.exp37=exp37;
todo.exp38=exp38;todo.exp39=exp39;
todo.exp40=exp40;todo.exp41=exp41;
todo.exp42=exp42;todo.exp43=exp43;
todo.exp44=exp44;todo.exp45=exp45;
todo.exp46=exp46;todo.exp47=exp47;
todo.exp48=exp48;todo.exp49=exp49;
todo.exp50=exp50;todo.exp51=exp51;%todo.exp=exp;
todo.exp52=exp52;todo.exp53=exp53;
todo.exp54=exp54;todo.exp55=exp55;
todo.exp56=exp56;todo.exp57=exp57;todo.exp58=exp58;

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
      if (todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)||(k==2&&controlFallas(i)==1)||(k==3&&controlFallas(i)==2)
        if (k==1)
          ++controlFallas(i);
        elseif (k==2)
         % nada 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)
            ++controlFallas(i);
          endif
        elseif (k==3)
         % nada
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)
            ++controlFallas(i);
          endif 
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
  figure()
  plot([primero:ultimo],T2(i,primero:ultimo),'--ob',[primero:ultimo],R2(i,primero:ultimo),'--or',[primero:ultimo],P2(i,primero:ultimo),'-->k',[primero:ultimo],S2(i,primero:ultimo),'--.m');
  xlabel(strcat("n de sesiones - Ultimas ",_ultimosX));
  ylabel("% Proporcion entre estados");
  title(strcat("Estrategias probabilistica en iPD: ",_txtSujetos(i,:)));
  legend("T=D-C","R=C-C","P=D-D","S=C-D");
  grid on;
endfor

% Frecuencia de estados - Promedio de las ultimas sesiones
T_mean=zeros(_nSujetos);R_mean=zeros(_nSujetos);P_mean=zeros(_nSujetos);S_mean=zeros(_nSujetos);
T_median=zeros(_nSujetos);R_median=zeros(_nSujetos);P_median=zeros(_nSujetos);S_median=zeros(_nSujetos);
T_std=zeros(_nSujetos);R_std=zeros(_nSujetos);P_std=zeros(_nSujetos);S_std=zeros(_nSujetos);
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  T_mean(i)=mean(T2(i,primero:ultimo));R_mean(i)=mean(R2(i,primero:ultimo));P_mean(i)=mean(P2(i,primero:ultimo));S_mean(i)=mean(S2(i,primero:ultimo));
  T_median(i)=median(T2(i,primero:ultimo));R_median(i)=median(R2(i,primero:ultimo));P_median(i)=median(P2(i,primero:ultimo));S_median(i)=median(S2(i,primero:ultimo));
  T_std(i)=std(T2(i,primero:ultimo));R_std(i)=std(R2(i,primero:ultimo));P_std(i)=std(P2(i,primero:ultimo));S_std(i)=std(S2(i,primero:ultimo));
  figure;
  %plot(1,T_mean(i), 2,R_mean(i) ,3, P_mean(i),4,S_mean(i));
  h=errorbar(1,T_mean(i), T_std(i),'*r', 2,R_mean(i),R_std(i),'*b', 3,P_mean(i), P_std(i),'*m', 4,S_mean(i), S_std(i),'*c');
  set (h, "linewidth", 3);
  xlabel("Estados");
  ylabel("% incidencia");
  title(strcat("Tasa de incidencia para cada estado en iPD: ",_txtSujetos(i,:)));
  legend("T=D-C","R=C-C","P=D-D","S=C-D");
  hold on
  bar(1:4,[T_mean(i),R_mean(i),P_mean(i),S_mean(i)])
  hold off
 endfor

graficos_iPD_1_2_9s_13s_12Ratas_medias_y_medianas % se obtienen los sujetos que superan el .75 porciento de cooperación
_sujetosCooperadores=find(_mediaXsujeto>.75); % indice de sujetos que pasaron el criterios 

% promediar las tasas de cooperacion y tasas de estados de los animales que superaron el criterio

_mediaT=mean(T_mean(_sujetosCooperadores));
_mediaR=mean(R_mean(_sujetosCooperadores));
_mediaP=mean(P_mean(_sujetosCooperadores));
_mediaS=mean(S_mean(_sujetosCooperadores));
_medianaT=mean(T_median(_sujetosCooperadores));
_medianaR=mean(R_median(_sujetosCooperadores));
_medianaP=mean(P_median(_sujetosCooperadores));
_medianaS=mean(S_median(_sujetosCooperadores));
_stdT=std(T_mean(_sujetosCooperadores));
_stdR=std(R_mean(_sujetosCooperadores));
_stdP=std(P_mean(_sujetosCooperadores));
_stdS=std(S_mean(_sujetosCooperadores));

figure;
h=errorbar(1,_mediaT, _stdT,'*r', 2,_mediaR,_stdR,'*b', 3,_mediaP, _stdP,'*m', 4,_mediaS, _stdS,'*c');
set (h, "linewidth", 3);
xlabel("Estados");
ylabel("% incidencia promedio");
title(strcat("Tasa de incidencia promedio para los animales que superaron el criterio del 75%C"));
legend("T=D-C","R=C-C","P=D-D","S=C-D");
hold on
bar(1:4,[_mediaT,_mediaR,_mediaP,_mediaS])
hold off

% test Friedman's Anova (Ho: todas los estados son igualmente probables)
% asignar rangos a los promedios de cada estado - ranks 
vals=[(T_mean(_sujetosCooperadores));
      (R_mean(_sujetosCooperadores));
      (P_mean(_sujetosCooperadores));
      (S_mean(_sujetosCooperadores));];
rangos=ranks(vals,1)';
        
rangos_mean=sum(rangos);
N = length(_sujetosCooperadores); % N numero de sujetos
k=4% k numero de clases (estados)
chi_2 = 12/(N*k*(k+1)).*sum(rangos_mean.^2)-3*N*(k+1)
% chi_2 es evaluado respecto a la distribución estandar chi2 con k-1 grado de libertad
if chi_2 > 14.860 % si chi_2 > chi2_tabla(alpha=0.005 -> 14.860) (alpha=0.05 -> 9.488)
                  % De una tabla corregida para N=6 CHI2_0.005_3 = 11.400 y CHI2_0.05_3=7.6
se rechaza Ho (hipotesis nula)
  "Se rechaza la hipotesis nula"
endif

% Comparaciñon por two tails Nemenyi
q_alpha=2,569; % alpha=0.05 -> 2,569  bonferroni correction alpha=0.05/N -> 2,394 
               % Bonferroni's adjustment: Lower the 0.05 to 0.0083333 ->  3.9608 http://www.quantitativeskills.com/sisa/calculations/bonfer.htm
               % table of bonferroni correction
q_alpha=3.9608;        
CD=q_alpha*sqrt((k*(k+1))/(6*N));
dif=[];
for i=1:4
  dif(i).diff=find(abs(rangos_mean-rangos_mean(i))>CD);
end




