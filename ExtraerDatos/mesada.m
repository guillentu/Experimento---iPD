

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
[S I]=sort(_mediaXsujeto);
threshold=0.3;
figure;
h=scatter(_mediaXsujeto(I(find(sort(_mediaXsujeto)>threshold))),R_mean(I(find(sort(_mediaXsujeto)>threshold))),20,(_delay4eat(I(find(sort(_mediaXsujeto)>threshold)))./120),"filled");
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
t=text(-0.01*[1 1 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I(find(sort(_mediaXsujeto)>threshold))),
         .08*[1 1 1 1 1 1 1 1 1 1 1 -1]+R_mean(I(find(sort(_mediaXsujeto)>threshold))),
         _txtSujetos(I(find(sort(_mediaXsujeto)>threshold)),:));
%axis('auto');
axis([.49 1.1 0 1.1]);
hold on;
h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,_idealSujeto(2,[1 3 4 5 6 7])./120,'s',"filled");
h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7])', 
        0.04*[.5 .5 .5 .5 1.4 1.4]+_idealSujeto(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7])', 
       -0.025*[1.2 1 1 1  1.9 1.9]+_idealSujeto(1,[1 3 4 5 6 7]) ,
        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
hold off;

% grafico Alimentos versus Cooperacion
[S I]=sort(_mediaXsujeto);
figure;
%h=plot(_mediaXsujeto(I),_alimento(I),'ko', "markersize",12,"markerfacecolor",'c', "linewidth", 2);
h=scatter(_mediaXsujeto(I(find(sort(_mediaXsujeto)>0.5))),_alimento(I(find(sort(_mediaXsujeto)>0.5))),20,_delay4eat(I(find(sort(_mediaXsujeto)>0.5)))./120,"filled");
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
t=text(-0.01*[1 1 1 1 1 1 1 -1]+_mediaXsujeto(I(find(sort(_mediaXsujeto)>0.5))), 
         .08*[ 1 1 1 1 1 1 1 -1]+_alimento(I(find(sort(_mediaXsujeto)>0.5))) ,
         _txtSujetos(I(find(sort(_mediaXsujeto)>0.5)),:));
%t=text(-0.01*[1 2.5 1 1 1 1 1 1 1 1 1 -1]+_mediaXsujeto(I), .03*[1 1 1 1 1 1 1 1 1 1 1 -1]+_alimento(I) ,_txtSujetos(I,:));
%axis('auto');
axis([.49 1.02 0 1.15]);
hold on;
%h=plot(_mediaXsujeto(I(length(I))),_alimento(I(length(I))),'ko', "markersize",20,"markerfacecolor",'none', "linewidth", 2);
h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,_idealSujeto(2,[1 3 4 5 6 7]),'s',"filled");
h=scatter(probC([1 3 4 5 6 7])',_idealSujeto(1,[1 3 4 5 6 7]),15,'k','s',"linewidth",2);
%h=scatter(_idealSujeto(1,[1 3 4 5 6 7]),_idealSujeto(2,[1 3 4 5 6 7]),15,probC([1 3 4 5 6 7])','s',"filled");
%h=plot(probC([1 3 4 5]),_idealSujeto(1,[1 3 4 5]),'ko', "markersize",20,"markerfacecolor",'r', "linewidth", 2);
t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7])', 
        0.04*[.5 .5 .5 .5 2.9 2.9]+_idealSujeto(1,[1 3 4 5 6 7]) ,{"switch CD";"switch CCDD";"half C";"switch 3Cx3D";"switch CCD";"switch CCCD"});
t=text(0.025*[1 1 1 1 -.8 -.5]+ probC([1 3 4 5 6 7])', 
       -0.025*[1.2 1 1 1 -3.2 -3.2]+_idealSujeto(1,[1 3 4 5 6 7]) ,
        {"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.5";"coop 0.66%";"coop 0.75%"});
t=text(0.6,-0.37,{"Normalized accumulated timeout per sessions"},"fontsize",14);
hold off;
