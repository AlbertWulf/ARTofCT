%
%A try of A new way of calculate the length and id of the grid when a line
%crosses it
function [value3all,A3]= ReturnValue(im3,rho3,theta3)
      length3all = 0;
      value3all = 0;
%       theta3 = (theta3+0.2)*pi/180;
      theta3 = (theta3)*pi/180;
      row3 = size(im3,1);
      clo3 = size(im3,2);
      xline3 = -clo3/2:clo3/2;
      xcross3 = (rho3-xline3*cos(theta3))/sin(theta3);
      yline3 = -row3/2:row3/2;
      ycross3 = (rho3-yline3*sin(theta3))/cos(theta3);
      costh3 = cos(theta3);
      panel3 = zeros(2,2*(row3+1));
      panel3(1,1:(row3+1)) = xline3;
      panel3(1,(row3+2):2*(row3+1)) = ycross3;
      panel3(2,1:(row3+1)) = xcross3;
      panel3(2,(row3+2):2*(row3+1)) = yline3;
      panelT3 = panel3';
      panelT3 = sortrows(panelT3,1);
      panel3 = panelT3';
      matrixx3 = ones(1,1);
      matrixy3 = ones(1,1);
      matrixlength3 = zeros(1,1);
      point3 = 0;%confirm the number of valid points
      for pp = 1:size(panel3,2)-1
          halfx = (panel3(1,pp)+panel3(1,pp+1))/2 ;
          halfy = (panel3(2,pp)+panel3(2,pp+1))/2 ;
          %imx = ceil(abs(halfx))*abs(halfx)/halfx;
          %imy = ceil(abs(halfy))*abs(halfy)/halfy;
          imx = floor(halfx);
          imy = floor(halfy);
          length3 = 0;
          
          if (halfx<row3/2) && (halfx>-row3/2) && (halfy>-clo3/2) && (halfy<clo3/2)
              point3 = point3 + 1;
              length3 = abs((panel3(2,pp)-panel3(2,pp+1))/costh3);
              length3all = length3 + length3all;
              value3all = value3all + abs((panel3(2,pp)-panel3(2,pp+1))/costh3)*im3(imx+clo3/2+1,imy+row3/2+1);
              matrixx3(1,point3) = imx+clo3/2+1;
              matrixy3(1,point3) = imy+row3/2+1;
              matrixlength3(1,point3) = length3 ;
          end
          
      end
     A3 = sparse(matrixx3,matrixy3,matrixlength3);