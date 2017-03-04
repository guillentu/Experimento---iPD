

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for i=1:_nSujetos
%  inicioAux=expXsuj(i)-_ultimosX+1;
%  finAux=expXsuj(i);
%  h=plot([1:10],_promediosC(inicioAux:finAux,i),_colores(i,:));
%  set(h, "linewidth", 2);
%  hh=xlabel("n de sesiones");set(hh, "fontsize", 14);
%  hh=ylabel("% de cooperacion");set(hh, "fontsize", 14);
%  hh=title(strcat("Cooperacion en iPD en sujetos que alcanzaron Criterio: ",num2str(_criterio,2)));
%  axis([1 10 0 1]);set(hh, "fontsize", 14);
%  grid on;
%endfor
%%close all;
%%_ultimosX=10
%%_ps1=zeros(2,_nSujetos);

%for i=1:_nSujetos
%  inicioAux=1;%expXsuj(i)-_ultimosX+1;
%  finAux=10;%expXsuj(i);
%  x=[1:_ultimosX]';%[inicio:fin]';
%  y=_promediosC(inicioAux:finAux,i);
%  F = [ ones(length(x),1) x];
%  [p,e_var,r,p_var,y_var] = LinearRegression(F,y(:,1));
%  yFit = F*p;
%  _ps1(:,i)=p;
%%  figure();
%%  plot(x,y(:,1),'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%%  title('Behavior Stability - Lineal Regresion');
%%  xlabel("session");
%%  ylabel("% of cooperation");
%%  legend(strcat('C choice ',_txtSujetos(i,:)),'fit','+/-95% Desv. Std');
%%  axis([0 10 0.2 1.3])
%%  grid on
%endfor

%%_ps2=zeros(2,_nSujetos);
%%_values=zeros(_nSujetos,1);
%for i=1:_nSujetos
%  inicioAux=expXsuj(i)-_ultimosX+1;
%  finAux=expXsuj(i);
%  x=[1:_ultimosX]';%[inicio:fin]';
%  y=_promediosC(inicioAux:finAux,i);
%  F = [ ones(length(x),1) x];
%  [p,e_var,r,p_var,y_var] = LinearRegression(F,y(:,1));
%  yFit = F*p;
%  _ps2(1,i)=[1 5]*p;
%  _ps2(1,i)
%  [_values(i) index]=max(abs(_ps2(1,i)-_promediosC(inicioAux:finAux,i)));
%  mean(y)
%  
%%  figure();
%%  plot(x,y(:,1),'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%%  title('Behavior Stability - Lineal Regresion');
%%  xlabel("session");
%%  ylabel("% of cooperation");
%%  legend(strcat('C choice ',_txtSujetos(i,:)),'fit','+/-95% Desv. Std');
%%  axis([0 10 0.2 1.3])
%%  grid on
%endfor
%for i=1:_nSujetos
%   _txtSujetos(i,:)
%  inicioAux=expXsuj(i)-_ultimosX+1;
%  finAux=expXsuj(i);
%  x=[1:_ultimosX]';%[inicio:fin]';
%  y=_promediosC(inicioAux:finAux,i);
%  F = [ ones(length(x),1) x];
%  [p,e_var,r,p_var,y_var] = LinearRegression(F,y(:,1));
%  yFit = F*p;
%  %_ps1(1,i)=p
%  _mediaXsujeto(i)
%  sqrt(e_var)
%  %_ps2(1,i)=[1 5]*p;
%  %_ps2(1,i)
%  [_values(i) index]=max(abs(_ps2(1,i)-_promediosC(inicioAux:finAux,i)));
%  %mean(y)
%%  figure();
%%  plot(x,y(:,1),'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%%  title('Behavior Stability - Lineal Regresion');
%%  xlabel("session");
%%  ylabel("% of cooperation");
%%  legend(strcat('C choice ',_txtSujetos(i,:)),'fit','+/-95% Desv. Std');
%%  axis([0 10 0.2 1.3])
%%  grid on
%endfor


% grafico Cooperacion Versus R
%[S I]=sort(_mediaXsujeto);
%threshold=0.3;
%figure;
%h=scatter(_mediaXsujeto(I(find(sort(_mediaXsujeto)>threshold))),R_mean(I(find(sort(_mediaXsujeto)>threshold))),20,(_delay4eat(I(find(sort(_mediaXsujeto)>threshold)))./120),"filled");
%ch=colormap(copper);
%colorbar('southoutside');
%set(h, "linewidth", 2);
%hh=xlabel("Among of C choice ");
%set(hh, "fontsize", 14);
%hh=ylabel("% Mutual Cooperation");
%set(hh, "fontsize", 14);
%hh=title("Cooperation Versus Mutual Cooperation (Colorbar=Timeout)"); 
%set(hh, "fontsize", 14);
%grid off;%grid minor;
%%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .08*[1 1 1 1 1 1 1 1 1 1 1 -1]+R_mean(I),_txtSujetos(I,:));
%t=text(-0.01*[1 1 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I(find(sort(_mediaXsujeto)>threshold))),
%         .08*[1 1 1 1 1 1 1 1 1 1 1 -1]+R_mean(I(find(sort(_mediaXsujeto)>threshold))),
%         _txtSujetos(I(find(sort(_mediaXsujeto)>threshold)),:));
%%axis('auto');
%axis([.49 1.1 0 1.1]);
%hold on;
%h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,_idealSujeto(2,[1 3 4 5 6 7])./120,'s',"filled");
%h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7])', 
%        0.04*[.5 .5 .5 .5 1.4 1.4]+_idealSujeto(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7])', 
%       -0.025*[1.2 1 1 1  1.9 1.9]+_idealSujeto(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;
%
%% grafico Alimentos versus Cooperacion
%[S I]=sort(_mediaXsujeto);
%figure;
%%h=plot(_mediaXsujeto(I),_alimento(I),'ko', "markersize",12,"markerfacecolor",'c', "linewidth", 2);
%h=scatter(_mediaXsujeto(I(find(sort(_mediaXsujeto)>0.5))),_alimento(I(find(sort(_mediaXsujeto)>0.5))),20,_delay4eat(I(find(sort(_mediaXsujeto)>0.5)))./120,"filled");
%ch=colormap(copper);
%colorbar('southoutside');
%set(h, "linewidth", 2);
%hh=xlabel("Among of C choice ");
%set(hh, "fontsize", 14);
%hh=ylabel("% Total Reward");
%set(hh, "fontsize", 14);
%hh=title("Reward versus Cooperation (Colorbar=Timeout)"); 
%set(hh, "fontsize", 14);
%grid off;%grid minor;
%t=text(-0.01*[1 1 1 1 1 1 1 -1]+_mediaXsujeto(I(find(sort(_mediaXsujeto)>0.5))), 
%         .08*[ 1 1 1 1 1 1 1 -1]+_alimento(I(find(sort(_mediaXsujeto)>0.5))) ,
%         _txtSujetos(I(find(sort(_mediaXsujeto)>0.5)),:));
%%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .03*[1 1 1 1 1 1 1 1 1 1 1 -1]+_alimento(I) ,_txtSujetos(I,:));
%%axis('auto');
%axis([.49 1.02 0 1.15]);
%hold on;
%%h=plot(_mediaXsujeto(I(length(I))),_alimento(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,_idealSujeto(2,[1 3 4 5 6 7]),'s',"filled");
%h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),_idealSujeto(2,[1 3 4 5 6 7]),15,probC([1 3 4 5 6 7])','s',"filled");
%%h=plot(probC([1 3 4 5]),_idealSujeto(1,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7])', 
%        0.04*[.5 .5 .5 .5 2.9 2.9]+_idealSujeto(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7])', 
%       -0.025*[1.2 1 1 1 -3.2 -3.2]+_idealSujeto(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;


%%%%%%%%%%%%%%%%%%%%%% Copy MArkov %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%_vSujetos=_vSujetos3;
%
%figure();
%plot([inicio:fin],_promediosC(3,:),'--ok',[inicio:fin],_promediosC(7,:),'--ob',[7:24],_promediosC(10,[7:24]),'--oc',[9:fin], _promediosC(9,[9:fin]),'--om');
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(3,:),_txtSujetos(7,:),_txtSujetos(10,:),_txtSujetos(9,:));
%grid on;
%
%figure();
%plot([inicio:fin],_promediosC(3,:),'--ok');
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(3,:));grid on;
%figure();
%plot([inicio:fin],_promediosC(7,:),'--ob');
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(7,:));grid on;
%figure();
%plot([inicio:42],_promediosC(12,inicio:42),'--or');
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(12,:));grid on;
%figure();
%plot([7:24],_promediosC(10,[7:24]),'--oc');
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(10,:));grid on;
%figure();
%plot([9:fin], _promediosC(9,[9:fin]),'--om');
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(9,:));grid on;
%
%
%
%% Promedio de cooperacion sin outlayers
%
%
%indiceSujeto=[];
%for i=1:_nSujetos
%  indiceSujeto=[indiceSujeto;strcat("Q",mat2str(i))]
%endfor
%% Probabilidades de transicion de estados
%matricesQxExp=[];
%matricesQaux=[];
%matricesQ=[];
%Q = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
%for i=1:_nSujetos
%  matricesQ.(indiceSujeto(i,:)) = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
%  matricesQaux.(indiceSujeto(i,:)) = zeros(4,4);
%endfor
%% 
%% Brief: Carga las matrices de transicion de estado de cada sujeto. 
%%        Acumula las veces que aparece la transicion durante los 29 trials a lo
%%        largo los inicio:fin de experimentos.
%T=zeros(_nSujetos,length(inicio:fin));C=zeros(_nSujetos,length(inicio:fin));
%P=zeros(_nSujetos,length(inicio:fin));S=zeros(_nSujetos,length(inicio:fin));
%controlFallas=zeros(1,_nSujetos);
%auxFallas=1;
%for j=inicio:fin
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
%    for k=_trialIni:_trialFin  % nºtrials x Exp.  TRAICIONAR DADO QUE
%      if ((todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)||(todo.(indice(j+1,:))(i)._respuestasOPO(k)==0))
%        if (k==1)
%          ++controlFallas(i);%%%
%        elseif (k==2) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)% k=1 y K=2 son ceros no se cuenta una falla auxiluar
%            auxFallas+=1;  
%          endif
%          ++controlFallas(i);%%%
%        elseif (k==3)
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-2)==0)&&(todo.(indice(j+1,:))(i)._respuestasEXP(k-1)==0)
%            % nada
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)
%            auxFallas+=1;
%          else
%            a="MIERDA!!!"
%          endif
%          ++controlFallas(i);%%%
%        else
%          auxFallas+=1;
%          ++controlFallas(i);
%        endif
%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==2)
%        T(i,j-inicio+1)++; %TRAICIONAR DADO :
%        if (k>1) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
%            ++matricesQ.(indiceSujeto(i,:))(1,1);
%            ++matricesQaux.(indiceSujeto(i,:))(1,1); 
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
%            ++matricesQ.(indiceSujeto(i,:))(2,1);
%            ++matricesQaux.(indiceSujeto(i,:))(2,1); 
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
%            ++matricesQ.(indiceSujeto(i,:))(3,1);
%            ++matricesQaux.(indiceSujeto(i,:))(3,1);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%            ++matricesQ.(indiceSujeto(i,:))(4,1);
%            ++matricesQaux.(indiceSujeto(i,:))(4,1); 
%          endif  
%        endif
%        auxFallas=1;
%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==2)
%        C(i,j-inicio+1)++; % COOPERACION MUTUA DADO :
%        if (k>1) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
%            ++matricesQ.(indiceSujeto(i,:))(1,2); 
%            ++matricesQaux.(indiceSujeto(i,:))(1,2);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
%            ++matricesQ.(indiceSujeto(i,:))(2,2);
%            ++matricesQaux.(indiceSujeto(i,:))(2,2);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
%            ++matricesQ.(indiceSujeto(i,:))(3,2);
%            ++matricesQaux.(indiceSujeto(i,:))(3,2);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%            ++matricesQ.(indiceSujeto(i,:))(4,2);
%            ++matricesQaux.(indiceSujeto(i,:))(4,2); 
%          endif
%        endif
%        auxFallas=1;
%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)=1)
%        P(i,j-inicio+1)++; % NO COOPERACION MUTUA DADO :
%        if (k>1) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %que Traiciono (imposible x TFT)%
%            ++matricesQ.(indiceSujeto(i,:))(1,3);
%            ++matricesQaux.(indiceSujeto(i,:))(1,3); 
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%Cooperacion mutua%
%            ++matricesQ.(indiceSujeto(i,:))(2,3);
%            ++matricesQaux.(indiceSujeto(i,:))(2,3); 
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
%            ++matricesQ.(indiceSujeto(i,:))(3,3);
%            ++matricesQaux.(indiceSujeto(i,:))(3,3);            
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%            ++matricesQ.(indiceSujeto(i,:))(4,3);
%            ++matricesQaux.(indiceSujeto(i,:))(4,3);             
%          endif
%        endif
%        auxFallas=1;
%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==1)
%        S(i,j-inicio+1)++; % ESTAFAR DADO :
%        if (k>1) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
%            ++matricesQ.(indiceSujeto(i,:))(1,4);
%            ++matricesQaux.(indiceSujeto(i,:))(1,4);             
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%Cooperacion mutua%
%            ++matricesQ.(indiceSujeto(i,:))(2,4);
%            ++matricesQaux.(indiceSujeto(i,:))(2,4);             
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
%            ++matricesQ.(indiceSujeto(i,:))(3,4);
%            ++matricesQaux.(indiceSujeto(i,:))(3,4);            
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%            ++matricesQ.(indiceSujeto(i,:))(4,4);
%            ++matricesQaux.(indiceSujeto(i,:))(4,4);             
%          endif
%        endif
%        auxFallas=1;
%      endif
%    endfor
%    auxFallas=1;
%    matricesQxExp.(indiceSujeto(i,:)).(indice(j+1,:))=matricesQaux.(indiceSujeto(i,:));
%  endfor
%  for i=1:_nSujetos
%    matricesQaux.(indiceSujeto(i,:)) = zeros(4,4);
%  endfor
%endfor
%
%%                    uno menos por en elprimer trial no cuenta
%_vSujetos=_vSujetos3;
%for i=_vSujetos
%  Q(:,:,i)=matricesQ.(indiceSujeto(i,:))./(29*(fin-inicio+1)-controlFallas(i));
%endfor
%%Q(:,:,1)=matricesQ.(indiceSujeto(1,:))./(29*(fin-inicio+1)-controlFallas(1));
%%Q(:,:,2)=matricesQ.(indiceSujeto(2,:))./(29*(fin-inicio+1)-controlFallas(2));
%%Q(:,:,3)=matricesQ.(indiceSujeto(3,:))./(29*(fin-inicio+1)-controlFallas(3));
%%Q(:,:,4)=matricesQ.(indiceSujeto(4,:))./(29*(fin-inicio+1)-controlFallas(4));
%%Q(:,:,5)=matricesQ.(indiceSujeto(5,:))./(29*(fin-inicio+1)-controlFallas(5));
%%Q(:,:,6)=matricesQ.(indiceSujeto(6,:))./(29*(fin-inicio+1)-controlFallas(6));
%%Q(:,:,7)=matricesQ.(indiceSujeto(7,:))./(29*(fin-inicio+1)-controlFallas(7));
%%Q(:,:,8)=matricesQ.(indiceSujeto(8,:))./(29*(fin-inicio+1)-controlFallas(8));
%%Q(:,:,9)=matricesQ.(indiceSujeto(9,:))./(29*(fin-inicio+1)-controlFallas(9));
%%Q(:,:,10)=matricesQ.(indiceSujeto(10,:))./(29*(fin-inicio+1)-controlFallas(10));
%%Q(:,:,11)=matricesQ.(indiceSujeto(11,:))./(29*(fin-inicio+1)-controlFallas(11));
%%Q(:,:,12)=matricesQ.(indiceSujeto(12,:))./(29*(fin-inicio+1)-controlFallas(12));
%
%Qmean=mean(Q,3);
%Qmedian=median(Q,3);
%Qvar=var(Q,0,3);
%%Falta la median y variancia de Q
%
%% VER COMO OBTENER LA MATRIZ DE ESTADO DE MARKOV
%
%T(:,:)=T(:,:)/length(_trialIni:_trialFin);C(:,:)=C(:,:)/length(_trialIni:_trialFin);
%P(:,:)=P(:,:)/length(_trialIni:_trialFin);S(:,:)=S(:,:)/length(_trialIni:_trialFin);
%% una por una
%for i=_vSujetos
%  figure();
%  plot([inicio:fin],T(i,:),'--ob',[inicio:fin],C(i,:),'--or',[inicio:fin],P(i,:),'--oc',[inicio:fin],S(i,:),'--om');
%  xlabel("n de sesiones");
%  ylabel("% Tasa de comportamientos");
%  title(strcat("Estrategias probabilistica en iPD: ",_txtSujetos(i,:)));
%  legend("T=D-C","C=C-C","P=D-D","S=C-D");
%  grid on;
%  %name=strcat(_txtSujetos(i,:),".pdf");
%  %name=strcat("temp_figs/tasa_TRPS_",name);
%  %print -deps name;
%  % VER saveas() SAVEAS
%endfor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TT=T;CC=C;
%PP=P;SS=S;
%% Analizando las ultimas X sesiones
%_ultimosX=10;
%%   Normalizacion para todos los sujetos en todos los experimentos
%Q_antes=matricesQ;
%for i=1:_nSujetos % Ceros para todos
%  matricesQ.(indiceSujeto(i,:)) = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
%endfor
%%   Promedio total --------------------------------------
%for i=_vSujetos
%  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
%  primero=ultimo-_ultimosX+1;
%  for v=primero:ultimo % matricesQ borrada arriba
%        matricesQ.(indiceSujeto(i,:))=matricesQ.(indiceSujeto(i,:))+matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:));
%  endfor
%endfor 
%%     Normalizacion
%for i=_vSujetos
%  for j=1:4
%    if sum(matricesQ.(indiceSujeto(i,:))(j,:))!=0
%      Q(j,:,i)=matricesQ.(indiceSujeto(i,:))(j,:)/sum(matricesQ.(indiceSujeto(i,:))(j,:));
%      %Q(j,:,i)=matricesQ.(indiceSujeto(i,:))(j,:);%/sum(matricesQ.(indiceSujeto(i,:))(j,:));
%    endif
%  endfor
%endfor
%% matriz para inkscape
%QQTotmarkovInk=zeros(4,4,_nSujetos);
%for i=_vSujetos
%  QQTotmarkovInk(:,:,i)=30*Q(:,:,i);
%%   QQTotmarkovInk(1,1,i)=30*Q(1,1,i)+0;
%%   QQTotmarkovInk(1,2,i)=30*Q(1,2,i)+0;
%%   QQTotmarkovInk(2,1,i)=30*Q(2,1,i)+0;
%%   QQTotmarkovInk(2,2,i)=30*Q(2,2,i)+0;
%endfor
%
%% ESTADOS ESTACIONARIOS
%%_estadoEstacionario4=zeros(4,_nSujetos);
%%
%%for i=1:_nSujetos
%%  _estadoEstacionario4(:,i) = dtmc(Q(:,:,i));
%%endfor
%
%
%%-------------------------------------------------------
%%   Normalización Individual --------------------------
%QxExp_ante=matricesQxExp;
%indQ=[];
%for i=_vSujetos
%  for v=_iniSujExp(i):nfields(matricesQxExp.(indiceSujeto(i,:))) % experimentos
%    for j=1:4 %Estados TRPS
%      if sum(matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:))!=0
%         matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:)=matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:)/sum(matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:));
%         %matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:)=matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:);%/sum(matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))(j,:));
%      endif
%    endfor
%  endfor  
%endfor
%Q2=zeros(4,4,_nSujetos);
%for i=_vSujetos
%  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
%  primero=ultimo-_ultimosX+1;
%  for v=primero:ultimo % matricesQ borrada arriba
%        Q2(:,:,i)=Q2(:,:,i)+(matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:))/length(primero:ultimo));
%        %Q2(:,:,i)=Q2(:,:,i)+(matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:)));%/length(primero:ultimo));
%  endfor
%endfor
%%     Normalizacion
%%for i=1:_nSujetos
%%  for j=1:4
%%    if sum(Q(j,:,i))!=0
%%      Q2(j,:,i)=Q2(j,:,i)/sum(Q2(j,:,i));
%%    endif
%%  endfor
%%endfor
%%-------------------------------------------------------
%%--- Desviacion estandar de Q---------------------------
%stdQ=[];
%for i=_vSujetos
%  aux=[];
%  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
%  primero=ultimo-_ultimosX+1;
%  for j=primero:ultimo % experimentos
%    aux=[aux;vec(matricesQxExp.(indiceSujeto(i,:)).(indice(j+1,:))')'];
%  endfor
%  v_std=std(aux,0);%std (x) = sqrt ( 1/(N-1) SUM_i (x(i) - mean(x))^2 )
%  stdQ.(indiceSujeto(i,:))=reshape(v_std,4,4)';
%  %plot(median(aux(:,6)))
%  %hist (aux(:,6), 15, "facecolor", "r", "edgecolor", "b");
%endfor
%
%
%
%
%%T2(:,:)=T(:,:)/length(_trialIni:_trialFin);R2(:,:)=C(:,:)/length(_trialIni:_trialFin);P2(:,:)=P(:,:)/length(_trialIni:_trialFin);S2(:,:)=S(:,:)/length(_trialIni:_trialFin);
%T2(:,:)=T(:,:);R2(:,:)=C(:,:);P2(:,:)=P(:,:);S2(:,:)=S(:,:);
%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% Frecuencia de ESTADOS ULTIMOS 10 SESIONES - POR SUJETOS
%%for i=1:_nSujetos
%%  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
%%  primero=ultimo-_ultimosX+1;
%%  figure()
%%  plot([primero:ultimo],T2(i,primero:ultimo),'--ob',[primero:ultimo],R2(i,primero:ultimo),'--or',[primero:ultimo],P2(i,primero:ultimo),'-->k',[primero:ultimo],S2(i,primero:ultimo),'--.m');
%%  xlabel(strcat("n de sesiones - Ultimas ",_ultimosX));
%%  ylabel("% Proporcion entre estados");
%%  title(strcat("Estrategias probabilistica en iPD: ",_txtSujetos(i,:)));
%%  legend("T=D-C","R=C-C","P=D-D","S=C-D");
%%  grid on;
%%endfor
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Frecuencia de estados - PROMEDIOS DE LAS ULTIMAS 10 SESIONES
%T_mean=zeros(1,_nSujetos);R_mean=zeros(1,_nSujetos);P_mean=zeros(1,_nSujetos);S_mean=zeros(1,_nSujetos);
%T_median=zeros(1,_nSujetos);R_median=zeros(1,_nSujetos);P_median=zeros(1,_nSujetos);S_median=zeros(1,_nSujetos);
%T_std=zeros(1,_nSujetos);R_std=zeros(1,_nSujetos);P_std=zeros(1,_nSujetos);S_std=zeros(1,_nSujetos);
%for i=_vSujetos
%  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
%  primero=ultimo-_ultimosX+1;
%  T_mean(i)=mean(T2(i,primero:ultimo));R_mean(i)=mean(R2(i,primero:ultimo),2);P_mean(i)=mean(P2(i,primero:ultimo));S_mean(i)=mean(S2(i,primero:ultimo));
%  T_median(i)=median(T2(i,primero:ultimo));R_median(i)=median(R2(i,primero:ultimo));P_median(i)=median(P2(i,primero:ultimo));S_median(i)=median(S2(i,primero:ultimo));
%  T_std(i)=std(T2(i,primero:ultimo));R_std(i)=std(R2(i,primero:ultimo));P_std(i)=std(P2(i,primero:ultimo));S_std(i)=std(S2(i,primero:ultimo));
%%  figure;
%%  %plot(1,T_mean(i), 2,R_mean(i) ,3, P_mean(i),4,S_mean(i));
%%  h=errorbar(1,T_mean(i), T_std(i),'*r', 2,R_mean(i),R_std(i),'*b', 3,P_mean(i), P_std(i),'*m', 4,S_mean(i), S_std(i),'*c');
%%  set (h, "linewidth", 3);
%%  xlabel("Estados");
%%  ylabel("% de ocurrencia");
%%  title(strcat("Tasa de ocurrencia de cada estado en iPD: ",_txtSujetos(i,:)));
%%  legend("T=D-C","R=C-C","P=D-D","S=C-D");
%%  hold on
%%  bar(1:4,[T_mean(i),R_mean(i),P_mean(i),S_mean(i)])
%%  hold off
%endfor
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%_criterio=.5;
%graficos_iPD_1_2_9s_13s_12Ratas_reversion_medias_y_medianas % se obtienen los sujetos que superan el .75 porciento de cooperación
%%_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
%_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
%_sujetosNocooperadores=complemento(_sujetosCooperadores,[_vSujetos]);
%QmediaC=zeros(4,4);
%QmediaD=zeros(4,4);
%for i=_sujetosCooperadores
%  QmediaC=QmediaC+Q(:,:,i);
%endfor
%QmediaC=QmediaC./sum(QmediaC,2);
%
%for i=_sujetosNocooperadores
%  QmediaD=QmediaD+Q(:,:,i);
%endfor
%QmediaD=QmediaD./sum(QmediaD,2);
%
% Test Friedman's Anova (Ho: todas los estados son igualmente probables)
% asignar rangos a los promedios de cada estado - ranks 
%vals=[(T_mean(_sujetosCooperadores));
%      (R_mean(_sujetosCooperadores));
%      (P_mean(_sujetosCooperadores));
%      (S_mean(_sujetosCooperadores))];
%           
%vals_std=[(T_std(_sujetosCooperadores));
%          (R_std(_sujetosCooperadores));
%          (P_std(_sujetosCooperadores));
%          (S_std(_sujetosCooperadores))];
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%for i=_vSujetos
%  figure();
%  plot([inicio:fin],T(i,:),'--ob',[inicio:fin],C(i,:),'--or',[inicio:fin],P(i,:),'--oc',[inicio:fin],S(i,:),'--om');
%  xlabel("n de sesiones");
%  ylabel("% Tasa de comportamientos");
%  title(strcat("Estrategias probabilistica en iPD: ",_txtSujetos(i,:)));
%  legend("T=D-C","C=C-C","P=D-D","S=C-D");
%  grid on;
%  %name=strcat(_txtSujetos(i,:),".pdf");
%  %name=strcat("temp_figs/tasa_TRPS_",name);
%  %print -deps name;
%  % VER saveas() SAVEAS
%endfor



%T=zeros(_nSujetos,length(inicio:fin));C=zeros(_nSujetos,length(inicio:fin));
%P=zeros(_nSujetos,length(inicio:fin));S=zeros(_nSujetos,length(inicio:fin));
%
%probxExp=[];
%probAux=[];
%fallasxExp=[];
%for i=1:_nSujetos
%  probTotal.(indiceSujeto(i,:)) = zeros(4,2); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
%  probAux = zeros(4,2);
%endfor
%
%controlFallas=zeros(1,_nSujetos);
%auxFallas=1;
%%_ultimosX=10;
%for i=_vSujetos
%  ultimo=_iniSujExp(i)-1+nfields(matricesQxExp.(indiceSujeto(i,:)));
%  primero=ultimo-_ultimosX+1;
%  for j=primero:ultimo
%    for k=_trialIni:_trialFin  % nºtrials x Exp. 
%      if ((todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)||(todo.(indice(j+1,:))(i)._respuestasOPO(k)==0))
%        if (k==1)
%          ++controlFallas(i);%%%
%        elseif (k==2) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)% k=1 y K=2 son ceros no se cuenta una falla auxiluar
%            auxFallas+=1;  
%          endif
%          ++controlFallas(i);%%%
%        elseif (k==3)
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-2)==0)&&(todo.(indice(j+1,:))(i)._respuestasEXP(k-1)==0)
%            % nada
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)
%            auxFallas+=1;
%          else
%            a="MIERDA!!!"
%          endif
%          ++controlFallas(i);%%%
%        else
%          auxFallas+=1;
%          ++controlFallas(i);
%        endif
%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2) %COOPERAR DADO:
%        if (k>1) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
%            ++probTotal.(indiceSujeto(i,:))(1,1);
%            ++probAux(1,1); 
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
%            ++probTotal.(indiceSujeto(i,:))(2,1);
%            ++probAux(2,1); 
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
%            ++probTotal.(indiceSujeto(i,:))(3,1);
%            ++probAux(3,1);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%            ++probTotal.(indiceSujeto(i,:))(4,1);
%            ++probAux(4,1);
%          else
%            a="COOP ????" 
%            i
%            j
%            k
%          endif  
%        endif
%        auxFallas=1;
%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)% NO COOPERAR DADO:
%        if (k>1) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
%            ++probTotal.(indiceSujeto(i,:))(1,2); 
%            ++probAux(1,2);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
%            ++probTotal.(indiceSujeto(i,:))(2,2);
%            ++probAux(2,2);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
%            ++probTotal.(indiceSujeto(i,:))(3,2);
%            ++probAux(3,2);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%            ++probTotal.(indiceSujeto(i,:))(4,2);
%            ++probAux(4,2); 
%          else
%            a="NO coop ????"
%            i
%            j
%            k
%          endif
%        endif
%        auxFallas=1;
%      endif
%    endfor
%    auxFallas=1;
%    probxExp.(indiceSujeto(i,:)).(indice(j+1,:))=probAux;
%    probAux =zeros(4,2);
%    fallasxExp.(indiceSujeto(i,:)).(indice(j+1,:))=controlFallas(i);
%  endfor
%  
%endfor
%
%% Transformando probabilidades de eleccion al intervalo [0,1] 
%% promediando las ultimas 10 sesiones por sujetos
%probxExpTotalN=zeros(4,2,_nSujetos);
%probxExpTotal=zeros(4,2,_nSujetos);
%probxExpN=[];
%for i=_vSujetos
%  ultimo=_iniSujExp(i)-1+nfields(matricesQxExp.(indiceSujeto(i,:)))
%  primero=ultimo-_ultimosX+1;
%  for j=primero:ultimo
%    for l=1:4
%      if sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)),2)(l)!=0
%           %sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)),2)(l)
%        probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))(l,:)=probxExp.(indiceSujeto(i,:)).(indice(j+1,:))(l,:)./sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)),2)(l);
%      else
%        probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))(l,:)=[0 0];
%      endif
%    endfor
%    %probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))=probxExp.(indiceSujeto(i,:)).(indice(j+1,:))./sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)),2);
%    probxExpTotalN(:,:,i)=probxExpTotalN(:,:,i)+probxExpN.(indiceSujeto(i,:)).(indice(j+1,:));
%    probxExpTotal(:,:,i)=probxExpTotal(:,:,i)+probxExp.(indiceSujeto(i,:)).(indice(j+1,:));
%  endfor
%endfor
%
%for i=1:_nSujetos
%  probxExpTotalN(:,:,i)=probxExpTotalN(:,:,i)./length(primero:ultimo);
%endfor
%
%% transformar frecuencias de elecion total del exp 
%probTotalN=zeros(4,2,_nSujetos);
%for i=1:_nSujetos
%  if (sum(sum(probTotal.(indiceSujeto(i,:)))))>0
%    probTotalN(:,:,i)=probTotal.(indiceSujeto(i,:))/sum(sum(probTotal.(indiceSujeto(i,:))));
%  endif
%endfor
%
%% Prob de ellcion dado un determinado estado. P(c|T) P(c|R) P(c|S) P(c|P)
%probEleccion=zeros(size(probxExpTotal));
%for i=1:_nSujetos
%  for j=1:4
%    if sum(probxExpTotal(j,:,i),2)!=0
%      probEleccion(j,:,i)=probxExpTotal(j,:,i)./sum(probxExpTotal(j,:,i),2);
%    endif
%  endfor
%endfor
%
%probEleccionSem=zeros(size(probxExpTotal));
%for i=_vSujetos
%  ultimo=_iniSujExp(i)-1+nfields(matricesQxExp.(indiceSujeto(i,:)));
%  primero=ultimo-_ultimosX+1;
%  aux1=[];
%  aux2=[];
%  for j=primero:ultimo
%    aux1=[aux1 probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))(:,1)];
%    aux2=[aux2 probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))(:,2)];
%  endfor
%  probEleccionSem(:,1,i)=sem(aux1,2);
%  probEleccionSem(:,2,i)=sem(aux2,2);
%endfor
%
%
%for i=_vSujetos
%  hhh=figure;
%  h=errorbar([1:4],probEleccion(:,1,i),probEleccionSem(:,1,i),'*k');
%  hold on;%set(h, "linewidth", 2);     
%  h=bar([1:4],probEleccion(:,1,i),'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
%  h=plot([0:5],[.5 .5 .5 .5 .5 .5],"--r");
%  axis ("tic[yz]", "labely[xyz]");
%  set(h, "linewidth", 2);  
%  legend("SEM","MEAN","Half prob");
%  %hh=xlabel("T=1 --- R=2 --- P=3 --- S=4");set(hh, "fontsize", 14);
%  hh=ylabel("P(C|X)");set(hh, "fontsize", 14);
%  hh=title(strcat("Probability of Cooperation given outcome: ",_txtSujetos(i,:)));
%  set(hh, "fontsize", 14);
%  axis ("tic[yz]", "labely[xyz]");
%  t=text([1:4], -.04*ones(1,4), {"P(c|T)"; "P(c|R)";"P(c|P)";"P(c|S)"},"fontsize",14);
%  axis([0 5 0 1]);
%  hold off;grid on;  
%  name=strcat("figura_iPD_1_2_9s_13s/fig_finales/prob_C_giveno_Outcome/",strcat(_txtSujetos(i,:),"_reversion"));
%  name=strcat(name,".png");
%  print(hhh, name);
%endfor

%food=[];
%for i=1:_nSujetos
%  food(:,i)=[TT(i,:).*_vRefuerzos(2) + CC(i,:).*_vRefuerzos(1) + PP(i,:).*_vRefuerzos(4) + SS(i,:).*_vRefuerzos(3)];
%endfor
%
%foodMedia=zeros(1,_nSujetos);
%
%for i=_vSujetos
%  inicioAux=(_iniSujExp(i)-1) + expXsuj(i)-(_ultimosX-1);
%  finAux=_iniSujExp(i)-1 + expXsuj(i);
%  foodMedia(i) = mean(food(inicioAux:finAux,i));
%endfor


 %                      
%for i=_vSujetos   % vec [a b;c d] -> [a c b d] = [c|c d|c c|d d|d]
%  N*_vRefuerzos*(vec(QQTotmarkov(:,:,i)).*[probC(i);probC(i);probD(i);probD(i)])
%endfor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5


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
%_vSujetos=_vSujetos3;
%
%figure();
%plot([inicio:fin],_promediosC(3,:),'--ok',[inicio:fin],_promediosC(7,:),'--ob',[7:24],_promediosC(10,[7:24]),'--oc',[9:fin], _promediosC(9,[9:fin]),'--om');
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(3,:),_txtSujetos(7,:),_txtSujetos(10,:),_txtSujetos(9,:));
%
%
%figure;
%plot([inicio:fin],_promediosC(3,:),'--ok');
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(3,:));
%figure;
%plot([inicio:fin],_promediosC(7,:),"--ob");
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(7,:));
%figure;
%plot([inicio:42],_promediosC(12,inicio:42),'--or');
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(12,:));
%figure;
%plot([7:24],_promediosC(10,[7:24]),'--oc');
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(10,:));
%figure;
%plot([9:fin],_promediosC(9,[9:fin]),'--om');
%xlabel("n de sesiones");ylabel("% de cooperacion");title("Cooperacion en iPD");
%legend(_txtSujetos(9,:));
%
%
%
%% Promedio de cooperacion sin outlayers
%
%
%%indiceSujeto=[];
%%for i=1:_nSujetos
%%  indiceSujeto=[indiceSujeto(i,:);strcat("Q",mat2str(i))];
%%endfor
%indiceSujeto=["Q01";"Q02";"Q03";"Q04";"Q05";"Q06";"Q07";"Q08";"Q09";"Q10";"Q11";"Q12"];
%
%% Probabilidades de transicion de estados
%matricesQxExp=[];
%matricesQaux=[];
%matricesQ=[];
%Q = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
%for i=1:_nSujetos
%  matricesQ.(indiceSujeto(i,:)) = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
%  matricesQaux.(indiceSujeto(i,:)) = zeros(4,4);
%endfor
%% 
%% Brief: Carga las matrices de transicion de estado de cada sujeto. 
%%        Acumula las veces que aparece la transicion durante los 29 trials a lo
%%        largo los inicio:fin de experimentos.
%T=zeros(_nSujetos,length(inicio:fin));C=zeros(_nSujetos,length(inicio:fin));
%P=zeros(_nSujetos,length(inicio:fin));S=zeros(_nSujetos,length(inicio:fin));
%controlFallas=zeros(1,_nSujetos);
%controlFallasXexp=zeros(_nSujetos,length(inicio:fin));
%auxFallas=1;
%for j=inicio:fin
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
%    for k=_trialIni:_trialFin  % nºtrials x Exp.  TRAICIONAR DADO QUE
%      if ((todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)||(todo.(indice(j+1,:))(i)._respuestasOPO(k)==0))
%        if (k==1)
%          ++controlFallas(i);%%%
%          %++controlFallasXexp(i,j);
%        elseif (k==2) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)% k=1 y K=2 son ceros no se cuenta una falla auxiluar
%            auxFallas+=1;
%          endif
%          ++controlFallas(i);%%%
%          ++controlFallasXexp(i,j);
%        elseif (k==3)
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-2)==0)&&(todo.(indice(j+1,:))(i)._respuestasEXP(k-1)==0)
%            % nada
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)
%            auxFallas+=1;
%          else
%            a="MIERDA!!!"
%          endif
%          ++controlFallas(i);%%%
%          ++controlFallasXexp(i,j);
%        else
%          auxFallas+=1;
%          ++controlFallas(i);
%          ++controlFallasXexp(i,j);
%        endif
%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==2)
%        T(i,j-inicio+1)++; %TRAICIONAR DADO :
%        if (k>1) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
%            ++matricesQ.(indiceSujeto(i,:))(1,1);
%            ++matricesQaux.(indiceSujeto(i,:))(1,1); 
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
%            ++matricesQ.(indiceSujeto(i,:))(2,1);
%            ++matricesQaux.(indiceSujeto(i,:))(2,1); 
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
%            ++matricesQ.(indiceSujeto(i,:))(3,1);
%            ++matricesQaux.(indiceSujeto(i,:))(3,1);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%            ++matricesQ.(indiceSujeto(i,:))(4,1);
%            ++matricesQaux.(indiceSujeto(i,:))(4,1); 
%          endif  
%        endif
%        auxFallas=1;
%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==2)
%        C(i,j-inicio+1)++; % COOPERACION MUTUA DADO :
%        if (k>1) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
%            ++matricesQ.(indiceSujeto(i,:))(1,2); 
%            ++matricesQaux.(indiceSujeto(i,:))(1,2);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
%            ++matricesQ.(indiceSujeto(i,:))(2,2);
%            ++matricesQaux.(indiceSujeto(i,:))(2,2);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
%            ++matricesQ.(indiceSujeto(i,:))(3,2);
%            ++matricesQaux.(indiceSujeto(i,:))(3,2);
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%            ++matricesQ.(indiceSujeto(i,:))(4,2);
%            ++matricesQaux.(indiceSujeto(i,:))(4,2); 
%          endif
%        endif
%        auxFallas=1;
%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)=1)
%        P(i,j-inicio+1)++; % NO COOPERACION MUTUA DADO :
%        if (k>1) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %que Traiciono (imposible x TFT)%
%            ++matricesQ.(indiceSujeto(i,:))(1,3);
%            ++matricesQaux.(indiceSujeto(i,:))(1,3); 
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%Cooperacion mutua%
%            ++matricesQ.(indiceSujeto(i,:))(2,3);
%            ++matricesQaux.(indiceSujeto(i,:))(2,3); 
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
%            ++matricesQ.(indiceSujeto(i,:))(3,3);
%            ++matricesQaux.(indiceSujeto(i,:))(3,3);            
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%            ++matricesQ.(indiceSujeto(i,:))(4,3);
%            ++matricesQaux.(indiceSujeto(i,:))(4,3);             
%          endif
%        endif
%        auxFallas=1;
%      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==1)
%        S(i,j-inicio+1)++; % ESTAFAR DADO :
%        if (k>1) 
%          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
%            ++matricesQ.(indiceSujeto(i,:))(1,4);
%            ++matricesQaux.(indiceSujeto(i,:))(1,4);             
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%Cooperacion mutua%
%            ++matricesQ.(indiceSujeto(i,:))(2,4);
%            ++matricesQaux.(indiceSujeto(i,:))(2,4);             
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
%            ++matricesQ.(indiceSujeto(i,:))(3,4);
%            ++matricesQaux.(indiceSujeto(i,:))(3,4);            
%          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
%            ++matricesQ.(indiceSujeto(i,:))(4,4);
%            ++matricesQaux.(indiceSujeto(i,:))(4,4);             
%          endif
%        endif
%        auxFallas=1;
%      endif
%    endfor
%    auxFallas=1;
%    matricesQxExp.(indiceSujeto(i,:)).(indice(j+1,:))=matricesQaux.(indiceSujeto(i,:));
%  endfor
%  for i=1:_nSujetos
%    matricesQaux.(indiceSujeto(i,:)) = zeros(4,4);
%  endfor
%endfor
%_vSujetos=_vSujetos3;
%T=T./(30-controlFallasXexp);
%C=C./(30-controlFallasXexp);
%P=P./(30-controlFallasXexp);
%S=S./(30-controlFallasXexp);
%
%T2(:,:)=T(:,:);R2(:,:)=C(:,:);P2(:,:)=P(:,:);S2(:,:)=S(:,:);
%
%_ultimosX=9;
%T_mean=zeros(1,_nSujetos);R_mean=zeros(1,_nSujetos);P_mean=zeros(1,_nSujetos);S_mean=zeros(1,_nSujetos);
%T_median=zeros(1,_nSujetos);R_median=zeros(1,_nSujetos);P_median=zeros(1,_nSujetos);S_median=zeros(1,_nSujetos);
%T_sem=zeros(1,_nSujetos);R_sem=zeros(1,_nSujetos);P_sem=zeros(1,_nSujetos);S_sem=zeros(1,_nSujetos);
%for i=_vSujetos
%  ultimo=_iniSujExp(i)-1+numfields(matricesQxExp.(indiceSujeto(i,:)))
%  primero=ultimo-_ultimosX+1
%  T_mean(i)=mean(T2(i,primero:ultimo),2);
%  R_mean(i)=mean(R2(i,primero:ultimo),2);
%  P_mean(i)=mean(P2(i,primero:ultimo),2);
%  S_mean(i)=mean(S2(i,primero:ultimo),2);
%  
%  T_median(i)=median(T2(i,primero:ultimo),2);
%  R_median(i)=median(R2(i,primero:ultimo),2);
%  P_median(i)=median(P2(i,primero:ultimo),2);
%  S_median(i)=median(S2(i,primero:ultimo),2);
%  
%  T_sem(i)=sem(T2(i,primero:ultimo),2);
%  R_sem(i)=sem(R2(i,primero:ultimo),2);
%  P_sem(i)=sem(P2(i,primero:ultimo),2);
%  S_sem(i)=sem(S2(i,primero:ultimo),2);
%endfor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

%for j=1:4
%    if sum(matricesQ.(indiceSujeto(i,:))(j,:))!=0
%      Q(j,:,i)=matricesQ.(indiceSujeto(i,:))(j,:)/sum(matricesQ.(indiceSujeto(i,:))(j,:))
%      %Q(j,:,i)=matricesQ.(indiceSujeto(i,:))(j,:);%/sum(matricesQ.(indiceSujeto(i,:))(j,:));
%    endif
%  endfor
%  
%  
  % Probabilidades de transicion de estados
matricesQxExp=[];
matricesQaux=[];
matricesQ=[];
Q = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
for i=1:_nSujetos
  matricesQ.(indiceSujeto(i,:)) = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
  matricesQaux.(indiceSujeto(i,:)) = zeros(4,4);
endfor
% 
% Brief: Carga las matrices de transicion de estado de cada sujeto. 
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
_vSujetos=_vSujetos3;
T=T./(30-controlFallasXexp);
C=C./(30-controlFallasXexp);
P=P./(30-controlFallasXexp);
S=S./(30-controlFallasXexp);


%                    uno menos por en elprimer trial no cuenta
_vSujetos=_vSujetos3;
for i=_vSujetos
  Q(:,:,i)=matricesQ.(indiceSujeto(i,:))./(29*(fin-inicio+1)-controlFallas(i));
endfor


Qmean=mean(Q,3);
Qmedian=median(Q,3);
Qvar=var(Q,0,3);
%Falta la median y variancia de Q

%for i=_vSujetos
%  figure;
%  plot([inicio:fin],T(i,:),'--ob',[inicio:fin],C(i,:),'--or',
%       [inicio:fin],P(i,:),'--oc',[inicio:fin],S(i,:),'--om');
%  xlabel("n de sesiones");
%  ylabel("% Tasa de comportamientos");
%  title(strcat("Estrategias probabilistica en iPD: ",_txtSujetos(i,:)));
%  legend("T=D-C","C=C-C","P=D-D","S=C-D");
%  %grid on;
%  %name=strcat(_txtSujetos(i,:),".pdf");
%  %name=strcat("temp_figs/tasa_TRPS_",name);
%  %print -deps name;
%  % VER saveas() SAVEAS
%endfor

%%%%%%%%%%%%%%%%%%%%%%%% Copy MArkov %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TT=T;CC=C;
PP=P;SS=S;

% Analizando las ultimas X sesiones
_ultimosX=9;

%   Normalizacion para todos los sujetos en todos los experimentos
Q_antes=matricesQ;
clear matricesQ;
for i=1:_nSujetos % Ceros para todos
  matricesQ.(indiceSujeto(i,:)) = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
  Q(:,:,i)=zeros(4,4);
endfor
%   Promedio total --------------------------------------
for i=_vSujetos
  ultimo=_iniSujExp(i)-1+numfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  for v=primero:ultimo % matricesQ borrada arriba
        matricesQ.(indiceSujeto(i,:))=matricesQ.(indiceSujeto(i,:))+matricesQxExp.(indiceSujeto(i,:)).(indice(v+1,:));
  endfor
endfor 
%     Normalizacion

for i=_vSujetos
  for j=1:4
    if sum(matricesQ.(indiceSujeto(i,:))(j,:))!=0
      Q(j,:,i)=matricesQ.(indiceSujeto(i,:))(j,:)./sum(matricesQ.(indiceSujeto(i,:))(j,:));
      %Q(j,:,i)=matricesQ.(indiceSujeto(i,:))(j,:);%/sum(matricesQ.(indiceSujeto(i,:))(j,:));
    endif
  endfor
endfor
