%todo.exp00=exp00;todo.exp01=exp01;todo.exp02=exp2;todo.exp03=exp3;todo.exp04=exp4;todo.exp05=exp5;
%todo.exp06=exp6;
%todo.exp07=exp7;todo.exp08=exp8;todo.exp09=exp9;
%todo.exp10=exp10;todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;
%todo.exp15=exp15;todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;
todo.exp19=exp19;todo.exp20=exp20;todo.exp21=exp21;todo.exp22=exp22;todo.exp23=exp23;
todo.exp24=exp24;todo.exp25=exp25;todo.exp26=exp26;todo.exp27=exp27;todo.exp28=exp28;
todo.exp29=exp29;todo.exp30=exp30;todo.exp31=exp31;todo.exp32=exp32;todo.exp33=exp33;
todo.exp34=exp34;todo.exp35=exp35;todo.exp36=exp36;todo.exp37=exp37;todo.exp38=exp38;
todo.exp39=exp39;todo.exp40=exp40;todo.exp41=exp41;todo.exp42=exp42;
indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";"exp06";"exp07";"exp08";
        "exp09";"exp10";"exp11";"exp12";"exp13";"exp14";"exp15";"exp16";"exp17";
        "exp18";"exp19";"exp20";"exp21";"exp22";"exp23";"exp24";"exp25";"exp26";
        "exp27";"exp28";"exp29";"exp30";"exp31";"exp32";"exp33";"exp34";"exp35";
				"exp36";"exp37";"exp38";"exp39";"exp40";"exp41";"exp42"];

% NUMERO DE CORRECTOS   
sujeto=2;  
inicio=19;
fin=42;   
%veces que ocurre Palanca IZq y DER
_nDer=zeros(1,length(inicio:fin));
_nIzq=zeros(1,length(inicio:fin));
_nPalanqueOKDer=zeros(1,length(inicio:fin));
_nPalanqueOKIzq=zeros(1,length(inicio:fin));
for j=inicio:fin
  %Cantidad de Veces que debe elegir DERECHA
  _nDer(j)=length(find((todo.(indice(j+1,:)))(sujeto)._umbral(1:29)>=5));
  _nIzq(j)=length(find((todo.(indice(j+1,:)))(sujeto)._umbral(1:29)< 5));
  _nPalanqueOKDer(j)=(todo.(indice(j+1,:)))(sujeto)._respuestasDer(29);
  _nPalanqueOKIzq(j)=(todo.(indice(j+1,:)))(sujeto)._respuestasIzq(29);
endfor
porcentaje=[_nPalanqueOKDer(inicio:fin)./_nDer(inicio:fin);_nPalanqueOKIzq(inicio:fin)./_nIzq(inicio:fin)];

x=[inicio:fin]';
y=porcentaje';
F = [ ones(length(x),1) x];

[p,e_var,r,p_var,y_var] = LinearRegression(F,y(:,1));
yFit = F*p;
figure();
plot(x,y(:,1),'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
title('Elecciones Correctas sobre palanca DERECHA - Regresion Lineal');
xlabel("n de sesion");
ylabel("% de elecciones correctas");
legend('Media de eleciones','fit','+/-95% Desv. Std');
grid on
[p,e_var,r,p_var,y_var] = LinearRegression(F,y(:,2));
yFit = F*p;
figure();
plot(x,y(:,2),'+r',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
title('Elecciones correctas sobre palanca IZQUIERDA - Regresion Lineal');
xlabel("n de sesion");
ylabel("% de elecciones correctas");
legend('Media de eleciones','fit','+/-95% Desv. Std');
grid on

figure()
plot([inicio:fin],porcentaje(1,:),'-+b',[inicio:fin],porcentaje(2,:),'-or')
xlabel("n de sesion");
ylabel("Porcentaje de elecciones correctas");
title('Promedio de Elecciones correctas Izquierda-Derecha');
legend('Media de eleciones-DER','Media de eleciones-IZQ');
grid on

%LATENCIA AL PALANQUEO
_lat=zeros(1,length(1:fin));
for j=inicio:fin
  _lat(j)=mean((todo.(indice(j+1,:)))(sujeto)._reloj(2,1:29));
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
title('Latencia a presionar la Palanca - Regresion Lineal');
xlabel("n de sesion");
ylabel("Promedio de latencia en sesion - [seg]");
legend('Latencias','Media','+/-95% Desv. Std');
grid on

%----- Cantidad de palanquoes en ITI ------------------------------------------
_controlITI=zeros(1,length([inicio:fin]));
for j=(inicio):fin
	_controlITI(j)=(sum((todo.(indice(j+1,:)))(sujeto)._controlITI(2,1:29)) 
                + sum((todo.(indice(j+1,:)))(sujeto)._controlITI(3,1:29))) / (todo.(indice(j+1,:)))(sujeto)._duarcionT;
endfor


x=[inicio+6:fin]';
y=(_controlITI((inicio+6):fin))';
F = [ones(length(x),1) x];
[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
yFit = F*p;
figure();
plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
title('Palaqueos en ITI - Regresion Lineal');
xlabel("n de sesion");
ylabel("n de palanqueos");
legend('Palanqueos','Promedio','+/-95% Desv. Std');
grid on
