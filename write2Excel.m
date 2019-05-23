function  write2Excel(sheetLocation,simlationStruct)
    % Write the Memory Variables value with each cycle a long  with the
    % Regisers to an External excel sheet
    for cycleCount=1:size(simlationStruct.memory,2)
        xlswrite(sheetLocation,cellstr(char(strcat('cycle',{' '},string(cycleCount)))),1,strcat(getColumnCount(cycleCount+2),'1'));
        xlswrite(sheetLocation,cellstr(dec2hex(simlationStruct.memory(:,cycleCount))),1,strcat(getColumnCount(cycleCount+2),'2'));
        xlswrite(sheetLocation,cellstr(char(strcat('cycle',{' '},string(cycleCount)))),2,strcat(getColumnCount(cycleCount+2),'1'));
        xlswrite(sheetLocation,cellstr(dec2hex(simlationStruct.registers(:,cycleCount))),2,strcat(getColumnCount(cycleCount+2),'2'));
    end
end

