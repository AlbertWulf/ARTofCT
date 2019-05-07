%A try of A new way of calculate the length and id of the grid when a line
%crosses it
function value2= Getlength(im2,rho2,theta2)
      length2 = 0;
      value2 = 0;
      theta2 = (theta2+0.2)*pi/180;
      row2 = size(im2,1);
      clo2 = size(im2,2);
      xline = -clo2/2:clo2/2;
      xcross = (rho2-xline*cos(theta2))/sin(theta2);
      yline = -row2/2:row2/2;
      ycross = (rho2-yline*sin(theta2))/cos(theta2);
      panel = zeros(2,2*(row2+1));
      panel(1,1:(row2+1)) = xline;
      panel(1,(row2+2):2*(row2+1)) = ycross;
      panel(2,1:(row2+1)) = xcross;
      panel(2,(row2+2):2*(row2+1)) = yline;
      panelT = panel';
      panelT = sortrows(panelT,1);
      panel = panelT';
      for pp = 1:size(panel,2)-1
          halfx = (panel(1,pp)+panel(1,pp+1))/2 ;
          halfy = (panel(2,pp)+panel(2,pp+1))/2 ;
          %imx = ceil(abs(halfx))*abs(halfx)/halfx;
          %imy = ceil(abs(halfy))*abs(halfy)/halfy;
          imx = floor(halfx);
          imy = floor(halfy);
          
          if (halfx<row2/2) && (halfx>-row2/2) && (halfy>-clo2/2) && (halfy<clo2/2)
              length2 = length2 + abs((panel(2,pp)-panel(2,pp+1))/cos(theta2));%后续将cos先算出来
              value2 = value2 + abs((panel(2,pp)-panel(2,pp+1))/cos(theta2))*im2(imx+clo2/2+1,imy+row2/2+1);
          end
      end
      
     