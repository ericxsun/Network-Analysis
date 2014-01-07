function cluster_coeff_edge_batch()
%CLUSTER_COEFF_EDGE_BATCH To compute cluster coefficient of edges.
%   CLUSTER_COEFF_EDGE_BATCH() computes the cluster coefficient of edges of
%   all the graphs.
%
%   Algorithm:
%   
%   Note:
%
%   Example:
%
%   Ref:
%
%   See also: 
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2013/12/17 09:00$
%

%-------------------------------------------------------------------------------

net_dir = '../data/net/';
res_dir = '../data/edge-cluster/';

net_prefix = {
'3-wordadj';
'6-polblogs-maxcomponent';
'10-condmat1999-maxcomponent';
'13-astroph-maxcomponent';
'14-hepth-maxcomponent';
'15-netscience-maxcomponent';
'16-as22july06';
'17-URVemail';
'18-jazz';
'19-pgp';
};
directed = false;

n_nets = size(net_prefix, 1);

for i = 1 : n_nets
    fprintf('[%d-%d]-%s\n', n_nets, i, net_prefix{i});
	fname = strcat(net_dir, net_prefix{i}, '.edges');
    
    edgeL = load(fname);
    adjL  = edgeL2adjL(edgeL, directed);
    cluster_coeff = cluster_coeff_edge(edgeL,adjL, directed);
    
    fname = strcat(res_dir, net_prefix{i}, '-edge-cluster.edges');
    fp    = fopen(fname, 'w');
    fprintf(fp, '%d\t%d\t%.6f\n', cluster_coeff');
    fclose(fp);
end

%-------------------------------------------------------------------------------
end