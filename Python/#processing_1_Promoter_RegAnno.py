file_in = open('RAW_RegAnno_Combined_2016.01.19.tsv', 'r')
file_out_hg19 = open('Hackathon_Peng_Promoter_RegAnno_hg19.txt', 'w')
file_out_hg38 = open('Hackathon_Peng_Promoter_RegAnno_hg38.txt', 'w')

total_count_hg19 = 0
gene_set_hg19 = set()

total_count_hg38 = 0
gene_set_hg38 = set()

file_in.readline()
for eachline in file_in:
	component = eachline.strip().split('\t')
	species = component[1]
	outcome = component[2]
	gene = component[4]
	build = component[13]
	strand = component[14]
	chr = component[15]
	start = component[16]
	end = component[17]
	if strand == '1': strand = '+'
	if strand == '-1': strand = '-'

	if species == 'Homo sapiens' and outcome == 'POSITIVE OUTCOME':
		if build == 'hg19':
			total_count_hg19 += 1
			gene_set_hg19.add(gene)
			file_out_hg19.write(chr + '\t' + start + '\t' + end + '\t' + strand + '\t' + gene + '\n')
		elif build == 'hg38':
			total_count_hg38 += 1
			gene_set_hg38.add(gene)
			file_out_hg38.write(chr + '\t' + start + '\t' + end + '\t' + strand + '\t' + gene + '\n')

gene_count_hg19 = len(gene_set_hg19)
print 'TOTAL COUNT hg19:\t' + str(total_count_hg19)
print 'GENE COUNT hg19:\t' + str(gene_count_hg19)

gene_count_hg38 = len(gene_set_hg38)
print 'TOTAL COUNT hg38:\t' + str(total_count_hg38)
print 'GENE COUNT hg38:\t' + str(gene_count_hg38)
