
function arr = getColumnCount(num)
% returns the excel column for a given number
i=1;
    while num>0
		rem = mod(num,26);
        if rem==0
			arr(i) = 'Z'; 
            i=i+1;
			num = floor(num/26)-1; 		
		else 	
			arr(i) =  char('A'+(rem-1));
            i=i+1;
			num = floor(num/26);
        end
    end
	arr=reverse(arr); 
end


