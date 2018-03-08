% My extension of autocorr(), in order to compute autocorr on a matrix of
% more than 1 signal, where each column is a different signal
function Rxx = my_autocorr (matrix)
	% If "matrix" has only a column, I only need to compute correlation once
	Rxx = autocorr(matrix(:,1));
	
	for k=2:size(matrix,2)
		Rxx = [Rxx autocorr(matrix(:,k))];
	end
end
