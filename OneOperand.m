function [ registers,memory ] = OneOperand( registers,memory,IR )
%ONEOPERAND IS to excute One operand instruction               
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
                                        registers(1)=OP1;
                                    case 1
                                        registers(1)=registers(and(OP1,1)+3);
                                    case 2
                                        registers(1)=memory(registers(and(OP1,1)+3)+1);
                                    case 3
                                        registers(1)= memory(registers(and(OP1,1)+3)+bitshift(OP1,-1)+1);
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
                         otherwise
                          disp('OP code of 1-op inst is out of scope')
                     end


end

