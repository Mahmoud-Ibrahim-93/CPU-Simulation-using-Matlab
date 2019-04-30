tic %%Elapsed time Counter start
clear %%clear the variables in the workspace
clc  %%Cmd window clear
%%import memory data
%number of locations in memory
global MemorySize;
MemorySize=256;
cycleCount=0;
sheetLocation='memory.xlsx';
[memory,registers] = ReadMemory(sheetLocation);

while 1
 
 % Instruction register holds the value which is currently held in the PC
 IR=memory(registers(1)+1);
 
 %The last 4 bit determine if the instruction has 2 Operands (0000 to 1011)
 % or has 1 Operand (1100 to 1110) or has no operand (1111);
 % IR has current 8-bit register and the 4 LSBs determine the Operand type
 OpCode=bitshift(IR,-4);
 
%% 2-operand instruction
if (OpCode < 12)
[registers,memory] = TwoOperand (registers,memory,IR);
end
 
%% 1-operand instruction
if (OpCode>=12)&&(OpCode<=14)
[registers,memory ] = OneOperand(registers,memory,IR );
end

%% Zero-operand instruction
if OpCode==15
[registers,memory,IR ] = ZeroOperand(registers,memory,IR );
end

cycleCount=cycleCount+1;
xlswrite('memory.xlsx',cellstr(char(strcat('cycle',{' '},string(cycleCount)))),1,strcat(getColumnCount(cycleCount+2),'1'));
xlswrite('memory.xlsx',cellstr(dec2hex(memory)),1,strcat(getColumnCount(cycleCount+2),'2'));
xlswrite('memory.xlsx',cellstr(char(strcat('cycle',{' '},string(cycleCount)))),2,strcat(getColumnCount(cycleCount+2),'1'));
xlswrite('memory.xlsx',cellstr(dec2hex(registers)),2,strcat(getColumnCount(cycleCount+2),'2'));

if(IR ==255)
   break; 
end

end

disp(registers);
disp(memory);
toc % Elapsed time counter