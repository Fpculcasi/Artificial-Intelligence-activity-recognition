function f = my_fft (matrix, ind)
    if(mod(ind,2)~=0), ind = ind-1; end
	f = fft(matrix);
	f = abs(f./ind);
	f(ind/2+1:end, :) = [];
	f= f.*2;
end
