function [opcode,AddressingMode,registers,memory,IR ] = OneOperand( registers,memory,IR )

% calculate IR which consists of 16 bit for 1 Operand instructoins
IR=bitshift(IR,8)+memory(registers(1)+2); % Big Endian
% calculate OpCode
opcode=bitshift(IR,-10);
% Increase Program counter by 2
registers(1)=registers(1)+2;
% Calculate Addressing mode for the only Operand
AM=bitshift(bitand(IR,768),-8);
% Calculate Operand 1
OP1=bitand(IR,255);
AddressingMode=[-1,AM];
switch opcode
    case 48 % 110000 -- Left shift Operand 1 one bit to the left
        switch AM
            case 0 % Immediate Addressing mode for the operand 
                error('can not deal with immediate values')
            case 1 % Register number for the operand given in LSB
                registers(bitand(OP1,1)+3)=bitshift(registers(bitand(OP1,1)+3),1);
            case 2 % Register indirect for the operand given in LSB
                memory(registers(bitand(OP1,1)+3)+1)=bitshift(memory(registers(bitand(OP1,1)+3)+1),1);
            case 3 % Base Register stored in LSB of the Operand and Displacement stred in the rest bits
                memory(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1)=bitshift(memory(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1),1);
        end
    case 49 % 110001 -- Arithmetic shift left
        switch AM
            case 0 % Immediate Addressing mode for the operand
                error('can not deal with immediate values')
            case 1 % Register number for the operand given in LSB
                registers(bitand(OP1,1)+3)=bitshift(  registers(bitand(OP1,1)+3),1);
            case 2 % Register indirect for the operand given in LSB
                memory(registers(bitand(OP1,1)+3)+1)=bitshift(memory(registers(bitand(OP1,1)+3)+1),1);
            case 3 % Base Register stored in LSB of the Operand and Displacement stred in the rest bits
                memory(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1)=bitshift(memory(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1),1);
        end
    case 52 % 110100 -- PUSH OP1 (Decrement stack pointer SP and put Operand 1 OP1 on the top of the stack)
        registers(2)=registers(2)-1;
        switch AM
            case 0 % Immediate Addressing mode for the operand
                memory(registers(4)+1)=OP1;
            case 1 % Register number for the operand given in LSB
                memory(registers(4)+1)=registers(bitand(OP1,1)+3);
            case 2 % Register indirect for the operand given in LSB
                memory(registers(4)+1)=memory(registers(bitand(OP1,1)+3)+1);
            case 3 % Base Register stored in LSB of the Operand and Displacement stred in the rest bits
                memory(registers(4)+1)=memory(registers(bitand(OP1,1)+3)+bitshift(OP1,-1)+1);
        end
    case 53 % 110101 -- POP the top element of the stack to OP1 and Increment SP
        registers(2)=registers(2)+1;
        switch AM
            case 0 % Immediate Addressing mode for the operand
                error('can not coppy top of the stack to #no')
            case 1 % Register number for the operand given in LSB
                registers(bitand(OP1,1)+3)=memory(registers(4));
            case 2 % Register indirect for the operand given in LSB
                memory(registers(bitand(OP1,1)+3)+1)=memory(registers(4));
            case 3 % Base Register stored in LSB of the Operand and Displacement stred in the rest bits
                memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)=memory(registers(4)-1);
        end
    case 56 % 111000 -- JUMP to address specified by OP1
        switch AM
            case 0 % Immediate Addressing mode for the operand
                registers(1)=OP1;
            case 1 % Register number for the operand given in LSB
                registers(1)=registers(and(OP1,1)+3);
            case 2 % Register indirect for the operand given in LSB  
                registers(1)=memory(registers(and(OP1,1)+3)+1);
            case 3 % Base Register stored in LSB of the Operand and Displacement stred in the rest bits
                registers(1)= memory(registers(and(OP1,1)+3)+bitshift(OP1,-1)+1);
        end
    case 57 % 111001 -- DJNZ OP1 (Decrement Register 0 and Jump if to operand 1 if its value is not zero)
        registers(3)=registers(3)-1;
        if registers(3) ~=0
            switch AM
                case 0 % Immediate Addressing mode for the operand
                    registers(1)=OP1;
                case 1 % Register number for the operand given in LSB
                    registers(1)=registers(bitand(OP1,1)+3);
                case 2 % Register indirect for the operand given in LSB
                    registers(1)=memory(registers(bitand(OP1,1)+3)+1);
                case 3 % Base Register stored in LSB of the Operand and Displacement stred in the rest bits
                    registers(1)=memory(registers(bitand(OP1,1)+3)+bitshift(OP1,-1)+1);
            end
        end
    case 59 % 111011 -- CALL subroutine specified by OP1 and save return address into the stack
        registers(2)=registers(2)-1;
        memory(registers(2)+1)=registers(1);
        switch AM
            case 0 % Immediate Addressing mode for the operand
                registers(1)=OP1;
            case 1 % Register number for the operand given in LSB
                registers(1)=registers(and(OP1,1)+3);
            case 2 % Register indirect for the operand given in LSB
                registers(1)=memory(registers(and(OP1,1)+3)+1);
            case 3 % Base Register stored in LSB of the Operand and Displacement stred in the rest bits
                registers(1)= memory(registers(and(OP1,1)+3)+bitshift(OP1,-1)+1);
        end
    otherwise
        error('OP code of 1-op inst is out of scope')
end
end