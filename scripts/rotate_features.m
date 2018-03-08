function f = rotate_features (features)
	for k=0:4:size(features,2);
		f = [features(:,k+1); features(:,k+2); features(:,k+3); ...
			features(:,k+4)];
	end
end
