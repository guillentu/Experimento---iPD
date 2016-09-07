
% cuanto comen por cada eventos
voluntadDfood=zeros(length(_dejarD),nfields(todo),_nSujetos);
voluntadCfood=zeros(length(_dejarC),nfields(todo),_nSujetos);
for i=1:_nSujetos
  for j=1:expXsuj(i) 
    auxfoodD=voluntad(1:30,j ,i)'*2;
    if voluntad(31,j ,i)>=1 % |11..12..
      auxfoodD=[auxfoodD 2];
    else
      auxfoodD=[auxfoodD 0];
    endif
    if voluntad(32,j ,i)>=1 % ..211..1|
      auxfoodD=[auxfoodD 2];
    else
      auxfoodD=[auxfoodD voluntad(32,j ,i)*2];
    endif
    %sum(auxfoodD)
    voluntadDfood(:,j,i)=auxfoodD;
    auxfoodC=[];
    auxfoodC=voluntadC(1:31,j ,i)'.*([0:29 1]);
    if voluntadC(32,j ,i)>=1
      auxfoodC=[auxfoodC voluntadC(32,j ,i)-1];
    else
      auxfoodC=[auxfoodC voluntadC(32,j ,i)];
    endif
    voluntadCfood(1:32,j,i)=auxfoodC;
    %sum(auxfoodC)
    if sum(auxfoodD)+sum(auxfoodC)==food(j,i)
    else
      printf("Sujeto:%d , Exp:%d - food:%d != suma:%d error\n",i,j,food(j,i),sum(auxfoodD)+sum(auxfoodC));
    endif
      %strcat(strcat(sum(auxfoodD)+sum(auxfoodC)," - "),food(j,i))
  endfor
endfor
