function [registers,memory ] = ZeroOperand(registers,memory,IR )
% Executes the zero operand instruction

% increment PC by 1
 registers(1)=registers(1)+1;
 switch IR
     case 242 % RETURN from a subroutine call. The return address is restored from the stack
         % PC <= *SP (value of the top of the stack location is stored in the program counter PC)
         registers(1)=memory(registers(2)+1);
         % inc rease stack pointer value (SP <= SP +1)
         registers(2)=registers(2)+1;
     case 244 % INITSP SP=255
         registers(2)=255; %%SP<==FF
     case 254 % NOP No Operation
%          continue; % NO Operation
     case 255 % RETURN (Stop execution)
%          IR=255;
     otherwise
         disp('can not recognise this zero instruction pattern');
 end
end

