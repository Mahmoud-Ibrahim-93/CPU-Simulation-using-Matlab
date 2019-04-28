function [ registers,memoryFull ] = OneOperand( registers,memoryFull,OpCode,IR )
%ONEOPERAND IS to excute One operand instruction

 
                
                if (OpCode>=12)&&(OpCode<=14)
                 
                 IR=bitshift(IR,8)+memoryFull(registers(1)+2); % Big Endian
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
                                        memoryFull(registers(bitand(OP1,1)+3)+1)=bitshift(memoryFull(registers(bitand(OP1,1)+3)+1),1);
                                    case 3
                                        memoryFull(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1)=bitshift(memoryFull(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1),1);
                          end
                                
                    case 49 % 110001 -- ASL OP1
                        
                          switch AM
                                
                              case 0
                                        disp('can not deal with immediate values')
                                    case 1
                                        registers(bitand(OP1,1)+3)=bitshift(  registers(bitand(OP1,1)+3),1);
                                    case 2
                                        memoryFull(registers(bitand(OP1,1)+3)+1)=bitshift(memoryFull(registers(bitand(OP1,1)+3)+1),1);
                                    case 3
                                        memoryFull(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1)=bitshift(memoryFull(registers(bitand(OP1,1)+3)+bitshift(op1,-1)+1),1);
                          end
                                
                        
                    case 52 % 110100 -- PUSH OP1
                            registers(2)=registers(2)-1;
                          switch AM
                                
                                    case 0
                                        memoryFull(registers(4)+1)=OP1;
                                    case 1
                                        memoryFull(registers(4)+1)=registers(bitand(OP1,1)+3);
                                    case 2
                                        memoryFull(registers(4)+1)=memoryFull(registers(bitand(OP1,1)+3)+1);
                                    case 3
                                        memoryFull(registers(4)+1)=memoryFull(registers(bitand(OP1,1)+3)+bitshift(OP1,-1)+1);
                          end
                                
                        
                    case 53 % 110101 -- POP OP1
                        registers(2)=registers(2)+1;
                        
                           switch AM
                                
                                    case 0
                                        disp('can not coppy top of the stack to #no')
                                    case 1
                                        registers(bitand(OP1,1)+3)=memoryFull(registers(4));
                                    case 2
                                        memoryFull(registers(bitand(OP1,1)+3)+1)=memoryFull(registers(4));
                                    case 3
                                        memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)=memoryFull(registers(4)-1);
                          end
                                
                        
                    case 56 % 111000 -- JUMP OP1
                        
                          switch AM
                                
                                    case 0
                                        registers(1)=OP1;
                                    case 1
                                        registers(1)=registers(and(OP1,1)+3);
                                    case 2
                                        registers(1)=memoryFull(registers(and(OP1,1)+3)+1);
                                    case 3
                                        registers(1)= memoryFull(registers(and(OP1,1)+3)+bitshift(OP1,-1)+1);
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
                                        registers(1)=memoryFull(registers(bitand(OP1,1)+3)+1);
                                    case 3
                                        registers(1)=memoryFull(registers(bitand(OP1,1)+3)+bitshift(OP1,-1)+1);
                                        
                 end
                 end
                        
                    case 59 % 111011 -- CALL OP1
                       
                        %%%
                        registers(2)=registers(2)-1;
                        memoryFull(registers(2)+1)=registers(1);
                        switch AM
                                
                                    case 0
                                        
                                        registers(1)=OP1;
                                    case 1
                                        registers(1)=registers(and(OP1,1)+3);
                                    case 2
                                        registers(1)=memoryFull(registers(and(OP1,1)+3)+1);
                                    case 3
                                        registers(1)= memoryFull(registers(and(OP1,1)+3)+bitshift(OP1,-1)+1);
                          end
                         otherwise
                          disp('OP code of 1-op inst is out of scope')
                     end
             end


end

