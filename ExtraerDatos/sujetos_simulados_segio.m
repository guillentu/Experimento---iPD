%clear all
%close all

Nn=1000;    %%% jugadas
Cc=0.7;      %%% prob apretar palanca Coopera
Ss=[ones(ceil(Nn*Cc),1);zeros(floor(Nn*(1-Cc)),1)];
M=[1 2;8 4];  %%% [CC DC;CD DD]
 
for iter=1:10000;
    Ss(randperm(Nn))=Ss;
    TFT=[1;Ss(1:end-1)];
    aux=10*Ss+TFT;
    CCc=length(find(aux==11));
    CDd=length(find(aux==10));
    DCc=length(find(aux==1));
    DDd=length(find(aux==0));
    Rr(iter)=CCc*M(1,1)+CDd*M(1,2);
    TO(iter)=DCc*M(2,1)+DDd*M(2,2);
end

%figure;
hold on;
scatter(TO,Rr,'m')
hold off;