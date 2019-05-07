%This is an old version and has been replaced by NEWART created
%one day later;
%My ART 
%2018/12/10,Sixth Teaching Building

iteration  = 64*180;%迭代次数
projectionline = reshape(projection,93*180,1);
lamdak = 0.2;%调节系数
X0 = ones(P1*P2,1);

    %X0 = 0.5*reshape(IDrho{1,40},1,P1*P2)';
for iter = 1:180*90
    %ik = mod(iter-1,P1*P2)+1;
    ik = iter;
    %fprintf('迭代次数%d\n',ik);
    rik = reshape(IDrho{1,ik},1,P1*P2);
   if projectionline(ik,1) ~=0
    %if rik*X0 <= projectionline(ik,1)
     %   X0 = X0;
    %else
        X0 = X0 + 0.5*(projectionline(ik,1)-rik*X0)*rik'/(rik*rik');
        %disp('kk');
    end
    %end
end
imshow(reshape(X0,64,64),[]);
