tic %%Elapsed time Counter start
clear %%clear the variables in the workspace
clc  %%Cmd window clear
%%import memory data
%number of locations in memory
global MemorySize;
MemorySize=256;
cycleCount=0;
sheetLocation='memory.xlsx';
simlationStruct=[];
% [simlationStruct.memory,simlationStruct.registers] = ReadMemory(sheetLocation);
[simlationStruct.memory(:,cycleCount+1),simlationStruct.registers(:,cycleCount+1)] = ReadMemory(sheetLocation);
while 1

 % Instruction register holds the value which is currently held in the PC
 simlationStruct.IR{cycleCount+1}=simlationStruct.memory(simlationStruct.registers(1,cycleCount+1)+1,cycleCount+1);
 
 %The last 4 bit determine if the instruction has 2 Operands (0000 to 1011)
 % or has 1 Operand (1100 to 1110) or has no operand (1111);
 % simlationStruct.IR has current 8-bit register and the 4 LSBs determine the Operand type
 OpCode=bitshift(simlationStruct.IR{cycleCount+1},-4);
 
%% 2-operand instruction
if (OpCode < 12)
[simlationStruct.registers(:,cycleCount+1),simlationStruct.memory(:,cycleCount+1),simlationStruct.IR{cycleCount+1}] = TwoOperand (simlationStruct.registers(:,cycleCount+1),simlationStruct.memory(:,cycleCount+1),simlationStruct.IR{cycleCount+1});
end
 
%% 1-operand instruction
if (OpCode>=12)&&(OpCode<=14)
[simlationStruct.registers(:,cycleCount+1),simlationStruct.memory(:,cycleCount+1),simlationStruct.IR{cycleCount+1} ] = OneOperand(simlationStruct.registers(:,cycleCount+1),simlationStruct.memory(:,cycleCount+1),simlationStruct.IR{cycleCount+1} );
end

%% Zero-operand instruction
if OpCode==15
[simlationStruct.registers(:,cycleCount+1),simlationStruct.memory(:,cycleCount+1)] = ZeroOperand(simlationStruct.registers(:,cycleCount+1),simlationStruct.memory(:,cycleCount+1),simlationStruct.IR{cycleCount+1} );
end

cycleCount=cycleCount+1;
%% write%%
if(simlationStruct.IR{cycleCount} ==255)
   break; 
end


 % Copy a version of the prev memory and register state
  simlationStruct.memory(:,cycleCount+1)=simlationStruct.memory(:,cycleCount);
  simlationStruct.registers(:,cycleCount+1)=simlationStruct.registers(:,cycleCount);
end
write2Excel(sheetLocation,simlationStruct);
for i=1:length(simlationStruct.IR)
    temp=dec2hex(simlationStruct.IR{i});
    if length(temp)==3
        disp(dec2hex(simlationStruct.IR{i},4));
    else
        disp(dec2hex(simlationStruct.IR{i}));
    end
end
toc % Elapsed time counter