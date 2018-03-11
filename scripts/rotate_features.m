function f = rotate_features (features)
    f = [features(:,1); features(:,2); features(:,3); ...
			features(:,4)];
	for k=1:size(features,2)/4-1;
		f = [f [features(:,4*k+1); features(:,4*k+2); features(:,4*k+3); ...
			features(:,4*k+4)]];
	end
end
