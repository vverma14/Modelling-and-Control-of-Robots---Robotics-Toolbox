function finaljacob = Geometric_Jacob_Sym(DH)
[row,num] = size(DH);
F = sym('A', [num 4]);
B=eye(4);
C = sym('C', [4 4]);
clc
A=[];
theta= sym('q', [1 num]);
for i=1:num
    
    F(i,1)=DH(1,i); %a
    
    F(i,2)= DH(2,i);%alpha
    
    
    
    F(i,3)=DH(3,i);%d
    
    
    
    F(i,4)=theta(i);%theta
    
    F(i,5)=DH(5,i);%joint type
    
    C=simplify([cos(F(i,4)) -sin(F(i,4))*cos(F(i,2)) sin(F(i,4))*sin(F(i,2)) F(i,1)*cos(F(i,4));
             sin(F(i,4)) cos(F(i,4))*cos(F(i,2)) -cos(F(i,4))*sin(F(i,2)) F(i,1)*sin(F(i,4));
             0 sin(F(i,2)) cos(F(i,2)) F(i,3);
             0 0 0 1]);
    eval(sprintf('A%d = C;',i));
   % B=B*C; 
    Mat=eval(sprintf('A%d',i));
    B=B*C;
    Zmatrix(1:3,i)=B(1:3,3);
    Pmatrix(1:3,i)=B(1:3,4);
end
%sprintf('T from Link 0 to Link %d is:',i)
%pretty(simplify(B))
z0=[0;0;1];
p0=[0;0;0];
pe=B(1:3,4);
%'Rotation Matrix=R'  , R=B(1:3,1:3);
%x=simplify(R)
%d=B(1:3,4);
%'translation Matrix=d' , simplify(d)
if (F(1,5))==1
   Jacobmatrix(1:3,1)=cross(z0,(pe-p0));
   Jacobmatrix(4:6,1)=z0;
else
    Jacobmatrix(1:3,1)=z0;
    Jacobmatrix(4:6,1)=[0;0;0];
end
m=1;
for i=2:num
 if (F(i,5))==1
     Jacobmatrix1(1:3,i)=cross(Zmatrix(:,m),(pe-Pmatrix(:,m)));
     Jacobmatrix1(4:6,i)=Zmatrix(:,m);
 else
     Jacobmatrix1(1:3,i)=Zmatrix(:,m);
     Jacobmatrix1(4:6,i)=[0;0;0];
    
 end
m=m+1;
end
if num>1
Jacobmatrix;
Jacobmatrix1(:,1)=[];
JACOBMATRIX=horzcat(Jacobmatrix,Jacobmatrix1);
finaljacob=simplify(JACOBMATRIX);
else
finaljacob=Jacobmatrix;
end
end

