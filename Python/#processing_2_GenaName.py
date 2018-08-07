file_in = open('RAW_gencode.v19.metadata.HGNC', 'r')
file_out = open('Hackathon_Peng_Genename.txt', 'w')

gene_set = set()
for eachline in file_in:
	component = eachline.strip().split('\t')
	gene = component[1]
	gene_set.add(gene)
print 'GENE COUNT:\t' + str(len(gene_set))

gene_list = list(gene_set)
gene_list.sort()
for eachgene in gene_list:
	file_out.write(eachgene + '\n')
