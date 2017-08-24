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
%todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;todo.exp19=exp19;todo.exp20=exp20;
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
%% Experimentos por sujetos
%expXsuj=zeros(1,_nSujetos);
%for j=inicio:(numfields(todo))
%  for i=1:length(todo.(indice(j+1,:)))
%    if length(todo.(indice(j+1,:))(i)._groupStr)!=0
%      expXsuj(i)++;
%    endif
%  endfor
%endfor
%%%%%%%% ACA 
%[r c]=size(_promediosC);
%if(r!=12)
%  _promediosC=_promediosC'
%endif
%_vSujetos=_vSujetos3;
%
%%%%%%%%%    TODOS JUNTOS DESDE EL FINAL hasta -17 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%_promediosC_EndAttached=zeros(_nSujetos,18);
%
%for i=[3 7 9 10]
%  _promediosC_EndAttached(i,:)=...
%            _promediosC(i,[(expXsuj(i)-17)+_iniSujExp(i)-1:(expXsuj(i)+_iniSujExp(i)-1)]);
%endfor
%_media_EndAtached=mean(_promediosC_EndAttached([3 7 9 10],:))
%_semTodos_EndAttached=sem(_promediosC_EndAttached([3 7 9 10],:),1)
%
%
%figure();
%h=plot([1:18],_promediosC(3,(fin-17):fin),'--ok',[1:18],_promediosC(7,fin-17:fin),'--ok',[1:18],_promediosC(10,[7:24]),'--ok',[1:18], _promediosC(9,[fin-17:fin]),'--ok');
%set(h,"linewidth",2);
%hold on;
%hh=plot(_media_EndAtached);set(hh, "linewidth", 3);
%hh=plot(_media_EndAtached+_semTodos_EndAttached,'--r');set(hh, "linewidth", 3);
%hh=plot(_media_EndAtached-_semTodos_EndAttached,'--r');set(hh, "linewidth", 3);
%hold off;
%hh=xlabel("n of sesiones");set(hh,"fontsize",20);
%hh=ylabel("% Cooperation");set(hh,"fontsize",20);
%hh=title("Evolution of Cooperation en iPD");set(hh,"fontsize",20)
%legend(_txtSujetos(3,:),_txtSujetos(7,:),_txtSujetos(10,:),_txtSujetos(9,:),4);
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%for i=_vSujetos
%  hhh=figure;
%  h=errorbar([1 2 3 4],vec(QQTotmarkov(:,:,i))',vec(QQTotmarkovSem(:,:,i))','*k');
%  hold on;set(h, "linewidth", 2);     
%  h=bar([1:4],vec(QQTotmarkov(:,:,i)),'facecolor', 'g', 'edgecolor','b', "linewidth",2);
%  h=plot([0:5],[.5 .5 .5 .5 .5 .5],"--r");
%  axis ("tic[yz]", "labely[xyz]");
%  set(h, "linewidth", 2);  
%  legend("SEM","MEAN");
%  %hh=xlabel("T=1 --- R=2 --- P=3 --- S=4");set(hh, "fontsize", 14);
%  hh=ylabel("P(C|X)");set(hh, "fontsize", 14);
%  hh=title(strcat("Probability of Cooperation given last choose: ",_txtSujetos(i,:)));
%  set(hh, "fontsize", 14);
%  axis ("tic[yz]", "labely[xyz]");
%  t=text([1:4], -.04*ones(1,4), {"P(c|c)"; "P(c|d)";"P(d|c)";"P(d|d)"},"fontsize",14);
%  axis([0 5 0 1]);
%  hold off;grid on;
%  name=strcat("figura_iPD_1_2_9s_13s/fig_finales/prob_C_dado_X/",_txtSujetos(i,:));
%  name=strcat(name,"_reversion");
%  name=strcat(name,".png");
%  print(hhh, name);
%endfor





%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% grafico Alimentos versus Cooperacion
%%% ACA para abajo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[Ss I]=sort(_mediaXsujeto);
%figure;
%aux=I(find(sort(_mediaXsujeto)>0.5))
%%h=plot(_mediaXsujeto(I),foodMedia(I),'ko', "markersize",12,"markerfacecolor",'c', "linewidth", 2);
%h=scatter(_mediaXsujeto(aux),foodMedia(aux),20,(_timeOutMedia(aux)-_timeoutITI)./_timeoutLimit,"filled");
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
%t=text(-0.01*[1 1 1 1]+_mediaXsujeto(aux), 
%         -.08*[1 1 1 1]+foodMedia(aux) ,
%         _txtSujetos(aux,:));
%%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .03*[1 1 1 1 1 1 1 1 1 1 1 -1]+foodMedia(I) ,_txtSujetos(I,:));
%%axis('auto');
%axis([.49 1.02 0 1.15]);
%hold on;
%%h=plot(_mediaXsujeto(I(length(I))),foodMedia(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%h=scatter(probC2([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(probC2([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),_idealSujeto(2,[1 3 4 5 6 7]),15,probC([1 3 4 5 6 7])','s',"filled");
%%h=plot(probC([1 3 4 5]),_idealSujeto(1,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC2([1 3 4 5 6 7])', 0.04*[.5 .5 .5 .5 2.9 2.9]+_idealSujeto(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC2([1 3 4 5 6 7])', 
%       -0.025*[1.2 1 1 1 -3.2 -3.2]+_idealSujeto(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;


%% grafico Cooperacion Versus R
%[Ss I]=sort(_mediaXsujeto);
%figure;
%aux=I(find(sort(_mediaXsujeto)>0.5));
%h=scatter(_mediaXsujeto(aux),R_mean(aux),20,((_timeOutMedia(aux)-_timeoutITI)./_timeoutLimit),"filled");
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
%t=text(-0.01*[1 1 1 1]+_mediaXsujeto(aux),.08*[1 1 1 -1]+R_mean(aux),_txtSujetos(aux,:));
%%axis('auto');
%axis([.49 1.02 0 1.15]);
%%axis([0 1.05 -.04 1.05]);
%hold on;
%h=scatter(probC2([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(probC2([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(0.025*[1 1 1 1 1 -1.5]+ probC2([1 3 4 5 6 7])', 
%        0.04*[1.8 .5 .5 .5 .5 2.8]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 1 -1.5]+ probC2([1 3 4 5 6 7])', 
%       -0.025*[-1.5 1 1 1 1 -2.5]+QQideales(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.55,-0.38,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;
%

%% grafico Reward Versus R
%[Ss I]=sort(R_mean);
%figure;
%aux=I(find(sort(R_mean)>0.4));
%h=scatter(foodMedia(aux),R_mean(aux),20,((_timeOutMedia(aux)-_timeoutITI)./_timeoutLimit),"filled");
%ch=colormap(copper);
%colorbar('southoutside');
%set(h, "linewidth", 2);
%hh=xlabel("% of maximal Reward");
%set(hh, "fontsize", 14);
%hh=ylabel("% Mutual Cooperation");
%set(hh, "fontsize", 14);
%hh=title("Reward Versus Mutual Cooperation (Colorbar=Timeout)"); 
%set(hh, "fontsize", 14);
%grid off;%grid minor;
%t=text(-0.01*[1 3 -1 1]' + foodMedia(aux)', .07*[1 1 1 -1]' + R_mean(aux)', _txtSujetos(aux,:))';
%%axis('auto');
%axis([.48 1.1 -.04 1.05]);
%hold on;
%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(0.025*[.51 .51 .51 .51 -.8 -.1]+ _idealSujeto(1,[1 3 4 5 6 7]), 
%        0.04*[.5 .5 .5 .5 1.4 1.4]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[.51 .51 .51 .51 -.8 -.5]+ _idealSujeto(1,[1 3 4 5 6 7]), 
%       -0.025*[1.2 1 1 1  1.9 1.9]+ QQideales(1,[1 3 4 5 6 7]),
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.62,-0.41,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;

%
%% Tasa de alimentacion
%%_foodRate= foodMedia./(_timeOutMedia/_timeoutLimit);%_vDelay4eat(1));
%%_delay2eat=(_timeOutMedia-_timeoutITI)./_timeoutLimit;
%%[Ss I]=sort(foodMedia);%_foodRate);
%%figure;
%%aux=I(find(sort(_mediaXsujeto)>0.7))
%%%h=plot(_mediaXsujeto(aux),_delay2eat(aux),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%h=scatter(_mediaXsujeto(aux),_delay2eat(aux),20,_foodRate(aux),"filled");
%%hold on;
%%ch=colormap(copper);
%%colorbar('southoutside');
%%set(h, "linewidth", 2);
%%hh=xlabel("Among of C choice ");
%%set(hh, "fontsize", 14);
%%hh=ylabel("Delay to eat [seconds]");
%%set(hh, "fontsize", 14);
%%hh=title("Cooperation versus Delay to eat"); 
%%set(hh, "fontsize", 14);
%%%h=plot(_mediaXsujeto(I),_delay2eat(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%grid on;
%%t=text(-0.02*[1 1 1 1]'+_mediaXsujeto(aux)', 0.15*[1 1 1 1]'+_delay2eat(aux)' ,_txtSujetos(aux,:));
%%axis('auto');
%%hold on;
%%h=plot(probC([1 3 4 5]),100/120.*_idealSujeto(2,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
%%t=text(0.025*ones(1,length(probC([1 3 4 5])))+ probC([1 3 4 5]), 
%%        _idealSujeto(2,[1 3 4 5])./_timeoutLimit ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D"});
%%hold off;
%

%% Alimentacion Versus Delay to eat
%_delay2eat=(_timeOutMedia-_timeoutITI)./_timeoutLimit;
%[Ss I]=sort(foodMedia);
%hhh=figure;
%aux=I(find(sort(foodMedia)>0.8));
%h=scatter(_delay2eat(aux),foodMedia(aux),20, _mediaXsujeto(aux),"filled");
%ch=colormap(copper);
%h=colorbar('southoutside');
%hold on;
%%h=errorbar(_delay2eat(I(find(sort(foodMedia)>0.8)))./120,foodMedia(I(find(sort(foodMedia)>0.8))),'*k');
%%set(h, "linewidth", 2);
%hh=ylabel("% of total Reward");
%set(hh, "fontsize", 14);
%hh=xlabel("% total acumulated Timeout per sessions");
%set(hh, "fontsize", 14);
%hh=title("Reward versus Timeout to eat (colorbar=cooperation)"); 
%set(hh, "fontsize", 14);
%grid on;
%t=text(0.02*[1 -1.5 1.5 1]+_delay2eat(aux),-0.04*[1 1 1 1]+foodMedia(aux),_txtSujetos(aux,:));
%%axis('auto');
%axis([-.04, 1.1, .5, 1.1], "square");
%hold on;
%h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,probC2([1 3 4 5 6 7])','s',"filled");
%h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%%h=plot(_idealSujeto(1,[1 3 4 5 6 7]),_idealSujeto(2,[1 3 4 5 6 7]),'ko', "markersize",15,"markerfacecolor",'r', "linewidth", 2);
%t=text(-0.10*[1 1 1 1 3.5 -1]+(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
%       0.05*ones(1,length(probC([1 3 4 5 6 7])))+ _idealSujeto(1,[1 3 4 5 6 7]), 
%       {"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%
%t=text(-0.10*[1 1 1 1 3.5 -1]+ (_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
%       0.03*[1 1 1 1 1 1]+ _idealSujeto(1,[1 3 4 5 6 7]),
%       {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"}); 
%t=text(0.1,0.28,{"Normalized amoung of C choice"},"fontsize",14);       
%hold off;


%
%
%
%%% tiempos promedio por ensayor
%%[S I]=sort(_effectiveness);
%%figure;
%%h=plot(30*_mediaXsujeto(I),_effectiveness(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%set(h, "linewidth", 2);
%%hh=xlabel("Among of C choice ");
%%set(hh, "fontsize", 14);
%%hh=ylabel("Effectiveness [time required/spend]");
%%set(hh, "fontsize", 14);
%%hh=title("Effectiveness versus Cooperation"); 
%%set(hh, "fontsize", 14);
%%grid on;
%%t=text(-0.60*[1 1 1 1 1 1 1 1 1 1 1 -1]+30*_mediaXsujeto(I), 0.02*[1 -1 1 1 1 1 1 1 1 1 1 .5]+_effectiveness(I) ,_txtSujetos(I,:));
%%axis([1 ,30, 0, 1],'auto');
%%hold on;
%%h=plot(30*_mediaXsujeto(I(length(I))),_effectiveness(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%%hold off;
%
%%% Food versus FoodRate
%%[S I]=sort(foodMedia(1:_nSujetos));
%%figure;
%%h=plot(foodMedia(I),_foodRate(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%set(h, "linewidth", 2);
%%hh=xlabel("Food Harvested [Pellet]");
%%set(hh, "fontsize", 14);
%%hh=ylabel("Food rate [Pellets/trial]");
%%set(hh, "fontsize", 14);
%%hh=title("Food Rate versus Food Harvested"); 
%%set(hh, "fontsize", 14);
%%grid on;
%%t=text(-0.60*[1 1 1 1 1 1 1 1 1 1 1 -1]+foodMedia(I), 0.02*[1 -1 1 1 1 1 1 1 1 1 1 .5]+_foodRate(I) ,_txtSujetos(I,:));
%%axis([1 ,30, 0, 1],'auto');
%%hold on;
%%h=plot(foodMedia(I(length(I))),_foodRate(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%%hold off;
%
%%%
%
%%[S I]=sort(foodMedia(1:_nSujetos));
%%[x, y, z] = sphere(50);
%%x=x./50;y=y./50;z=z./50;
%%figure;
%%
%%%for i=I
%%  mesh((_timeOutMedia(i))+x, _mediaXsujeto(i)+y, foodMedia(i)+z);hold on;set(h, "linewidth", 2);hold on;
%%endfor
%%figure;
%%for i=I
%%  contourc((_timeOutMedia(i))+x, _mediaXsujeto(i)+y, foodMedia(i)+z);
%%endfor
%figure;
%contour(_timeOutMedia, _mediaXsujeto, foodMedia);
%%&stem3((_timeOutMedia(i))+x, _mediaXsujeto(i)+y, foodMedia(i)+z,"markersize",20,"markerfacecolor",'none', "linewidth", 3);
%hold off;
%hh=zlabel("FOOD");set(hh, "fontsize", 14);
%hh=ylabel("MEDIA DE COOPERACION");set(hh, "fontsize", 14);
%hh=xlabel("DELAY TO EAT [Seconds]");set(hh, "fontsize", 14);
%hh=title("Delay and Cooperation and Food Harvested"); 
%set(hh, "fontsize", 14);
%
%figure;
%x = randn (100, 1);
%y = randn (100, 1);
%c = x .* y;
%scatter (x, y, 20, c, 'filled');
%
%x = 1:100;
%y = 1:100;
%scatter(foodMedia,_timeOutMedia,20, _mediaXsujeto,"filled");
%
%%_criterio=.5;
%graficos_iPD_1_2_9s_13s_12Ratas_reversion_medias_y_medianas_reversionBETA % se obtienen los sujetos que superan el .75 porciento de cooperación
%_sujetosCooperadores=find(_mediaXsujeto>_criterio); % indice de sujetos que pasaron el criterios 
%
%
%QmarkovmediaC=zeros(2,2);
%QmarkovmediaD=zeros(2,2);
%for i=_sujetosCooperadores
%  QmarkovmediaC=QmarkovmediaC+QQTotmarkov(:,:,i);
%endfor
%QmarkovmediaC=QmarkovmediaC./sum(QmarkovmediaC,2);
%
%for i=_sujetosNocooperadores
%  QmarkovmediaD=QmarkovmediaD+QQTotmarkov(:,:,i);
%endfor
%QmarkovmediaD=QmarkovmediaD./sum(QmarkovmediaD,2);
%
%
%
%%%%% Calculo de coeficiente de preferencia  %%%%%%%%%%%%%%%%%%%%%%%%%
%aux=I(find(sort(foodMedia)>0.8));
%%%%%%_selfish=foodMedia./((_timeOutMedia)./_timeoutLimit);
%%%%%%
%%%%%%_selfishInf=foodMedia.*_timeOutMedia;
%%%%%%
%%%%%%_selfishtheor=_idealSujeto(1,:)./((_idealSujeto(2,:))./_timeoutLimit);
%%%%%%
%%%%%%hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}
%%%%%%
%%%%%%scatter(_selfish(find(_mediaXsujeto>0.5)),ones(1,length(find(_mediaXsujeto>0.5))),20,"filled");
%%%%%%hold on;
%%%%%%%t=text(-0.002+_selfish(find(_mediaXsujeto>0.5)),0.013+ones(1,length(find(_mediaXsujeto>0.5))),{_txtSujetos(_vSujetos(1:4),:)},"fontsize",14);
%%%%%%t=text(-0.002*[1 -1.15 1 1]+_selfish(find(_mediaXsujeto>0.5)),0.013*[1 1 1 1]+ones(1,length(find(_mediaXsujeto>0.5))),_txtSujetos(_vSujetos(1:4),:),"fontsize",14);
%%%%%%h=scatter(_selfishtheor([1 2 3 5 6]),ones(1,length(_selfishtheor([1 2 3 5 6]))),25,'r');
%%%%%%set(h, "linewidth", 2);  
%%%%%%t=text(-0.005+_selfishtheor([1 2 3 5 6]),-0.013+ones(1,length(_selfishtheor([1 2 3 5 6]))),
%%%%%%                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD"},"fontsize",12);
%%%%%%%t=text([0.26 0.27 0.26 0.27],[1.055 1.055 1.045 1.045],
%%%%%%%       {num2str(_vRefuerzos(1));num2str(_vRefuerzos(2));num2str(_vRefuerzos(3));num2str(_vRefuerzos(4))},"fontsize",13);                                     
%%%%%%%t=text(0.005+[0.26 0.27 0.26 0.27],-0.005+[1.055 1.055 1.045 1.045],
%%%%%%%       {num2str(_vDelay4eat(1));num2str(_vDelay4eat(2));num2str(_vDelay4eat(3));num2str(_vDelay4eat(4))},"fontsize",13);
%%%%%%hold off;
%%%%%%ylabel("");
%%%%%%xlabel("Coefficient of preference","fontsize",16);
%%%%%%
%%%%%%
%%%%%%name=strcat("figura_iPD_1_2_9s_13s/fig_finales/coefficientOfPreference_reversion",_txtSujetos(i,:));
%%%%%%name=strcat(name,".png");
%%%%%%print(hhh, name);
%%%%%
%%%%
%%%
%%%_selfish=foodMedia./((_timeOutMedia)./_timeoutLimit);
%%
%_selfishInf=foodMedia.*_timeOutMedia;
%
%_selfishtheor=_idealSujeto(1,:)./((_idealSujeto(2,:))./_timeoutLimit);
%
%hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}
%hold on;
%scatter(_selfish,ones(1,_nSujetos),20,"filled");
%t=text(-0.002+_selfish,0.013+ones(1,_nSujetos),_txtSujetos(:,:),"fontsize",14);
%h=scatter(_selfishtheor([1 2 3 5 6]),ones(1,length(_selfishtheor([1 2 3 5 6]))),25,'r');
%set(h, "linewidth", 2);  
%t=text(-0.005+_selfishtheor([1 2 3 5 6]),-0.013+ones(1,length(_selfishtheor([1 2 3 5 6]))),
%                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD"},"fontsize",12);
%t=text([0.26 0.27 0.26 0.27],[1.055 1.055 1.045 1.045],
%       {num2str(_vRefuerzos(1));num2str(_vRefuerzos(2));num2str(_vRefuerzos(3));num2str(_vRefuerzos(4))},"fontsize",13);                                     
%t=text(0.005+[0.26 0.27 0.26 0.27],-0.005+[1.055 1.055 1.045 1.045],
%       {num2str(_vDelay4eat(1));num2str(_vDelay4eat(2));num2str(_vDelay4eat(3));num2str(_vDelay4eat(4))},"fontsize",13);
%hold off;
%ylabel("");
%xlabel("Coefficient of preference");
%
%
%name=strcat("figura_iPD_1_2_9s_13s/fig_finales/coefficientOfPreference",_txtSujetos(i,:));
%name=strcat(name,".png");
%print(hhh, name);

%% Experimentos por sujetos
%expXsuj=zeros(1,_nSujetos);
%for j=inicio:(numfields(todo)-8)
%  for i=1:length(todo.(indice(j+1,:)))
%    if length(todo.(indice(j+1,:))(i)._groupStr)!=0
%      expXsuj(i)++;
%    endif
%  endfor
%endfor
%expXsuj(1)=21;
%
%mediasXratas=zeros(12,(50/5));
%for i=1:_nSujetos
%  k=0;
%  for j=1:5:expXsuj(i)
%    k++;
%    if ((j+4)<expXsuj(i))
%      mediasXratas(i,k)=mean(_promediosC(j:j+4,i));
%    else
%      mediasXratas(i,k)=mean(_promediosC(j:expXsuj(i),i));
%    endif
%  endfor
%endfor
%
%%_colores=["--+b";"--ob";"--*b";"--.b";"--xb";"--sb";"--^b";"--vb";"-->b";"--<b";"--pb";"--hb"];
%_colores=["--+k";"--om";"--*g";"--.r";"--xb";"--sc";"--^m";"--vg";"-->b";"--<c";"--pr";"--hr"];
%figure;
%hold on;
%for i=[1 3 7 8 9 10 11 12]
%  %h=plot(1:expXsuj(i),_promediosC(1:expXsuj(i),i),_colores(i,:));
%  h=plot(1:ceil(expXsuj(i)/5),mediasXratas(i,1:ceil(expXsuj(i)/5)),_colores(i,:));
%  set (h, "linewidth", 1);
%endfor
%hold off;
%
%figure;
%hold on;
%for i=[1 3 7 8 9 10 11 12]
%  %h=plot(1:expXsuj(i),_promediosC(1:expXsuj(i),i),_colores(i,:));
%  h=plot(1:ceil(expXsuj(i)/5),mediasXratas(i,1:ceil(expXsuj(i)/5)),'k');
%  set (h, "linewidth", 1);
%endfor
%hold off;


%%%%%%%% TIMEOUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
_timeoutC_EndAttached=(_timeOut(:,i)-_timeoutITI)./_timeoutLimit; %% ejecutar cantidad de alimentos.m

_shft=zeros(1,_nSujetos);
for i=1:_nSujetos
  shft(i)=length(find(_timeOut(:,i)==0));
  _timeoutC_EndAttached(:,i)=shift((_timeOut(:,i)-_timeoutITI)./_timeoutLimit,shft(i));
endfor
_media_EndAtached=sum(_timeoutC_EndAttached,2);
_semTodos_EndAttached=zeros(size(_media_EndAtached));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hf=figure();
hold on;
finAux=max(shft);
%for i=[1 3 7 8 9 10 11 12]
%  %h=plot(1:length([shft(3)+1:finAux]),_promediosC_EndAttached(shft(3)+1:finAux,i),_colores(i,:));
%  h=plot(1:length([shft(3)+1:finAux]),_promediosC_EndAttached(shft(3)+1:finAux,i),'k');
%  set (h, "linewidth", 1);
%endfor

hh=plot(_media_EndAtached(28:finAux),'k');set(hh, "linewidth", 3);
%h=errorbar(_media_EndAtached(28:finAux),_semTodos_EndAttached(28:finAux),'--k');set(hh, "linewidth", 3);
hh=plot(_media_EndAtached(28:finAux)+_semTodos_EndAttached(28:finAux),'--k');set(hh, "linewidth", 3);
hh=plot(_media_EndAtached(28:finAux)-_semTodos_EndAttached(28:finAux),'--k');set(hh, "linewidth", 3);

hhh=xlabel("n of sesiones");set(hhh, "fontsize", 18);
hhh=ylabel("% of cooperation");set(hhh, "fontsize", 18);

hhh=plot(40*ones(1,length([0.45:0.02:0.95]))-shft(3),[0.05:0.02:0.95],'*k');set(hhh, "linewidth", 1);
grid on;