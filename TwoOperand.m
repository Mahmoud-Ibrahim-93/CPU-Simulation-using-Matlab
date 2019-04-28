function [ registers,memoryFull ] = TwoOperand ( AM1,AM2,registers,memoryFull,OP1,OP2,OpCode )
                switch OpCode           
                    case 0 % Copy OP2 to OP1
                        
                        switch AM1
                            
                            case 0
                               disp(' Error Can not copy to immediate value')
                               case 1
                                switch AM2
                                
                                    case 0
                                        registers(bitand(OP1,1)+3)=OP2;
                                        case 1
                                        registers(bitand(OP1,1)+3)=registers(bitand(OP2,1)+3);
                                    case 2
                                        registers(bitand(OP1,1)+3)=memoryFull(registers(bitand(OP2,1)+3)+1) ;
                                        case 3
                                        registers(bitand(OP1,1)+3)=memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                                end
                            case 2
                                switch AM2
                                
                                    case 0
                                    memoryFull(registers(bitand(OP1,1)+3)+1) =OP2;
                                    case 1
                                    memoryFull(registers(bitand(OP1,1)+3)+1)=registers(bitand(OP2,1)+3);
                                    case 2
                                    memoryFull(registers(bitand(OP1,1)+3)+1)=memoryFull(registers(bitand(OP2,1)+3)+1) ;
                                    case 3
                                     memoryFull(registers(bitand(OP1,1)+3)+1)=memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                                        
                                end
                            case 3
                                switch AM2
                                
                                    case 0
                                    memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =OP2;
                                    case 1
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =registers(bitand(OP2,1)+3);
                                    case 2
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memoryFull(registers(bitand(OP2,1)+3)+1) ;
                                    case 3
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                                end
                            
                        end
                        
                        
                    case 2 % OP1=OP1+OP2
                        %%%%%%
                        
                        
                        
                        
                        switch AM1
                            
                            case 0
                               disp(' Error Can not copy to immediate value')
                               case 1
                                switch AM2
                                
                                    case 0
                                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+OP2;
                                    case 1
                                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+registers(bitand(OP2,1)+3);
                                    case 2
                                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+memoryFull(registers(bitand(OP2,1)+3)+1) ;
                                    case 3
                                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)+memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                                end
                            case 2
                                switch AM2
                                
                                    case 0
                                    memoryFull(registers(bitand(OP1,1)+3)+1) =memoryFull(registers(bitand(OP1,1)+3)+1)+OP2;
                                    case 1
                                    memoryFull(registers(bitand(OP1,1)+3)+1)=memoryFull(registers(bitand(OP1,1)+3)+1)+registers(bitand(OP2,1)+3);
                                    case 2
                                    memoryFull(registers(bitand(OP1,1)+3)+1)=memoryFull(registers(bitand(OP1,1)+3)+1)+memoryFull(registers(bitand(OP2,1)+3)+1) ;
                                    case 3
                                     memoryFull(registers(bitand(OP1,1)+3)+1)=memoryFull(registers(bitand(OP1,1)+3)+1)+memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                                        
                                end
                            case 3
                                switch AM2
                                
                                    case 0
                                    memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+OP2;
                                    case 1
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+registers(bitand(OP2,1)+3);
                                    case 2
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+memoryFull(registers(bitand(OP2,1)+3)+1) ;
                                    case 3
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)+memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                                end
                            
                        end
                        
                        
                        
                        
                        %%%%%%
                        
                    case 3 % OP1=OP1-OP2
                        
                           %%%%%%
                        
                        
                        
                        
                        
                        switch AM1
                            
                            case 0
                               disp(' Error Can not copy to immediate value')
                               case 1
                                switch AM2
                                
                                    case 0
                                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-OP2;
                                    case 1
                                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-registers(bitand(OP2,1)+3);
                                    case 2
                                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-memoryFull(registers(bitand(OP2,1)+3)+1) ;
                                    case 3
                                        registers(bitand(OP1,1)+3)=registers(bitand(OP1,1)+3)-memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                                end
                            case 2
                                switch AM2
                                
                                    case 0
                                    memoryFull(registers(bitand(OP1,1)+3)+1) =memoryFull(registers(bitand(OP1,1)+3)+1)-OP2;
                                    case 1
                                    memoryFull(registers(bitand(OP1,1)+3)+1)=memoryFull(registers(bitand(OP1,1)+3)+1)-registers(bitand(OP2,1)+3);
                                    case 2
                                    memoryFull(registers(bitand(OP1,1)+3)+1)=memoryFull(registers(bitand(OP1,1)+3)+1)-memoryFull(registers(bitand(OP2,1)+3)+1) ;
                                    case 3
                                     memoryFull(registers(bitand(OP1,1)+3)+1)=memoryFull(registers(bitand(OP1,1)+3)+1)-memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                                        
                                end
                            case 3
                                switch AM2
                                
                                    case 0
                                    memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-OP2;
                                    case 1
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-registers(bitand(OP2,1)+3);
                                    case 2
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-memoryFull(registers(bitand(OP2,1)+3)+1) ;
                                    case 3
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)-memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1);
                                end
                            
                        end
                        
                        
                        
                        
                        
                        %%%%%%
                        
                    case 8 % OP1=XOR(OP1,OP2)
                           %%%%%%
                        
                        
                        
                        
                        
                        switch AM1
                            
                            case 0
                               disp(' Error Can not copy to immediate value')
                               case 1
                                switch AM2
                                
                                    case 0
                                        registers(bitand(OP1,1)+3)=bitxor(registers(bitand(OP1,1)+3),OP2);
                                    case 1
                                        registers(bitand(OP1,1)+3)=bitxor(registers(bitand(OP2,1)+3),registers(bitand(OP1,1)+3));
                                    case 2
                                        registers(bitand(OP1,1)+3)=bitxor(memoryFull(registers(bitand(OP2,1)+3)+1),registers(bitand(OP1,1)+3)) ;
                                    case 3
                                        registers(bitand(OP1,1)+3)=bitxor(memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1),registers(bitand(OP1,1)+3));
                                end
                            case 2
                                switch AM2
                                
                                    case 0
                                    memoryFull(registers(bitand(OP1,1)+3)) =bitxor(OP2,memoryFull(registers(bitand(OP1,1)+3)+1));
                                    case 1
                                    memoryFull(registers(bitand(OP1,1)+3)+1)=bitxor(registers(bitand(OP2,1)+3),memoryFull(registers(bitand(OP1,1)+3)+1));
                                    case 2
                                    memoryFull(registers(bitand(OP1,1)+3)+1)=bitxor(memoryFull(registers(bitand(OP2,1)+3)+1),memoryFull(registers(bitand(OP1,1)+3)+1)) ;
                                    case 3
                                     memoryFull(registers(bitand(OP1,1)+3)+1)=bitxor(memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1),memoryFull(registers(bitand(OP1,1)+3)+1));
                                        
                                end
                            case 3
                                switch AM2
                                
                                    case 0
                                    memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(OP2,memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1));
                                    case 1
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(registers(bitand(OP2,1)+3),memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1));
                                    case 2
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(memoryFull(registers(bitand(OP2,1)+3)+1),memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1)) ;
                                    case 3
                                     memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1) =bitxor(memoryFull(bitshift(OP2,-1)+registers(bitand(OP2,1)+3)+1),memoryFull(bitshift(OP1,-1)+registers(bitand(OP1,1)+3)+1));
                                end
                            
                        end
                        
                        
                        
                        
                        
                        %%%%%%
                                                                                              
                    otherwise
                        disp('Out of Op-Code data scope')
                end
                
              
                end
                
                 
