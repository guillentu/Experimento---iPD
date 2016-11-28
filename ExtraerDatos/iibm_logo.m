figure;
a=1; % factor de escala
%b=1.5;% cuan fuerte se desenrolla
tita=(1+sqrt(5))/2;
b=log(tita)/(pi/2);
phi=0:pi/25:4*pi+pi/10;
x=a.*exp(b*phi).*cos(phi);
y=a.*exp(b*phi).*sin(phi);
rot=pi/2;
R=[cos(rot) -sin(rot);sin(rot) cos(rot)];

xy_rot=R*[x; y];

scatter(-xy_rot(1,:),xy_rot(2,:),0.8.*([1:length(x)]).^(2/3),"filled");

