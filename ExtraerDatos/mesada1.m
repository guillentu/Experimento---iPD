%%-------------------------------------------------------------------
%%------- Alternar Random - Control ITI - Castigo
%close all; clear all
%
%load "iPD_1_2_9s_13s/reversion/datosCargadoWorkspace20160427"
%
%indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";
%        "exp06";"exp07";"exp08";"exp09";"exp10";"exp11";
%        "exp12";"exp13";"exp14";"exp15";"exp16";"exp17";
%        "exp18";"exp19";"exp20";"exp21";"exp22";"exp23";
%				"exp24";"exp25";"exp26";"exp27";"exp28";"exp29";
%				"exp30";"exp31";"exp32";"exp33";"exp34";"exp35";
%				"exp36";"exp37";"exp38";"exp39";"exp40";"exp41";
%        "exp42";"exp43";"exp44";"exp45";"exp46";"exp47";
%        "exp48";"exp49";"exp50";"exp51";"exp52"];
%
%%todo.exp00=exp00;
%todo.exp01=exp01;todo.exp02=exp02;todo.exp03=exp03;todo.exp04=exp04;todo.exp05=exp05;
%todo.exp06=exp06;todo.exp07=exp07;todo.exp08=exp08;todo.exp09=exp09;todo.exp10=exp10;
%todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;todo.exp15=exp15;
%todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;todo.exp19=exp19,todo.exp20=exp20;
%todo.exp21=exp21;todo.exp22=exp22;todo.exp23=exp23;todo.exp24=exp24;todo.exp25=exp25;
%todo.exp26=exp26;todo.exp27=exp27;todo.exp28=exp28;todo.exp29=exp29;todo.exp30=exp30;
%todo.exp31=exp31;todo.exp32=exp32;todo.exp33=exp33;todo.exp34=exp34;todo.exp35=exp35;
%todo.exp36=exp36;todo.exp37=exp37;todo.exp38=exp38;todo.exp39=exp39;todo.exp40=exp40;
%todo.exp41=exp41;todo.exp42=exp42;todo.exp43=exp43;todo.exp44=exp44;todo.exp45=exp45;
%todo.exp46=exp46;todo.exp47=exp47;todo.exp48=exp48;
%todo.exp49=exp49;todo.exp50=exp50;todo.exp51=exp51;todo.exp52=exp52;
%%todo.exp=exp;
%
%_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];
%
%% PORCENTAJE DE COOPERACION
%_nSujetos=12;
%
%
%_vSujetos1=[3 7 12];% desde el exp01
%_vSujetos2=[3 7 10 12];% desde el exp07  
%_vSujetos3=[3 7 9 10 12];% desde el exp09
%_vSujetos4=[3 7 9 12];% desde el exp25
%_vSujetos5=[3 7 9];% desde el exp43
%_iniSujExp=[0 0 1 0 0 0 1 0 9 7 0 1];
%%_vSujetos=[10];
%_coop=zeros(1,_nSujetos);
%_cooperacion=[];
%_nada=[];
%_nadaAux=zeros(1,_nSujetos);
%_trialIni=1;
%_trialFin=30;
%inicio=1;
%fin=52;
%datos=zeros(2,fin);
%% se promedia solo los que siguen con IPD
%for j=inicio:fin
%  _coop=zeros(1,_nSujetos);
%  _nadaAux=zeros(1,_nSujetos);
%  if j<07
%    _vSujetos=_vSujetos1;
%  elseif (j>=07 && j<09)
%    _vSujetos=_vSujetos2;
%  elseif (j>=09 && j<25)
%    _vSujetos=_vSujetos3;
%  elseif (j>=25 && j<43)
%    _vSujetos=_vSujetos4;
%  elseif (j>=43)
%    _vSujetos=_vSujetos5;
%  endif
%  for i=_vSujetos
%    _coop(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(1:30)==2));
%  endfor
%  _cooperacion=[_cooperacion; _coop];
%  for i=_vSujetos
%    _nadaAux(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(1:30)==0));
%  endfor
%  _nada=[_nada; _nadaAux];
%endfor
%_cooperacion=_cooperacion';
%_trialsOK=30*ones(length([inicio:fin]),_nSujetos);
%_promediosC=zeros(_nSujetos,length([inicio:fin]));
%_promediosC(3,:)=_cooperacion(3,:)./(_trialsOK'-_nada')(3,:);
%_promediosC(7,:)=_cooperacion(7,:)./(_trialsOK'-_nada')(7,:);
%_promediosC(12,:)=_cooperacion(12,:)./(_trialsOK'-_nada')(12,:);
%_promediosC(10,:)=_cooperacion(10,:)./(_trialsOK'-_nada')(10,:);
%_promediosC(9,:)=_cooperacion(9,:)./(_trialsOK'-_nada')(9,:);
%_media=sum(_promediosC)/_nSujetos; % CHEQUEAR MEDIA con menos sujetos
%
%%Media  ARREGLAR LA SUMA SIN LOS NADA
%%mediaG=sum(_cooperacion)/(_nSujetos*30-sum(_nada));
%
%%media sin 1A
%%media=sum((_cooperacion([2 3 4 5 6],:)./(5*30)));
%
%
%%%%%%%% ACA 
%[r c]=size(_promediosC);
%if (r!=12)
%  _promediosC=_promediosC'
%Endif
%_vSujetos=_vSujetos3;
%%%%%%%%%    TODOS JUNTOS DESDE EL FINAL hasta -17 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure();
%h=plot([1:18],_promediosC(3,(fin-17):fin),'--ok',[1:18],_promediosC(7,fin-17:fin),'--ok',...
%             [1:18],_promediosC(10,[7:24]),'--ok',[1:18], _promediosC(9,[fin-17:fin]),'--ok');
%set(h,"linewidth",2)
%hh=xlabel("n of sesiones");set(hh,"fontsize",20);
%hh=ylabel("% Cooperation");set(hh,"fontsize",20);
%hh=title("Evolution of Cooperation en iPD");set(hh,"fontsize",20)
%legend(_txtSujetos(3,:),_txtSujetos(7,:),_txtSujetos(10,:),_txtSujetos(9,:));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%
%%%%%%%
%%%%%%%clear all
%%%%%%%close all
%%%%%%%
%%%%%%%% load "iPD_1_2_9s_13s/datosCargadoWorkspace20160423";
%%%%%%%
%%%%%%%load "iPD_1_2_9s_13s/datos_modificados_sobre_errores";
%%%%%%%
%%%%%%%%indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";
%%%%%%%%        "exp06";"exp07";"exp08";"exp09";"exp10";"exp11";
%%%%%%%%        "exp12";"exp13";"exp14";"exp15";"exp16";"exp17";
%%%%%%%%        "exp18";"exp19";"exp20";"exp21";"exp22";"exp23";
%%%%%%%%				"exp24";"exp25";"exp26";"exp27";"exp28";"exp29";
%%%%%%%%				"exp30";"exp31";"exp32";"exp33";"exp34";"exp35";
%%%%%%%%				"exp36";"exp37";"exp38";"exp39";"exp40";"exp41";
%%%%%%%%        "exp42";"exp43";"exp44";"exp45";"exp46";"exp47";
%%%%%%%%        "exp48";"exp49";"exp50";"exp51";"exp52";"exp53";
%%%%%%%%        "exp54";"exp55";"exp56";"exp57";"exp58"];
%%%%%%%%%%%%%%%todo.exp00=exp00;
%%%%%%%%todo.exp01=exp01;todo.exp02=exp02;todo.exp03=exp03;todo.exp04=exp04;todo.exp05=exp05;
%%%%%%%%todo.exp06=exp06;todo.exp07=exp07;todo.exp08=exp08;todo.exp09=exp09;todo.exp10=exp10;
%%%%%%%%todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;todo.exp15=exp15;
%%%%%%%%todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;todo.exp19=exp19,todo.exp20=exp20;
%%%%%%%%todo.exp21=exp21;todo.exp22=exp22;todo.exp23=exp23;todo.exp24=exp24;todo.exp25=exp25;
%%%%%%%%todo.exp26=exp26;todo.exp27=exp27;todo.exp28=exp28;todo.exp29=exp29;
%%%%%%%%todo.exp30=exp30;todo.exp31=exp31;todo.exp32=exp32;todo.exp33=exp33;
%%%%%%%%todo.exp34=exp34;todo.exp35=exp35;
%%%%%%%%todo.exp36=exp36;todo.exp37=exp37;
%%%%%%%%todo.exp38=exp38;todo.exp39=exp39;
%%%%%%%%todo.exp40=exp40;todo.exp41=exp41;
%%%%%%%%todo.exp42=exp42;todo.exp43=exp43;
%%%%%%%%todo.exp44=exp44;todo.exp45=exp45;
%%%%%%%%todo.exp46=exp46;todo.exp47=exp47;
%%%%%%%%todo.exp48=exp48;todo.exp49=exp49;
%%%%%%%%todo.exp50=exp50;todo.exp51=exp51;%todo.exp=exp;
%%%%%%%%todo.exp52=exp52;todo.exp53=exp53;
%%%%%%%%todo.exp54=exp54;todo.exp55=exp55;
%%%%%%%%todo.exp56=exp56;todo.exp57=exp57;todo.exp58=exp58;
%%%%%%%
%%%%%%%_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];
%%%%%%%
%%%%%%%% PORCENTAJE DE COOPERACION
%%%%%%%_nSujetos=12;
%%%%%%%_vSujetosNull=[];
%%%%%%%_vSujetos1=[1 2 3 4 5 6 7 8 9 10 11 12];% desde exp01
%%%%%%%_vSujetos2=[2 6 8 9 10 11];% a partir del exp24
%%%%%%%_vSujetos3=[2 6 8 9 11]; % a partir del exp30
%%%%%%%_vSujetos4=[2 8 11]; % a partir del exp32
%%%%%%%_vSujetos5=[8]; % a partir del exp34
%%%%%%%_vSujetos=_vSujetos1;
%%%%%%%_iniSujExp=[0 0 0 0 0 0 0 0 0 0 0 0];
%%%%%%%_finAnalisis1=23;% valor inclusive de experimento  (1 3 4 5 7 12)
%%%%%%%_finAnalisis2=29;%(10)
%%%%%%%_finAnalisis3=31;%(6 9)
%%%%%%%_finAnalisis4=33;%(2 11)
%%%%%%%_finAnalisis5=50;%(9)
%%%%%%%_iniAnalisis1=1;
%%%%%%%_iniAnalisis2=1;
%%%%%%%_iniAnalisis3=1;
%%%%%%%_iniAnalisis4=1;
%%%%%%%_iniAnalisis5=1;
%%%%%%%_coop=zeros(1,_nSujetos);
%%%%%%%_cooperacion=[];
%%%%%%%_nada=[];
%%%%%%%_nadaAux=zeros(1,_nSujetos);
%%%%%%%_trialIni=1;
%%%%%%%_trialFin=30;
%%%%%%%inicio=01;
%%%%%%%fin=50;
%%%%%%%datos=zeros(2,fin);
%%%%%%%            %R T P  S
%%%%%%%_vRefuerzos=[1 2 0  0];
%%%%%%%_vDelay4eat=[5 5 9 13];%[cc dc cd dd] [R T S P]
%%%%%%%_timeoutLimit=10*0+10*8+10*4;%10*5+10*13+10*9;% 270s en 30trials  %195; %13*15 or T+29*P=
%%%%%%%_timeoutITI=30*5;
%%%%%%%_foodLimit=2*15+0*15;% food por T y por S, alterna
%%%%%%%
%%%%%%%_criterio=0.5;
%%%%%%%% Testeo ------------------------------
%%%%%%%%for j=inicio:fin
%%%%%%%%  if j<24
%%%%%%%%    _vSujetos=_vSujetos1;
%%%%%%%%  elseif (j>=24 && j<30)
%%%%%%%%    _vSujetos=_vSujetos2;
%%%%%%%%  elseif (j>=30 && j<32)
%%%%%%%%    _vSujetos=_vSujetos3;
%%%%%%%%  elseif (j>=32 && j<34)
%%%%%%%%    _vSujetos=_vSujetos4;
%%%%%%%%  elseif (j>=34)
%%%%%%%%    _vSujetos=_vSujetos5;
%%%%%%%%  else
%%%%%%%%    _vSujetos=_vSujetosNull;
%%%%%%%%  endif
%%%%%%%%  for i=_vSujetos
%%%%%%%%    %todo.(indice(j+1,:))(i)._respuestasEXP=[2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1];
%%%%%%%%   %if i==1 && (j==4||j==23)
%%%%%%%%   %todo.(indice(j+1,:))(i)._respuestasEXP=[2 2 2 0 0 2 2 2 2 2 2 2 2 2 2 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1];
%%%%%%%%   %else
%%%%%%%%   todo.(indice(j+1,:))(i)._respuestasEXP=ceil(2*rand(1,31));%[2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
%%%%%%%%   %endif
%%%%%%%%    %todo.(indice(j+1,:))(i)._respuestasEXP=[1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2];
%%%%%%%%    %todo.(indice(j+1,:))(i)._respuestasOPO=[1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2];
%%%%%%%%    todo.(indice(j+1,:))(i)._respuestasOPO=ceil(2*rand(1,31));%[2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
%%%%%%%%    %todo.(indice(j+1,:))(i)._respuestasOPO=[2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1];
%%%%%%%%  endfor
%%%%%%%%endfor
%%%%%%%%--------------------------------------
%%%%%%%
%%%%%%%indiceSujeto=[];
%%%%%%%%for i=1:_nSujetos
%%%%%%%%  indiceSujeto=[indiceSujeto;strcat("Q",mat2str(i))];
%%%%%%%%endfor
%%%%%%%indiceSujeto=["Q01";"Q02";"Q03";"Q04";"Q05";"Q06";"Q07";"Q08";"Q09";"Q10";"Q11";"Q12"];
%%%%%%%% Probabilidades de transicion de estados
%%%%%%%%matricesQ1.Q1=[];matricesQ2.Q2=[];matricesQ3.Q3=[];matricesQ4.Q4=[];matricesQ5.Q5=[];matricesQ6.Q6=[];
%%%%%%%%matricesQ7.Q7=[];matricesQ8.Q8=[];matricesQ9.Q9=[];matricesQ10.Q10=[];matricesQ11.Q11=[];matricesQ12.Q12=[];
%%%%%%%matricesQxExp=[];
%%%%%%%matricesQaux=[];
%%%%%%%Q = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
%%%%%%%fallasXexp=[];
%%%%%%%%matricesQ.Q1=[];matricesQ.Q2=[];matricesQ.Q3=[];matricesQ.Q4=[];matricesQ.Q5=[];matricesQ.Q6=[];matricesQ.Q7=[];matricesQ.Q8=[];matricesQ.Q9=[];matricesQ.Q10=[];matricesQ.Q11=[];matricesQ.Q12=[];
%%%%%%%for i=1:_nSujetos
%%%%%%%  matricesQ.(indiceSujeto(i,:)) = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
%%%%%%%  matricesQaux.(indiceSujeto(i,:)) = zeros(4,4);
%%%%%%%endfor
%%%%%%%
%%%%%%%% Experimentos por sujetos
%%%%%%%expXsuj=zeros(1,_nSujetos);
%%%%%%%for j=inicio:(numfields(todo)-8)
%%%%%%%  for i=1:length(todo.(indice(j+1,:)))
%%%%%%%    if length(todo.(indice(j+1,:))(i)._groupStr)!=0
%%%%%%%      expXsuj(i)++;
%%%%%%%    endif
%%%%%%%  endfor
%%%%%%%endfor
%%%%%%%
%%%%%%%fin=numfields(todo)-8;
%%%%%%%% 
%%%%%%%% Brief: Carga las matrices de transicion de estado de cada sujeto.
%%%%%%%%        Es un promedio total 
%%%%%%%%        Acumula las veces que aparece la transicion durante los 29 trials a lo
%%%%%%%%        largo los inicio:fin de experimentos.
%%%%%%%T=zeros(_nSujetos,length(inicio:fin));C=zeros(_nSujetos,length(inicio:fin));
%%%%%%%P=zeros(_nSujetos,length(inicio:fin));S=zeros(_nSujetos,length(inicio:fin));
%%%%%%%controlFallas=zeros(1,_nSujetos);
%%%%%%%controlFallasXexp=zeros(_nSujetos,length(inicio:(fin)));
%%%%%%%auxFallas=1;
%%%%%%%
%%%%%%%_ultimosX=10;
%%%%%%%for i=1:_nSujetos
%%%%%%%  ultimo=expXsuj(i);
%%%%%%%  primero=1;
%%%%%%%  for j=primero:ultimo %Experimentos
%%%%%%%    for k=_trialIni:_trialFin  % nºtrials x Exp.  TRAICIONAR DADO QUE
%%%%%%%      if ((todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)||(todo.(indice(j+1,:))(i)._respuestasOPO(k)==0))
%%%%%%%        if (k==1)
%%%%%%%          ++controlFallas(i);%%%
%%%%%%%        elseif (k==2) 
%%%%%%%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)% k=1 y K=2 son ceros no se cuenta una falla auxiluar
%%%%%%%            auxFallas+=1;  
%%%%%%%          endif
%%%%%%%          ++controlFallas(i);%%%
%%%%%%%          ++controlFallasXexp(i,j);
%%%%%%%        elseif (k==3)
%%%%%%%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-2)==0)&&(todo.(indice(j+1,:))(i)._respuestasEXP(k-1)==0)
%%%%%%%            % nada
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)
%%%%%%%            auxFallas+=1;
%%%%%%%          else
%%%%%%%            a="MIERDA!!!"
%%%%%%%          endif
%%%%%%%          ++controlFallas(i);%%%
%%%%%%%          ++controlFallasXexp(i,j);
%%%%%%%        else
%%%%%%%          auxFallas+=1;
%%%%%%%          ++controlFallas(i);
%%%%%%%          ++controlFallasXexp(i,j);
%%%%%%%        endif
%%%%%%%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==2)
%%%%%%%        T(i,j-inicio+1)++; %TRAICIONAR DADO :
%%%%%%%        if (k>1) 
%%%%%%%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(1,1);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(1,1); 
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(2,1);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(2,1); 
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(3,1);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(3,1);
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(4,1);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(4,1); 
%%%%%%%          endif  
%%%%%%%        endif
%%%%%%%        auxFallas=1;
%%%%%%%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==2)
%%%%%%%        C(i,j-inicio+1)++; % COOPERACION MUTUA DADO :
%%%%%%%        if (k>1) 
%%%%%%%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(1,2); 
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(1,2);
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(2,2);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(2,2);
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(3,2);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(3,2);
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(4,2);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(4,2); 
%%%%%%%          endif
%%%%%%%        endif
%%%%%%%        auxFallas=1;
%%%%%%%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)=1)
%%%%%%%        P(i,j-inicio+1)++; % NO COOPERACION MUTUA DADO :
%%%%%%%        if (k>1) 
%%%%%%%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %que Traiciono (imposible x TFT)%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(1,3);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(1,3); 
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%Cooperacion mutua%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(2,3);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(2,3); 
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(3,3);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(3,3);            
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(4,3);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(4,3);             
%%%%%%%          endif
%%%%%%%        endif
%%%%%%%        auxFallas=1;
%%%%%%%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==1)
%%%%%%%        S(i,j-inicio+1)++; % ESTAFAR DADO :
%%%%%%%        if (k>1) 
%%%%%%%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(1,4);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(1,4);             
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%Cooperacion mutua%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(2,4);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(2,4);             
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(3,4);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(3,4);            
%%%%%%%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%%%%%%%            ++matricesQ.(indiceSujeto(i,:))(4,4);
%%%%%%%            ++matricesQaux.(indiceSujeto(i,:))(4,4);             
%%%%%%%          endif
%%%%%%%        endif
%%%%%%%        auxFallas=1;
%%%%%%%      endif
%%%%%%%    endfor
%%%%%%%    auxFallas=1;
%%%%%%%    matricesQxExp.(indiceSujeto(i,:)).(indice(j+1,:))=matricesQaux.(indiceSujeto(i,:));
%%%%%%%  endfor
%%%%%%%  for i=1:_nSujetos
%%%%%%%    matricesQaux.(indiceSujeto(i,:)) = zeros(4,4);
%%%%%%%  endfor
%%%%%%%endfor
%%%%%%%
%%%%%%%T(:,:)=T(:,:)/(length(_trialIni:_trialFin));C(:,:)=C(:,:)/length(_trialIni:_trialFin);P(:,:)=P(:,:)/length(_trialIni:_trialFin);S(:,:)=S(:,:)/length(_trialIni:_trialFin);
%%%%%%%auxOutComes=T(:,:)+C(:,:)+P(:,:)+S(:,:);
%%%%%%%T=T./auxOutComes;T(isnan(T(:,:)))=0;
%%%%%%%C=C./auxOutComes;C(isnan(C(:,:)))=0;
%%%%%%%P=P./auxOutComes;P(isnan(P(:,:)))=0;
%%%%%%%S=S./auxOutComes;S(isnan(S(:,:)))=0;
%%%%%%%
%%%%%%%%T=T./(30-controlFallasXexp);
%%%%%%%%C=C./(30-controlFallasXexp);
%%%%%%%%P=P./(30-controlFallasXexp);
%%%%%%%%S=S./(30-controlFallasXexp);
%%%%%%%TT=[];CC=[];PP=[];SS=[];
%%%%%%%TT=T;CC=C;PP=P;SS=S;
%%%%%%%T2=T;R2=C;P2=P;S2=S;
%%%%%%%
%%%%%%%T_mean=zeros(1,_nSujetos);R_mean=zeros(1,_nSujetos);P_mean=zeros(1,_nSujetos);S_mean=zeros(1,_nSujetos);
%%%%%%%T_median=zeros(1,_nSujetos);R_median=zeros(1,_nSujetos);P_median=zeros(1,_nSujetos);S_median=zeros(1,_nSujetos);
%%%%%%%T_sem=zeros(1,_nSujetos);R_sem=zeros(1,_nSujetos);P_sem=zeros(1,_nSujetos);S_sem=zeros(1,_nSujetos);
%%%%%%%for i=_vSujetos
%%%%%%%  ultimo=_iniSujExp(i)-1+numfields(matricesQxExp.(indiceSujeto(i,:)));
%%%%%%%  primero=ultimo-_ultimosX+1;
%%%%%%%  T_mean(i)=mean(T2(i,primero:ultimo),2);R_mean(i)=mean(R2(i,primero:ultimo),2);P_mean(i)=mean(P2(i,primero:ultimo),2);S_mean(i)=mean(S2(i,primero:ultimo),2);
%%%%%%%  T_median(i)=median(T2(i,primero:ultimo),2);R_median(i)=median(R2(i,primero:ultimo),2);P_median(i)=median(P2(i,primero:ultimo),2);S_median(i)=median(S2(i,primero:ultimo),2);
%%%%%%%  T_sem(i)=sem(T2(i,primero:ultimo),2);R_sem(i)=sem(R2(i,primero:ultimo),2);P_sem(i)=sem(P2(i,primero:ultimo),2);S_sem(i)=sem(S2(i,primero:ultimo),2);
%%%%%%%endfor
%%%%%%%
%%%%%%%
%%%%%%%QxExp_ante=matricesQxExp;
%%%%%%%% Analizando las ultimas X sesiones
%%%%%%%_ultimosX=10;
%%%%%%%%   Normalizacion para todos los sujetos en todos los experimentos
%%%%%%%Q_antes=matricesQ;
%%%%%%%QQ=[];
%%%%%%%QQTot=zeros(2,2,_nSujetos);
%%%%%%%QQTotmarkov=zeros(2,2,_nSujetos);
%%%%%%%QQTotmarkovSem=zeros(2,2,_nSujetos);
%%%%%%%%for i=1:_nSujetos
%%%%%%%%  ultimo=expXsuj(i);
%%%%%%%%  primero=ultimo-_ultimosX+1;
%%%%%%%%  jj=0;
%%%%%%%%  aux2=[];
%%%%%%%%  for j=primero:ultimo %Experimentos
%%%%%%%%    jj++;  %| la P(c|c) es igual a la sumatorias en "sum(x ,1)" de P(c|R) y P(c|S) y las otras filas lsa compo ponentes son cero
%%%%%%%%    aux = sum(QxExp_ante.(indiceSujeto(i,:)).(indice(j+1,:)));% P(d|c) P(c|c) P(d|d) P(c|d) 
%%%%%%%%    aux2=[aux2 aux'./[aux(1)+aux(3);aux(2)+aux(4);aux(1)+aux(3);aux(2)+aux(4)]];
%%%%%%%%    QQTot(:,:,i)=QQTot(:,:,i) + [aux(sort(1:4,'descend'))(3:4); aux(sort(1:4,'descend'))(1:2)];% se ordena par que tengal a lforma 2x2
%%%%%%%%    QQ.(indiceSujeto(i,:)).(num2str(jj))=[aux(sort(1:4,'descend'))(3:4); aux(sort(1:4,'descend'))(1:2)];%./sum(sum(QxExp_ante.(indiceSujeto(i,:)).(indice(j+1,:)))),1)';
%%%%%%%%  endfor
%%%%%%%%  QQTotmarkov(1,:,i)=QQTot(1,:,i)./sum(QQTot(:,:,i),2)(1);%QQTot = P(c|c) P(d|c) => vec(QQTot)
%%%%%%%%  QQTotmarkov(2,:,i)=QQTot(2,:,i)./sum(QQTot(:,:,i),2)(2);%        P(c|d) P(d|d)  P(c|c) P(c|d) P(d|c) P(d|d)
%%%%%%%%                         % sem cc             dc           cd                dd
%%%%%%%%  QQTotmarkovSem(:,:,i)= [ sem(aux2,2)(2) sem(aux2,2)(1); sem(aux2,2)(4) sem(aux2,2)(3)];
%%%%%%%%endfor
%%%%%%%for i=_vSujetos
%%%%%%%  ultimo=_iniSujExp(i)-1+numfields(matricesQxExp.(indiceSujeto(i,:)));
%%%%%%%  primero=ultimo-_ultimosX+1;
%%%%%%%  jj=0;
%%%%%%%  aux2=[];
%%%%%%%  for j=primero:ultimo %Experimentos
%%%%%%%    jj++;  %| la P(c|c) es igual a la sumatorias en "sum(x ,1)" de P(c|R) y P(c|S) y las otras filas lsa compo ponentes son cero
%%%%%%%    aux = QxExp_ante.(indiceSujeto(i,:)).(indice(j+1,:))./sum(QxExp_ante.(indiceSujeto(i,:)).(indice(j+1,:)),2);
%%%%%%%    
%%%%%%%    aux(isnan(aux))=0; %%Elimina los valores NaN
%%%%%%%    %P(c|c)
%%%%%%%    QQTot(1,1,i)= QQTot(1,1,i) + aux(2,2)*C(i,j)+ aux(4,2)*S(i,j);
%%%%%%%    %P(d|c)
%%%%%%%    QQTot(1,2,i)= QQTot(1,2,i) + aux(2,1)*C(i,j)+ aux(4,1)*S(i,j);
%%%%%%%    %P(c|d)
%%%%%%%    QQTot(2,1,i)= QQTot(2,1,i) + aux(1,4)*T(i,j)+ aux(3,4)*P(i,j);
%%%%%%%    %P(d|d)
%%%%%%%    QQTot(2,2,i)= QQTot(2,2,i) + aux(1,3)*T(i,j)+ aux(3,3)*P(i,j);
%%%%%%%    
%%%%%%%    aux3=[aux(2,2)*C(i,j)+ aux(4,2)*S(i,j) aux(2,1)*C(i,j)+ aux(4,1)*S(i,j);%c|c% %d|c%
%%%%%%%          aux(1,4)*T(i,j)+ aux(3,4)*P(i,j) aux(1,3)*T(i,j)+ aux(3,3)*P(i,j);%c|d% %d|d%
%%%%%%%          ];
%%%%%%%    aux3=aux3./sum(aux3,2);
%%%%%%%    %aux2=aux2./[aux2(1)+aux2(3) aux2(2)+aux2(4) aux2(1)+aux2(3) aux2(2)+aux2(4)];
%%%%%%%    aux2=[aux2 vec(aux3)]; % vec -> %c|c  c|d  d|c  d|d %
%%%%%%%                           %          R    S    T    P
%%%%%%%  endfor
%%%%%%%  %QQTot(:,:,i)
%%%%%%%  QQTot(:,:,i) = QQTot(:,:,i)./length([primero:ultimo]);
%%%%%%%  QQTot(:,:,i) = QQTot(:,:,i)./sum(QQTot(:,:,i),2);
%%%%%%%  QQTotmarkovSem(:,:,i)=[sem(aux2,2)(1) sem(aux2,2)(2); sem(aux2,2)(3) sem(aux2,2)(4)];% R T P S
%%%%%%%endfor
%%%%%%%QQTotmarkov=QQTot;
%%%%%%%
%%%%%%%% matriz para inkscape
%%%%%%%QQTotmarkovInk=zeros(2,2,_nSujetos);
%%%%%%%for i=1:_nSujetos
%%%%%%%   QQTotmarkovInk(1,1,i)=30*QQTotmarkov(1,1,i)+0;
%%%%%%%   QQTotmarkovInk(1,2,i)=30*QQTotmarkov(1,2,i)+0;
%%%%%%%   QQTotmarkovInk(2,1,i)=30*QQTotmarkov(2,1,i)+0;
%%%%%%%   QQTotmarkovInk(2,2,i)=30*QQTotmarkov(2,2,i)+0;
%%%%%%%endfor


%% %  EVOLUCION COOP Y REVERSION
clear all;
%close all;
load datos_suavizado_5_coop;
load datos_suavizado_5_rev;
figure;hold on;
h=plot([1-length(suavizado3):0],[suavizado3],'-o-k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado7):0],[suavizado7],'-+k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado9):0],[suavizado9],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado10):0],[suavizado10],'-<k');set(h, "linewidth", 2,'MarkerSize',10);

h=plot([0:length(suavizado_379_rev(1,:))-1],[ suavizado_379_rev(1,:)],'-o-k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado_379_rev(2,:))-1],[ suavizado_379_rev(2,:)],'-+k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado_379_rev(3,:))-1],[ suavizado_379_rev(3,:)],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado10rev)-1],[ suavizado10rev],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
hold off;

clear all;
load datos_suavizado_4_coop;
load datos_suavizado_4_rev;
figure;hold on;
h=plot([1-length(suavizado3):0],[suavizado3],'-o-k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado7):0],[suavizado7],'-+k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado9):0],[suavizado9],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado10):0],[suavizado10],'-<k');set(h, "linewidth", 2,'MarkerSize',10);

h=plot([0:length(suavizado_379_rev(1,:))-1],[ suavizado_379_rev(1,:)],'-o-k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado_379_rev(2,:))-1],[ suavizado_379_rev(2,:)],'-+k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado_379_rev(3,:))-1],[ suavizado_379_rev(3,:)],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado10rev)-1],[ suavizado10rev],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
hold off;


clear all;
load datos_suavizado_3_coop;
load datos_suavizado_3_rev;
figure;hold on;
h=plot([1-length(suavizado3):0],[suavizado3],'-ok');set(h, "linewidth", 2,'MarkerSize',7,'markerfacecolor','k');
h=plot([1-length(suavizado7):0],[suavizado7],'-+k');set(h, "linewidth", 2,'MarkerSize',7,'markerfacecolor','k');
h=plot([1-length(suavizado9):0],[suavizado9],'-<k');set(h, "linewidth", 2,'MarkerSize',7,'markerfacecolor','k');
h=plot([1-length(suavizado10):0],[suavizado10],'-sk');set(h, "linewidth", 2,'MarkerSize',7,'markerfacecolor','k');

h=plot([0:length(suavizado_379_rev(1,:))-1],[ suavizado_379_rev(1,:)],'-ok');set(h, "linewidth", 2,'MarkerSize',7,'markerfacecolor','k');
h=plot([0:length(suavizado_379_rev(2,:))-1],[ suavizado_379_rev(2,:)],'-+k');set(h, "linewidth", 2,'MarkerSize',7,'markerfacecolor','k');
h=plot([0:length(suavizado_379_rev(3,:))-1],[ suavizado_379_rev(3,:)],'-<k');set(h, "linewidth", 2,'MarkerSize',7,'markerfacecolor','k');
h=plot([0:length(suavizado10rev)-1],[ suavizado10rev],'-sk');set(h, "linewidth", 2,'MarkerSize',7,'markerfacecolor','k');
hold off;


clear all;
load datos_suavizado_2_coop;
load datos_suavizado_2_rev;
figure;hold on;
h=plot([1-length(suavizado3):0],[suavizado3],'-o-k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado7):0],[suavizado7],'-+k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado9):0],[suavizado9],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado10):0],[suavizado10],'-<k');set(h, "linewidth", 2,'MarkerSize',10);

h=plot([0:length(suavizado_379_rev(1,:))-1],[ suavizado_379_rev(1,:)],'-o-k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado_379_rev(2,:))-1],[ suavizado_379_rev(2,:)],'-+k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado_379_rev(3,:))-1],[ suavizado_379_rev(3,:)],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado10rev)-1],[ suavizado10rev],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
hold off;

clear all;
load datos_suavizado_1_coop;
load datos_suavizado_1_rev;
figure;hold on;
h=plot([1-length(suavizado3):0],[suavizado3],'-o-k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado7):0],[suavizado7],'-+k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado9):0],[suavizado9],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([1-length(suavizado10):0],[suavizado10],'-<k');set(h, "linewidth", 2,'MarkerSize',10);

h=plot([0:length(suavizado_379_rev(1,:))-1],[ suavizado_379_rev(1,:)],'-o-k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado_379_rev(2,:))-1],[ suavizado_379_rev(2,:)],'-+k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado_379_rev(3,:))-1],[ suavizado_379_rev(3,:)],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
h=plot([0:length(suavizado10rev)-1],[ suavizado10rev],'-<k');set(h, "linewidth", 2,'MarkerSize',10);
hold off;