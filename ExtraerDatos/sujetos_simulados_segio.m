%clear all
%close all
color=['r';'b';'r';'b';'r';'b';'r';'b';'r';'b'];
%figure;
for Cc=[0.4 0.5 0.6 0.7 0.8 0.9]
  Nn=30;    %%% jugadas
  %Cc=0.7;      %%% prob apretar palanca Coopera
  Ss=[ones(ceil(Nn*Cc),1);zeros(floor(Nn*(1-Cc)),1)];
  
  M=[1 2;8 4];  %%% [CC DC;CD DD]
   
  for iter=1:10000;
      Ss(randperm(length(Ss)))=Ss;
      TFT=[1;Ss(1:end-1)];
      aux=10*Ss+TFT;
      CCc=length(find(aux==11));
      CDd=length(find(aux==10));
      DCc=length(find(aux==1));
      DDd=length(find(aux==0));
      Rr(iter)=CCc*M(1,1)+CDd*M(1,2);
      TO(iter)=DCc*M(2,1)+DDd*M(2,2);
  end

  foodLimit=(Nn-1)*M(1,1)+M(1,2);
  timeoutLimit=(Nn/2)*8; 
  %figure;
  hold on;
  scatter(-1*(TO-Nn*5)/(timeoutLimit),Rr/(foodLimit),1000,color(Cc*10,:));
  hold off;
endfor
