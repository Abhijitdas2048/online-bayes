function [PredictedClass,Posterior] = NBPredict(NB,TestSamples)

[NoOfClasses,NoOfFeatures] = size(NB);
Posterior = [];
PredictedClass = [];
NoOfTestSamples = 1;%size(TestSamples,1);

%Find the posterior of all the samples corresponding to all the classes
%In the posterior evaluation, prior is not included because its same for all
%the classes and hence do not create any difference in class prediction.
for Index1 = 1:NoOfTestSamples
    Index1;
    for Index2 = 1:NoOfClasses
        TempLogSum = 0;
        for Index3 = 1:NoOfFeatures
            TempSigma = NB{Index2,Index3}(2,1);
%             OneBySigmaRoot2Pi = 1/(TempSigma * sqrt(2*pi));
            LogOneBySigmaRoot2Pi = -0.5*log(2*pi*(TempSigma));
            XMinusMue = TestSamples(Index1,Index3) - NB{Index2,Index3}(1,1);
            XMinusMueBySigmaSquare = -0.5*((XMinusMue/sqrt(TempSigma))^2);
%            ExpXMinusMueBySigmaWholSq = exp(-0.5*(XMinusMueBySigma^2));
%            Temp2 = (OneBySigmaRoot2Pi * ExpXMinusMueBySigmaWholSq);
            TempLogSum = TempLogSum + (LogOneBySigmaRoot2Pi + XMinusMueBySigmaSquare + log(2.718));
        end
        Posterior(Index1,Index2) = TempLogSum;
    end
end
[Posterior] = Normalize(Posterior);   %normalize between 0 to 1 and make it a probability (i.e. summation = 0)


%Find the class of each test sample
Temp2 = max(Posterior');    %finds max posterior value in each row of matrix Posterior
for Index1 = 1:NoOfTestSamples
    Temp3 = Posterior(Index1,:);
    PredictedClass(Index1) = find(Temp3 == Temp2(Index1));
end
% ConfusionMat = confusionmat(Classes,PredictedClass);
% PredictedClass = PredictedClass';
% Accuracy = [];
% for Index1 = 1:NoOfClasses
%     Index1
%     Count = 0;
%     for Index2 = 1:100
%         Index3 = ((Index1 - 1)*100) + Index2;
%         if(PredictedClass(Index3,1) == Index1)
%             Count = Count + 1;
%         end
%     end
%     Accuracy = [Accuracy;Count];
% end
% FinalAccuracy = (sum(Accuracy)/NoOfTestSamples)*100
