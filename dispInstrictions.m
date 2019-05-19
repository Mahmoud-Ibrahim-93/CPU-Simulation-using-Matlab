function dispInstrictions(simlationStruct)
% Displays the Instructions During the Program Execution
for i=1:length(simlationStruct.IR)
    temp=dec2hex(simlationStruct.IR{i});
    if length(temp)==3
        disp(dec2hex(simlationStruct.IR{i},4));
    else
        disp(dec2hex(simlationStruct.IR{i}));
    end
end
end

