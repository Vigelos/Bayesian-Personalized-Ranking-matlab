function auc_value = AUC(User,Item,interactionMatrix_test)
% 计算AUC值
Vsigmoid = @(x) 1/(1+exp(-x));

auc_value = 0;
count = size(interactionMatrix_test,1);
for user=1:size(interactionMatrix_test,1)
    auc_user = 0;
    positive_item = find(interactionMatrix_test(user,:)==1);
    if size(positive_item,2)==0
        count = count-1;
        continue;
    end
    negative_item = find(interactionMatrix_test(user,:)==0);
    for i=1:size(positive_item,2)
        for j=1:size(negative_item,2)
            auc_user = auc_user+Vsigmoid(User(user,:)*Item(:,i)-User(user,:)*Item(:,j));
        end
    end
    auc_user = auc_user/(size(positive_item,2)*size(negative_item,2));
    auc_value = auc_value + auc_user/count;
end

