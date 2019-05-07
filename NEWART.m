%A new version of ART 
P = phantom(64);
PSIZE = size(P);
P1 = PSIZE(1);
P2 = PSIZE(2);
detelength = ceil(sqrt(P1^2 + P2^2));%gap of detector
detegap = 1;
rhosum = 1:floor(detelength);
a = floor(detelength);
thetarange = 0:179;
thetagap = 1;%gap of theta
thetasum = 0.1:thetagap:179.1;
%size(radonsum)
%rhosumnp = -ceil(detelength/2):ceil(detelength/2);
rhosumnp = -ceil(detelength/2):detegap:ceil(detelength/2);
numdet = size(rhosumnp,2);
ls = size(rhosumnp,2);
ll = ceil(detelength/2);
radonsum = zeros(size(rhosumnp,2),size(thetasum,2));
projection = radonsum*0;
%xorin = floor(P1/2);
%yorin = floor(P2/2);
kk=1;
IDrho = cell(1,size(rhosumnp,2)*size(thetasum,2));%
itheta = 1;
probar = waitbar(0,'Projection Progress');%a time bar show the progress of the projection
for i = thetasum
    %costh = abs(cos((0.5+i)*pi/180));
    %disp(i);
    jrho = 0;
    for j = rhosumnp
        sum = 0;
        pero = zeros(P1,P2);
        jrho = jrho + 1;%
%         perrho = zeros(P1,P2);
%         for ii = 1:P1
%             for jj = 1:P2
%                [flag,py1,py2] = judge(ii-xorin,jj-yorin,j,i+0.5);
%                 if flag == 1
%                     length = abs(py1-py2)/costh;
%                    
%                 else
%                     length = 0;
%                 end
%                 perrho(ii,jj) = length;
%                 sum = sum + length*P(ii,jj);
%            end
%         end
%        IDrho{1,ls*i+jrho} = perrho;
%        projection(jrho,i+1) = sum; 
       [sum,Am] = ReturnValue(P,j,i);
       %radonsum(jrho,i+1) = sum;
       radonsum(jrho,itheta) = sum;
       tempam = full(Am);
       pero(1:size(tempam,1),1:size(tempam,2)) = tempam;
       IDrho{1,ls*itheta+jrho} = pero;
       projection(jrho,itheta+1) = sum;
%         if i<=90
%                 radonsum(jrho,i+1) = sum;
%                 %IDrho{1,size(rhosumnp,2)*(i+90-1)+ ls+1-jrho} = perrho;
%         else
%                 radonsum(ls+1-jrho,i+1) = sum;
%                 %IDrho{1,size(rhosumnp,2)*(i-90-1)+ls+1-jrho} = perrho;
%         end
                
                
    end
    itheta = itheta + 1;
    prostrbar = ['Projection Progress',num2str(itheta/180*100),'%'];
    waitbar(itheta/180,probar,prostrbar);
end
delete(probar);
%iteration  = 64*180;
[prom,pron] = size(projection);
projectionline = reshape(projection,prom*pron,1);
lamdak = 0.2;%
X0 = zeros(P1*P2,1);
eff = 0;
    %X0 = 0.5*reshape(IDrho{1,40},1,P1*P2)';
h = waitbar(0,'Iteration Progress');

for Iter = 1:10
    %disp(Iter);
for iter = 1:180*floor(size(rhosumnp,2))
    %ik = mod(iter-1,P1*P2)+1;
    ik = iter;
    %fprintf('Iteration :%d\n',ik);
    %rik = reshape(IDrho{1,ik},1,P1*P2);
    if projectionline(ik,1) ~= 0
    %if rik*X0 <= projectionline(ik,1)
       %X0 = X0;
   % else
   rik = reshape(IDrho{1,ik},1,P1*P2);
        rikT = rik';
        eff = eff +1;
        %next line: Use the logical matrix to just correct the pixels which
        %are crossed by the special line(theta,rho)
        X0(rik'>0) = X0(rik'>0)+ 0.2*(projectionline(ik,1)-rik*X0)*(rikT(rikT>0))/(rik*rik');
        
        
        %disp('kk');
    end
    %end
   
end
iterstrbar = ['Iteratiow34n Progress',num2str(Iter/10*100),'%'];
waitbar(Iter/10,h,iterstrbar);
end
delete(h);
imshow(reshape(X0,P1,P2));