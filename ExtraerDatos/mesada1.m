%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------
%
%[Ss I]=sort(_mediaXsujeto);
%figure;
%aux=I(find(sort(_mediaXsujeto)>0.5));
%%h=plot(_mediaXsujeto(I),_alimento(I),'ko', "markersize",12,"markerfacecolor",'c', "linewidth", 2);
%h=scatter(_mediaXsujeto(aux),_alimento(aux),20,(_delay4eat(aux)-_timeoutITI)./_timeoutLimit,"filled");
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
%t=text(-0.01*[1 1 1 1 1 1 1 -1]+_mediaXsujeto(aux),.08*[ 1 1 1 1 1 1 1 -1]+_alimento(aux),_txtSujetos(aux,:));
%%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .03*[1 1 1 1 1 1 1 1 1 1 1 -1]+_alimento(I) ,_txtSujetos(I,:));
%%axis('auto');
%axis([.49 1.02 0 1.15]);
%hold on;
%%h=plot(_mediaXsujeto(I(length(I))),_alimento(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),_idealSujeto(2,[1 3 4 5 6 7]),15,probC([1 3 4 5 6 7])','s',"filled");
%%h=plot(probC([1 3 4 5]),_idealSujeto(1,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 
%        0.04*[.5 .5 .5 .5 2.9 2.9]+_idealSujeto(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 
%       -0.025*[1.2 1 1 1 -3.2 -3.2]+_idealSujeto(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;
%
%
%% grafico Cooperacion Versus R
%[Ss I]=sort(_mediaXsujeto);
%figure;
%aux=I(find(sort(_mediaXsujeto)>0.5));
%h=scatter(_mediaXsujeto(aux),R_mean(aux),20,((_delay4eat(aux)-_timeoutITI)./_timeoutLimit),"filled");
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
%axis([0 1.05 -.04 1.05]);
%hold on;
%h=scatter(probC([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(probC([1 3 4 5 6 7])',QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 
%        0.04*[.5 .5 .5 .5 2.4 2.4]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7]), 
%       -0.025*[1.2 1 1 1  -2.3 -2.3]+QQideales(1,[1 3 4 5 6 7]) ,
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;
%
%% grafico Reward Versus R
%[Ss I]=sort(R_mean);
%figure;
%aux=I(find(sort(R_mean)>0.4));
%h=scatter(_alimento(aux),R_mean(aux),20,((_delay4eat(aux)-_timeoutITI)./_timeoutLimit),"filled");
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
%t=text(-0.01*[1 1 1 1 1 3 1 -1] + _alimento(aux),.07*[1 1 1 1 1 0.2 1 .5] + R_mean(aux)',_txtSujetos(aux,:))';
%%axis('auto');
%axis([.49 1.1 0 1.1]);
%hold on;
%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),QQideales(1,[1 3 4 5 6 7]),15,(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,'s',"filled");
%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),QQideales(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(0.025*[.51 .51 .51 .51 -.8 -.5]+ _idealSujeto(1,[1 3 4 5 6 7]), 
%        0.04*[.5 .5 .5 .5 1.4 1.4]+QQideales(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%t=text(0.025*[.51 .51 .51 .51 -.8 -.5]+ _idealSujeto(1,[1 3 4 5 6 7]), 
%       -0.025*[1.2 1 1 1  1.9 1.9]+ QQideales(1,[1 3 4 5 6 7]),
%        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
%t=text(0.62,-0.38,{"Normalized accumulated timeout per sessions"},"fontsize",14);
%hold off;
%
%% Tasa de alimentacion
%%_foodRate= _alimento(1:_nSujetos)./(_delay4eat);%_vDelay4eat(1));
%%_delay2eat=_delay4eat;
%%[Ss I]=sort(_foodRate);
%%figure;
%%h=plot(_mediaXsujeto(I),100.*_delay2eat(I)./_timeOutMedia,'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%hold on;
%%set(h, "linewidth", 2);
%%hh=xlabel("Among of C choice ");
%%set(hh, "fontsize", 14);
%%hh=ylabel("Delay to eat [seconds]");
%%set(hh, "fontsize", 14);
%%hh=title("Cooperation versus Delay to eat"); 
%%set(hh, "fontsize", 14);
%%%h=plot(_mediaXsujeto(I),_delay2eat(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%grid on;
%%t=text(-0.02*[1 1 1 1 1 1 1 1 1 1 1 1]+_mediaXsujeto(I), 0.15*[1 1 -1 1 1 1 1 1 1 1 1 -1]+_delay2eat(I) ,_txtSujetos(I,:));
%%axis('auto');
%%hold on;
%%h=plot(probC([1 3 4 5]),100/120.*_idealSujeto(2,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
%%t=text(0.025*ones(1,length(probC([1 3 4 5])))+ probC([1 3 4 5])', 
%%        100/_timeOutMedia.*_idealSujeto(2,[1 3 4 5]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D"});
%%hold off;
%
%% Alimentacion Versus Delay to eat
%_delay2eat=(_delay4eat-_timeoutITI)./_timeoutLimit;
%[Ss I]=sort(_alimento);
%hhh=figure;
%aux=I(find(sort(_alimento)>0.8));
%h=scatter(_delay2eat(aux),_alimento(aux),20, _mediaXsujeto(aux),"filled");
%ch=colormap(copper);
%h=colorbar('southoutside');
%hold on;
%%h=errorbar(_delay2eat(I(find(sort(_alimento)>0.8)))./_timeOutMedia,_alimento(I(find(sort(_alimento)>0.8))),,'*k');
%%set(hhh, "linewidth", 2);
%hh=ylabel("% of total Reward");
%set(hh, "fontsize", 14);
%hh=xlabel("% total acumulated Timeout per sessions");
%set(hh, "fontsize", 14);
%hh=title("Reward versus Timeout to eat (colorbar=cooperation)"); 
%set(hh, "fontsize", 14);
%grid on;
%t=text(0.02*[-1 -1 -1 -1 -1 -1 -1 -1]+_delay2eat(aux)./_timeoutLimit,-0.04*[1 1 1 1 1.2 -1 1 -1]+_alimento(aux),_txtSujetos(aux,:));
%%axis('auto');
%axis([-.04, 1.1, .5, 1.1], "square");
%hold on;
%h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,probC([1 3 4 5 6 7]),'s',"filled");
%h=scatter((_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%t=text(-0.10*[1 1 1 1 1 1]+(_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
%       0.05*ones(1,length(probC([1 3 4 5 6 7])))+ _idealSujeto(1,[1 3 4 5 6 7]), 
%       {"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
%
%t=text(-0.10*[1 1 1 1 1 1]+ (_idealSujeto(2,[1 3 4 5 6 7])-_timeoutITI)./_timeoutLimit,
%       0.03*[1 1 1 1 1 1]+ _idealSujeto(1,[1 3 4 5 6 7]),
%       {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"}); 
%t=text(0.2,0.22,{"Normalized amoung of C choice"},"fontsize",14);       
%hold off;
%
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
%%[S I]=sort(_alimento(1:_nSujetos));
%%figure;
%%h=plot(_alimento(I),_foodRate(I),'ko', "markersize",14,"markerfacecolor",'c', "linewidth", 2);
%%set(h, "linewidth", 2);
%%hh=xlabel("Food Harvested [Pellet]");
%%set(hh, "fontsize", 14);
%%hh=ylabel("Food rate [Pellets/trial]");
%%set(hh, "fontsize", 14);
%%hh=title("Food Rate versus Food Harvested"); 
%%set(hh, "fontsize", 14);
%%grid on;
%%t=text(-0.60*[1 1 1 1 1 1 1 1 1 1 1 -1]+_alimento(I), 0.02*[1 -1 1 1 1 1 1 1 1 1 1 .5]+_foodRate(I) ,_txtSujetos(I,:));
%%axis([1 ,30, 0, 1],'auto');
%%hold on;
%%h=plot(_alimento(I(length(I))),_foodRate(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
%%hold off;
%
%%%
%
%%[Ss I]=sort(_alimento(1:_nSujetos));
%%[x, y, z] = sphere(50);
%%x=x./50;y=y./50;z=z./50;
%%figure;
%%
%%for i=I
%%  mesh((_delay4eat(i))+x, _mediaXsujeto(i)+y, _alimento(i)+z);hold on;set(h, "linewidth", 2);hold on;
%%endfor
%%figure;
%%for i=I
%%  contourc((_delay4eat(i))+x, _mediaXsujeto(i)+y, _alimento(i)+z);
%%endfor
%figure;
%contour(_delay4eat, _mediaXsujeto, _alimento);
%%&stem3((_delay4eat(i))+x, _mediaXsujeto(i)+y, _alimento(i)+z,"markersize",20,"markerfacecolor",'none', "linewidth", 3);
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
%scatter(_alimento,_delay4eat,20, _mediaXsujeto,"filled");
%
%%_criterio=.5;
%graficos_iPD_1_2_9s_13s_12Ratas_medias_y_medianas % se obtienen los sujetos que superan el .75 porciento de cooperación
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
%%%%%% Calculo de coeficiente de preferencia  %%%%%%%%%%%%%%%%%%%%%%%%%
%
%_selfish=foodMedia./_timeOutMedia;
%
%_selfishInf=_alimento.*_delay4eat;
%
%_selfishtheor=_idealSujeto(1,:)*30./_idealSujeto(2,:);
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

%probC=zeros(1,_nSujetos);
%%probC=_mediaXsujeto;
%probD=zeros(1,_nSujetos);
%%probD=1-_mediaXsujeto;
%
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





