%%
%----------------------------%
%Code used for the papers: 
%1-Applications of Complex Network Analysis in Electric Power Systems
%http://www.mdpi.com/1996-1073/11/6/1381
%2-Optimal Microgrids Placement in Electric Distribution Systems Using Complex Network Framework
%https://ieeexplore-ieee-org.ccny-proxy1.libr.ccny.cuny.edu/document/8191215/
%For Citations: 1- M. saleh, Y. Esa, A. Mohamed, "Applications of Complex Network Analysis in Electric Power Systems," Energies, 2018.
% 2- M. saleh, Y. Esa, A. Mohamed, "Optimal Microgrids Placement in Electric Distribution Systems Using Complex Network Framework,"International Conference on Renewable Energy Research and Applications (ICRERA), San Diego, CA, 2017.
%----------------------------%
%%
clear; clc; clf;
%Branch Data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
branch_data = [
	1	2	0.0192	0.0575	0.0528	0	0	0	0	0	1	-360	360;
	1	3	0.0452	0.1652	0.0408	0	0	0	0	0	1	-360	360;
	2	4	0.057	0.1737	0.0368	0	0	0	0	0	1	-360	360;
	3	4	0.0132	0.0379	0.0084	0	0	0	0	0	1	-360	360;
	2	5	0.0472	0.1983	0.0418	0	0	0	0	0	1	-360	360;
	2	6	0.0581	0.1763	0.0374	0	0	0	0	0	1	-360	360;
	4	6	0.0119	0.0414	0.009	0	0	0	0	0	1	-360	360;
	5	7	0.046	0.116	0.0204	0	0	0	0	0	1	-360	360;
	6	7	0.0267	0.082	0.017	0	0	0	0	0	1	-360	360;
	6	8	0.012	0.042	0.009	0	0	0	0	0	1	-360	360;
	6	9	0	0.208	0	0	0	0	0.978	0	1	-360	360;
	6	10	0	0.556	0	0	0	0	0.969	0	1	-360	360;
	9	11	0	0.208	0	0	0	0	0	0	1	-360	360;
	9	10	0	0.11	0	0	0	0	0	0	1	-360	360;
	4	12	0	0.256	0	0	0	0	0.932	0	1	-360	360;
	12	13	0	0.14	0	0	0	0	0	0	1	-360	360;
	12	14	0.1231	0.2559	0	0	0	0	0	0	1	-360	360;
	12	15	0.0662	0.1304	0	0	0	0	0	0	1	-360	360;
	12	16	0.0945	0.1987	0	0	0	0	0	0	1	-360	360;
	14	15	0.221	0.1997	0	0	0	0	0	0	1	-360	360;
	16	17	0.0524	0.1923	0	0	0	0	0	0	1	-360	360;
	15	18	0.1073	0.2185	0	0	0	0	0	0	1	-360	360;
	18	19	0.0639	0.1292	0	0	0	0	0	0	1	-360	360;
	19	20	0.034	0.068	0	0	0	0	0	0	1	-360	360;
	10	20	0.0936	0.209	0	0	0	0	0	0	1	-360	360;
	10	17	0.0324	0.0845	0	0	0	0	0	0	1	-360	360;
	10	21	0.0348	0.0749	0	0	0	0	0	0	1	-360	360;
	10	22	0.0727	0.1499	0	0	0	0	0	0	1	-360	360;
	21	22	0.0116	0.0236	0	0	0	0	0	0	1	-360	360;
	15	23	0.1	0.202	0	0	0	0	0	0	1	-360	360;
	22	24	0.115	0.179	0	0	0	0	0	0	1	-360	360;
	23	24	0.132	0.27	0	0	0	0	0	0	1	-360	360;
	24	25	0.1885	0.3292	0	0	0	0	0	0	1	-360	360;
	25	26	0.2544	0.38	0	0	0	0	0	0	1	-360	360;
	25	27	0.1093	0.2087	0	0	0	0	0	0	1	-360	360;
	28	27	0	0.396	0	0	0	0	0.968	0	1	-360	360;
	27	29	0.2198	0.4153	0	0	0	0	0	0	1	-360	360;
	27	30	0.3202	0.6027	0	0	0	0	0	0	1	-360	360;
	29	30	0.2399	0.4533	0	0	0	0	0	0	1	-360	360;
	8	28	0.0636	0.2	0.0428	0	0	0	0	0	1	-360	360;
	6	28	0.0169	0.0599	0.013	0	0	0	0	0	1	-360	360;
];
%Calculates the weights for the edges
branch_data(:,15) = sqrt((branch_data(:,3).^2)+(branch_data(:,4).^2));  % Calculate the impedence of the lines square root of(R^2 + X^2)
branch_data(:,17) = branch_data(:,15)./max(branch_data(:,15));          % Normalize it by dividing the maximum impedence
branch_data(:,19) = 1./branch_data(:,17);                               % Calculate the addmitance Y
%define the edges. No need to define nodes as matlab will automatically
%generate the nodes from edges.
%**The edges can be re-ordered to change the look of the graph**
edges_1 = [1;1;2;3;2;2;4;5;6;6;6;6;9;9;4;12;12;12;12;14;16;15;18;19;10;10;10;10;21;15;22;23;24;25;25;28;27;27;29;8;6];
edges_2 = [2;3;4;4;5;6;6;7;7;8;9;10;11;10;12;13;14;15;16;15;17;18;19;20;20;17;21;22;22;23;24;24;25;26;27;27;29;30;30;28;28];
line_cap = [130 130 65 130 130 65 90 70 130 32 65 32 65 65 65 65 32 32 32 16 16 16 16 32 32 32 32 32 32 16 16 16 16 16 16 65 16 16 16 32 32];
line_cap = line_cap';
%'graph' creates the graph with the edges defined above as well as the
%nodes
G = graph(edges_1,edges_2);
%Adds Weights to the graph
G.Edges.Weights = branch_data(:,19);
normz_weights = branch_data(:,17);
lc_weights = line_cap ./max(line_cap);
%plot the graph
g = plot(G);
%changes the layout from random to circular to resemble small-world phenomenon
layout(g,'circle');                 % This is fig.2 we got in the conference paper, and it is also fig 3 we got in the Journal version
h = plot(G,'Layout','circle');      % This command also show figure 2 also, but I am using it so that I can save the fig as png in the results section on this platform
 
%Measures the degree of the nodes
d = centrality(G,'degree');  %The degree of each node
D = mean(d);                % the average degree in the whole graph
% All centrality measures in the table at the end of the paper is calculated as follows:
%Mesures the betweenness centrality of nodes and edges
unweigted_betweenness = centrality(G,'betweenness');                           % unweigted betweenness
be = centrality(G,'betweenness','Cost',G.Edges.Weights);    % weigted betweenness without normalizing the impedence values
weigted_betweenness = centrality(G,'betweenness','Cost',normz_weights); % weigted betweenness with normalizing the impedence values
be_lc = centrality(G,'betweenness','Cost',lc_weights);      % weigted betweenness with the line capacities (was not used in the paper)
%Measures the closeness centrality of nodes and edges
unweigted_closeness = centrality(G,'closeness');
weigted_closeness = centrality(G,'closeness','Cost',normz_weights);
%Retrieve the adjacency matrix
A = adjacency(G);
%%
% As for the clustering Coefficient, we used an online toolbox and we checked that its working properly by comparing the results of a simple graph with the ones that came out of the toolbox. The toolbox could be found by the name of matlab bgl
% Could be found at: https://www.mathworks.com/matlabcentral/fileexchange/10922-matlabbgl
%Clustering Coefficient
%C = clustering_coefficients(A);
%M = mean(C);
%Characteristic Path Length
%SP = all_shortest_paths(A);
%for i = 1:length(A)
%    MSP(i,:) = mean(SP(i,:));
%end
%CPL = median(MSP);
Table = [unweigted_closeness,weigted_closeness,weigted_betweenness,unweigted_betweenness,be_lc,be]