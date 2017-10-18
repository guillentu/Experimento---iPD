figure;
for i=_vSujetos(7:12)
%for i=_vSujetos(1:6)
  subplot(2,3,i-6);hold on;
  %subplot(2,3,i);hold on;
  Q2v=round(Q2.*10000)/100;
  scatter([2],[2],R_mean(i)*500,'o','linewidth',2)
  scatter([4],[4],T_mean(i)*500,'o','linewidth',2)
  scatter([6],[2],P_mean(i)*500,'o','linewidth',2)
  scatter([4],[0],S_mean(i)*500,'o','linewidth',2)
  text(-0.25+[2 4 6 4],[2 4 2 0],{'R';'T';'P';'S'},'fontsize',10)
  title(strcat('sujeto: ', _txtSujetos(i,:)))
  h=drawArrow([2*1.25,2*1.25,.85*4,.85*4],1.25,0.3,0.3);
  set(h.body,'linewidth',1,'color','r');
  set(h.wing,'linewidth',1,'color','r');
  h=drawArrow([4+.5,4-.5,6-.5,2+.5],1.25,0.3,0.3);
  set(h.body,'linewidth',1,'color','r');
  set(h.wing,'linewidth',1,'color','r');
  h=drawArrow([6-.5,2-.5,4+.5,0+.5],1.25,0.3,0.3);
  set(h.body,'linewidth',1);
  set(h.wing,'linewidth',1);
  h=drawArrow([4-.5,0+.5,2+.5,2-.5],1.25,0.3,0.3);
  set(h.body,'linewidth',1);
  set(h.wing,'linewidth',1);
  h=drawArrow([4-.25,4-1,4-.25,0+1],1.25,0.3,0.3);
  set(h.body,'linewidth',1);
  set(h.wing,'linewidth',1);
  h=drawArrow([4+.25,0+1,4+.25,4-1],1.25,0.3,0.3);
  set(h.body,'linewidth',1,'color','r');
  set(h.wing,'linewidth',1,'color','r');
  %h=drawArrow([2,2,4,3],0.5,0.1,0.1)
  %set(h.body,'linewidth',3)
  %set(h.wing,'linewidth',3)
  %h=drawArrow([2,2,4,3],0.5,0.1,0.1)
  %set(h.body,'linewidth',3)
  %set(h.wing,'linewidth',3)h=drawArrow([2,2,4,3],0.5,0.1,0.1)
  %set(h.body,'linewidth',3)
  %set(h.wing,'linewidth',3)
  %h=drawArrow([2,2,4,3],0.5,0.1,0.1)
  %set(h.body,'linewidth',3)
  %set(h.wing,'linewidth',3)


  fontSize=7;
  text(-2.3+[2],0.75+[2],num2str(Q2v(2,2,i)),'fontsize',fontSize) % R|R
  text(0.75+[6],0.75+[2],num2str(Q2v(3,3,i)),'fontsize',fontSize)  % P|P
  text(-0.5 +[2],1.15+[2],num2str(Q2v(2,1,i)),'fontsize',fontSize) % T|R 
  text(1.75+[4],-0.85+[4],num2str(Q2v(1,3,i)),'fontsize',fontSize) % P|T


  text(-1.25+[4],1+[1],num2str(Q2v(1,4,i)),'fontsize',fontSize) % S|T
  text(-.75+[6],-1.5+[2],num2str(Q2v(3,4,i)),'fontsize',fontSize) % S|P
  text(0.25+[4],-1+[3],num2str(Q2v(4,1,i)),'fontsize',fontSize) % T|S
  text(-2+[4],0.5+[0],num2str(Q2v(4,2,i)),'fontsize',fontSize) % R|S
  axis([-.5 8 -1 5])


  %ans(:,:,1) =
  %
  %   0.00000   0.00000   0.40000   0.60000
  %   0.10175   0.89825   0.00000   0.00000
  %   0.00000   0.00000   0.00000   1.00000
  %   0.10000   0.90000   0.00000   0.00000
endfor