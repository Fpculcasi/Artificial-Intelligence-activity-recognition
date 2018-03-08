function f = my_fft (matrix)
	f = fft(matrix);
	f = abs(f./N(index));
	f(N(index)/2+1:end, :) = [];
	f= 2.*f;
end
