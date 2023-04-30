function result=relys(popxc,C,D)
    %load data C D
    %load data1 guanlian
    C0=C(:,(popxc(:)==1));
    [m,n]=size(C0);
    [~,n_star]=size(C);
    [p,q]=size(D);
    if sum(popxc(:))==n_star
        result=0;
    else
    for ii=1:q
        D0=D(:,1:ii);
        [p0,q0]=size(D0);
        C1=unique(C0,'rows');
        D1=unique(D0,'rows');
        [m1,n1]=size(C1);
        [p1,q1]=size(D1);
        %===============划分等价类(条件属性)================
        for i=1:m
            for j=1:m1
                if isequal(C0(i,1:n),C1(j,1:n1))==1%条件属性
                    C0(i,n+1)=j;
                end
            end
        end
        %==============划分等价类(决策属性)=================
        for i=1:p0
            for j=1:p1
                if isequal(D0(i,1:q0),D1(j,1:q1))==1%条件属性
                    D0(i,q0+1)=j;
                end
            end
        end
        %===============等价关系=============
        for i=1:m
            k=0;
            for j=1:m
                if C0(i,n+1)==C0(j,n+1)
                   k=k+1;
                   ind_c(i,k)=j;
                end
            end
        end
        for i=1:p0
            k=0;
            for j=1:p0
                if D0(i,q0+1)==D0(j,q0+1)
                   k=k+1;
                   ind_d(i,k)=j;
                end
            end
            ind_d(i,k+1)=0;
        end
        %==================计算正域==================
        for i=1:m
            pos(i)=all(ismember(ind_c(i,:),ind_d(i,:)));
        end
        %fit(ii)=sum(guanlian(1:ii))*sum(pos(:))/m;
        fit(ii)=sum(pos(:))/m;
    end
    %for i=1:q
    %   fit(i)=sum(guanlian(1:i))*sum(pos(:))/m;
    %    %fit(i)=sum(pos(:))/m;
    %end
    result=sum(fit(:));
    end
return