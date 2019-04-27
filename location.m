classdef location < handle
   properties
      margin_left=.2
      margin_buttom=0
      locationWidth=.65
      locationHeight=.05
      content='   '
      txtObj=[]
      box=[]
      color=['none','green']
   end
   methods

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
%           obj.locationWidth=obj.txtObj.Extent(3);
          set(obj.txtObj,'Units','normalized')

      end
      
      function paint(obj)
        set(obj.txtObj,'Position',[obj.margin_left,obj.locationHeight/2+obj.margin_buttom])
        set(obj.box,'Position',[obj.margin_left,obj.margin_buttom,obj.locationWidth,obj.locationHeight],'Curvature',0.15,'FaceColor',[.8,1,1]);
      end
    
      function obj=moveRight(obj,dist)
          obj.margin_left=obj.margin_left+dist;
          obj.paint();
      end
      function obj=animate(obj)
        set(obj.box,'FaceColor','red')
        pause(.5)
        set(obj.box,'FaceColor','blue')
        pause(.5)
      end
   end
end