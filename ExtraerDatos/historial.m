%

for j=inicio:fin
  if j<24
    _vSujetos=_vSujetos1;
  elseif (j>=24 && j<30)
    _vSujetos=_vSujetos2;
  elseif (j>=30 && j<32)
    _vSujetos=_vSujetos3;
  elseif (j>=32 && j<34)
    _vSujetos=_vSujetos4;
  elseif (j>=34)
    _vSujetos=_vSujetos5;
  else
    _vSujetos=_vSujetosNull;
  endif
  for i=_vSujetos
    %todo.(indice(j+1,:))(i)._respuestasEXP=[2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1];
   if i==1 && (j==4||j==23)
   todo.(indice(j+1,:))(i)._respuestasEXP=[2 2 2 0 0 2 2 2 2 2 2 2 2 2 2 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1];
   else
   todo.(indice(j+1,:))(i)._respuestasEXP=[2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
   endif
    %todo.(indice(j+1,:))(i)._respuestasEXP=[1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2];
    %todo.(indice(j+1,:))(i)._respuestasOPO=[1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2 1 2 2];
    todo.(indice(j+1,:))(i)._respuestasOPO=[2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
    %todo.(indice(j+1,:))(i)._respuestasOPO=[2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1];
  endfor
endfor



stdQ=[];

for i=1:_nSujetos
  aux=[];
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX;
  for j=primero:ultimo % experimentos
    aux=[aux;vec(matricesQxExp.(indiceSujeto(i,:)).(indice(j+1,:))')'];
    %reshape(ee,4,4)'
    %matricesQxExp.(indiceSujeto(i,:)).(indice(j+1,:))
  endfor
  v_std=std(aux,0);
  stdQ.(indiceSujeto(i,:))=reshape(v_std,4,4)';
  %plot(median(aux(:,6)))
  %hist (aux(:,6), 15, "facecolor", "r", "edgecolor", "b");
endfor
%matricesQxExp.Q01.
%std (x) = sqrt ( 1/(N-1) SUM_i (x(i) - mean(x))^2 )



for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX;
  figure()
  plot([primero:ultimo],T(i,primero:ultimo),'--ob',[primero:ultimo],C(i,primero:ultimo),'--or',[primero:ultimo],P(i,primero:ultimo),'-->k',[primero:ultimo],S(i,primero:ultimo),'--.m');
  xlabel("n de sesiones");
  ylabel("% Tasa de comportamientos");
  title(strcat("Estrategias probabilistica en iPD: ",_txtSujetos(i,:)));
  legend("T=D-C","C=C-C","P=D-D","S=C-D");
  grid on;
endfor

% HACER:   struct de T R P S para cada sujeto por sesion
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX;
  figure()
  plot([primero:ultimo],T(i,primero:ultimo),'--ob',[primero:ultimo],C(i,primero:ultimo),'--or',[primero:ultimo],P(i,primero:ultimo),'-->k',[primero:ultimo],S(i,primero:ultimo),'--.m');
  xlabel("n de sesiones");
  ylabel("% Tasa de comportamientos");
  title(strcat("Estrategias probabilistica en iPD: ",_txtSujetos(i,:)));
  legend("T=D-C","C=C-C","P=D-D","S=C-D");
  grid on;
endfor


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pasan=zeros(1,4);
frec_obs=zeros(4,2,_nSujetos);
for j=1:4 %Estados
  for i=1:_nSujetos
    if sum(probTotalN(j,:,i))!=0
      frec_obs(j,:,i)=probTotalN(j,:,i)./sum(probTotalN(j,:,i));
    endif
  endfor
endfor
_porX=100;
frec_teo= _porX*0.5
% P(c|T) prob
aa=zeros(1,_nSujetos);
for i=_sujetosCooperadores
  aa(i)=(_porX*frec_obs(1,1,i)-frec_teo).^2./frec_teo;
endfor
chi_2_coop = sum(aa(_sujetosCooperadores),3); 
% El chi2cdf(11.0705,5)=0.95 La funcion da P(X2 < x) inverso a la tabla
if (1-chi2cdf(chi_2_coop,5))<0.05 % Con correccion de Bonferroni 0.05/5
  pasan(1)=1;
endif


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aa=zeros(4,_nSujetos);
frec_teo=zeros(4,1,_nSujetos);
frec_teo= sum(probxExpTotal(:,:,:),2)./2;%     Se suman y div x 2 todos las eleciones luego de T
% componentes de la sumatoria  (Oi-Ei)^2/Ei
aa=(probxExpTotal(:,1,:)-frec_teo).^2./frec_teo;
% sumatoria del Chi 2
chi_2_coop = zeros(4,1);% sum(aa([1 2 4],1,_sujetosCooperadores),3)
chi_2_coop(1) = sum(aa(1,1,_sujetosCooperadores),3);
chi_2_coop(2) = sum(aa(2,1,_sujetosCooperadores),3);
chi_2_coop(3) = sum(aa(3,1,_sujetosCooperadores([2:4 6])),3); % SALVANDO ESTADOS DONDE NUCA SE REALIZARON ELECCIONES
chi_2_coop(4) = sum(aa(4,1,_sujetosCooperadores),3);

chi_2_coop
_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos); % Obtiene los indices de los no coop
chi_2_nocoop = sum(aa(:,1,_sujetosNocooperadores),3)

pasanCoop=zeros(1,4);
pasanNocoop=zeros(1,4);
% Sin correccion de Bonferroni
freedom=6;
for i=1:4
  if i==3 % Salvando la no existencia de estado P en sujetos 3A y 10A
    freedom=4-1;
  else
    freedom=6-1;
  endif
  if (1-chi2cdf(chi_2_coop(i),freedom))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanCoop(i)=1;% Se rechaza la HIP NULA
  endif
endfor

for i=1:4
  if (1-chi2cdf(chi_2_nocoop(i),freedom))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanNocoop(i)=1;% Se rechaza la HIP NULA
  endif
endfor
% Con Correccion de Bonferroni
pasanCoopBon=zeros(1,4);
pasanNocoopBon=zeros(1,4);
for i=1:4
  if i==3 % Salvando la no existencia de estado P en sujetos 3A y 10A
    freedom=4-1;
  else
    freedom=6-1;
  endif
  if (1-chi2cdf(chi_2_coop(i),freedom))<(0.05/(freedom+1)) %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanCoopBon(i)=1;% Se rechaza la HIP NULA
  endif
endfor

for i=1:4
  if (1-chi2cdf(chi_2_nocoop(i),freedom))<(0.05/(freedom+1)) %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanNocoopBon(i)=1;% Se rechaza la HIP NULA
  endif
endfor
% Da casi todo significativo, indicando que las probabilidades de eleción no provienen de problaciones aleatorias.


probEleccion=zeros(size(probxExpTotal));
for i=1:_nSujetos
  for j=1:4
    if sum(probxExpTotal(j,:,i),2)!=0
      probEleccion(j,:,i)=probxExpTotal(j,:,i)./sum(probxExpTotal(j,:,i),2);
    endif
  endfor
endfor
_txtSujetos=["1A";"2A";"3A";"4A";"5A";"6A";"7A";"8A";"9A";"10A";"3B";"4B"];
_colores=["--+k";"--om";"--*g";"--.r";"--xb";"--sc";"--^m";"--vg";"-->b";"--<c";"--pr";"--hr"];
figure;
for i=_sujetosCooperadores
  hold on;
  h=plot(probEleccion(:,1,i),_colores(i,:));
  set(h, "linewidth", 2);
endfor
plot(probEleccion(:,2,_sujetosCooperadores(5)),"--ok");
set(h, "linewidth", 1);
plot([.5 .5 .5 .5],"--r");
set(h, "linewidth", 2);  
legend(_txtSujetos(_sujetosCooperadores,:), 4);
xlabel("T=1 --- R=2 --- P=3 --- S=4");
ylabel("P(C|X)");
title("Probabilidad de elegir C dado cada estado");
hold off;

figure;
for i=_sujetosNocooperadores
  hold on;
  h=plot(probEleccion(:,1,i),_colores(i,:));
  set(h, "linewidth", 2);       
endfor
plot([.5 .5 .5 .5],"--r");
set(h, "linewidth", 2);  
legend(_txtSujetos(_sujetosNocooperadores,:));
xlabel("T=1 --- R=2 --- P=3 --- S=4");
ylabel("P(C|X)");
title("Probabilidad de elegir C dado cada estado- No alcanzaron Criterio");
hold off;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
freedomCoop=zeros(1,4);freedomNocoop=zeros(1,4);
_auxSujCoops=[]

_estados=["T";"R";"P";"S"];
for i=1:4
  _aux=[];
  for j=1:length(_sujetosCooperadores)
    if ~isnan(aa(i,1,_sujetosCooperadores(j))) % Salvando cuando el animal no estuvo en el estado X
      freedomCoop(i)++;
      _aux = [_aux, j];
    endif
  endfor
  _auxSujCoops.(_estados(i))=_aux
endfor



