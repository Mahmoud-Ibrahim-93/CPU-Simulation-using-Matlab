classdef block < handle
   properties
   %number of floors
   numberOfFloors=10;
   %number of locations per floor
   floorsize=1;
   % an array of locations ( rectangles with text in it )
   building=location();
   % shift the block origin x axis
   shift_x=.05;
   % shift the block origin x axis
   shift_y=.05;
   % Default location width
   location_default_width=.15;
   % Default location height
   loction_default_height=.05;
   end
   methods
      
      % Build the block properties
      function obj = block(floorscount,floor_size,origin_x,origin_y,room_width,room_height)
      if (nargin==1)    
      obj.numberOfFloors=floorscount;  
      end
      if (nargin==2)
      obj.numberOfFloors=floorscount;  
      obj.floorsize=floor_size;  
      end
      if (nargin==3)
      obj.numberOfFloors=floorscount;  
      obj.floorsize=floor_size;  
      obj.shift_x=origin_x;
      end
      if (nargin==4)
      obj.numberOfFloors=floorscount;  
      obj.floorsize=floor_size;  
      obj.shift_x=origin_x;
      obj.shift_y=origin_y;
      end
      if (nargin==5)
      obj.numberOfFloors=floorscount;  
      obj.floorsize=floor_size;  
      obj.shift_x=origin_x;
      obj.shift_y=origin_y;
      obj.location_default_width=room_width;
      end
      if (nargin==6)
      obj.numberOfFloors=floorscount;  
      obj.floorsize=floor_size;  
      obj.shift_x=origin_x;
      obj.shift_y=origin_y;
      obj.location_default_width=room_width;
      obj.loction_default_height=room_height;
      end
      
      % draw the floors of the building
      for j=1:obj.floorsize
         for i=1:obj.numberOfFloors
             % location(mytext,loc_x,loc_y,width,height)
            obj.building(i,j)=location(strcat('F no',{' '},string(i)),(j-1)*obj.location_default_width+obj.shift_x,obj.shift_y+(i-1)*obj.loction_default_height,obj.location_default_width,obj.loction_default_height);
            % draws the loactinon in floor i and squence number j
            obj.building(i,j).paint();
         end
      end
      
      end
      
      % fill a certain location with a certain content
      function fillLocation(obj,floor_level,floor_location_no,content)
          if ~isempty(obj.building) && floor_level <=length(obj.building) 
              if(floor_location_no <=size(obj.building,2))
                  set(obj.building(floor_level,floor_location_no).txtObj,'String',content)
              end
          end
      end
     
   end
end