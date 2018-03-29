%�Ƚ�seqId1�е�������seqId2�����еĴ�֡�
%ÿ�д���seqId1��һ�����У�ÿ�д���seqId2��һ������
function [bitscore, eval] = pairVals(pairfile,seqId1,seqId2)
      
    if iscell(seqId1)
        row = size(seqId1,2);
    else
        row = 1;
    end
    if iscell(seqId2)
        col = size(seqId2,2);
    else
        col = 1;
    end
    fid = fopen(pairfile,'r');
    
    bitscore = 18*ones(row,col);
    eval = 15*ones(row,col);
    tline=fgetl(fid);
    while ischar(tline) && ~isempty(tline)
        A = textscan(tline,'%s %s %f %d %d %d %d %d %d %d %f %f');
        p1 = A(1);
        p2 = A(2);
        if row == 1
            i = 1;
        else
            i = findStrFromCell(seqId1, p1{1});
        end
        j = findStrFromCell(seqId2, p2{1});
        if j==0 
            tline=fgetl(fid);
            continue;
        end
        eval(i,j) = A{11};
        bitscore(i,j) = A{12};
        tline=fgetl(fid);
    end
    fclose(fid);