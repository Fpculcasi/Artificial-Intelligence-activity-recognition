function f = my_fft (matrix, ind)
	f = fft(matrix);
	f = abs(f./ind);
	f(ind/2+1:end, :) = [];
	f= f.*2;
end
