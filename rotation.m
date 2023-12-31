function rotations = rotation(code1, code2)
% The "rotation" function serves the purpose of determining the
% relationship between pcodes or profiles, particularly whether it qualifies
% as a rotation or not. When a rotation is identified, the function returns
% a string that indicates its quality. In cases where no rotation exists,
% the function returns an empty string.
% 
% Usage:
%       rotations (first rhythmic profile code or name, second rhythmic
%       profile code or name)
% Example:
%         rotation ('0t1', '0i1')
% 
%         ans =
% 
%             'RLc'
% 
% Created in July 2023 under MATLAB 2022 (Mac OS)
%
% � Part of Prosodic Rhythms Analysis Toolbox - PRA Toolbox,
% Copyright �2023, Pauxy Gentil Nunes Filho, Filipe de Matos Rocha
% PArtiMus, and MusMat Research Groups - PPGM-UFRJ
% See License.txt
% ==========
% basic conversion
if size(code1,2) < 4
    code1 = p2code(code1);
end
if size(code2,2) < 4
    code2 = p2code(code2);
end
% rotation analysis
rotations = [];
rot = [];
matriz = 'tadc';
pfxrel = ['it';'ab';'bd';'ad'];
    for f = 1:size(code1,1)
        tcode1 = (code1(f,:));
        tcode2 = (code2(f,:));
        %icode1 = code1(f,2:4)
        %icode2 = code2(f,2:4)
        z1 = find(tcode1 == '0');
        z2 = find(tcode2 == '0');
        z1z2 = [numel(z1) numel(z2)];
        dif = find((tcode1 == tcode2)==0);
        % there is parsimony
        if size(dif,2) > 1
            if (any((isletter(tcode1)|isletter(tcode2))))==0
            dif1 = sort(tcode1(dif));
            dif2 = sort(tcode2(dif));
            % simple profile
                if dif1 == dif2 & isequal(tcode1(1),tcode2(1))
                    rot = 'R';
                end
            end
        elseif size(dif,2)==1
            dif = find((tcode1 == tcode2)==0);
            difs = sort([tcode1(dif) tcode2(dif)]);
            if sum(isletter(difs))==2
                    if any(ismember(pfxrel,difs,'rows'))
                        rot = ['RL' matriz(dif)];
                    end
            end
        else
            rot = '0';
        end
    end
    rotations = [rotations; rot];
end