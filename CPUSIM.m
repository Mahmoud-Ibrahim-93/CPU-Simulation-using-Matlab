tic %%Elapsed time Counter start
clear %%clear the variables in the workspace
clc  %%Cmd window clear
%%import memory data
%number of locations in memory
MemorySize=256;
cycleCount=0;
[num,txt,raw] =xlsread('memory.xlsx',1,strcat('B2:B',string(MemorySize+1)));
memory=hex2dec(string(raw));
memory(3)=3;
memory(255)=95;
%%import registers data
[num2,txt2,raw2] =xlsread('memory.xlsx',2,'B2:B5');
registers=hex2dec(string(raw2));
IR=243; %initially

while 1
 IR=memory(registers(1)+1);
 OpCode=bitshift(IR,-4);

%% 2-operand instruction
if (OpCode < 12)
IR=bitshift(IR,8)+memory(registers(1)+2); % Big Endian
registers(1)=registers(1)+2; %PC
AM1=bitshift(bitand(IR,3072),-10);
AM2=bitshift(bitand(IR,48),-4);
OP1=bitshift(bitand(IR,960),-6);
 OP2=bitand(IR,15);
switch OpCode

    case 0 % Copy OP2 to OP1

        switch AM1

            case 0
               disp(' Error Can not copy immediate value to immediate value')
               case 1
                switch AM2

                    case 0
                        registers(bitand(OP1,1)+3)=OP2;
                        case 1
                        registers(bitand(OP1,1)+3)=registers(bitand(OP2,1)+3);
                    case 2
                        registers(bitand(OP1,1)+3)=memory(registers(bitand(OP2,1)+3)+1) ;
                        case 3
                        registers(bitand(OP1,1)+3)=memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
            case 2
                switch AM2

                    case 0
                    memory(registers(bitand(OP1,1)+3)+1) =OP2;
                    case 1
                    memory(registers(bitand(OP1,1)+3)+1)=registers(bitand(OP2,1)+3);
                    case 2
                    memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3
                     memory(registers(bitand(OP1,1)+3)+1)=memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);

                end
            case 3
                switch AM2

                    case 0
                    memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =OP2;
                    case 1
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =registers(bitand(OP2,1)+3);
                    case 2
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end

        end


    case 2 % OP1=OP1+OP2
        %%%%%%




        switch AM1

            case 0
               disp(' Error Can not copy immediate value to immediate value')
               case 1
                switch AM2

                    case 0
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+OP2;
                    case 1
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+registers(bitand(OP2,1)+3);
                    case 2
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
            case 2
                switch AM2

                    case 0
                    memory(registers(bitand(OP1,1)+3)+1) =memory(registers(bitand(OP1,1)+3)+1)+OP2;
                    case 1
                    memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)+registers(bitand(OP2,1)+3);
                    case 2
                    memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)+memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3
                     memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)+memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);

                end
            case 3
                switch AM2

                    case 0
                    memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+OP2;
                    case 1
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+registers(bitand(OP2,1)+3);
                    case 2
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end

        end




        %%%%%%

    case 3 % OP1=OP1-OP2

           %%%%%%





        switch AM1

            case 0
               disp(' Error Can not copy immediate value to immediate value')
               case 1
                switch AM2

                    case 0
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-OP2;
                    case 1
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-registers(bitand(OP2,1)+3);
                    case 2
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3
                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end
            case 2
                switch AM2

                    case 0
                        memory(registers(bitand(OP1,1)+3)+1) =memory(registers(bitand(OP1,1)+3)+1)-OP2;
                    case 1
                    memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)-registers(bitand(OP2,1)+3);
                    case 2
                    memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)-memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3
                     memory(registers(bitand(OP1,1)+3)+1)=memory(registers(bitand(OP1,1)+3)+1)-memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);

                end
            case 3
                switch AM2

                    case 0
                    memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-OP2;
                    case 1
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-registers(bitand(OP2,1)+3);
                    case 2
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-memory(registers(bitand(OP2,1)+3)+1) ;
                    case 3
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                end

        end





        %%%%%%

    case 8 % OP1=XOR(OP1,OP2)
           %%%%%%





        switch AM1

            case 0
               disp(' Error Can not copy immediate value to immediate value')
               case 1
                switch AM2

                    case 0
                        registers(bitand(OP1,1)+3)=bitxor(registers(bitand(OP1,1)+3),OP2);
                    case 1
                        registers(bitand(OP1,1)+3)=bitxor(registers(bitand(OP2,1)+3),registers(bitand(OP1,1)+3));
                    case 2
                        registers(bitand(OP1,1)+3)=bitxor(memory(registers(bitand(OP2,1)+3)+1),registers(bitand(OP1,1)+3)) ;
                    case 3
                        registers(bitand(OP1,1)+3)=bitxor(memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1),registers(bitand(OP1,1)+3));
                end
            case 2
                switch AM2

                    case 0
                    memory(registers(bitand(OP1,1)+3)) =bitxor(OP2,memory(registers(bitand(OP1,1)+3)+1));
                    case 1
                    memory(registers(bitand(OP1,1)+3)+1)=bitxor(registers(bitand(OP2,1)+3),memory(registers(bitand(OP1,1)+3)+1));
                    case 2
                    memory(registers(bitand(OP1,1)+3)+1)=bitxor(memory(registers(bitand(OP2,1)+3)+1),memory(registers(bitand(OP1,1)+3)+1)) ;
                    case 3
                     memory(registers(bitand(OP1,1)+3)+1)=bitxor(memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1),memory(registers(bitand(OP1,1)+3)+1));

                end
            case 3
                switch AM2

                    case 0
                    memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(OP2,memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1));
                    case 1
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(registers(bitand(OP2,1)+3),memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1));
                    case 2
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(memory(registers(bitand(OP2,1)+3)+1),memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)) ;
                    case 3
                     memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(memory(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1),memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1));
                end

        end





        %%%%%%

    otherwise
        disp('Out of Op-Code data scope')
end

 end
%% 1-operand instruction




if (OpCode>=12)&&(OpCode<=14)

 IR=bitshift(IR,8)+memory(registers(1)+2); % Big Endian
 OP1opcode=bitshift(IR,-10);
registers(1)=registers(1)+2;
AM=bitshift(bitand(IR,768),-8);
OP1=bitand(IR,255);

switch OP1opcode

    case 48 % 110000 -- LSL OP1
          switch AM

                    case 0
                        disp('can not deal with immediate values')
                    case 1
                        registers(bitand(OP1,1)+3)=bitshift(  registers(bitand(OP1,1)+3),1);
                         case 2
                        memory(registers(bitand(OP1,1)+3)+1)=bitshift(memory(registers(bitand(OP1,1)+3)+1),1);
                    case 3
                        memory(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1)=bitshift(memory(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1),1);
          end

    case 49 % 110001 -- ASL OP1

          switch AM

              case 0
                        disp('can not deal with immediate values')
                    case 1
                        registers(bitand(OP1,1)+3)=bitshift(  registers(bitand(OP1,1)+3),1);                                        
                    case 2
                        memory(registers(bitand(OP1,1)+3)+1)=bitshift(memory(registers(bitand(OP1,1)+3)+1),1);
                    case 3
                        memory(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1)=bitshift(memory(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1),1);
          end


    case 52 % 110100 -- PUSH OP1
            registers(2)=registers(2)-1;
          switch AM

                    case 0
                        memory(registers(4)+1)=OP1;
                    case 1
                        memory(registers(4)+1)=registers(bitand(OP1,1)+3);
                    case 2
                        memory(registers(4)+1)=memory(registers(bitand(OP1,1)+3)+1);
                    case 3
                        memory(registers(4)+1)=memory(registers(bitand(OP1,1)+3)+bitshift(OP1,-1)+1);
          end


    case 53 % 110101 -- POP OP1
        registers(2)=registers(2)+1;

           switch AM

                    case 0
                        disp('can not coppy top of the stack to #no')
                    case 1
                        registers(bitand(OP1,1)+3)=memory(registers(4));
                    case 2
                        memory(registers(bitand(OP1,1)+3)+1)=memory(registers(4));
                    case 3
                        memory(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)=memory(registers(4)-1);
          end


    case 56 % 111000 -- JUMP OP1

          switch AM

                    case 0
                        registers(3)=OP1;
                    case 1
                        registers(3)=registers(and(OP1,1)+3);
                    case 2
                        registers(3)=memory(registers(and(OP1,1)+3)+1);
                    case 3
                        registers(3)= memory(registers(and(OP1,1)+3)+bitshift(OP1,-1)+1);
          end


    case 57 % 111001 -- DJNZ OP1
 registers(3)=registers(3)-1;

 if registers(3) ~=0
 switch AM

                    case 0
                        registers(1)=OP1;
                         case 1
                        registers(1)=registers(bitand(OP1,1)+3);
                    case 2
                        registers(1)=memory(registers(bitand(OP1,1)+3)+1);
                    case 3
                        registers(1)=memory(registers(bitand(OP1,1)+3)+bitshift(OP1,-1)+1);

 end
  end      

    case 59 % 111011 -- CALL OP1

        %%%
        registers(2)=registers(2)-1;
        memory(registers(2)+1)=registers(1);
        switch AM

                    case 0

                        registers(1)=OP1;
                    case 1
                        registers(1)=registers(and(OP1,1)+3);
                    case 2
                        registers(1)=memory(registers(and(OP1,1)+3)+1);
                    case 3
                        registers(1)= memory(registers(and(OP1,1)+3)+bitshift(OP1,-1)+1);
          end




        %%
          otherwise
          disp('OP code of 1-op inst is out of scope')

end


end


%%%%%%%%%


 %% Zero-operand instruction
if OpCode==15


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



     %%%


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

    toc % Elapsed time counter