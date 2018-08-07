file_in_gene = open('Hackathon_Peng_Genename.txt', 'r')

file_in_promoter_hg19 = open('Hackathon_Peng_Promoter_RegAnno_hg19.txt', 'r')
file_out_hg19 = open('Hackathon_Peng_Promoter_RegAnno_hg19_new.txt', 'w')

file_in_promoter_hg38 = open('Hackathon_Peng_Promoter_RegAnno_hg38.txt', 'r')
file_out_hg38 = open('Hackathon_Peng_Promoter_RegAnno_hg38_new.txt', 'w')

gene_set = set()
for eachline in file_in_gene:
	gene_set.add(eachline.strip())

total_count_hg19 = 0
gene_match_set_hg19 = set()
promoter_head = file_in_promoter_hg19.readline()
file_out_hg19.write(promoter_head)
for eachline in file_in_promoter_hg19:
	component = eachline.strip().split('\t')
	gene = component[4]
	if gene in gene_set:
		file_out_hg19.write(eachline)
		total_count_hg19 += 1
		gene_match_set_hg19.add(gene)

gene_match_count_hg19 = len(gene_match_set_hg19)
print 'TOTAL COUNT hg19:\t' + str(total_count_hg19)
print 'GENE COUNT hg19:\t' + str(gene_match_count_hg19)

total_count_hg38 = 0
gene_match_set_hg38 = set()
promoter_head = file_in_promoter_hg38.readline()
file_out_hg38.write(promoter_head)
for eachline in file_in_promoter_hg38:
	component = eachline.strip().split('\t')
	gene = component[4]
	if gene in gene_set:
		file_out_hg38.write(eachline)
		total_count_hg38 += 1
		gene_match_set_hg38.add(gene)

gene_match_count_hg38 = len(gene_match_set_hg38)
print 'TOTAL COUNT hg38:\t' + str(total_count_hg38)
print 'GENE COUNT hg38:\t' + str(gene_match_count_hg38)
