%% 08 ANFIS
inputs2 = [inputs actual];

sugeno = mam2sug(mamdani);

anfisedit;

%%
outputs = evalfis(inputs,sugeno2);
% errors = gsubtract(targets,outputs);
% pre_error = sqrt(mean(errors.^2))

if(showPlots),
    figure,
    plot(1:size(outputs,1),targets,'bo',1:size(outputs,1),outputs,'rx');
    hold on;
    plot(1:size(outputs,1),zeros(1,size(outputs,1)),'k--');
    plot(1:size(outputs,1),0.3*ones(1,size(outputs,1)),'k--');
    plot(1:size(outputs,1),0.5*ones(1,size(outputs,1)),'k--');
    plot(1:size(outputs,1),0.7*ones(1,size(outputs,1)),'k--');
    plot(1:size(outputs,1),ones(1,size(outputs,1)),'k--');
    title('Result of Mamdani FIS');
    xlabel('inputs');
    ylabel('classes');
    legend('target class','output class');
end

% just to better understand plot
for k=1:size(outputs,1)
    if outputs(k)<1.5
        outputs(k) = 1;
    elseif outputs(k)<2.5
        outputs(k) = 2;
    elseif outputs(k)<3.5
        outputs(k) = 3;
    else
        outputs(k) = 4;
    end
    
    if outputs(k) == targets(k),
        count = count + 1;
    end
end

cfmatrix2(actual',outputs',[1 2 3 4], 0, 1);
