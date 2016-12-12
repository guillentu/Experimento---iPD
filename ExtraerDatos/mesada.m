

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
close all;
_ultimosX=10
_ps1=zeros(2,_nSujetos);

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

_ps2=zeros(2,_nSujetos);
_values=zeros(_nSujetos,1);
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
for i=1:_nSujetos
  inicioAux=expXsuj(i)-_ultimosX+1;
  finAux=expXsuj(i);
  x=[1:_ultimosX]';%[inicio:fin]';
  y=_promediosC(inicioAux:finAux,i);
  F = [ ones(length(x),1) x];
  [p,e_var,r,p_var,y_var] = LinearRegression(F,y(:,1));
  yFit = F*p;
  _ps1(1,i)=p
  e_var
  _ps2(1,i)=[1 5]*p;
  %_ps2(1,i)
  [_values(i) index]=max(abs(_ps2(1,i)-_promediosC(inicioAux:finAux,i)));
  %mean(y)
%  figure();
%  plot(x,y(:,1),'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
%  title('Behavior Stability - Lineal Regresion');
%  xlabel("session");
%  ylabel("% of cooperation");
%  legend(strcat('C choice ',_txtSujetos(i,:)),'fit','+/-95% Desv. Std');
%  axis([0 10 0.2 1.3])
%  grid on
endfor