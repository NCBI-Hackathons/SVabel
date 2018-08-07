file_in_gene = open('Hackathon_Peng_Genename.txt', 'r')
file_in_promoter = open('Hackathon_Peng_Promoter.txt', 'r')

file_out = open('Hackathon_Peng_Promoter_matched.txt', 'w')

gene_set = set()
for eachline in file_in_gene:
	gene_set.add(eachline.strip())

total_count = 0
gene_match_set = set()
promoter_head = file_in_promoter.readline()
file_out.write(promoter_head)
for eachline in file_in_promoter:
	component = eachline.strip().split('\t')
	gene = component[4]
	if gene in gene_set:
		file_out.write(eachline)
		total_count += 1
		gene_match_set.add(gene)

gene_match_count = len(gene_match_set)
print 'TOTAL COUNT:\t' + str(total_count)
print 'GENE COUNT:\t' + str(gene_match_count)
