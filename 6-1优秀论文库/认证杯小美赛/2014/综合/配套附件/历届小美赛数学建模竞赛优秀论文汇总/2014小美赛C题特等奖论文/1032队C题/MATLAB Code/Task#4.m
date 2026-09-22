clc,clear 
Number=input('please enter the codes of problem(1 min risks 2lowest cost£©Number=£º');
if Number==1
    F=[5 4 5 1 2 3 2 4 5 5 1 5 1 3 1 2 3 2 4 2 1 3 4 2 3];
elseif Number==2
    F=[20 19 20 28 17 18 24 27 20 20 26 16 15 18 15 17 20 24 19 16 15 18 21 17 21];
end
A=[];B=[];
Aeq=[ones(1,5) zeros(1,20);zeros(1,5) ones(1,5) zeros(1,15);zeros(1,10) ones(1,5) zeros(1,10);...
    zeros(1,15) ones(1,5) zeros(1,5);zeros(1,20) ones(1,5);...
    1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,4);...
    zeros(1,1) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,3);...
    zeros(1,2) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,2);...
    zeros(1,3) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,1);...
    zeros(1,4) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,4) 1 zeros(1,0)];
Beq=ones(1,10);
if Number==1
    [x,min_fval]=bintprog(F,A,B,Aeq,Beq);
    min_fval2=min_fval/5;
    fprintf('(1)the match function of company£º\n')
    fprintf('(A1) the match function of company A£¨1 replace match 0 replace not match£©\n')
    disp('    A-1   A-2   A-3   A-4   A-5'),disp(x(1:5)')
    fprintf('(B1) the match function of company B£¨1 replace match 0 replace not match£©\n')
    disp('    B-1   B-2   B-3   B-4   B-5'),disp(x(6:10)')
    fprintf('(C1) the match function of company C£¨1 replace match 0 replace not match£©\n')
    disp('    C-1   C-2   C-3   C-4   C-5'),disp(x(11:15)')
    fprintf('(D1) the match function of company D£¨1 replace match 0 replace not match£©\n')
    disp('    D-1   D-2   D-3   D-4   D-5'),disp(x(16:20)')
    fprintf('(E1) the match function of company E£¨1 replace match 0 replace not match£©\n')
    disp('    E-1   E-2   E-3   E-4   E-5'),disp(x(21:25)')
    fprintf('min risks£º'),disp(min_fval2)
elseif Number==2
        [x,min_fval]=bintprog(F,A,B,Aeq,Beq);
        min_fval2=min_fval/5;
    fprintf('(2)the match function of company£º\n')
    fprintf(' (A2) the match function of company B£¨1 replace match 0 replace not match£©\n')
    disp('    A-1   A-2   A-3   A-4   A-5'),disp(x(1:5)')
    fprintf(' (B2) the match function of company B£¨1 replace match 0 replace not match£©\n')
    disp('    B-1   B-2   B-3   B-4   B-5'),disp(x(6:10)')
    fprintf(' (C2) the match function of company C£¨1 replace match 0 replace not match£©\n')
    disp('    C-1   C-2   C-3   C-4   C-5'),disp(x(11:15)')
    fprintf(' (D2) the match function of company D£¨1 replace match 0 replace not match£©\n')
    disp('    D-1   D-2   D-3   D-4   D-5'),disp(x(16:20)')
    fprintf(' (E2) the match function of company E£¨1 replace match 0 replace not match£©\n')
    disp('    E-1   E-2   E-3   E-4   E-5'),disp(x(21:25)')
    fprintf('lowest costs£º'),disp(min_fval2)
end
