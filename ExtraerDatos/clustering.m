%IDX=zeros(12,20);
%CENTERS=zeros(2,2,20);

[IDX CENTERS ]=kmeans([_mediaXsujeto(I);_alimento(I)]',2);

figure;
scatter(_mediaXsujeto(I(IDX==1)),_alimento(I(IDX==1)),15,'r','filled');
hold on
scatter(_mediaXsujeto(I(IDX==2)),_alimento(I(IDX==2)),15,'b','filled');
plot(CENTERS(2,1),CENTERS(2,2),'gx','markersize',20,'linewidth',3);
plot(CENTERS(1,1),CENTERS(1,2),'gx','markersize',20,'linewidth',3);
hold off

