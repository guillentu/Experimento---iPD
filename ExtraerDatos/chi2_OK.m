%load datos_exp_R1T2

%% PARA LA MEDIA DE TODOS los SUJETOS COOPERADORES
sujetos=[1 3 7 8 9 10 11 12];
sujetos=[2 4 5 6];
scale=1;
auxC=sum(scale*probEleccionC(:,sujetos),2)
auxD=sum(scale*probEleccionD(:,sujetos),2)
auxC=scale*[.5 .5 .5 .5]';
auxD=scale*[.5 .5 .5 .5]';
marg_col=auxC+auxD;
marg_fila=[sum(auxC) sum(auxD)];
frecC_e=marg_col.*marg_fila(1)./sum(marg_col);
frecD_e=marg_col.*marg_fila(2)./sum(marg_col);

chi2_total=sum(((auxC-frecC_e).^2)./frecC_e) + sum(((auxD-frecD_e).^2)./frecD_e)
df=3;
1-chi2cdf(chi2_total,df)

chi2val(0.05,df)


auxC=[];
auxD=[];probxExpTotal(:,1,1)
for i=1:1
  auxC=probxExpTotal(:,1,1); % Suma de los ultimos X sesiones 
  auxD=probxExpTotal(:,2,1);
  marg_col=auxC+auxD;
  marg_fila=[sum(auxC) sum(auxD)];
  
  frecC_e=marg_col.*marg_fila(1)./sum(marg_col)
  frecC_e=marg_col.*marg_fila(2)./sum(marg_col)
  chi2_total=sum(((auxC-frecC_e).^2)./frecC_e) + sum(((auxD-frecD_e).^2)./frecD_e)
  
  
endfor