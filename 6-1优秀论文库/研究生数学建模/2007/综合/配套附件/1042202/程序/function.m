function result= TS_TSP(N, Start)
T= N*20;
TT= ceil(T/2);
tabulength= 5+N;  
runcount= 0; 
Pby= 0.4;
Max= 100000;
while runcount<T
    runcount= runcount+1;
    TongJi1(runcount)= candidate_now.value;
    TongJi2(runcount)= best_so_far.value; 
    kk= 1;
    for i= 1:N-2
        for j= i+1:N-1
            flag= true;
            for n= 1:tabulength
                tempflag= sum(abs(tabulist(n).change-[i, j]));
                flag= flag & tempflag;
            end;
            if flag
                temp= cat(1, candidate_now.xulie);
                t= temp(i);
                temp(i)= temp(j);
                temp(j)= t;
                neighborhood(kk).xulie= temp; 
                neighborhood(kk).change= [i, j];
                kk= kk+1;
            end;
        end;
    end;
    L= length(neighborhood);
    if IsBianYi && runcount<50
        i= L;
        for k= 1:ceil(N)
            if rand<Pby
                i= i+1;
                neighborhood(i).change= [0, 0];
                if rand<0.5
                    xulie_temp= best_so_far.xulie;
                else
                    xulie_temp= candidate_now.xulie;
                end;
                if rand<0.4 
                    if runcount<TT
                        disj= 0;
                        for j= 1:N-3
                            disj_temp= dis(xulie_temp(j), xulie_temp(j+1));
                            if disj_temp>disj
                                disj= disj_temp;
                                indexj= j;
                            end;
                        end;
                        if dis(xulie_temp(N-2), Start)<dis(xulie_temp(N-1), Start)
                            xulie_temp(end-1:end)= xulie_temp(end:-1:end-1);
                        end;
                    else
                        indexj= ceil(rand*(N-3));
                    end; 
                        disj= Max;
                        for j= indexj+2:N-1
                            disj_temp= dis(xulie_temp(indexj), xulie_temp(j));
                            if disj_temp<disj
                                disj= disj_temp;
                                indexjj= j;
                            end;
                        end;
                        xulie_temp(indexj+1:indexjj)= xulie_temp(indexjj:-1:indexj+1);
                        neighborhood(i).xulie= xulie_temp;
                elseif rand<0.6 
                    
                    indexjc= ceil(rand*(N-2));
                    temp11= xulie_temp(1:indexjc);
                    temp22= xulie_temp(indexjc+1:end);
                    xulie_temp= [temp22, temp11];
                    neighborhood(i).xulie= xulie_temp;
                else
                    indexby2length= ceil(rand*ceil(N/4));
                    indexby2start1= ceil(rand*(N-1-indexby2length));
                    tempby21= xulie_temp(indexby2start1 : indexby2start1+indexby2length-1);
                    disby2= dis + Max*eye(N);
                    disby2(:, [1, tempby21])= Max;
                    minindexby2= find(disby2(xulie_temp(indexby2start1), :)==min(disby2(xulie_temp(indexby2start1), :)), 1, 'first');
                    xulie_temp(indexby2start1 : indexby2start1+indexby2length-1)= [];
                    indexby2start2= find(xulie_temp==minindexby2);
                    xulie_tempp= xulie_temp(1:indexby2start2);
                    if rand<0.5
                        xulie_tempp(indexby2start2+1:indexby2start2+1+indexby2length-1)= tempby21;
                    else
                        xulie_tempp(indexby2start2+1+indexby2length-1:-1:indexby2start2+1)= tempby21;
                    end;
                    xulie_tempp(indexby2start2+1+indexby2length:N-1)= xulie_temp(indexby2start2+1:end);
                    neighborhood(i).xulie= xulie_tempp;
                end; 
            end;
        end; 
        L= i;
    end;
        for n= 1:10
            index= find(cat(1, neighborhood.value)==candidate_next(n));
            tx= neighborhood(index(1)).xulie;
            tc= neighborhood(index(1)).change;
            flag= true;
            for i= 2:tabulength
                flag= flag & sum(abs(tc - tabulist(i).change))>0;
            end;
            if flag
                candidate_now.xulie= tx;
                candidate_now.change= tc;
                candidate_now.value= candidate_next(n);
                for i= tabulength-1:-1:1 
                    tabulist(i+1).change= tabulist(i).change;
                    tabulist(i+1).xulie= tabulist(i).xulie;
                    tabulist(i+1).value= tabulist(i).value;
                end;
                tabulist(1).change= candidate_now.change;
                tabulist(1).xulie= candidate_now.xulie;
                tabulist(1).value= candidate_now.value;
                break;
            end;
        end;
    end;
result= best_so_far.value; 
return;