%_colores=["--+k";"--ok";"--*k";"--.k";"--xk";"--sk";"--^k";"--vk";"-->k";"--<k";"--pk";"--hk"];
%
%_cooperacion=[];
%_nada=[];
%for j=inicio:fin
%  _coop=zeros(1,_nSujetos);
%  _nadaAux=zeros(1,_nSujetos);
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
%  endif
%  for i=_vSujetos
%    _coop(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(_trialIni:_trialFin)==2));
%  endfor
%  _cooperacion=[_cooperacion; _coop];
%  for i=_vSujetos
%    _nadaAux(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(_trialIni:_trialFin)==0));
%  endfor
%  _nada=[_nada; _nadaAux];
%endfor
%
%%_cooperacion=_cooperacion';
%_trialsOK=30*ones(length([inicio:fin]),_nSujetos);
%_promediosC=zeros(length([inicio:fin]),_nSujetos);
%%for i=1:_vSujetos
%%  _promediosC(i,:)=_cooperacion(i,:)./(_trialsOK-_nada)(i,:);
%%endfor
%
%_promediosC=_cooperacion./(_trialsOK-_nada);
%
%_media=sum(_promediosC');%/_nSujetos; % CHEQUEAR MEDIA con menos sujetos
%_semTodos=zeros(1,length(_media));
%inicioAux=inicio;
%finAux=fin;
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
%  endif
%  _media(j)=_media(j)/length(_vSujetos);
%  _semTodos(j)=sem(_promediosC(j,_vSujetos));
%endfor
%
%inicioAux=inicio;
%finAux=fin;
%% PLOT sujeto Todos juntos
%
%figure();
%hold on;
%for i=[1 3 7 8 9 10 11 12]
%  if i==1||i==3||i==4||i==5||i==7||i==12
%    finAux=23;
%  elseif i==10
%    finAux=29;
%  elseif i==6||i==9
%    finAux=31;
%  elseif i==2||i==11
%    finAux=33;
%  elseif i==8
%    finAux=fin;
%  endif
%  
%  %figure()
%  h=plot([inicioAux:finAux],_promediosC(inicioAux:finAux,i),_colores(i,:));set (h, "linewidth", 1);
%  
%  
%  
%endfor
%hh=plot(_media);set(hh, "linewidth", 3);
%hh=plot(_media);set(hh, "linewidth", 3);
%hh=plot(_media+_semTodos);set(hh, "linewidth", 3);
%hh=plot(_media-_semTodos);set(hh, "linewidth", 3);
%%x=[inicio:50]';
%%y=(_media(inicio:50))';
%%F = [ ones(length(x),1) x];
%%[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
%%yFit = F*p;
%%%figure();
%%%hh=plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%%set(hh, "linewidth", 3);
%xlabel("n de sesiones");
%ylabel("% de cooperacion");
%title("Cooperacion en iPD");
%legend(_txtSujetos([1 3 7 8 9 10 11 12],:),4);
%grid on;
%
%hold off;
%
%%%%%%%%%%%%%%%%%    todos alineados al final           %%%%%%%%%%%%%%%%%%%%%
%
%_promediosC_EndAttached=_promediosC;
%
%_shft=zeros(1,_nSujetos);
%for i=1:_nSujetos
%  shft(i)=length(find(_promediosC(:,i)==0));
%  _promediosC_EndAttached(:,i)=shift(_promediosC(:,i),shft(i));
%endfor
%_media_EndAtached=sum(_promediosC_EndAttached,2);
%_semTodos_EndAttached=zeros(size(_media_EndAtached));
%b=shft;
%bb=10000;bbb=10000;bbbb=10000;bbbbb=10000;
%for j=inicio:fin
%  if (j>min(bbbbb))
%    _vSujetos=_vSujetos1;
%  elseif j>min(bbbb)
%    _vSujetos=_vSujetos2;
%    bbbbb = bbbb(bbbb~=min(bbbb)) ;
%  elseif j>min(bbb)
%    _vSujetos=_vSujetos3;
%    bbbb = bbb(bbb~=min(bbb)); 
%  elseif j>min(bb)
%    _vSujetos=_vSujetos4;
%    bbb = bb(bb~=min(bb)) ;
%  elseif j>min(b)
%    _vSujetos=_vSujetos5;
%     bb = b(b~=min(b));
%  endif
%  _media_EndAtached(j)=_media_EndAtached(j)/length(_vSujetos);
%  _semTodos_EndAttached(j)=sem(_promediosC_EndAttached(j,_vSujetos));
%endfor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%figure();
%hold on;
%finAux=max(shft);
%for i=[1 3 7 8 9 10 11 12]
%  
%  h=plot(1:length([shft(3)+1:finAux]),_promediosC_EndAttached(shft(3)+1:finAux,i),_colores(i,:));set (h, "linewidth", 1);
%endfor
%
%hh=plot(_media_EndAtached(28:finAux));set(hh, "linewidth", 3);
%hh=plot(_media_EndAtached(28:finAux)+_semTodos_EndAttached(28:finAux),'--r');set(hh, "linewidth", 3);
%hh=plot(_media_EndAtached(28:finAux)-_semTodos_EndAttached(28:finAux),'--r');set(hh, "linewidth", 3);
%%x=[inicio:50]';
%%y=(_media(inicio:50))';
%%F = [ ones(length(x),1) x];
%%[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
%%yFit = F*p;
%%%figure();
%%%hh=plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%%set(hh, "linewidth", 3);
%hhh=xlabel("n of sesiones");set(hhh, "fontsize", 14);
%hhh=ylabel("% of cooperation");set(hhh, "fontsize", 14);
%%title("Cooperacion en iPD");
%legend(_txtSujetos([1 3 7 8 9 10 11 12],:),4);
%t=text(13.5, 0.25, {"Last 10 sessions"},"fontsize",14);
%hhh=plot(40*ones(1,length([0.05:0.02:0.95]))-shft(3),[0.05:0.02:0.95],'*m');set(hhh, "linewidth", 1);
%grid on;
%
%hold off;
%
%%%%  la media y sem de las ultimas 10 sesiones del vectos de media por sesion del grupo de cooperadores
%mean(_media_EndAtached(length(_media_EndAtached)-9:end))
%%ans =  0.85286
%mean(_semTodos_EndAttached(length(_semTodos_EndAttached):end))
%
%


%_colores=["--+k";"--ok";"--*k";"--.k";"--xk";"--sk";"--^k";"--vk";"-->k";"--<k";"--pk";"--hk"];
%
%_cooperacion=[];
%_nada=[];
%for j=inicio:fin
%  _coop=zeros(1,_nSujetos);
%  _nadaAux=zeros(1,_nSujetos);
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
%  endif
%  for i=_vSujetos
%    _coop(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(_trialIni:_trialFin)==2));
%  endfor
%  _cooperacion=[_cooperacion; _coop];
%  for i=_vSujetos
%    _nadaAux(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(_trialIni:_trialFin)==0));
%  endfor
%  _nada=[_nada; _nadaAux];
%endfor
%
%%_cooperacion=_cooperacion';
%_trialsOK=30*ones(length([inicio:fin]),_nSujetos);
%_promediosC=zeros(length([inicio:fin]),_nSujetos);
%%for i=1:_vSujetos
%%  _promediosC(i,:)=_cooperacion(i,:)./(_trialsOK-_nada)(i,:);
%%endfor
%
%_promediosC=_cooperacion./(_trialsOK-_nada);
%
%_media=sum(_promediosC');%/_nSujetos; % CHEQUEAR MEDIA con menos sujetos
%_semTodos=zeros(1,length(_media));
%inicioAux=inicio;
%finAux=fin;
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
%  endif
%  _media(j)=_media(j)/length(_vSujetos);
%  _semTodos(j)=sem(_promediosC(j,_vSujetos));
%endfor
%
%inicioAux=inicio;
%finAux=fin;
%% PLOT sujeto Todos juntos
%
%figure();
%hold on;
%for i=[1 3 7 8 9 10 11 12]
%  if i==1||i==3||i==4||i==5||i==7||i==12
%    finAux=23;
%  elseif i==10
%    finAux=29;
%  elseif i==6||i==9
%    finAux=31;
%  elseif i==2||i==11
%    finAux=33;
%  elseif i==8
%    finAux=fin;
%  endif
%  
%  %figure()
%  h=plot([inicioAux:finAux],_promediosC(inicioAux:finAux,i),_colores(i,:));set (h, "linewidth", 1);
%  
%  
%  
%endfor
%hh=plot(_media);set(hh, "linewidth", 3);
%hh=plot(_media);set(hh, "linewidth", 3);
%hh=plot(_media+_semTodos);set(hh, "linewidth", 3);
%hh=plot(_media-_semTodos);set(hh, "linewidth", 3);
%%x=[inicio:50]';
%%y=(_media(inicio:50))';
%%F = [ ones(length(x),1) x];
%%[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
%%yFit = F*p;
%%%figure();
%%%hh=plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%%set(hh, "linewidth", 3);
%xlabel("n de sesiones");
%ylabel("% de cooperacion");
%title("Cooperacion en iPD");
%legend(_txtSujetos([1 3 7 8 9 10 11 12],:),4);
%grid on;
%
%hold off;
%
%%%%%%%%%%%%%%%%%    todos alineados al final           %%%%%%%%%%%%%%%%%%%%%
%
%_promediosC_EndAttached=_promediosC;
%
%_shft=zeros(1,_nSujetos);
%for i=1:_nSujetos
%  shft(i)=length(find(_promediosC(:,i)==0));
%  _promediosC_EndAttached(:,i)=shift(_promediosC(:,i),shft(i));
%endfor
%_media_EndAtached=sum(_promediosC_EndAttached,2);
%_semTodos_EndAttached=zeros(size(_media_EndAtached));
%b=shft;
%bb=10000;bbb=10000;bbbb=10000;bbbbb=10000;
%for j=inicio:fin
%  if (j>min(bbbbb))
%    _vSujetos=_vSujetos1;
%  elseif j>min(bbbb)
%    _vSujetos=_vSujetos2;
%    bbbbb = bbbb(bbbb~=min(bbbb)) ;
%  elseif j>min(bbb)
%    _vSujetos=_vSujetos3;
%    bbbb = bbb(bbb~=min(bbb)); 
%  elseif j>min(bb)
%    _vSujetos=_vSujetos4;
%    bbb = bb(bb~=min(bb)) ;
%  elseif j>min(b)
%    _vSujetos=_vSujetos5;
%     bb = b(b~=min(b));
%  endif
%  _media_EndAtached(j)=_media_EndAtached(j)/length(_vSujetos);
%  _semTodos_EndAttached(j)=sem(_promediosC_EndAttached(j,_vSujetos));
%endfor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%figure();
%hold on;
%finAux=max(shft);
%for i=[1 3 7 8 9 10 11 12]
%  
%  h=plot(1:length([shft(3)+1:finAux]),_promediosC_EndAttached(shft(3)+1:finAux,i),_colores(i,:));set (h, "linewidth", 1);
%endfor
%
%hh=plot(_media_EndAtached(28:finAux));set(hh, "linewidth", 3);
%hh=plot(_media_EndAtached(28:finAux)+_semTodos_EndAttached(28:finAux),'--r');set(hh, "linewidth", 3);
%hh=plot(_media_EndAtached(28:finAux)-_semTodos_EndAttached(28:finAux),'--r');set(hh, "linewidth", 3);
%%x=[inicio:50]';
%%y=(_media(inicio:50))';
%%F = [ ones(length(x),1) x];
%%[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
%%yFit = F*p;
%%%figure();
%%%hh=plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%%set(hh, "linewidth", 3);
%hhh=xlabel("n of sesiones");set(hhh, "fontsize", 14);
%hhh=ylabel("% of cooperation");set(hhh, "fontsize", 14);
%%title("Cooperacion en iPD");
%legend(_txtSujetos([1 3 7 8 9 10 11 12],:),4);
%t=text(13.5, 0.25, {"Last 10 sessions"},"fontsize",14);
%hhh=plot(40*ones(1,length([0.05:0.02:0.95]))-shft(3),[0.05:0.02:0.95],'*m');set(hhh, "linewidth", 1);
%grid on;
%
%hold off;
%
%%%%  la media y sem de las ultimas 10 sesiones del vectos de media por sesion del grupo de cooperadores
%mean(_media_EndAtached(length(_media_EndAtached)-9:end))
%%ans =  0.85286
%mean(_semTodos_EndAttached(length(_semTodos_EndAttached):end))
%
%
%
%%-------  coopMedia/timeout
%_timeoutLimit=15*13+15*5;
%_selfish=_mediaXsujeto./((_timeOutMedia)./_timeoutLimit);
%
%_selfishInf=_mediaXsujeto.*_timeOutMedia;
%
%_selfishtheor=probC2'./((_idealSujeto(2,:))./_timeoutLimit);
%
%hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}
%
%t=text(-0.002+_selfish,-0.05*[1 .6 1 1 1 1 1 1 1 1.8 1 1 ]+foodMedia,_txtSujetos,"fontsize",14);
%hold on;
%%h=scatter(_selfishtheor([1 2 3 5 6]),ones(1,length(_selfishtheor([1 2 3 5 6]))),25,'r');
%%set(h, "linewidth", 2);  
%h=scatter(_selfish,foodMedia,17,"k","filled");
%h=scatter(_selfishtheor([1 2 3 5 6]),_idealSujeto(1,[1 2 3 5 6]),25,'k'); set(h, "linewidth", 3);
%
%t=text(-0.01*[1 1 5 -1 1]+_selfishtheor([1 2 3 5 6]),0.05*[ 2 1 1.5 1 1 ]'+probC2([1 2 3 5 6]),...
%                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD"},"fontsize",12);
%%axis([.3 .85 .95 1.05]);
%ylabel("Cooperation [%]");
%xlabel("Coefficient of preference Coop/timeOut");
%hold off;
%
%%-------  coopMedia/timeout
%
%_selfish=_mediaXsujeto./((_timeOutMedia)./_timeoutLimit);
%
%_selfishInf=_mediaXsujeto.*_timeOutMedia;
%
%_selfishtheor=probC2'./((_idealSujeto(2,:))./_timeoutLimit);
%
%hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}
%
%t=text(foodMedia,-0.002+_selfish,_txtSujetos,"fontsize",14);
%hold on;
%%h=scatter(_selfishtheor([1 2 3 5 6]),ones(1,length(_selfishtheor([1 2 3 5 6]))),25,'r');
%%set(h, "linewidth", 2);  
%h=scatter(foodMedia,_selfish,17,"k","filled");
%h=scatter(_idealSujeto(1,[1 2 3 5 6 7]),_selfishtheor([1 2 3 5 6 7]),25,'k');set(h, "linewidth", 3);
%t=text(0.00*[ 2 1 1.5 1 1 1]+_idealSujeto(1,[1 2 3 5 6 7]),-0.00*[1 1 5 -1 1 1]+_selfishtheor([1 2 3 5 6 7]),...
%                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD","CCCD"},"fontsize",12);
%%axis([.3 .85 .95 1.05]);
%xlabel("Reward [%] GG");
%ylabel("Coefficient of preference Coop/timeOut");
%hold off;
%

_vRefuerzos=[1 2 0  0];
_vDelay4eat=[5 5 9 13];%[cc dc cd dd] [R T S P]
_timeoutLimit=10*0+10*13+10*9;%10*5+10*13+10*9;% 270s en 30trials  %195; %13*15 or T+29*P=
_timeoutITI=30*5;
_foodLimit=2*15+0*15;% food por T y por S, alterna


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

%-------  coopMedia/timeout INFINITY

_selfish=_mediaXsujeto./((_timeOutMedia)./_timeoutLimit);
_selfishtheor=probC2'./(_idealSujeto(2,:)./_timeoutLimit);

hhh=figure;%  {"switch CD"; "all C";      "switch CCDD";  "half C";            "switch 3Cx3D";   "switch CCD";  "switch CCCD"}
%t=text(foodMedia,-0.002+_selfish,_txtSujetos,"fontsize",14);
hold on;
%h=scatter(foodMedia,_selfish,17,"k","filled");
%h=scatter(probC2([1 2 3 5 6 7]),_selfishtheor([1 2 3 5 6 7]),25,'k');set(h, "linewidth", 3);
h=scatter(_idealSujeto(1,[1 2 3 5 6 7]),_selfishtheor([1 2 3 5 6 7]),25,'k');set(h, "linewidth", 3);
t=text(0.00*[ 2 1 1.5 1 1 1]+_idealSujeto(1,[1 2 3 5 6 7]),-0.00*[1 1 5 -1 1 1]+_selfishtheor([1 2 3 5 6 7]),...
                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD","CCCD"},"fontsize",12);
%axis([.3 .85 .95 1.05]);
xlabel("Reward [%]");
ylabel("Coefficient of preference Coop/timeOut");
%hold off;


_vRefuerzos=[1 4 0 0];
_vDelay4eat=[5 5 9 13];%[cc dc cd dd] [R T S P]
%_timeoutLimit=10*0+10*8+10*4;%10*5+10*13+10*9;% 270s en 30trials  %195; %13*15 or T+29*P=
%_timeoutITI=30*5;
_foodLimit=_vRefuerzos(2)*15+0*15;% food por T y por S, alterna


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


_selfishtheor=probC2'./(_idealSujeto(2,:)./_timeoutLimit);
%h=scatter(probC2([1 2 3 5 6 7]),_selfishtheor([1 2 3 5 6 7]),20,'r');set(h, "linewidth", 3);
h=scatter(_idealSujeto(1,[1 2 3 5 6 7]),_selfishtheor([1 2 3 5 6 7]),20,'r');set(h, "linewidth", 3);
t=text(0.00*[ 2 1 1.5 1 1 1]+_idealSujeto(1,[1 2 3 5 6 7]),-0.00*[1 1 5 -1 1 1]+_selfishtheor([1 2 3 5 6 7]),...
                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD","CCCD"},"fontsize",12);
xlabel("Reward [%]");
ylabel("Coefficient of preference Coop/timeOut");
%hold off;



_vRefuerzos=[2 3 0 0];
_vDelay4eat=[5 5 9 13];%[cc dc cd dd] [R T S P]
%_timeoutLimit=10*0+10*8+10*4;%10*5+10*13+10*9;% 270s en 30trials  %195; %13*15 or T+29*P=
%_timeoutITI=30*5;
_foodLimit=_vRefuerzos(2)*15+0*15;% food por T y por S, alterna

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


_selfishtheor=probC2'./(_idealSujeto(2,:)./_timeoutLimit);
%h=scatter(probC2([1 2 3 5 6 7]),_selfishtheor([1 2 3 5 6 7]),10,'b');set(h, "linewidth", 3);
h=scatter(_idealSujeto(1,[1 2 3 5 6 7]),_selfishtheor([1 2 3 5 6 7]),10,'b');set(h, "linewidth", 3);
t=text(0.00*[ 2 1 1.5 1 1 1]+_idealSujeto(1,[1 2 3 5 6 7]),-0.00*[1 1 5 -1 1 1]+_selfishtheor([1 2 3 5 6 7]),...
                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD","CCCD"},"fontsize",12);
xlabel("Reward [%]");
ylabel("Coefficient of preference Coop/timeOut");
%hold off;


_vRefuerzos=[4 6 0 0];
_vDelay4eat=[5 5 9 13];%[cc dc cd dd] [R T S P]
%_timeoutLimit=10*0+10*8+10*4;%10*5+10*13+10*9;% 270s en 30trials  %195; %13*15 or T+29*P=
%_timeoutITI=30*5;
_foodLimit=_vRefuerzos(2)*15+0*15;% food por T y por S, alterna

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


_selfishtheor=probC2'./(_idealSujeto(2,:)./_timeoutLimit);
%h=scatter(probC2([1 2 3 5 6 7]),_selfishtheor([1 2 3 5 6 7]),5,'m');set(h, "linewidth", 3);
h=scatter(_idealSujeto(1,[1 2 3 5 6 7]),_selfishtheor([1 2 3 5 6 7]),5,'m');set(h, "linewidth", 3);
t=text(0.00*[ 2 1 1.5 1 1 1]+_idealSujeto(1,[1 2 3 5 6 7]),-0.00*[1 1 5 -1 1 1]+_selfishtheor([1 2 3 5 6 7]),...
                                       {"CD","AllC","2Cx2D","3Cx3D" ,"CCD","CCCD"},"fontsize",12);
xlabel("Reward [%]");
ylabel("Coefficient of preference Coop/timeOut");
hold off;