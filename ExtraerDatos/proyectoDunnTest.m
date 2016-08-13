_proporcionC=30*_cooperacion./(_trialsOK-_nada);
% los datos deben ser mayores a 5 para que el test funcione bien
x=[];
for i=1:length(_sujetosCooperadores)
  x=[x _proporcionC([expXsuj(_sujetosCooperadores(i))-9:expXsuj(_sujetosCooperadores(i))],_sujetosCooperadores(i))];
endfor
[pVal,k,DF]=kruskal_wallis_test(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),x(:,6),x(:,7))
                                
                                
% Post-hoc test: Dunn's test   
% son comparaciones de a pares para contratar si dos samples tieneprovienen de distribuciones
% diferentes                              
% Ti es la suma de los ranks del ith sample
% p cantidades de pares a contrastar
% ym valor del contrates
% n cantidad de componente de la sumatoria de Ti
% ym = sum(T1)/sum(n1)-sum(T2)/sum(n2)
% tau desviacion estandar
% tau=N(N+1)/12 *( 1/sum(n1) + 1/sum(n2) )
% N=sum(n) todos los ni
% 

% Diferencia entre la media de los rangos






