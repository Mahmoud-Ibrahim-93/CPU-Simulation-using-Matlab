function [memory,registers] = ReadMemory(sheetLocation)
%READMEMORY data ( Main memory & Registers )
global MemorySize;
[num,txt,raw] =xlsread(sheetLocation,1,strcat('B2:B',string(MemorySize+1)));
memory=hex2dec(string(raw));
%%import registers data
[num2,txt2,raw2] =xlsread(sheetLocation,2,'B2:B5');
% Transform hexadecimal value of the Registers to a decimal value
registers=hex2dec(string(raw2));
% From the excel sheet 2
% Registers(1) PC - Registers(2) SP - Registers(3) R0 - Registers(4) R1

end

