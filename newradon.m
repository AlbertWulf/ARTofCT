%My new radon
P = phantom(64);
PSIZE = size(P);
P1 = PSIZE(1);
P2 = PSIZE(2);
detegap = ceil(sqrt(P1^2 + P2^2));%gap of detector
rhosum = 1:floor(detegap);
a = floor(detegap);
thetasum = 0:179;

%size(radonsum)
rhosumnp = -ceil(detegap/2):ceil(detegap/2);
numdet = size(rhosumnp,2);
ls = size(rhosumnp,2);
ll = ceil(detegap/2);
radonsum = zeros(size(rhosumnp,2),size(thetasum,2));
projection = radonsum*0;
xorin = floor(P1/2);
yorin = floor(P2/2);
kk=1;
%IDrho = cell(1,size(rhosumnp,2)*size(thetasum,2));%用于存放对应的系数矩阵
for i = thetasum
    %costh = abs(cos((0.5+i)*pi/180));
    jrho = 0;
    for j = rhosumnp
        sum = 0;
        jrho = jrho + 1;%用于标记每一次theta时是第几条射线
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
       sum = Getlength(P,j,i);
       radonsum(jrho,i+1) = sum;
%         if i<=90
%                 radonsum(jrho,i+1) = sum;
%                 %IDrho{1,size(rhosumnp,2)*(i+90-1)+ ls+1-jrho} = perrho;
%         else
%                 radonsum(ls+1-jrho,i+1) = sum;
%                 %IDrho{1,size(rhosumnp,2)*(i-90-1)+ls+1-jrho} = perrho;
%         end
                
                
    end
end
%h = fspecial('gaussian',10 );
%imshow(radonsum);
%P = phantom(64); % create a shepp-logan
% linepro = reshape(radonsum,size(rhosumnp,2)*size(thetasum,2),1);%投影矩阵的列向量形式
% linepro64 = linepro(1:P1*P2,1);%投影矩阵的列向量形式，取4096位
% IDrho64 = IDrho(1,20:P1*P2+19);%系数矩阵的列向量形式，取4096位
% Ri = zeros(1,P1*P2);

%X0  = zeros(P1*P2,1);
% for X0I = 1:P1*P2
%     X0 = X0 +

% iteration  = 20;%迭代次数
% lamdak = 0.2;%调节系数
% for iter = 1:iteration
%     ik = mod(P1*P2,iter)+1;
%     fprintf('迭代次数%d',iter);
%    rik =  reshape(IDrho64{1,ik},1,P1*P2);
%     if reshape(IDrho64{1,ik},1,P1*P2)*X0 <linepro64(ik,1)
%         X0 = X0;
%     else
%         X0 = X0 + lamdak*(linepro64(ik,1)-rik*X0)*rik'/(rik*rik');
%     end
% end
original = zeros(P1,P2);
 profilter = zeros(size(radonsum,1),size(radonsum,2));
for angel = 1:180
    
    for rhorr =  1:2*ceil(detegap/2)+1
        sum = 0;
        for mk =  1:2*ceil(detegap/2)+1
            sum = sum + radonsum(mk,angel)*RLfilter(rhorr-mk);
        end
        profilter(rhorr,angel)= sum;
    end
end
for oo = 1:P1
    for qq = 1:P2
        www = 0;
        for tt = 1:180
            wrho = (oo-P1/2)*cos(tt*pi/180) + (qq-P2/2)*sin(tt*pi/180);
            shwrho = floor(wrho);
            cerho = ceil(wrho);
            www = www + profilter(shwrho+ll,tt)*(1-abs(wrho-shwrho))+ profilter(cerho+ll,tt)*(1-abs(cerho-wrho));
        end
        original(oo,qq) = www;
    end
end
imshow(original,[]);
    
  