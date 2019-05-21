function [OpCode,addressingMode,registers,memory,IR] = TwoOperand (registers,memory,IR)
OpCode=bitshift(IR,-4);
IR=bitshift(IR,8)+memory(registers(1)+2); % Big Endian
registers(1)=registers(1)+2; %PC
% AM1 Addressing mode for operand 1
AM1=bitshift(bitand(IR,3072),-10);

% AM2 Addressing mode for operand 2
AM2=bitshift(bitand(IR,48),-4);
addressingMode=[AM1,AM2];
% Op1 Operand 1 Value
OP1=bitshift(bitand(IR,960),-6);

% Op1 Operand 2 Value
OP2=bitand(IR,15);
switch OpCode           
    case 0 % Copy OP2 to OP1
        switch AM1
            case 0 % Immediate Addressing mode for operand 1
                error(' Error Can not copy to an immediate value')
            case 1 % Register number is encoded in the LSB in Operand 1
                switch AM2
                    case 0 % Immediate Addressing mode for operand 2
                        registers(bitand(OP1,1)+3)=OP2;
                    case 1 % Register number for operand 2 given in LSB
                        registers(bitand(OP1,1)+3)=registers(bitand(OP2,1)+3);
                    case 2 % Register indirect for operand 2 given in LSB
                        registers(bitand(OP1,1)+3)=memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        registers(bitand(OP1,1)+3)=memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
            case 2  % Register indirect Register Address encoded in the LSB in Operand 1
                switch AM2
                    case 0 % Immediate Addressing mode for operand 2
                        memory(registers(bitand(OP1,1)+3)+1) =OP2;
                    case 1 % Register number for operand 2 given in LSB
                        memory(registers(bitand(OP1,1)+3)+1)=registers(bitand(OP2,1)+3);
                    case 2 % Register indirect for operand 2 given in LSB
                        memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        memory(registers(bitand(OP1,1)+3)+1)=memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
            case 3
                switch AM2
                    case 0 % Immediate Addressing mode for operand 2
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =OP2;
                    case 1 % Register number for operand 2 given in LSB
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =registers(bitand(OP2,1)+3);
                    case 2 % Register indirect for operand 2 given in LSB
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
        end
    case 2 % OP1=OP1+OP2
        switch AM1
            case 0 % Immediate addressing mode for operand 1
                error(' Error Can not store in immediate value')
            case 1 % Register number stored in the LSB of Operand 1
                switch AM2
                    case 0 % Immediate addressing for operand 2
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+OP2;
                    case 1 % Register no stored in LSB of operand 2
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+registers(bitand(OP2,1)+3);
                    case 2 % Register indirect addressing stored in LSB of operand 2
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
            case 2 % Register indirect Register Address encoded in the LSB in Operand 1
                switch AM2
                    case 0 % Immediate addressing for operand 2
                        memory(registers(bitand(OP1,1)+3)+1) =memory(registers(bitand(OP1,1)+3)+1)+OP2;
                    case 1 % Register no stored in LSB of operand 2
                        memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)+registers(bitand(OP2,1)+3);
                    case 2 % Register indirect addressing stored in LSB of operand 2
                        memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)+memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)+memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
            case 3
                switch AM2
                    case 0 % Immediate addressing for operand 2
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+OP2;
                    case 1 % Register no stored in LSB of operand 2
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+registers(bitand(OP2,1)+3);
                    case 2 % Register indirect addressing stored in LSB of operand 2
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
        end
    case 3 % OP1=OP1-OP2
        switch AM1
            case 0 % Immediate Addressing mode for operand 1
                error(' Error Can not copy to immediate value')
            case 1 % Register number is encoded in the LSB in Operand 1
                switch AM2
                    case 0 % Immediate addressing for operand 2
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-OP2;
                    case 1 % Register no stored in LSB of operand 2
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-registers(bitand(OP2,1)+3);
                    case 2 % Register indirect addressing stored in LSB of operand 2
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
            case 2 % Register indirect Register Address encoded in the LSB in Operand 1
                switch AM2
                    case 0 % Immediate addressing for operand 2
                        memory(registers(bitand(OP1,1)+3)+1) =memory(registers(bitand(OP1,1)+3)+1)-OP2;
                    case 1 % Register no stored in LSB of operand 2
                        memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)-registers(bitand(OP2,1)+3);
                    case 2 % Register indirect addressing stored in LSB of operand 2
                        memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)-memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)-memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
            case 3
                switch AM2
                    case 0 % Immediate addressing for operand 2
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-OP2;
                    case 1 % Register no stored in LSB of operand 2
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-registers(bitand(OP2,1)+3);
                    case 2 % Register indirect addressing stored in LSB of operand 2
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
        end
    case 8 % OP1=XOR(OP1,OP2)
        switch AM1
            case 0 % Immediate Addressing mode for operand 1
                error(' Error Can not copy to immediate value')
            case 1 % Register number is encoded in the LSB in Operand 1
                switch AM2
                    case 0 % Immediate addressing for operand 2
                        registers(bitand(OP1,1)+3)=bitxor(registers(bitand(OP1,1)+3),OP2);
                    case 1 % Register no stored in LSB of operand 2
                        registers(bitand(OP1,1)+3)=bitxor(registers(bitand(OP2,1)+3),registers(bitand(OP1,1)+3));
                    case 2 % Register indirect addressing stored in LSB of operand 2
                        registers(bitand(OP1,1)+3)=bitxor(memory(registers(bitand(OP2,1)+3)+1),registers(bitand(OP1,1)+3)) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        registers(bitand(OP1,1)+3)=bitxor(memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1),registers(bitand(OP1,1)+3));
                end
            case 2 % Register indirect Register Address encoded in the LSB in Operand 1
                switch AM2
                    case 0 % Immediate addressing for operand 2
                        memory(registers(bitand(OP1,1)+3)) =bitxor(OP2,memory(registers(bitand(OP1,1)+3)+1));
                    case 1 % Register no stored in LSB of operand 2
                        memory(registers(bitand(OP1,1)+3)+1)=bitxor(registers(bitand(OP2,1)+3),memory(registers(bitand(OP1,1)+3)+1));
                    case 2 % Register indirect addressing stored in LSB of operand 2
                        memory(registers(bitand(OP1,1)+3)+1)=bitxor(memory(registers(bitand(OP2,1)+3)+1),memory(registers(bitand(OP1,1)+3)+1)) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        memory(registers(bitand(OP1,1)+3)+1)=bitxor(memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1),memory(registers(bitand(OP1,1)+3)+1));
                end
            case 3
                switch AM2
                    case 0 % Immediate addressing for operand 2
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(OP2,memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1));
                    case 1 % Register no stored in LSB of operand 2
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(registers(bitand(OP2,1)+3),memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1));
                    case 2 % Register indirect addressing stored in LSB of operand 2
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(memory(registers(bitand(OP2,1)+3)+1),memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)) ;
                    case 3 % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1),memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1));
                end
        end
    otherwise % Base Register stored in LSB of OP2 and Displacement stred in the rest 5 bits
        error('Out of Op-Code data scope')
end
end
                
                 
