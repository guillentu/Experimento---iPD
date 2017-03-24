%-------------------------------------------------------------------
%------- IPD + TFT
% Analisis de las ultimas 10 sesiones
clear all
close all

% load "iPD_1_2_9s_13s/datosCargadoWorkspace20160423";

%load "iPD_1_2_9s_13s/datos_modificados_sobre_errores";
load "iPD_1_2_9s_13s/reversion/datosCargadoWorkspace20160427"

indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";
        "exp06";"exp07";"exp08";"exp09";"exp10";"exp11";
        "exp12";"exp13";"exp14";"exp15";"exp16";"exp17";
        "exp18";"exp19";"exp20";"exp21";"exp22";"exp23";
				"exp24";"exp25";"exp26";"exp27";"exp28";"exp29";
				"exp30";"exp31";"exp32";"exp33";"exp34";"exp35";
				"exp36";"exp37";"exp38";"exp39";"exp40";"exp41";
        "exp42";"exp43";"exp44";"exp45";"exp46";"exp47";
        "exp48";"exp49";"exp50";"exp51";"exp52"];

%todo.exp00=exp00;
todo.exp01=exp01;todo.exp02=exp02;todo.exp03=exp03;todo.exp04=exp04;todo.exp05=exp05;
todo.exp06=exp06;todo.exp07=exp07;todo.exp08=exp08;todo.exp09=exp09;todo.exp10=exp10;
todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;todo.exp15=exp15;
todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;todo.exp19=exp19,todo.exp20=exp20;
todo.exp21=exp21;todo.exp22=exp22;todo.exp23=exp23;todo.exp24=exp24;todo.exp25=exp25;
todo.exp26=exp26;todo.exp27=exp27;todo.exp28=exp28;todo.exp29=exp29;todo.exp30=exp30;
todo.exp31=exp31;todo.exp32=exp32;todo.exp33=exp33;todo.exp34=exp34;todo.exp35=exp35;
todo.exp36=exp36;todo.exp37=exp37;todo.exp38=exp38;todo.exp39=exp39;todo.exp40=exp40;
todo.exp41=exp41;todo.exp42=exp42;todo.exp43=exp43;todo.exp44=exp44;todo.exp45=exp45;
todo.exp46=exp46;todo.exp47=exp47;todo.exp48=exp48;
todo.exp49=exp49;todo.exp50=exp50;todo.exp51=exp51;todo.exp52=exp52;

_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];

% PORCENTAJE DE COOPERACION
_nSujetos=12;
_vSujetosNull=[];
_vSujetos1=[3 7 12];% desde el exp01
_vSujetos2=[3 7 10 12];% desde el exp07  
_vSujetos3=[3 7 9 10 12];% desde el exp09
_vSujetos4=[3 7 9 12];% desde el exp25
_vSujetos5=[3 7 9];% desde el exp43
_iniSujExp=[0 0 1 0 0 0 1 0 9 7 0 1];
_vSujetos=_vSujetos1;

_coop=zeros(1,_nSujetos);
_cooperacion=[];
_nada=[];
_nadaAux=zeros(1,_nSujetos);
_trialIni=1;
_trialFin=30;
inicio=01;

_ultimosX=6;
            %R T P  S
_vRefuerzos=[1 2 0  0];
_vDelay4eat=[5 5 9 13];%[cc dc cd dd] [R T S P]
_timeoutLimit=10*0+10*8+10*4;%10*5+10*13+10*9;% 270s en 30trials  %195; %13*15 or T+29*P=
_timeoutITI=30*5;
_foodLimit=2*15+0*15;% food por T y por S, alterna

_criterio=0.5;
% Testeo ------------------------------
%
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
fallasXexp=[];
%matricesQ.Q1=[];matricesQ.Q2=[];matricesQ.Q3=[];matricesQ.Q4=[];matricesQ.Q5=[];matricesQ.Q6=[];matricesQ.Q7=[];matricesQ.Q8=[];matricesQ.Q9=[];matricesQ.Q10=[];matricesQ.Q11=[];matricesQ.Q12=[];
for i=1:_nSujetos
  matricesQ.(indiceSujeto(i,:)) = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
  matricesQaux.(indiceSujeto(i,:)) = zeros(4,4);
endfor

% Experimentos por sujetos
expXsuj=zeros(1,_nSujetos);
for j=inicio:(numfields(todo))
  for i=1:length(todo.(indice(j+1,:)))
    if length(todo.(indice(j+1,:))(i)._groupStr)!=0
      expXsuj(i)++;
    endif
  endfor
endfor

fin=numfields(todo)

% 
% Brief: Carga las matrices de transicion de estado de cada sujeto.
%        Es un promedio total 
%        Acumula las veces que aparece la transicion durante los 29 trials a lo
%        largo los inicio:fin de experimentos.
T=zeros(_nSujetos,length(inicio:fin));C=zeros(_nSujetos,length(inicio:fin));
P=zeros(_nSujetos,length(inicio:fin));S=zeros(_nSujetos,length(inicio:fin));
controlFallas=zeros(1,_nSujetos);
controlFallasXexp=zeros(_nSujetos,length(inicio:fin));
auxFallas=1;

for j=inicio:fin
  if j<07
    _vSujetos=_vSujetos1;
  elseif (j>=07 && j<09)
    _vSujetos=_vSujetos2;
  elseif (j>=09 && j<25)
    _vSujetos=_vSujetos3;
  elseif (j>=25 && j<43)
    _vSujetos=_vSujetos4;
  elseif (j>=43)
    _vSujetos=_vSujetos5;
  endif
  for i=_vSujetos
    for k=_trialIni:_trialFin  % nºtrials x Exp.  TRAICIONAR DADO QUE
      if ((todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)||(todo.(indice(j+1,:))(i)._respuestasOPO(k)==0))
        if (k==1)
          ++controlFallas(i);%%%
          %++controlFallasXexp(i,j);
        elseif (k==2) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)% k=1 y K=2 son ceros no se cuenta una falla auxiluar
            auxFallas+=1;
          endif
          ++controlFallas(i);%%%
          ++controlFallasXexp(i,j);
        elseif (k==3)
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-2)==0)&&(todo.(indice(j+1,:))(i)._respuestasEXP(k-1)==0)
            % nada
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)
            auxFallas+=1;
          else
            a="MIERDA!!!"
          endif
          ++controlFallas(i);%%%
          ++controlFallasXexp(i,j);
        else
          auxFallas+=1;
          ++controlFallas(i);
          ++controlFallasXexp(i,j);
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
%                    uno menos por en elprimer trial no cuenta
_vSujetos=[3 7 9 10];%_vSujetos3;
T=T./(30-controlFallasXexp);
C=C./(30-controlFallasXexp);
P=P./(30-controlFallasXexp);
S=S./(30-controlFallasXexp);
TT=T;CC=C;
PP=P;SS=S;
T2(:,:)=T(:,:);R2(:,:)=C(:,:);P2(:,:)=P(:,:);S2(:,:)=S(:,:);

T_mean=zeros(1,_nSujetos);R_mean=zeros(1,_nSujetos);P_mean=zeros(1,_nSujetos);S_mean=zeros(1,_nSujetos);
T_median=zeros(1,_nSujetos);R_median=zeros(1,_nSujetos);P_median=zeros(1,_nSujetos);S_median=zeros(1,_nSujetos);
T_sem=zeros(1,_nSujetos);R_sem=zeros(1,_nSujetos);P_sem=zeros(1,_nSujetos);S_sem=zeros(1,_nSujetos);
for i=_vSujetos
  ultimo=_iniSujExp(i)-1+numfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  T_mean(i)=mean(T2(i,primero:ultimo),2);R_mean(i)=mean(R2(i,primero:ultimo),2);P_mean(i)=mean(P2(i,primero:ultimo),2);S_mean(i)=mean(S2(i,primero:ultimo),2);
  T_median(i)=median(T2(i,primero:ultimo),2);R_median(i)=median(R2(i,primero:ultimo),2);P_median(i)=median(P2(i,primero:ultimo),2);S_median(i)=median(S2(i,primero:ultimo),2);
  T_sem(i)=sem(T2(i,primero:ultimo),2);R_sem(i)=sem(R2(i,primero:ultimo),2);P_sem(i)=sem(P2(i,primero:ultimo),2);S_sem(i)=sem(S2(i,primero:ultimo),2);
endfor


QxExp_ante=matricesQxExp;
% Analizando las ultimas X sesiones

%   Normalizacion para todos los sujetos en todos los experimentos
Q_antes=matricesQ;
QQ=[];
QQTot=zeros(2,2,_nSujetos);
QQTotmarkov=zeros(2,2,_nSujetos);
QQTotmarkovSem=zeros(2,2,_nSujetos);
%for i=_vSujetos
%  ultimo=_iniSujExp(i)-1+numfields(matricesQxExp.(indiceSujeto(i,:)));
%  primero=ultimo-_ultimosX+1;
%  jj=0;
%  aux2=[];
%  for j=primero:ultimo %Experimentos
%    jj++;  %| la P(c|c) es igual a la sumatorias en "sum(x ,1)" de P(c|R) y P(c|S) y las otras filas lsa compo ponentes son cero
%    aux = sum(QxExp_ante.(indiceSujeto(i,:)).(indice(j+1,:)));% P(d|c) P(c|c) P(d|d) P(c|d) 
%    
%    %aux2=[aux2 aux'./[aux(1)+aux(3);aux(2)+aux(4);aux(1)+aux(3);aux(2)+aux(4)]];
%    aux2=[aux2 aux'./[aux(1)+aux(2);aux(2)+aux(1);aux(4)+aux(3);aux(3)+aux(4)]];
%    QQTot(:,:,i)=QQTot(:,:,i) + [aux(sort(1:4,'descend'))(3:4); aux(sort(1:4,'descend'))(1:2)];% se ordena par que tengal a lforma 2x2
%    QQ.(indiceSujeto(i,:)).(num2str(jj))=[aux(sort(1:4,'descend'))(3:4); aux(sort(1:4,'descend'))(1:2)];%./sum(sum(QxExp_ante.(indiceSujeto(i,:)).(indice(j+1,:)))),1)';
%  endfor
%  QQTotmarkov(1,:,i)=QQTot(1,:,i)./sum(QQTot(:,:,i),2)(1);%QQTot = P(c|c) P(d|c) => vec(QQTot)
%  QQTotmarkov(2,:,i)=QQTot(2,:,i)./sum(QQTot(:,:,i),2)(2);%        P(c|d) P(d|d)  P(c|c) P(c|d) P(d|c) P(d|d)
%                         % sem cc             dc           cd                dd
%  QQTotmarkovSem(:,:,i)= [ sem(aux2,2)(2) sem(aux2,2)(1); sem(aux2,2)(4) sem(aux2,2)(3)];
%endfor
for i=_vSujetos
  ultimo=_iniSujExp(i)-1+numfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  jj=0;
  aux2=[];
  for j=primero:ultimo %Experimentos
    jj++;  %| la P(c|c) es igual a la sumatorias en "sum(x ,1)" de P(c|R) y P(c|S) y las otras filas lsa compo ponentes son cero
    aux = QxExp_ante.(indiceSujeto(i,:)).(indice(j+1,:))./sum(QxExp_ante.(indiceSujeto(i,:)).(indice(j+1,:)),2)
    
    aux(isnan(aux))=0 %%Elimina los valores NaN
    %P(c|c)
    QQTot(1,1,i)= QQTot(1,1,i) + aux(2,2)*C(i,j)+ aux(4,2)*S(i,j);
    %P(d|c)
    QQTot(1,2,i)= QQTot(1,2,i) + aux(2,1)*C(i,j)+ aux(4,1)*S(i,j);
    %P(c|d)
    QQTot(2,1,i)= QQTot(2,1,i) + aux(1,4)*T(i,j)+ aux(3,4)*P(i,j);
    %P(d|d)
    QQTot(2,2,i)= QQTot(2,2,i) + aux(1,3)*T(i,j)+ aux(3,3)*P(i,j);
    
    aux3=[aux(2,2)*C(i,j)+ aux(4,2)*S(i,j) aux(2,1)*C(i,j)+ aux(4,1)*S(i,j);%c|c% %d|c%
          aux(1,4)*T(i,j)+ aux(3,4)*P(i,j) aux(1,3)*T(i,j)+ aux(3,3)*P(i,j);%c|d% %d|d%
          ];
    aux3=aux3./sum(aux3,2)
    %aux2=aux2./[aux2(1)+aux2(3) aux2(2)+aux2(4) aux2(1)+aux2(3) aux2(2)+aux2(4)];
    aux2=[aux2 vec(aux3)]; % vec -> %c|c  c|d  d|c  d|d %
                           %          R    S    T    P
  endfor
  QQTot(:,:,i)
  QQTot(:,:,i) = QQTot(:,:,i)./length([primero:ultimo]);
  QQTot(:,:,i) = QQTot(:,:,i)./sum(QQTot(:,:,i),2);
  QQTotmarkovSem(:,:,i)=[sem(aux2,2)(1) sem(aux2,2)(2); sem(aux2,2)(3) sem(aux2,2)(4)];% R T P S
endfor
QQTotmarkov=QQTot;
% matriz para inkscape
QQTotmarkovInk=zeros(2,2,_nSujetos);
for i=1:_nSujetos
   QQTotmarkovInk(1,1,i)=30*QQTotmarkov(1,1,i)+0;
   QQTotmarkovInk(1,2,i)=30*QQTotmarkov(1,2,i)+0;
   QQTotmarkovInk(2,1,i)=30*QQTotmarkov(2,1,i)+0;
   QQTotmarkovInk(2,2,i)=30*QQTotmarkov(2,2,i)+0;
endfor

% Alimento obtenido por cada animal
graficos_iPD_1_2_9s_13s_cantidadAlimentos_reversion;

graficos_iPD_1_2_9s_13s_Promedios_ultimosX_reversion;

% Probabilidad d estar en C o en D

%probC=zeros(1,_nSujetos);
%probC=_mediaXsujeto;
%probD=zeros(1,_nSujetos);
%probD=1-_mediaXsujeto;
%
%N=1; % numero de trials
%%_vRefuerzos=[1 2 0 0];
%foodMedia=zeros(1,_nSujetos); %                      
%for i=_vSujetos   % vec [a b;c d] -> [a c b d] = [c|c c|d d|c d|d]              mal[c|c d|c c|d d|d]
%  %foodMedia(i)=N*_vRefuerzos*(vec(QQTotmarkov(:,:,i)).*[probC(i);probC(i);probD(i);probD(i)]);
%  %                           R S T P
%  foodMedia(i)=N*_vRefuerzos([1 4 2 3])*(vec(QQTotmarkov(:,:,i)).*[probC(i);probD(i);probC(i);probD(i)]);
%  % VER meanFoodXsuj desde cantidad  de alimento
%endfor
%% vec(QQTotmarkov(:,:,1)) y reshape(ans,2,2)
%%_vDelay4eat=[0 0 8 4];
%_timeOutMedia=zeros(1,_nSujetos);
%for i=_vSujetos   % vec [a b;c d] -> [a c b d] = [c|c c|d d|c d|d]
%  _timeOutMedia(i)=30*_vDelay4eat([1 4 2 3])*(vec(QQTotmarkov(:,:,i)).*[probC(i);probD(i);probC(i);probD(i)]);
%  % VER meanFoodXsuj desde cantidad  de alimento
%endfor
%%%%%%%%%%%% calculos teoricos desde la matriz Q %%%%%%%%%%%%%
probC=zeros(1,_nSujetos);
%probC=_mediaXsujeto;
probD=zeros(1,_nSujetos);
%probD=1-_mediaXsujeto;
for i=1:_nSujetos
  probC(i)=QQTotmarkov(2,1,i)/(1+QQTotmarkov(2,1,i)-QQTotmarkov(1,1,i));
endfor
probD=1-probC;

N=1; % numero de trials
_alimento_MK=zeros(1,_nSujetos); %                      
for i=_vSujetos   % vec [a b;c d] -> [a c b d] = [c|c c|d d|c d|d]              mal[c|c d|c c|d d|d]
  %                           R S T P
  _alimento_MK(i)=N*_vRefuerzos([1 4 2 3])*(vec(QQTotmarkov(:,:,i)).*[probC(i);probD(i);probC(i);probD(i)]);
endfor

_delay4eat_MK=zeros(1,_nSujetos);
for i=_vSujetos   % vec [a b;c d] -> [a c b d] = [c|c c|d d|c d|d]
  _delay4eat_MK(i)=30*_vDelay4eat([1 4 2 3])*(vec(QQTotmarkov(:,:,i)).*[probC(i);probD(i);probC(i);probD(i)]);
endfor

RSTP_mean_MK=zeros(4,_nSujetos);
for i=1:_nSujetos
  RSTP_mean_MK(:,i)=(vec(QQTotmarkov(:,:,i)).*[probC(i);probD(i);probC(i);probD(i)]);
endfor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% alimento de sujetos ideales   markov       prob estaren C o D
probC2=zeros(1,7); % [alternador; cooperador; CyD de a pares; la mitad coop] 
probC2=[.5;1;0.5;.5;.5;2/3;3/4];
probD2=zeros(1,7);
probD2=1-probC2;
%         {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}
QQideales=[[0; 1 ;1; 0],[1; 0; 0; 0],[.5; .5; .5; .5],[14/15; 0; 1/15; 1],[2/3;1/3;1/3;2/3],[.5; 1; .5; 0],[2/3; 1; 1/3; 0]];
_idealSujeto=zeros(2,length(probC2));% row 1 alimetno - row 2 delay to eat
for i=1:length(probC2)
  _idealSujeto(1,i)=N*_vRefuerzos([1 4 2 3])*(QQideales(:,i).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
endfor
for i=1:length(probC2)
  _idealSujeto(2,i)=30*_vDelay4eat([1 4 2 3])*(QQideales(:,i).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
endfor


_effectiveness=(N*_vDelay4eat(1))./_timeOutMedia;

%mean(food(inicioAux:finAux,i))
_estadoEstacionario=zeros(2,_nSujetos);

%for i=_vSujetos
%  if (sum(sum(QQTotmarkov(:,:,i)))!=0)
%    _estadoEstacionario(:,i) = dtmc(QQTotmarkov(:,:,i));
%  endif
%endfor

% Prob de Coop dado que antes C o D
for i=_vSujetos
  hhh=figure;
  h=errorbar([1 2 3 4],vec(QQTotmarkov(:,:,i))',vec(QQTotmarkovSem(:,:,i))','*k');
  hold on;set(h, "linewidth", 2);     
  h=bar([1:4],vec(QQTotmarkov(:,:,i)),'facecolor', 'g', 'edgecolor','b', "linewidth",2);
  h=plot([0:5],[.5 .5 .5 .5 .5 .5],"--r");
  axis ("tic[yz]", "labely[xyz]");
  set(h, "linewidth", 2);  
  legend("SEM","MEAN");
  %hh=xlabel("T=1 --- R=2 --- P=3 --- S=4");set(hh, "fontsize", 14);
  hh=ylabel("P(C|X)");set(hh, "fontsize", 14);
  hh=title(strcat("Probability of Cooperation given last choose: ",_txtSujetos(i,:)));
  set(hh, "fontsize", 14);
  axis ("tic[yz]", "labely[xyz]");
  t=text([1:4], -.04*ones(1,4), {"P(c|c)"; "P(c|d)";"P(d|c)";"P(d|d)"},"fontsize",14);
  axis([0 5 0 1]);
  hold off;grid on;
  name=strcat("figura_iPD_1_2_9s_13s/fig_finales/prob_C_dado_X/",_txtSujetos(i,:));
  name=strcat(name,"_reversion");
  name=strcat(name,".png");
  print(hhh, name);
endfor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% grafico Alimentos versus Cooperacion
[Ss I]=sort(_mediaXsujeto);
figure;
aux=I(find(sort(_mediaXsujeto)>0.5))
%h=plot(_mediaXsujeto(I),foodMedia(I),'ko', "markersize",12,"markerfacecolor",'c', "linewidth", 2);
h=scatter(_mediaXsujeto(aux),foodMedia(aux),20,(_timeOutMedia(aux)-_timeoutITI)./_timeoutLimit,"filled");
ch=colormap(copper);
colorbar('southoutside');
set(h, "linewidth", 2);
hh=xlabel("Among of C choice ");
set(hh, "fontsize", 14);
hh=ylabel("% Total Reward");
set(hh, "fontsize", 14);
hh=title("Reward versus Cooperation (Colorbar=Timeout)"); 
set(hh, "fontsize", 14);
grid off;%grid minor;
t=text(-0.01*[1 1 1 1]+_mediaXsujeto(aux), 
         .08*[1 1 1 1]+foodMedia(aux) ,
         _txtSujetos(aux,:));
%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .03*[1 1 1 1 1 1 1 1 1 1 1 -1]+foodMedia(I) ,_txtSujetos(I,:));
%axis('auto');
axis([.49 1.02 0 1.15]);
hold on;
%h=plot(_mediaXsujeto(I(length(I))),foodMedia(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),_idealSujeto(2,[1 3 4 5 6 7]),15,probC([1 3 4 5 6 7])','s',"filled");
%h=plot(probC([1 3 4 5]),_idealSujeto(1,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 0.04*[.5 .5 .5 .5 2.9 2.9]+_idealSujeto(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 
       -0.025*[1.2 1 1 1 -3.2 -3.2]+_idealSujeto(1,[1 3 4 5 6 7]) ,
        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
hold off;


% grafico Cooperacion Versus R
[Ss I]=sort(_mediaXsujeto);
figure;
aux=I(find(sort(_mediaXsujeto)>0.5));
h=scatter(_mediaXsujeto(aux),R_mean(aux),20,((_timeOutMedia(aux)-_timeoutITI)./_timeoutLimit),"filled");
ch=colormap(copper);
colorbar('southoutside');
set(h, "linewidth", 2);
hh=xlabel("Among of C choice ");
set(hh, "fontsize", 14);
hh=ylabel("% Mutual Cooperation");
set(hh, "fontsize", 14);
hh=title("Cooperation Versus Mutual Cooperation (Colorbar=Timeout)"); 
set(hh, "fontsize", 14);
grid off;%grid minor;
%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .08*[1 1 1 1 1 1 1 1 1 1 1 -1]+R_mean(I),_txtSujetos(I,:));
t=text(-0.01*[1 3 -1 1]+_mediaXsujeto(aux),.08*[1 1 1 -1]+R_mean(aux),_txtSujetos(aux,:));
%axis('auto');
axis([0 1.05 -.04 1.05]);
hold on;
h=scatter(probC([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
h=scatter(probC([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
t=text(0.025*[1 1 1 1 1 1]+ probC([1 3 4 5 6 7]), 
        0.04*[.5 .5 .5 .5 .5 .5]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
t=text(0.025*[1 1 1 1 1 1]+ probC([1 3 4 5 6 7]), 
       -0.025*[1 1 1 1 1 1]+QQideales(1,[1 3 4 5 6 7]) ,
        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
hold off;

% grafico Reward Versus R
[Ss I]=sort(R_mean);
figure;
aux=I(find(sort(R_mean)>0.4));
h=scatter(foodMedia(aux),R_mean(aux),20,((_timeOutMedia(aux)-_timeoutITI)./_timeoutLimit),"filled");
ch=colormap(copper);
colorbar('southoutside');
set(h, "linewidth", 2);
hh=xlabel("% of maximal Reward");
set(hh, "fontsize", 14);
hh=ylabel("% Mutual Cooperation");
set(hh, "fontsize", 14);
hh=title("Reward Versus Mutual Cooperation (Colorbar=Timeout)"); 
set(hh, "fontsize", 14);
grid off;%grid minor;
t=text(-0.01*[1 3 -1 1]' + foodMedia(aux)', .07*[1 1 1 -1]' + R_mean(aux)', _txtSujetos(aux,:))';
%axis('auto');
axis([.48 1.1 -.04 1.05]);
hold on;
h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
t=text(0.025*[.51 .51 .51 .51 -.8 -.1]+ _idealSujeto(1,[1 3 4 5 6 7]), 
        0.04*[.5 .5 .5 .5 1.4 1.4]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
t=text(0.025*[.51 .51 .51 .51 -.8 -.5]+ _idealSujeto(1,[1 3 4 5 6 7]), 
       -0.025*[1.2 1 1 1  1.9 1.9]+ QQideales(1,[1 3 4 5 6 7]),
        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
t=text(0.62,-0.41,{"Normalized accumulated timeout per sessions"},"fontsize",14);
hold off;


% Tasa de alimentacion
%_foodRate= foodMedia./(_timeOutMedia/_timeoutLimit);%_vDelay4eat(1));
%_delay2eat=(_timeOutMedia-_timeoutITI)./_timeoutLimit;
%[Ss I]=sort(foodMedia);%_foodRate);
%figure;
%aux=I(find(sort(_mediaXsujeto)>0.7))
%%h=plot(_mediaXsujeto(aux),_delay2eat(aux),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%h=scatter(_mediaXsujeto(aux),_delay2eat(aux),20,_foodRate(aux),"filled");
%hold on;
%ch=colormap(copper);
%colorbar('southoutside');
%set(h, "linewidth", 2);
%hh=xlabel("Among of C choice ");
%set(hh, "fontsize", 14);
%hh=ylabel("Delay to eat [seconds]");
%set(hh, "fontsize", 14);
%hh=title("Cooperation versus Delay to eat"); 
%set(hh, "fontsize", 14);
%%h=plot(_mediaXsujeto(I),_delay2eat(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%grid on;
%t=text(-0.02*[1 1 1 1]'+_mediaXsujeto(aux)', 0.15*[1 1 1 1]'+_delay2eat(aux)' ,_txtSujetos(aux,:));
%axis('auto');
%hold on;
%h=plot(probC([1 3 4 5]),100/120.*_idealSujeto(2,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
%t=text(0.025*ones(1,length(probC([1 3 4 5])))+ probC([1 3 4 5]), 
%        _idealSujeto(2,[1 3 4 5])./_timeoutLimit ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D"});
%hold off;

% Alimentacion Versus Delay to eat
_delay2eat=(_timeOutMedia-_timeoutITI)./_timeoutLimit;
[Ss I]=sort(foodMedia);
hhh=figure;
aux=I(find(sort(foodMedia)>0.8));
h=scatter(_delay2eat(aux),foodMedia(aux),20, _mediaXsujeto(aux),"filled");
ch=colormap(copper);
h=colorbar('southoutside');
hold on;
%h=errorbar(_delay2eat(I(find(sort(foodMedia)>0.8)))./120,foodMedia(I(find(sort(foodMedia)>0.8))),'*k');
%set(h, "linewidth", 2);
hh=ylabel("% of total Reward");
set(hh, "fontsize", 14);
hh=xlabel("% total acumulated Timeout per sessions");
set(hh, "fontsize", 14);
hh=title("Reward versus Timeout to eat (colorbar=cooperation)"); 
set(hh, "fontsize", 14);
grid on;
t=text(0.02*[1 -1.5 1.5 1]+_delay2eat(aux),-0.04*[1 1 1 1]+foodMedia(aux),_txtSujetos(aux,:));
%axis('auto');
axis([-.04, 1.1, .5, 1.1], "square");
hold on;
h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,probC2([1 3 4 5 6 7])','s',"filled");
h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%h=plot(_idealSujeto(1,[1 3 4 5 6 7]),_idealSujeto(2,[1 3 4 5 6 7]),'ko', "markersize",15,"markerfacecolor",'r', "linewidth", 2);
t=text(-0.10*[1 1 1 1 3.5 -1]+(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
       0.05*ones(1,length(probC([1 3 4 5 6 7])))+ _idealSujeto(1,[1 3 4 5 6 7]), 
       {"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});

t=text(-0.10*[1 1 1 1 3.5 -1]+ (_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
       0.03*[1 1 1 1 1 1]+ _idealSujeto(1,[1 3 4 5 6 7]),
       {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"}); 
t=text(0.1,0.28,{"Normalized amoung of C choice"},"fontsize",14);       
hold off;





%% tiempos promedio por ensayor
%[S I]=sort(_effectiveness);
%figure;
%h=plot(30*_mediaXsujeto(I),_effectiveness(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%set(h, "linewidth", 2);
%hh=xlabel("Among of C choice ");
%set(hh, "fontsize", 14);
%hh=ylabel("Effectiveness [time required/spend]");
%set(hh, "fontsize", 14);
%hh=title("Effectiveness versus Cooperation"); 
%set(hh, "fontsize", 14);
%grid on;
%t=text(-0.60*[1 1 1 1 1 1 1 1 1 1 1 -1]+30*_mediaXsujeto(I), 0.02*[1 -1 1 1 1 1 1 1 1 1 1 .5]+_effectiveness(I) ,_txtSujetos(I,:));
%axis([1 ,30, 0, 1],'auto');
%hold on;
%h=plot(30*_mediaXsujeto(I(length(I))),_effectiveness(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%hold off;

%% Food versus FoodRate
%[S I]=sort(foodMedia(1:_nSujetos));
%figure;
%h=plot(foodMedia(I),_foodRate(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%set(h, "linewidth", 2);
%hh=xlabel("Food Harvested [Pellet]");
%set(hh, "fontsize", 14);
%hh=ylabel("Food rate [Pellets/trial]");
%set(hh, "fontsize", 14);
%hh=title("Food Rate versus Food Harvested"); 
%set(hh, "fontsize", 14);
%grid on;
%t=text(-0.60*[1 1 1 1 1 1 1 1 1 1 1 -1]+foodMedia(I), 0.02*[1 -1 1 1 1 1 1 1 1 1 1 .5]+_foodRate(I) ,_txtSujetos(I,:));
%axis([1 ,30, 0, 1],'auto');
%hold on;
%h=plot(foodMedia(I(length(I))),_foodRate(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%hold off;

%%

%[S I]=sort(foodMedia(1:_nSujetos));
%[x, y, z] = sphere(50);
%x=x./50;y=y./50;z=z./50;
%figure;
%
%%for i=I
%  mesh((_timeOutMedia(i))+x, _mediaXsujeto(i)+y, foodMedia(i)+z);hold on;set(h, "linewidth", 2);hold on;
%endfor
%figure;
%for i=I
%  contourc((_timeOutMedia(i))+x, _mediaXsujeto(i)+y, foodMedia(i)+z);
%endfor
figure;
contour(_timeOutMedia, _mediaXsujeto, foodMedia);
%&stem3((_timeOutMedia(i))+x, _mediaXsujeto(i)+y, foodMedia(i)+z,"markersize",20,"markerfacecolor",'none', "linewidth", 3);
hold off;
hh=zlabel("FOOD");set(hh, "fontsize", 14);
hh=ylabel("MEDIA DE COOPERACION");set(hh, "fontsize", 14);
hh=xlabel("DELAY TO EAT [Seconds]");set(hh, "fontsize", 14);
hh=title("Delay and Cooperation and Food Harvested"); 
set(hh, "fontsize", 14);

figure;
x = randn (100, 1);
y = randn (100, 1);
c = x .* y;
scatter (x, y, 20, c, 'filled');

x = 1:100;
y = 1:100;
scatter(foodMedia,_timeOutMedia,20, _mediaXsujeto,"filled");

%_criterio=.5;
graficos_iPD_1_2_9s_13s_12Ratas_reversion_medias_y_medianas_reversionBETA % se obtienen los sujetos que superan el .75 porciento de cooperación
_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 


QmarkovmediaC=zeros(2,2);
QmarkovmediaD=zeros(2,2);
for i=_sujetosCooperadores
  QmarkovmediaC=QmarkovmediaC+QQTotmarkov(:,:,i);
endfor
QmarkovmediaC=QmarkovmediaC./sum(QmarkovmediaC,2);

for i=_sujetosNocooperadores
  QmarkovmediaD=QmarkovmediaD+QQTotmarkov(:,:,i);
endfor
QmarkovmediaD=QmarkovmediaD./sum(QmarkovmediaD,2);



%%%%% Calculo de coeficiente de preferencia  %%%%%%%%%%%%%%%%%%%%%%%%%
%aux=I(find(sort(foodMedia)>0.8));
_selfish=foodMedia./_timeOutMedia;

_selfishInf=foodMedia.*_timeOutMedia;

_selfishtheor=_idealSujeto(1,:)*30./_idealSujeto(2,:);

hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}
hold on;
scatter(_selfish(find(_mediaXsujeto>0.5)),ones(1,length(find(_mediaXsujeto>0.5))),20,"filled");
%t=text(-0.002+_selfish(find(_mediaXsujeto>0.5)),0.013+ones(1,length(find(_mediaXsujeto>0.5))),{_txtSujetos(_vSujetos(1:4),:)},"fontsize",14);
t=text(-0.002*[1 -1.15 1 1]+_selfish(find(_mediaXsujeto>0.5)),0.013*[1 1 1 1]+ones(1,length(find(_mediaXsujeto>0.5))),_txtSujetos(_vSujetos(1:4),:),"fontsize",14);
h=scatter(_selfishtheor([1 2 3 5 6]),ones(1,length(_selfishtheor([1 2 3 5 6]))),25,'r');
set(h, "linewidth", 2);  
t=text(-0.005+_selfishtheor([1 2 3 5 6]),-0.013+ones(1,length(_selfishtheor([1 2 3 5 6]))),
                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD"},"fontsize",12);
t=text([0.26 0.27 0.26 0.27],[1.055 1.055 1.045 1.045],
       {num2str(_vRefuerzos(1));num2str(_vRefuerzos(2));num2str(_vRefuerzos(3));num2str(_vRefuerzos(4))},"fontsize",13);                                     
t=text(0.005+[0.26 0.27 0.26 0.27],-0.005+[1.055 1.055 1.045 1.045],
       {num2str(_vDelay4eat(1));num2str(_vDelay4eat(2));num2str(_vDelay4eat(3));num2str(_vDelay4eat(4))},"fontsize",13);
hold off;
ylabel("");
xlabel("Coefficient of preference");


name=strcat("figura_iPD_1_2_9s_13s/fig_finales/coefficientOfPreference_reversion",_txtSujetos(i,:));
name=strcat(name,".png");
print(hhh, name);

















