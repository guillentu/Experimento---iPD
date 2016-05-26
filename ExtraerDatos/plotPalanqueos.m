todo.exp01=exp1;todo.exp02=exp2;todo.exp03=exp3;todo.exp04=exp4;todo.exp05=exp5;todo.exp06=exp6;
todo.exp07=exp7;todo.exp08=exp8;todo.exp09=exp9;
todo.exp10=exp10;todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;
todo.exp15=exp15;todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;
indice=["exp01";"exp02";"exp03";"exp04";"exp05";"exp06";"exp07";"exp08";"exp09"
       ;"exp10";"exp11";"exp12";"exp13";"exp14";"exp15";"exp16"
       ;"exp17";"exp18";]

% NUMERO DE CORRECTOS
inicio=19;

fin=27;   
%veces que ocurre Palanca IZq y DER
_nDer=zeros(1,length(12:18));
_nIzq=zeros(1,length(12:18));
_nPalanqueOKDer=zeros(1,length(12:18));
_nPalanqueOKIzq=zeros(1,length(12:18));
for j=12:18
  %Cantidad de Veces que debe elegir DERECHA
  _nDer(j-11)=length(find((todo.(indice(j,:)))(1)._umbral>=5));
  _nIzq(j-11)=length(find((todo.(indice(j,:)))(1)._umbral< 5));
  _nPalanqueOKDer(j-11)=(todo.(indice(j,:)))(1)._respuestasDer(30);
  _nPalanqueOKIzq(j-11)=(todo.(indice(j,:)))(1)._respuestasIzq(30);
endfor
porcentaje=[_nPalanqueOKDer./_nDer;_nPalanqueOKIzq./_nIzq];  

x=[12:18]';
y=porcentaje';
F = [ ones(length(x),1) x];

[p,e_var,r,p_var,y_var] = LinearRegression(F,y(:,1));
yFit = F*p;
figure();
plot(x,y(:,1),'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
title('Promedio de Elecciones correctas sobre palanca Derecha - Regresion Lineal');
xlabel("n de sesion");
ylabel("Porcentaje de elecciones correctas");
legend('Media de eleciones','fit','+/-95%');
grid on
[p,e_var,r,p_var,y_var] = LinearRegression(F,y(:,2));
yFit = F*p;
figure();
plot(x,y(:,2),'+r',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
title('Promedio de Elecciones correctas sobre palanca Izquierda - Regresion Lineal');
xlabel("n de sesion");
ylabel("Porcentaje de elecciones correctas");
legend('Media de eleciones','fit','+/-95%');
grid on


plot([12:18],porcentaje(1,:),'-+b',[12:18],porcentaje(2,:),'-or')
xlabel("n de sesion");
ylabel("Porcentaje de elecciones correctas");
title('Promedio de Elecciones correctas Izquierda-Derecha');
legend('Media de elecionesDER','Media de elecionesIZQ');
grid on
%for i=1:30
%  for j=12:18
%    (todo.(indice(j,:)))(1)._nTrial)
%  endfor            
%endfor


%LATENCIA AL PALANQUEO
figure
lat=zeros(1,length(12:18));
for j=12:18
  %Cantidad de Veces que debe elegir DERECHA
  _lat(j-11)=mean((todo.(indice(j,:)))(1)._reloj(15:30))
endfor
plot([12:18],_lat)
xlabel("n de trials");
ylabel("segundos");
title("Latencia al palanqueo");

x=[12:18]';
y=(30-_lat)';
F = [ ones(length(x),1) x];
[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
yFit = F*p;
figure();
plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
title('Regresion Lineal');
xlabel("n de trials");
ylabel("segundos");
legend('Latencias','fit','+/-95%');
grid on

%figure
%scatter(exp1(1)._nTrial, exp1(1)._respuestasIzq,'b')
%hold on;
%scatter(exp2(1)._nTrial, exp2(1)._respuestasIzq,'b')
%scatter(exp3(1)._nTrial, exp3(1)._respuestasIzq,'b')
%scatter(exp4(1)._nTrial, exp4(1)._respuestasIzq,'b')
%scatter(exp1(1)._nTrial, exp1(1)._respuestasDer,'r')
%scatter(exp2(1)._nTrial, exp1(1)._respuestasDer,'r')
%scatter(exp3(1)._nTrial, exp1(1)._respuestasDer,'r')
%scatter(exp4(1)._nTrial, exp1(1)._respuestasDer,'r')
%xlabel("n de trials - 15 y 15");
%ylabel("n de palanqueos, azul IZQ y rojo DER");
%title("Evolucion de cantidad  de palanqueos por trials");

figure;hold on;
for j=1:4
  scatter((todo.(indice(j,:)))(1)._nTrial,(todo.(indice(j,:)))(1)._respuestasIzq,'b');
endfor
for j=1:4
  scatter((todo.(indice(j,:)))(1)._nTrial,(todo.(indice(j,:)))(1)._respuestasDer,'r');
endfor
xlabel("n de trials - 15 y 15");
ylabel("n de palanqueos, azul IZQ y rojo DER");
title("Evolucion de cantidad  de palanqueos por trials");

%figure
%scatter(exp5(1)._nTrial, exp5(1)._respuestasIzq,'b')
%hold on;
%scatter(exp6(1)._nTrial, exp6(1)._respuestasIzq,'b')
%scatter(exp7(1)._nTrial, exp7(1)._respuestasIzq,'b')
%scatter(exp8(1)._nTrial, exp8(1)._respuestasIzq,'b')
%scatter(exp9(1)._nTrial, exp9(1)._respuestasIzq,'b')
%scatter(exp10(1)._nTrial, exp10(1)._respuestasIzq,'b')
%scatter(exp11(1)._nTrial, exp11(1)._respuestasIzq,'b')
%scatter(exp12(1)._nTrial, exp12(1)._respuestasIzq,'b')
%scatter(exp13(1)._nTrial, exp13(1)._respuestasIzq,'b')
%scatter(exp14(1)._nTrial, exp14(1)._respuestasIzq,'b')
%scatter(exp15(1)._nTrial, exp15(1)._respuestasIzq,'b')
%scatter(exp16(1)._nTrial, exp16(1)._respuestasIzq,'b')
%scatter(exp17(1)._nTrial, exp17(1)._respuestasIzq,'b')
%scatter(exp18(1)._nTrial, exp18(1)._respuestasIzq,'b')
%
%scatter(exp5(1)._nTrial, exp5(1)._respuestasDer,'r')
%scatter(exp6(1)._nTrial, exp6(1)._respuestasDer,'r')
%scatter(exp7(1)._nTrial, exp7(1)._respuestasDer,'r')
%scatter(exp8(1)._nTrial, exp8(1)._respuestasDer,'r')
%scatter(exp9(1)._nTrial, exp9(1)._respuestasDer,'r')
%scatter(exp10(1)._nTrial, exp10(1)._respuestasDer,'r')
%scatter(exp11(1)._nTrial, exp11(1)._respuestasDer,'r')
%scatter(exp12(1)._nTrial, exp12(1)._respuestasDer,'r')
%scatter(exp13(1)._nTrial, exp13(1)._respuestasDer,'r')
%scatter(exp14(1)._nTrial, exp14(1)._respuestasDer,'r')
%scatter(exp15(1)._nTrial, exp15(1)._respuestasDer,'r')
%scatter(exp16(1)._nTrial, exp16(1)._respuestasDer,'r')
%scatter(exp17(1)._nTrial, exp17(1)._respuestasDer,'r')
%scatter(exp18(1)._nTrial, exp18(1)._respuestasDer,'r')
%xlabel("n de trials - RANDOM");
%ylabel("n de palanqueos, azul IZQ y rojo DER");
%title("Evolucion de cantidad  de palanqueos por trials");

figure;hold on;
for j=12:18
  if j==11
    plot((todo.(indice(j,:)))(2)._nTrial,(todo.(indice(j,:)))(2)._respuestasIzq,'ob')
  else
    plot((todo.(indice(j,:)))(1)._nTrial,(todo.(indice(j,:)))(1)._respuestasIzq,'ob')
  endif
endfor
for j=12:18
  if j==11
    plot((todo.(indice(j,:)))(2)._nTrial,(todo.(indice(j,:)))(2)._respuestasDer,'+r')
  else
    plot((todo.(indice(j,:)))(1)._nTrial,(todo.(indice(j,:)))(1)._respuestasDer,'+r')
  endif
endfor
xlabel("n de trials - RANDOM");
ylabel("n de palanqueos, azul IZQ y rojo DER");
title("Evolucion de cantidad  de palanqueos por trials");

%size(exp1(i)._respuestasIzq)
%size(exp2(i)._respuestasIzq)
%size(exp3(i)._respuestasIzq)
%size(exp4(i)._respuestasIzq)
%size(exp5(i)._respuestasIzq)
%size(exp6(i)._respuestasIzq)
%size(exp7(i)._respuestasIzq)
%size(exp8(i)._respuestasIzq)
%size(exp9(i)._respuestasIzq)
%size(exp10(i)._respuestasIzq)
%size(exp11(i)._respuestasIzq)
%size(exp12(i)._respuestasIzq)
%size(exp13(i)._respuestasIzq)
%size(exp14(i)._respuestasIzq)
%size(exp15(i)._respuestasIzq)
%size(exp16(i)._respuestasIzq)
%size(exp17(i)._respuestasIzq)
%size(exp18(i)._respuestasIzq)
%size(exp1(i)._respuestasDer)
%size(exp2(i)._respuestasDer)
%size(exp3(i)._respuestasDer)
%size(exp4(i)._respuestasDer)
%size(exp5(i)._respuestasDer)
%size(exp6(i)._respuestasDer)
for j=1:18
  size((todo.(indice(j,:)))(1)._respuestasIzq)
endfor
for j=1:18
  (todo.(indice(j,:)))(1)._respuestasIzq%_nTrial
endfor

%--------------------------------------------------------------------------
%---------------- DISCRIMINAR ---------------------------------------------
%--------------------------------------------------------------------------
indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";"exp06";"exp07";"exp08";"exp09"
       ;"exp10";"exp11";"exp12";"exp13";"exp14";"exp15";"exp16"]

todo.exp01=exp01;todo.exp02=exp02;todo.exp03=exp03;todo.exp04=exp04;todo.exp05=exp05;
todo.exp06=exp06;todo.exp07=exp07;todo.exp08=exp08;todo.exp09=exp09;todo.exp10=exp10;
todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;todo.exp15=exp15;
todo.exp16=exp16;todo.exp00=exp00;

sujeto=2;
inicio=1;
if (sujeto==2)
  inicio=5;
endif
fin=17;
datos=zeros(2,fin);
for j=inicio:fin
  if ((todo.(indice(j,:)))(sujeto)._umbral(1) < 5) % Preferencia por Derecha 1
    datos(1,j)=1;
    datos(2,j)=(todo.(indice(j,:)))(sujeto)._respuestasDer(29);
  else                                              %Preferencia por Izquierda 8
    datos(1,j)=8;
    datos(2,j)=(todo.(indice(j,:)))(sujeto)._respuestasIzq(29);
  endif
endfor

figure();
plot([inicio:fin],datos(2,inicio:fin),'--b',[inicio:fin],datos(1,inicio:fin),'or')
xlabel("n de sesiones");
ylabel("n de elecciones correctas - come=2");
title("Discriminacion de cantidad de refuerzo");
legend('ComeDOS','1-DER 2-IZQ');
grid on

%Latencia al palanqueo
sujeto=2;
inicio=1;
if (sujeto==2)
  inicio=5;
endif
fin=17;
_lat=zeros(1,length(1:fin));
for j=inicio:fin
  _lat(j)=mean((todo.(indice(j,:)))(sujeto)._reloj(1:29));
endfor

figure();
plot([inicio:fin],_lat(inicio:fin),'--+b')
xlabel("n de trials");
ylabel("segundos");
title("Latencia al palanqueo");

x=[inicio:fin]';
y=(30-_lat(inicio:fin))';
F = [ ones(length(x),1) x];
[p,e_var,r,p_var,y_var] = LinearRegression(F,y);
yFit = F*p;
figure();
plot(x,y,'+b',x,yFit,'-g',x,yFit+1.96*sqrt(y_var),'--r',x,yFit-1.96*sqrt(y_var),'--r');
title('Regresion Lineal');
xlabel("n de trials");
ylabel("segundos");
legend('Latencias','fit','+/-95%');
grid on

%for j=inicio:fin
%  (todo.(indice(j,:)))(sujeto)._fileStr%_startDateStr
%endfor
%for j=inicio:fin
%  size((todo.(indice(j,:)))(sujeto)._nTrial)
%endfor