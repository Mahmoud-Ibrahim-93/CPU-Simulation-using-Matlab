function [MemorySize,simulationStruct]=startSimulation(newMemoryRegisterData)

tic %%Elapsed time Counter start
% clc  %%Cmd window clear
%number of locations in memory
MemorySize=256;
cycleCount=0;
sheetLocation='memory.xlsx';
simulationStruct=[];


% isSix = cellfun(@(x)isequal(x,2),simlationStruct.addressingModes(:,1));
% [row,col] = find(isSix);
if( newMemoryRegisterData<=0)
load('oldSimulationData.mat','simulationStruct');
return
end

if( newMemoryRegisterData>0)
% Supported Addressing modes
simulationStruct.addressingModes={
0,'The immediate value is stored in the Value/Address\n field of the instruction';
1,'Register number is encoded by the least significant\n bit (LSB) of the Value/Address field.';
2,'Register Indirect: Register is encoded\n by the LSB field';
3,'Base Register number is encoded by the LSB field of the VA field\nDisplacement is encoded by the rest of the VA field.';
};
% Supported instructions
simulationStruct.supportedInstructions={
0,'MOV Op1, Op2\nCopy Op2 to Op1';
2,'ADD Op1, Op2\nAdd Op2 to Op1 and store the result to Op1';
3,'SUB Op1, Op2\nSUB Op1, Op2\nSubtract Op2 from Op1 and store the result to Op1';
8,'XOR Op1, Op2\nXOR Op2 with Op1 and store the result to Op1';
48,'LSL Op1\nShift Op1 logically one-bit position to the left.';
49,'ASL Op1\nShift Op1 arithmetically one-bit\nposition to the left';
52,'PUSH Op1\nDecrement SP, and then put Op1\non top of the stack';
53,'POP Op1\nCopy the top element of the\nstack to Op1, and then increment SP';
56,'JUMP Op1\nBranch to an address specified\nby the VA field of Op1';
57,'DJNZ Op1\nDecrement R0, and check its new value.\nIf it is not zero, branch to the address\nspecified by the VA field of Op1';
59,'CALL Op1\nCall a subroutine whose address\nis specified by the VA field of Op1.\nThe return address is saved to the stack';
242,'RETURN\nReturn from a subroutine call.\nThe return address is restored fromthe stack';
244,'INITSP\nLoad SP with a binary value of 11111111';
254,'NOP\nNo Operation';
255,'HALT\nStop execution'
};
    
%%import memory data
[simulationStruct.memory(:,cycleCount+1),simulationStruct.registers(:,cycleCount+1)] = ReadMemory(sheetLocation,MemorySize);
end
while 1

 % Instruction register holds the value which is currently held in the PC
 simulationStruct.IR{cycleCount+1}=simulationStruct.memory(simulationStruct.registers(1,cycleCount+1)+1,cycleCount+1);
 
 %The last 4 bit determine if the instruction has 2 Operands (0000 to 1011)
 % or has 1 Operand (1100 to 1110) or has no operand (1111);
 % simlationStruct.IR has current 8-bit register and the 4 LSBs determine the Operand type
 OpCode=bitshift(simulationStruct.IR{cycleCount+1},-4);
 
%% 2-operand instruction
if (OpCode < 12)
[simulationStruct.opcode(cycleCount+1),simulationStruct.AM(cycleCount+1,:),simulationStruct.registers(:,cycleCount+1),simulationStruct.memory(:,cycleCount+1),simulationStruct.IR{cycleCount+1}] = TwoOperand (simulationStruct.registers(:,cycleCount+1),simulationStruct.memory(:,cycleCount+1),simulationStruct.IR{cycleCount+1});
end
 
%% 1-operand instruction
if (OpCode>=12)&&(OpCode<=14)
[simulationStruct.opcode(cycleCount+1),simulationStruct.AM(cycleCount+1,:),simulationStruct.registers(:,cycleCount+1),simulationStruct.memory(:,cycleCount+1),simulationStruct.IR{cycleCount+1} ] = OneOperand(simulationStruct.registers(:,cycleCount+1),simulationStruct.memory(:,cycleCount+1),simulationStruct.IR{cycleCount+1} );
end

%% Zero-operand instruction
if OpCode==15
[simulationStruct.opcode(cycleCount+1),simulationStruct.AM(cycleCount+1,:),simulationStruct.registers(:,cycleCount+1),simulationStruct.memory(:,cycleCount+1)] = ZeroOperand(simulationStruct.registers(:,cycleCount+1),simulationStruct.memory(:,cycleCount+1),simulationStruct.IR{cycleCount+1} );
end

cycleCount=cycleCount+1;
%% check code halt Instruction%%
if(simulationStruct.IR{cycleCount} ==255)
   break; 
end


 % Copy a version of the prev memory and register state
  simulationStruct.memory(:,cycleCount+1)=simulationStruct.memory(:,cycleCount);
  simulationStruct.registers(:,cycleCount+1)=simulationStruct.registers(:,cycleCount);
end

if( newMemoryRegisterData>0)
% write the Execution data to the Excel
write2Excel(sheetLocation,simulationStruct);
save('oldSimulationData.mat','simulationStruct') 
end

% Display Execution Instructions for debugging purposes
% dispInstrictions(simlationStruct);

toc % Elapsed time counter
end