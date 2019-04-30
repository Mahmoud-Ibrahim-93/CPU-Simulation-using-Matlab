function [registers,memory ] = ZeroOperand(registers,memory,IR )
% Executes the zero operand instruction


 registers(1)=registers(1)+1;

 switch IR

     case 242 % RETURN 
         registers(1)=memory(registers(2)+1);
         registers(2)=registers(2)+1;

     case 244 % INITSP 

         registers(2)=255; %%SP<==FF
         registers(2)=255;
     case 254 % NOP 
         continue; % NO Operation
     case 255 % RETURN 
         break;

     otherwise
         disp('can not recognise this zero instruction pattern');

 end
end

