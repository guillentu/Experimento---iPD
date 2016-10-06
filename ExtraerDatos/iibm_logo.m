figure;
a=.5; % factor de escala
b=1.4;% cuan fuerte se desenrolla
phi=0:pi/20:3*pi;
x=a.*b.^phi.*cos(phi);
y=-a.*b.^phi.*sin(phi);
scatter(x,y,0.8.*[1:length(x)])