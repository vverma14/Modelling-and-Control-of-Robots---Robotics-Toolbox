function  [T,Tf]=For_Kin_angles(R,DH,Q)

[~,num] =size(DH); 
F = sym('A', [num 4]);
B=eye(4);
P=eye(4);
C = sym('C', [4 4]);
A=[];

theta= Q*pi/180;


for i=1:num
    F(i,1)=DH(1,i); %a
    
    F(i,2)= DH(2,i);%alpha
    
    
    
    F(i,3)=DH(3,i);%d
    
    
    
    F(i,4)=theta(i);%theta
    
    F(i,5)=DH(5,i);%joint type
    
       
      % FOR FORWARD KINEMATICS
    C=([cos(str2num(char(F(i,4)))) -sin(str2num(char(F(i,4))))*cos(str2num(char(F(i,2)))) sin(str2num(char(F(i,4))))*sin(str2num(char(F(i,2)))) str2num(char(F(i,1)))*cos(str2num(char(F(i,4))));sin(str2num(char(F(i,4)))) cos(str2num(char(F(i,4))))*cos(str2num(char(F(i,2)))) -cos(str2num(char(F(i,4))))*sin(str2num(char(F(i,2)))) str2num(char(F(i,1)))*sin(str2num(char(F(i,4))));0 sin(str2num(char(F(i,2)))) cos(str2num(char(F(i,2)))) str2num(char(F(i,3)));0 0 0 1]);
    T(i)={C}
    B=B*C;
%      % FOR FORMULA
%     D=([cos(F(i,4)) -sin(F(i,4))*cos(F(i,2)) sin(F(i,4))*sin(F(i,2)) F(i,1)*cos(F(i,4));sin(F(i,4)) cos(F(i,4))*cos(F(i,2)) -cos(F(i,4))*sin(F(i,2)) F(i,1)*sin(F(i,4));0 sin(F(i,2)) cos(F(i,2)) F(i,3);0 0 0 1]);    
%     P=P*D;
end   
     Tf=((B))