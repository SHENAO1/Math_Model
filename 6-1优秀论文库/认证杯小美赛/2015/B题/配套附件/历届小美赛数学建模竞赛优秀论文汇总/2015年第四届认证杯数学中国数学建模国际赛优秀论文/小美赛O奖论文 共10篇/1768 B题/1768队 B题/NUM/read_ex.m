clear;  %¶Áxlsx
for n = 1:30;
    for no_ = 1:4
    eval([' [temp]=xlsread(''',num2str(n),''',no_); ']);
    eval(['NUM',num2str(n),'( :,no_:4:(44+no_) ) = temp( temp(:,1)>1990&temp(:,1)<=2015,2:13);']);
    end;
    eval(['NUM',num2str(n),'(isnan(NUM',num2str(n),')) =  mean(NUM',num2str(n),'(~isnan(NUM',num2str(n),')))+2;']);
     eval(['save NUM',num2str(n),'.mat']);
end;

  
  