%-------------------------------------------------------------------
%------- Alternar Random - Control ITI - Castigo
indice=["exp00";"exp01";"exp02";"exp03";"exp04";"exp05";
        "exp06";"exp07";"exp08";"exp09";"exp10";"exp11";
        "exp12";"exp13";"exp14";"exp15";"exp16";"exp17";
        "exp18";"exp19";"exp20";"exp21";"exp22";"exp23"];
%				"exp24";"exp25";"exp26";"exp27";"exp28";"exp29";
%				"exp30";"exp31";"exp32";"exp33";"exp34";"exp35";
%				"exp36";"exp37";"exp38";"exp39";"exp40"];

%todo.exp00=exp00;
todo.exp01=exp01;todo.exp02=exp02;todo.exp03=exp03;todo.exp04=exp04;todo.exp05=exp05;
todo.exp06=exp06;todo.exp07=exp07;todo.exp08=exp08;todo.exp09=exp09;todo.exp10=exp10;
todo.exp11=exp11;todo.exp12=exp12;todo.exp13=exp13;todo.exp14=exp14;todo.exp15=exp15;
todo.exp16=exp16;todo.exp17=exp17;todo.exp18=exp18;todo.exp19=exp19,todo.exp20=exp20;
todo.exp21=exp21;todo.exp22=exp22;todo.exp23=exp23;
%todo.exp24=exp24;todo.exp25=exp25;todo.exp26=exp26;todo.exp27=exp27;
%todo.exp28=exp28;todo.exp29=exp29;todo.exp30=exp30;todo.exp31=exp31;todo.exp32=exp32;
%todo.exp33=exp33;todo.exp34=exp34;todo.exp35=exp35;todo.exp36=exp36;todo.exp37=exp37;todo.exp38=exp38;todo.exp39=exp39;todo.exp40=exp40;
%todo.exp=exp;

% PORCENTAJE DE COOPERACION
_nSujetos=12;
_coop=zeros(1,_nSujetos);
_cooperacion=[];
_nada=[];
_nadaAux=zeros(1,_nSujetos);
inicio=1;
fin=23;
datos=zeros(2,fin);
for j=inicio:fin
  for i=1:_nSujetos
    _coop(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(1:30)==2));
  endfor
  _cooperacion=[_cooperacion; _coop];
  for i=1:_nSujetos
    _nadaAux(i)=length(find(todo.(indice(j+1,:))(i)._respuestasEXP(1:30)==0));
  endfor
  _nada=[_nada; _nadaAux];
  
endfor
_cooperacion=_cooperacion';
_trialsOK=30*ones(length([inicio:fin]),_nSujetos);
_promediosC=_cooperacion./(_trialsOK'-_nada');
_media=sum(_promediosC)/_nSujetos;
%Media  ARREGLAR LA SUMA SIN LOS NADA
%mediaG=sum(_cooperacion)/(_nSujetos*30-sum(_nada));

%media sin 1A
%media=sum((_cooperacion([2 3 4 5 6],:)./(5*30)));

figure();
plot([inicio:fin],_promediosC(1,:),'--+k',[inicio:fin],_promediosC(2,:),'--ok',[inicio:fin],_promediosC(3,:),'--*g',[inicio:fin],_promediosC(4,:),'--.g',[inicio:fin],_promediosC(5,:),'--xb',[inicio:fin],_promediosC(6,:),'--sb',[inicio:fin],_promediosC(7,:),'--^m',[inicio:fin],_promediosC(8,:),'--vm',[inicio:fin],_promediosC(9,:),'-->c',[inicio:fin],_promediosC(10,:),'--<c',[inicio:fin],_promediosC(11,:),'--pr',[inicio:fin],_promediosC(12,:),'--hr',[inicio:fin],_media,"r")
xlabel("n de sesiones");
ylabel("% de cooperacion");
title("Cooperacion en iPD");
legend('1A','2A','3A','4A','5A','6A','7A','8A','9A','10A','3B','4B');
grid on

% Promedio de cooperacion sin outlayers



indiceSujeto=[];
for i=1:_nSujetos
  indiceSujeto=[indiceSujeto;strcat("Q",mat2str(i))];
endfor
% Probabilidades de transicion de estados
matricesQ=[];
Q = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
for i=1:_nSujetos
  matricesQ.(indiceSujeto(i,:)) = zeros(4,4); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
endfor
% 
% Brief: Carga las matrices de transicion de estado de cada sujeto. 
%        Acumula las veces que aparece la transicion durante los 29 trials a lo
%        largo los inicio:fin de experimentos.
T=zeros(_nSujetos,length(inicio:fin));C=zeros(_nSujetos,length(inicio:fin));
P=zeros(_nSujetos,length(inicio:fin));S=zeros(_nSujetos,length(inicio:fin));
controlFallas=zeros(1,_nSujetos);
auxFallas=1;
for j=inicio:fin
  for i=1:_nSujetos
    for k=1:30  % nºtrials x Exp.  TRAICIONAR DADO QUE
      if (todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)
        if (k==1)
          k=3
          i
          ++controlFallas(i);
        else
          auxFallas=2;
          ++controlFallas(i);
        endif
      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==2)
        T(i,j-inicio+1)++; %TRAICIONAR DADO :
        if (k>1) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
            ++matricesQ.(indiceSujeto(i,:))(1,1); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
            ++matricesQ.(indiceSujeto(i,:))(1,2); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
            ++matricesQ.(indiceSujeto(i,:))(1,3);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++matricesQ.(indiceSujeto(i,:))(1,4); 
          endif  
        endif
        auxFallas=1;
      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==2)
        C(i,j-inicio+1)++; % COOPERACION MUTUA DADO :
        if (k>1) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
            ++matricesQ.(indiceSujeto(i,:))(2,1); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
            ++matricesQ.(indiceSujeto(i,:))(2,2);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
            ++matricesQ.(indiceSujeto(i,:))(2,3);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++matricesQ.(indiceSujeto(i,:))(2,4); 
          endif
        endif
        auxFallas=1;
      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)=1)
        P(i,j-inicio+1)++; % NO COOPERACION MUTUA DADO :
        if (k>1) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %que Traiciono (imposible x TFT)%
            ++matricesQ.(indiceSujeto(i,:))(3,1); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%Cooperacion mutua%
            ++matricesQ.(indiceSujeto(i,:))(3,2); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
            ++matricesQ.(indiceSujeto(i,:))(3,3);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++matricesQ.(indiceSujeto(i,:))(3,4); 
          endif
        endif
        auxFallas=1;
      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k)==1)
        S(i,j-inicio+1)++; % TRAICIONAR DADO :
        if (k>1) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
            ++matricesQ.(indiceSujeto(i,:))(4,1); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%Cooperacion mutua%
            ++matricesQ.(indiceSujeto(i,:))(4,2); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
            ++matricesQ.(indiceSujeto(i,:))(4,3);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++matricesQ.(indiceSujeto(i,:))(4,4); 
          endif
        endif
        auxFallas=1;
      endif
    endfor
    auxFallas=1;
  endfor
endfor

%                                        uno menos por en elprimer trial no cuenta
Q(:,:,1)=matricesQ.(indiceSujeto(1,:))./(29*(fin-inicio+1)-controlFallas(1));
Q(:,:,2)=matricesQ.(indiceSujeto(2,:))./(29*(fin-inicio+1)-controlFallas(2));
Q(:,:,3)=matricesQ.(indiceSujeto(3,:))./(29*(fin-inicio+1)-controlFallas(3));
Q(:,:,4)=matricesQ.(indiceSujeto(4,:))./(29*(fin-inicio+1)-controlFallas(4));
Q(:,:,5)=matricesQ.(indiceSujeto(5,:))./(29*(fin-inicio+1)-controlFallas(5));
Q(:,:,6)=matricesQ.(indiceSujeto(6,:))./(29*(fin-inicio+1)-controlFallas(6));
Q(:,:,7)=matricesQ.(indiceSujeto(7,:))./(29*(fin-inicio+1)-controlFallas(7));
Q(:,:,8)=matricesQ.(indiceSujeto(8,:))./(29*(fin-inicio+1)-controlFallas(8));
Q(:,:,9)=matricesQ.(indiceSujeto(9,:))./(29*(fin-inicio+1)-controlFallas(9));
Q(:,:,10)=matricesQ.(indiceSujeto(10,:))./(29*(fin-inicio+1)-controlFallas(10));
Q(:,:,11)=matricesQ.(indiceSujeto(11,:))./(29*(fin-inicio+1)-controlFallas(11));
Q(:,:,12)=matricesQ.(indiceSujeto(12,:))./(29*(fin-inicio+1)-controlFallas(12));

Qmean=mean(Q,3);
Qmedian=median(Q,3);
Qvar=var(Q,0,3);
%Falta la median y variancia de Q

% VER COMO OBTENER LA MATRIZ DE ESTADO DE MARKOV

T(:,:)=T(:,:)/30;C(:,:)=C(:,:)/30;P(:,:)=P(:,:)/30;S(:,:)=S(:,:)/30;
figure();
plot([inicio:fin],T(1,:),'--+b',[inicio:fin],T(2,:),'--ob',[inicio:fin],T(3,:),'--+g',[inicio:fin],T(4,:),'--og',[inicio:fin],T(5,:),'--+m',[inicio:fin],T(6,:),'--om',[inicio:fin],T(7,:),'--+r',[inicio:fin],T(8,:),'--or',[inicio:fin],T(9,:),'--+c',[inicio:fin],T(10,:),'--oc',[inicio:fin],T(11,:),'--ok',[inicio:fin],T(12,:),'--+k')
xlabel("n de sesiones");
ylabel("% de estados T = D-C");
title("Tasa de ocurrencia de estado T en iPD&TFT");
legend('1A','2A','3A','4A','5A','6A','7A','8A','9A','10A','11A','12A','3B','4B');
grid on
figure();
plot([inicio:fin],C(1,:),'--+b',[inicio:fin],C(2,:),'--ob',[inicio:fin],C(3,:),'--+g',[inicio:fin],C(4,:),'--og',[inicio:fin],C(5,:),'--+m',[inicio:fin],C(6,:),'--om',[inicio:fin],C(7,:),'--+r',[inicio:fin],C(8,:),'--or',[inicio:fin],C(9,:),'--+c',[inicio:fin],C(10,:),'--oc',[inicio:fin],C(11,:),'--ok',[inicio:fin],C(12,:),'--+k')
xlabel("n de sesiones");
ylabel("% de estados C = C-C");
title("Tasa de ocurrencia de estado C en iPD&TFT");
legend('1A','2A','3A','4A','5A','6A','7A','8A','9A','10A','11A','12A','3B','4B');
grid on
figure();
plot([inicio:fin],P(1,:),'--+b',[inicio:fin],P(2,:),'--ob',[inicio:fin],P(3,:),'--+g',[inicio:fin],P(4,:),'--og',[inicio:fin],P(5,:),'--+m',[inicio:fin],P(6,:),'--om',[inicio:fin],P(7,:),'--+r',[inicio:fin],P(8,:),'--or',[inicio:fin],P(9,:),'--+c',[inicio:fin],P(10,:),'--oc',[inicio:fin],P(11,:),'--ok',[inicio:fin],P(12,:),'--+k')
xlabel("n de sesiones");
ylabel("% de estados P = D-D");
title("Tasa de ocurrencia de estado P en iPD&TFT");
legend('1A','2A','3A','4A','5A','6A','7A','8A','9A','10A','11A','12A','3B','4B');
grid on
figure();
plot([inicio:fin],S(1,:),'--+b',[inicio:fin],S(2,:),'--ob',[inicio:fin],S(3,:),'--+g',[inicio:fin],S(4,:),'--og',[inicio:fin],S(5,:),'--+m',[inicio:fin],S(6,:),'--om',[inicio:fin],S(7,:),'--+r',[inicio:fin],S(8,:),'--or',[inicio:fin],S(9,:),'--+c',[inicio:fin],S(10,:),'--oc',[inicio:fin],S(11,:),'--ok',[inicio:fin],S(12,:),'--+k')
xlabel("n de sesiones");
ylabel("% de estados S = D-C");
title("Tasa de ocurrencia de estado S en iPD&TFT");
legend('1A','2A','3A','4A','5A','6A','7A','8A','9A','10A','11A','12A','3B','4B');
grid on

% Falta Promediar las diferentes estados T C P S


% Grafico de quien palanqueo primero
% Grafico de probabilidades sobre palanqueo primero dado que C, T, P o S


