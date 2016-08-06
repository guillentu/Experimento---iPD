_proporcionC=30*_cooperacion./(_trialsOK-_nada);

[pVal,k,DF]=kruskal_wallis_test(_proporcionC(1:expXsuj(1),_sujetosCooperadores(1)),
                                %_proporcionC(1:expXsuj(2),_sujetosCooperadores(2)),
                                %_proporcionC(1:expXsuj(3),_sujetosCooperadores(3)),
                                %_proporcionC(1:expXsuj(4),_sujetosCooperadores(4)),
                                _proporcionC(1:expXsuj(5),_sujetosCooperadores(5)),
                                %_proporcionC(1:expXsuj(6),_sujetosCooperadores(6)),
                                _proporcionC(1:expXsuj(7),_sujetosCooperadores(7)))
                                
                                
% Ti es la suma de los ranks del ith sample
% p cantidades de pares a contrastar
% ym valor del contrates
% n cantidad de componente de la sumatoria de Ti
% ym = sum(T1)/sum(n1)-sum(T2)/sum(n2)
% tau desviacion estandar
% tau=N(N+1)/12 *( 1/sum(n1) + 1/sum(n2) )
% N=sum(n) todos los ni
% 
