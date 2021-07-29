function [U,I] = Vtrain(U,I,train_matrix,learning_rate,regulation_index)

% using bootstarp SGD
for i=1:size(train_matrix,1)
    
    user = randi([1,size(train_matrix,1)]);
    Uu = U(user,:);
    
    positive_item = find(train_matrix(user,:)==1);
    positive_item = positive_item(randi([1,size(positive_item,2)]));
    Ii = I(:,positive_item);
    
    negative_item = find(train_matrix(user,:)==0);
    negative_item = negative_item(randi([1,size(negative_item,2)]));
    Ij = I(:,negative_item);
    
    Xuij = Uu*Ii-Uu*Ij;
    
    prefix = -1/(1+exp(Xuij));
    
    Uu_new = Uu-learning_rate*(prefix*(Ii-Ij)'+Uu*regulation_index);
    Ii_new = Ii-learning_rate*(prefix*Uu'+Ii*regulation_index);
    Ij_new = Ij-learning_rate*(prefix*(-Uu)'+Ij*regulation_index);
    
    U(user,:) = Uu_new;
    I(:,positive_item) = Ii_new;
    I(:,negative_item) = Ij_new;

end