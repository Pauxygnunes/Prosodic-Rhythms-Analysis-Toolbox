% ========== Initialize table of relations
load('reldata.mat','reldata');
% ========== Render clusters based on rotations
inds = find(contains (reldata.rel, {'P', 'R'}));
% ========== Select correspondet profiles
rels = reldata(inds,:);