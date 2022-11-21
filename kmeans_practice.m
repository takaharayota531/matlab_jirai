clc;clear all;


load fisheriris
X = meas(:,3:4);

figure;
plot(X(:,1),X(:,2),'k*','MarkerSize',5);
title 'fisher''s Iris Data '
xlabel('petal length');
ylabel('petal width');
%% kmeans 
rng(1); % For reproducibility
[idx,C] = kmeans(X,3);

%% meshgrid

x1 = min(X(:,1)):0.01:max(X(:,1));
x2 = min(X(:,2)):0.01:max(X(:,2));
[x1G,x2G] = meshgrid(x1,x2);
XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot
idx2Region=kmeans(XGrid,3,'MaxIter',1,'Start',C);


%%
figure;
gscatter(XGrid(:,1),XGrid(:,2),idx2Region,...
    [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
hold on;
plot(X(:,1),X(:,2),'k*','MarkerSize',5);
title 'Fisher''s Iris Data';
xlabel 'Petal Lengths (cm)';
ylabel 'Petal Widths (cm)'; 
legend('Region 1','Region 2','Region 3','Data','Location','SouthEast');
hold off;

%% kmeans

rng default;
x_clustering=[randn(100,2)*0.75+ones(100,2);randn(100,2)*0.5-ones(100,2)];

figure;
plot(x_clustering(:,1),x_clustering(:,2),'.');
title ('random generated data');

%% result plot
opts=statset('Display','final');
[idx,C]=kmeans(x_clustering,3,'Distance','cityblock','Replicates',10,'Options',opts);

%% plot
figure;
plot(x_clustering(idx==1,1),x_clustering(idx==1,2),'r.','MarkerSize',12)
hold on
plot(x_clustering(idx==2,1),x_clustering(idx==2,2),'b.','MarkerSize',12)
hold on
plot(x_clustering(idx==3,1),x_clustering(idx==3,2),'g.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off



