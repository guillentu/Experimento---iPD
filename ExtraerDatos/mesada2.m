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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
%t=text(-0.01*[1 1 1 1 1 1 1 -1]+_mediaXsujeto(aux),.08*[-1 -1 -1 1 1 1 1 -1]+R_mean(aux),_txtSujetos(aux,:));
%axis([.49 1.05 -.04 1.15]);
%hold on;
%h=scatter(probC2([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(probC2([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC2([1 3 4 5 6 7])', 
%        0.04*[.5 .5 .5 .5 2.4 2.4]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC2([1 3 4 5 6 7])', 
%       -0.025*[1.2 1 1 1  -2.3 -2.3]+QQideales(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.6,-0.44,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  %%
%probC=zeros(1,_nSujetos);
%%probC=_mediaXsujeto;
%probD=zeros(1,_nSujetos);
%%probD=1-_mediaXsujeto;
%for i=1:_nSujetos
%  probC(i)=QQTotmarkov(2,1,i)/(1+QQTotmarkov(2,1,i)-QQTotmarkov(1,1,i));
%endfor
%probD=1-probC;
%
%N=1; % numero de trials
%_alimento_MK=zeros(1,_nSujetos); %                      
%for i=_vSujetos   % vec [a b;c d] -> [a c b d] = [c|c c|d d|c d|d]              mal[c|c d|c c|d d|d]
%  %                           R S T P
%  _alimento_MK(i)=N*_vRefuerzos([1 4 2 3])*(vec(QQTotmarkov(:,:,i)).*[probC(i);probD(i);probC(i);probD(i)]);
%endfor
%
%_delay4eat_MK=zeros(1,_nSujetos);
%for i=_vSujetos   % vec [a b;c d] -> [a c b d] = [c|c c|d d|c d|d]
%  _delay4eat_MK(i)=30*_vDelay4eat([1 4 2 3])*(vec(QQTotmarkov(:,:,i)).*[probC(i);probD(i);probC(i);probD(i)]);
%endfor
%
%RSTP_mean_MK=zeros(4,_nSujetos);
%for i=1:_nSujetos
%  RSTP_mean_MK(:,i)=(vec(QQTotmarkov(:,:,i)).*[probC(i);probD(i);probC(i);probD(i)]);
%endfor
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% alimento de sujetos ideales   markov       prob estaren C o D
%probC2=zeros(1,7); % [alternador; cooperador; CyD de a pares; la mitad coop] 
%probC2=[.5;1;0.5;.5;.5;2/3;3/4];
%probD2=zeros(1,7);
%probD2=1-probC2;
%%         {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}
%QQideales=[[0; 1 ;1; 0],[1; 0; 0; 0],[.5; .5; .5; .5],[14/15; 0; 1/15; 1],[2/3;1/3;1/3;2/3],[.5; 1; .5; 0],[2/3; 1; 1/3; 0]];
%_idealSujeto=zeros(2,length(probC2));% row 1 alimetno - row 2 delay to eat
%for i=1:length(probC2)
%  _idealSujeto(1,i)=N*_vRefuerzos([1 4 2 3])*(QQideales(:,i).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
%endfor
%for i=1:length(probC2)
%  _idealSujeto(2,i)=30*_vDelay4eat([1 4 2 3])*(QQideales(:,i).*[probC2(i);probD2(i);probC2(i);probD2(i)]);
%endfor
%
%
%%_effectiveness=(N*_vDelay4eat(1))./_timeOutMedia;
%
%%mean(food(inicioAux:finAux,i))
%_estadoEstacionario=zeros(2,_nSujetos);
%
%for i=1:_nSujetos
%  _estadoEstacionario(:,i) = dtmc(QQTotmarkov(:,:,i));
%endfor[Ss I]=sort(R_mean);
%%%%%%%%%%%%


%%%%% Calculo de coeficiente de preferencia  %%%%%%%%%%%%%%%%%%%%%%%%%

_selfish=foodMedia./((_timeOutMedia)./_timeoutLimit);

_selfishInf=foodMedia.*_timeOutMedia;

_selfishtheor=_idealSujeto(1,:)./((_idealSujeto(2,:))./_timeoutLimit);

hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}
hold on;

t=text(-0.002+_selfish(_sujetosCooperadores),0.013*[1 1 1 1 1 1.5 1 1]+ones(1,length(_sujetosCooperadores)),...
                                            _txtSujetos(_sujetosCooperadores,:),"fontsize",12);
h=scatter(_selfishtheor([1 2 3 5 6]),ones(1,length(_selfishtheor([1 2 3 5 6]))),20,'r');
set(h, "linewidth", 2);  
t=text(-0.005*[1 1 1.5 6 1]+_selfishtheor([1 2 3 5 6]),-0.013+ones(1,length(_selfishtheor([1 2 3 5 6]))),
                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD"},"fontsize",12);
%t=text([0.26 0.27 0.26 0.27],[1.055 1.055 1.045 1.045],
%       {num2str(_vRefuerzos(1));num2str(_vRefuerzos(2));num2str(_vRefuerzos(3));num2str(_vRefuerzos(4))},"fontsize",13);                                     
%t=text(0.005+[0.26 0.27 0.26 0.27],-0.005+[1.055 1.055 1.045 1.045],
%       {num2str(_vDelay4eat(1));num2str(_vDelay4eat(2));num2str(_vDelay4eat(3));num2str(_vDelay4eat(4))},"fontsize",13);
hh=scatter(_selfish(_sujetosCooperadores),ones(1,length(_sujetosCooperadores)),15,'b');
set(hh, "linewidth", 3);  
axis([.3 .85 .9 1.1])
ylabel("");
xlabel("Coefficient of preference");
aa=legend("Simulated","rats");  
hold off;
name="figura_iPD_1_2_9s_13s/fig_finales/coefficientOfPreference2.png";
%name=strcat(name,".png");
print(hhh, name);


