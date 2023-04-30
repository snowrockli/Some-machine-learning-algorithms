function result=rely_g(x,CK,DK)
[~,n_star]=size(CK);
C=CK(:,(x(:)==1));
D=DK;
if sum(x(:))==n_star
    result=0;
else
    [m,n]=size(C);
    [p,q]=size(D);
    D1=unique(D,'rows');
    [p1,q1]=size(D1);
    %==============���ֵȼ���(��������)===============
    for i=1:p
        for j=1:p1
            if isequal(D(i,1:q),D1(j,1:q1))==1%��������
                D(i,q+1)=j;
            end
        end
    end
    %=============�ȼ۹�ϵ(��������)===============
    for i=1:p
        k=0;
        for j=1:p
            if D(i,q+1)==D(j,q+1)
                k=k+1;
                ind_d(i,k)=j;
            end
        end
        ind_d(i,k+1)=0;
    end
    %==========��������============
    for ii=1:n
        C1=unique(C(:,ii),'rows');%ÿһ��������
        [m1,n1]=size(C1);
        ind_c=[];
        %===============���ֵȼ���(��������)==================
        for i=1:m
            for j=1:m1
                if isequal(C(i,ii),C1(j,:))==1%��������
                    C(i,n+1)=j;
                end
            end
        end
        %===============�ȼ۹�ϵ(��������)=============
        for i=1:m
            k=0;
            for j=1:m
                if C(i,n+1)==C(j,n+1)
                    k=k+1;
                    ind_c(i,k)=j;
                end
            end
        end
        %==========���ܲ�ͬ�������Ի��ֳ��ȼ���Ľ��==============
        IND_C(:,:,ii)=zeros(m,m+1);
        [~,cn]=size(ind_c);
        for i=1:m
            for j=1:cn
                IND_C(i,j,ii)=ind_c(i,j);
            end
        end
    end
    %=================���㲻ͬ�������Ե��½��Ƽ�===========
    for ii=1:n
        POS(:,:,ii)=zeros(m,m+1);
        for i=1:m
            if all(ismember(IND_C(i,:,ii),ind_d(i,:)))==1
                POS(i,:,ii)=IND_C(i,:,ii);
            end
        end
    end
    %=================�󽻼�/����=================
    POS_IN=POS(:,:,1);
    POS_UN=POS(:,:,1);
    for ii=1:n
        POS_IN=intersect(POS_IN,POS(:,:,ii));
        POS_UN=union(POS_UN,POS(:,:,ii));
    end
    %=============������============
    rely_in=0.0001+sum(POS_IN~=0)/m;%����
    rely_un=sum(POS_UN~=0)/m;%�ֹ�
    result=(1/n)*rely_un;
end
return