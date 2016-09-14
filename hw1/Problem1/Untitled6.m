p = rand(10,2);
scatter(p(:,1), p(:,2), 'filled')
axis([0 1 0 1])

labels = num2str((1:size(p,1))','%d');    %'
text(p(:,1), p(:,2), labels, 'horizontal','left', 'vertical','bottom')