% Class responsible for each room (location and its motion)
classdef location < handle
   properties
      % distance from the left axis (y-axis) and the location 
      margin_left=.2
      % distance from the bottom axis (x- axis) and the bottom of the location
      margin_buttom=0
      % Location width (relative to x-axis 65%)
      locationWidth=.65
      % Location height (relative to y-axis 5%)    
      locationHeight=.05
      % The content written inside the location
      content='   '
      % The GUI element named text displaying the content
      txtObj=[]
      % Holds The rectangle GUI element
      box=[]
      % Default colors reserved for future use
      color=['none','green']
      % Default number of animations
      numberOfAnumations=3;
      % Default Animation length
      animationLength = .2;
   end
   methods
      
      % Constructor for the  Location class with default text and location
      % origin (loc_x,loc_y) and dimensions (width,height)
      function obj = location(mytext,loc_x,loc_y,width,height)
         
          
          if(nargin==1)
          obj.content=mytext;
          end

          if(nargin==5)
          obj.margin_left=loc_x;
          obj.margin_buttom=loc_y;
          obj.locationWidth=width;
          obj.locationHeight=height;
          obj.content=mytext;
          end
          obj.box = rectangle();
          obj.txtObj=text(obj.margin_left,obj.margin_buttom,obj.content,'FontSize',13.5);
          set(obj.txtObj,'Units','normalized')

      end
      
      %Paint the location to the GUI
      function paint(obj)
        set(obj.txtObj,'Position',[obj.margin_left,obj.locationHeight/2+obj.margin_buttom])
        set(obj.box,'Position',[obj.margin_left,obj.margin_buttom,obj.locationWidth,obj.locationHeight],'Curvature',0.15,'FaceColor',[.39,.95,.35]);
      end
      
      % move the location to the right
      function obj=moveRight(obj,dist)
          obj.margin_left=obj.margin_left+dist;
          obj.paint();
      end
      
      % changes the color of the location back and forth by the number numberOfAnumations
      function obj=animate(obj,numberOfAnumations,animationLength)
        InitialColor=obj.box.FaceColor;
        if nargin==1 
        for i=1:obj.numberOfAnumations
            set(obj.box,'FaceColor','red')
            pause(obj.animationLength)
            set(obj.box,'FaceColor',InitialColor)
            pause(obj.animationLength)        
        end
        elseif nargin==2 
            for i=1:numberOfAnumations
                set(obj.box,'FaceColor','red')
                pause(obj.animationLength)
                set(obj.box,'FaceColor',InitialColor)
                pause(obj.animationLength)        
            end
        elseif nargin==3 
            for i=1:numberOfAnumations
                set(obj.box,'FaceColor','red')
                pause(animationLength)
                set(obj.box,'FaceColor',InitialColor)
                pause(animationLength)        
            end
        end
      end
   end
end