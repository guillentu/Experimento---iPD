%%%% DIFERENCIS ENTRE matris 1/3 y 2/3 - tres sujetos
clear all;
load '/home/guille/Documents/github_Repository/experimento/Experimento---iPD/ExtraerDatos/datos_coop_reward_T2.mat';

load('/home/guille/Documents/github_Repository/experimento/Experimento-Meli--iPD/datos_coop_reward_T3.mat');

load('/home/guille/Documents/github_Repository/experimento/Experimento-Meli--iPD/datos_coop_reward_T5.mat');

figure;
hold on
plot(promediosC_T3(:,[2 5 6]))
plot(26+[1:14],promediosC_T5([1:14],[2 5 6]))

figure;hold on;
auxT3=[];
auxT5=[];
for i=1:6
   if (2==i)||(5==i)||(6==i)
    auxT3(i)=mean(promediosC_T3(23:27,i));
    auxT5(i)=mean(promediosC_T5(10:14,i));
   else
    auxT3(i)=mean(promediosC_T3(14:18,i));
    auxT5(i)=mean(promediosC_T5(13:17,i));
   end
end
bar(auxT3)

figure;plot([promediosC_T3(23:27,[5]); promediosC_T5(10:14,[5])])
figure;plot([promediosC_T3(23:27,[6]); promediosC_T5(10:14,[6])])
figure;plot([promediosC_T3(23:27,[2]); promediosC_T5(10:14,[2])])

X=[ promediosC_T3(23:27,[2 5]) ];

kruskalwallis([ promediosC_T3(23:27,[2]) promediosC_T5(10:14,[2]) ])
kruskalwallis([ promediosC_T3(23:27,[5]) promediosC_T5(10:14,[5]) ])
kruskalwallis([ promediosC_T3(23:27,[6]) promediosC_T5(10:14,[6]) ])


ranksum(promediosC_T3(23:27,[2]), promediosC_T5(10:14,[2]))
ranksum(promediosC_T3(23:27,[5]), promediosC_T5(10:14,[5]))
ranksum(promediosC_T3(23:27,[6]), promediosC_T5(10:14,[6]))


ranksum([promediosC_T3(23:27,2);promediosC_T3(23:27,5);promediosC_T3(23:27,6)],[promediosC_T5(10:14,2);promediosC_T5(10:14,5);promediosC_T5(10:14,6)])
ranksum([promediosC_T3(23:27,2);promediosC_T3(23:27,6)],[promediosC_T5(10:14,2);promediosC_T5(10:14,6)])


friedman(promediosC_T3(23:27,[2 5 6]),promediosC_T5(10:14,[2 5 6]))

ttest2(promediosC_T3(23:27,[2 5 6]),promediosC_T5(10:14,[2 5 6]))
% Cooperacion
ranksum(mean(promediosC_T3(23:27,[2 6]),2),mean(promediosC_T5(10:14,[2 6]),2)) % Sujeto 2 y 6 dan significativo entre 1/3 y 2/3
ranksum(mean(promediosC_T3(23:27,[2 6]),1),mean(promediosC_T5(10:14,[2 6]),1))

figure;hold on;
xx=[mean(promediosC_T3(23:27,[2 5 6]),1)' mean(promediosC_T5(10:14,[2 5 6]),1)']
xxSem=[(std(promediosC_T3(23:27,[2 5 6]),1)./sqrt(5))' (std(promediosC_T5(10:14,[2 5 6]),1)./sqrt(5))']
plot([1 2],xx(1,:),'--ob');
errorbar([1 2],xx(1,:),xxSem(1,:),'--ob');
plot([1 2],xx(2,:),'--or');
errorbar([1 2],xx(2,:),xxSem(2,:),'--ob');
plot([1 2],xx(3,:),'--og');
errorbar([1 2],xx(3,:),xxSem(3,:),'--ob');
axis([])
%plot([2 2 2],mean(promediosC_T5(10:14,[2 5 6]),1)','or');

aux=mean(mean(promediosC_T3(23:27,[2 6]),1));
auxSem=std(mean(promediosC_T3(23:27,[2 6]),1))./sqrt(2);
aux2=mean(mean(promediosC_T5(10:14,[2 6]),1));
aux2Sem=std(mean(promediosC_T5(10:14,[2 6]),1))./sqrt(2);
figure;hold on;
errorbar([1; 2],[aux; aux2],[auxSem;aux2Sem],'.')
bar([1; 2],[aux; aux2])
title('cooperacion 2S 1T 2T en 1/3 -> 2/3')
axis([0 3 0.3 0.8])
aa=promediosC_T3(23:27,[2 6])
bb=promediosC_T5(10:14,[2 6])
ranksum(aa(:),bb(:))
% Cooperacion 1/3 1/5   % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;hold on;
xx=[mean(promediosC_T3(14:18,[1 3 4]),1)' mean(promediosC_T5(13:17,[1 3 4]),1)']
xxSem=[(std(promediosC_T3(14:18,[1 3 4]),1)./sqrt(5))' (std(promediosC_T5(13:17,[1 3 4]),1)./sqrt(5))']
plot([1 2],xx(1,:),'--ob');
errorbar([1 2],xx(1,:),xxSem(1,:),'--ob');
plot([1 2],xx(2,:),'--or');
errorbar([1 2],xx(2,:),xxSem(2,:),'--ob');
plot([1 2],xx(3,:),'--og');
errorbar([1 2],xx(3,:),xxSem(3,:),'--ob');
axis([])

aux=mean(mean(promediosC_T3(14:18,[1 3 4]),1));
auxSem=std(mean(promediosC_T3(14:18,[1 3 4]),1))./sqrt(2);
aux2=mean(mean(promediosC_T5(13:17,[1 3 4]),1));
aux2Sem=std(mean(promediosC_T5(13:17,[1 3 4]),1))./sqrt(2);
figure;hold on;
errorbar([1; 2],[aux; aux2],[auxSem;aux2Sem],'.')
bar([1; 2],[aux; aux2])
axis([0 3 0.3 1])

ranksum(mean(promediosC_T3(14:18,[1 3 4])),mean(promediosC_T5(13:17,[1 3 4])))
aa=promediosC_T3(14:18,[1 3 4]);
bb=promediosC_T5(13:17,[1 3 4]);
ranksum(aa(:),bb(:))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
bar([mean(aux), mean(aux2)])
axis([0 3 0.4 0.7])

title('cooperacion 2S 1T 2T en 1/3 -> 2/3')

aux=45*mean(food_T3(23:27,[2 5 6]),1);
aux2=60*mean(food_T5(10:14,[2 5 6]),1);
figure;
bar([aux(1),aux2(1),aux(2),aux2(2),aux(3),aux2(3)])
title('reward 2S 1T 2T en 1/3 -> 2/3')
figure;
bar([mean(aux),mean(aux2)])
axis([0 3 25 50])

ttest2(45*food_T3(23:27,[2 5 6]),60*food_T5(10:14,[2 5 6]))
ranksum(45*food_T3(23:27,[2]), 60*food_T5(10:14,[2]))
ranksum(45*food_T3(23:27,[5]), 60*food_T5(10:14,[5]))
ranksum(45*food_T3(23:27,[6]), 60*food_T5(10:14,[6]))

[H,P]=ranksum(30*aaT3,30*aaT5)

[H,P]=ttest(30*aaT3,30*aaT5)
[H,P]=ttest(aaT3,mean(aaT5))  % no da
[H,P]=ttest(aaT5,mean(aaT3))  % SI DA significativo


figure;plot(1:5,aaT3','--.b',1:5, aaT5','--.r')

auxT3=[promediosC_T3(23:27,2);promediosC_T3(23:27,5);promediosC_T3(23:27,6)];
auxT5=[promediosC_T5(10:14,2);promediosC_T5(10:14,5);promediosC_T5(10:14,6)];
[H,P]=ttest(auxT3,auxT5)
[H,P]=ttest(auxT3,mean(auxT5))
[H,P]=ttest(auxT5,mean(auxT3))
kstest(auxT3)

i=1;p=signtest(promediosC_T3(22+1,[2 5 6]),promediosC_T5(9+1,[2 5 6]))

figure;hold on;
scatter(promediosC_T3(23:27,[2]),promediosC_T5(10:14,[2]),'b','filled')
scatter(promediosC_T3(23:27,[5]),promediosC_T5(10:14,[5]),'r','filled')
scatter(promediosC_T3(23:27,[6]),promediosC_T5(10:14,[6]),'g','filled')
axis([.32 0.9 .32 .9])

figure;hold on;
scatter(mean(promediosC_T3(23:27,[2 6])),mean(promediosC_T5(10:14,[2 6])),'b','filled')

axis([.5 0.8 .5 .8])
ranksum(promediosC_T3(23:27,[2]),mean(promediosC_T5(10:14,[2])))

%%%%%%%%%%%%%%% SERGIO %%%%%%%%%%%%%%%%%%%%%%
eeT3=promediosC_T3(23:27,[2 6]);
eeT5=promediosC_T5(10:14,[2 6]);
Y=[eeT3(:) ; eeT5(:)];
aux_S=(1:2)'*ones(1,5);
S=[aux_S(:);aux_S(:)];
F1=[ones(length(Y)/2,1);2*ones(length(Y)/2,1)];     %%% LO / HI
auxF2=ones(size(eeT3,1),1)*(1:size(eeT3,2));     %%% Time
F2=[auxF2(:);auxF2(:)];
stats = rm_anova2(Y,S,F1,F2,{'1', '2'})
