
% Lin structural controllabuility theorem
function isSControllable = LinControllability(A,B)
    %Lin's structural controllability theorem checks if the function is
    %structurally controllable
    %Theorem 1 (Lin’s Structural Controllability Theorem).
    %The following three statements are equivalent:
    %1. A linear control system (A, B) is structurally controllable.
    %2. i) The digraph G(A, B) contains no inaccessible nodes.
    %ii) The digraph G(A, B) contains no dilation.
    %3. G(A, B) is spanned by cacti


    %no inaccessible nodes
    flag1=1;
    flag2=1;
    

    length(checkreachableset(A,B));
    size(A,1);

    if sum(checkreachableset(A,B))~=size(A,1)
        flag1=0;
    end

    if checkDilation(A,B)==1
        flag2=0;
    end

    if flag1==1 && flag2==1
        isSControllable=1;
        % print('state space system is structurally controllable');
    else
        isSControllable=0;
        % print('state space system is not structurally controllable')


end




