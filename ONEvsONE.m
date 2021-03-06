function [HTr,HTe,STr,STe] = ONEvsONE(svm, hebb, X, y, X2, y2, Theta1, Theta2, desired_digit, second_digit, ...
    input_layer_size, hidden_layer_size, num_labels, k,HTr,HTe,STr,STe, I, xF,yF,x2F,y2F)

MTheta2 = Theta2;
sdi = 4*(second_digit); 
if (svm)
    %% ================= Part 7: Training SVM against 1 digit =================
    fprintf('\n Training with SVM type learning ...\n');
    Theta2 = SVMLearn(Theta1, Theta2, desired_digit, input_layer_size,...
                              hidden_layer_size, num_labels, xF, yF, k);

    %% =================  Prediction with SVM against 1 digit =================
    T1string = sprintf('S%d_%dTheta1',desired_digit,second_digit);
    T2string = sprintf('S%d_%dTheta2',desired_digit,second_digit);
    S = struct(T1string,Theta1,T2string,Theta2);
    save('OvMS.mat', '-struct', 'S', '-append');

    pred = predictSVM(Theta1, Theta2, xF);
    yP = yF == desired_digit;
    acc = mean(double(pred == yP)) * 100;
    pr = find(pred==1); ac = find(yP == 1);
    nPr = find(pred == 0); nAc = find(yP == 0);
    fprintf('\n ---- \n SVM Training Set Accuracy: %f\n', acc);
    % STr(second_digit+1,I) = acc;
    STr(1+sdi:1+sdi,I) = length(intersect(pr,ac));
    STr(2+sdi:2+sdi,I) = length(intersect(pr,nAc));
    STr(3+sdi:3+sdi,I) = length(intersect(nPr,ac));
    STr(4+sdi:4+sdi,I) = length(intersect(nPr,nAc));

    yP = y2F == desired_digit;
    pred = predictSVM(Theta1, Theta2, x2F);
    acc = mean(double(pred == yP)) * 100;
    pr = find(pred==1); ac = find(yP == 1);
    nPr = find(pred == 0); nAc = find(yP == 0);
    fprintf('\n SVM Test Set Accuracy: %f\n ---- \n', acc);
    % STe(second_digit+1,I) = acc;
    STe(1+sdi:1+sdi,I) = length(intersect(pr,ac));
    STe(2+sdi:2+sdi,I) = length(intersect(pr,nAc));
    STe(3+sdi:3+sdi,I) = length(intersect(nPr,ac));
    STe(4+sdi:4+sdi,I) = length(intersect(nPr,nAc));
    % fprintf('Program paused. Press enter to continue.\n');
    % pause;
end

%% ================= Training Hebb against 1 digit =================

Theta2 = MTheta2;

fprintf('\n Training with Hebbian type learning ...\n')
Theta2 = HebbLearn(Theta1, Theta2, desired_digit, input_layer_size, ...
                          hidden_layer_size, num_labels, xF, yF, k);


%% ================= Prediction with Hebb against 1 digit =================                  

T1string = sprintf('H%d_%dTheta1',desired_digit,second_digit);
T2string = sprintf('H%d_%dTheta2',desired_digit,second_digit);
S = struct(T1string,Theta1,T2string,Theta2);
save('OvOH.mat', '-struct', 'S', '-append');

pred = predictSVM(Theta1, Theta2, xF);
yP = yF == desired_digit;
acc = mean(double(pred == yP)) * 100;
pr = find(pred==1); ac = find(yP == 1);
nPr = find(pred == 0); nAc = find(yP == 0);
fprintf('\n ---- \nHebbian Training Set Accuracy: %f', acc);
% HTr(second_digit+1,I) = acc;
HTr(1+sdi:1+sdi,I) = length(intersect(pr,ac));
HTr(2+sdi:2+sdi,I) = length(intersect(pr,nAc));
HTr(3+sdi:3+sdi,I) = length(intersect(nPr,ac));
HTr(4+sdi:4+sdi,I) = length(intersect(nPr,nAc));

%% ================= Prediction with Hebb against 1 digit =================                  

T1string = sprintf('H%d_%dTheta1',desired_digit,second_digit);
T2string = sprintf('H%d_%dTheta2',desired_digit,second_digit);
S = struct(T1string,Theta1,T2string,Theta2);
save('OvOH.mat', '-struct', 'S', '-append');

pred = predictSVM(Theta1, Theta2, xF);
yP = yF == desired_digit;
acc = mean(double(pred == yP)) * 100;
pr = find(pred==1); ac = find(yP == 1);
nPr = find(pred == 0); nAc = find(yP == 0);
fprintf('\n ---- \nHebbian Training Set Accuracy: %f', acc);
% HTr(second_digit+1,I) = acc;
HTr(1+sdi:1+sdi,I) = length(intersect(pr,ac));
HTr(2+sdi:2+sdi,I) = length(intersect(pr,nAc));
HTr(3+sdi:3+sdi,I) = length(intersect(nPr,ac));
HTr(4+sdi:4+sdi,I) = length(intersect(nPr,nAc));

end