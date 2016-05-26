%-------------------------------------------------------------------
%------- Alternar Random - Control ITI - Castigo
indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";
        "exp06";"exp07";"exp08";"exp09";"exp10";"exp11";
        "exp12";"exp13";"exp14";"exp15";"exp16";"exp17";
        "exp18";"exp19";"exp20";"exp21";"exp22";"exp23";
				"exp24";"exp25";"exp26";"exp27";"exp28";"exp29";
				"exp30";"exp31";"exp32";"exp33";"exp34";"exp35";
				"exp36";"exp37";"exp38";"exp39";"exp40"];

%todo.exp00=exp00;
%todo.exp01=exp1;todo.exp02=exp2;todo.exp03=exp3;todo.exp04=exp4;
todo.exp05=exp05;todo.exp06=exp06;todo.exp07=exp07;todo.exp08=exp08;todo.exp09=exp09;todo.exp10=exp10;
todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;todo.exp15=exp15;
todo.exp16=exp16;todo.exp17=exp17;%todo.exp18=exp18;todo.exp19=exp19;todo.exp20=exp20;
%todo.exp21=exp21;todo.exp22=exp22;
%todo.exp23=exp23;todo.exp24=exp24;todo.exp25=exp25;todo.exp26=exp26;todo.exp27=exp27;
%todo.exp28=exp28;todo.exp29=exp29;todo.exp30=exp30;todo.exp31=exp31;todo.exp32=exp32;
%todo.exp33=exp33;todo.exp34=exp34;todo.exp35=exp35;todo.exp36=exp36;todo.exp37=exp37;todo.exp38=exp38;todo.exp39=exp39;todo.exp40=exp40;%todo.exp=exp;

% NUMERO DE CORRECTOS   
sujeto=2;
inicio=05;
fin=17;
datos=zeros(2,fin);
for j=inicio:fin
  if ((todo.(indice(j+1,:)))(sujeto)._umbral(10) < 5) % Preferencia por Derecha 1
    datos(1,j)=1;
    datos(2,j)=(todo.(indice(j+1,:)))(sujeto)._respuestasDer(30);
  else                                              %Preferencia por Izquierda 8
    datos(1,j)=8;
    datos(2,j)=(todo.(indice(j+1,:)))(sujeto)._respuestasIzq(30);
  endif
endfor

figure();
plot([inicio:fin],datos(2,inicio:fin)/30,'--+b',[inicio:fin],datos(1,inicio:fin)/10,'or')
xlabel("n de sesiones");
ylabel("n de elecciones correctas - come=2");
title("Discriminacion de cantidad de refuerzo");
legend('ComeTRES','0.1-DER 0.8-IZQ');
grid on

%Latencia al palanqueo

_lat=zeros(1,length(1:fin));
for j=inicio:fin
  _lat(j)=mean((todo.(indice(j+1,:)))(sujeto)._reloj(2,1:30));
endfor

figure();
plot([inicio:fin],_lat(inicio:fin),'--+b')
xlabel("n de sesion");
ylabel("segundos");
title("Latencia al palanqueo");

x=[inicio:fin]';
y=(30-_lat(inicio:fin))';
F = [ ones(length(x),1) x];
[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
yFit = F*p;
figure();
plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
title('Latencia al palanqueo - Regresion Lineal');
xlabel("n de sesion");
ylabel("segundos");
legend('Latencias','Promedio','+/-95% Desv. Std');
grid on

%----- Cantidad de palanquoes en ITI ------------------------------------------
_controlITI=zeros(1,length([inicio:fin]));
for j=inicio:fin
	_controlITI(j)=(sum((todo.(indice(j+1,:)))(sujeto)._controlITI(2,1:30)) 
                + sum((todo.(indice(j+1,:)))(sujeto)._controlITI(3,1:30))) / (todo.(indice(j+1,:)))(sujeto)._duarcionT;
endfor


x=[inicio:fin]';
y=(_controlITI(inicio:fin))';
F = [ones(length(x),1) x];
[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
yFit = F*p;
figure();
plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
title('Palaqueos en ITI - Regresion Lineal');
xlabel("n de sesiones");
ylabel("nº de palanqueos");
legend('Palanqueos','Promedio','+/-95%Desv. Std');
grid on
