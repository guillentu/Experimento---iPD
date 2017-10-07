clear all
load('datos_coop_reward_T2.mat')
load('datos_coop_reward_T2r.mat')
semXsujeto_T2=[0.0330357 0.0246043 0.0034483 0.0551389 0.0311519 0.0348078 0.0307117...
    0.0256952 0.0268878   0.0033333 0.0357149 0.0133442];

%fin=[21 33 23 23 23 31 23 50 31 29 33 23];
fin=[21 33 23 23 23 31 23 50 31 29 33 23];
figure();
hold on;
n=21;
media_last_T2=zeros(1,n);
sem_last_T2=zeros(1,n);
aux=zeros(n,4);
j=0;
for i=[3 7 9 10]
   j=j+1;
   aux(:,j)=promediosC_T2(fin(i)-n+1:fin(i),i);
end
media_last_T2=mean(aux,2)
sem_last_T2=std(aux',1)'./sqrt(length([1 3 7 8 9 10 11 12]));
niceBars([1:n],media_last_T2',sem_last_T2',[1 0 0],0.5)


finRev=[0    0   44    0    0    0   44    0   36   18    0   42];
figure();
hold on;
nr=18;
media_last_T2r=zeros(1,nr);
sem_last_T2r=zeros(1,nr);
auxr=zeros(nr,4);
j=0;
for i=[3 7 9 10]
   j=j+1;
   auxr(:,j)=promediosC_T2r(finRev(i)-nr+1:finRev(i),i);
end
media_last_T2r=mean(auxr,2)
sem_last_T2r=std(auxr',1)'./sqrt(length([3 79 10]));
niceBars([1:nr],media_last_T2r',sem_last_T2r',[1 0 0],0.5)


figure;hold on;
niceBars([1:n],media_last_T2',sem_last_T2',[0 0 1],0.5)
niceBars(n+[1:nr],media_last_T2r',sem_last_T2r',[1 0 0],0.5)

