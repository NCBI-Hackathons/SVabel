file_in = open('RAW_hg19.cage_peak_ann.txt', 'r')
file_out = open('Hackathon_Peng_Promoter.txt', 'w')

total_count = 0
gene_count = 0
gene_set = set()

for eachline in file_in:
	if eachline.startswith('chr'):
		component = eachline.strip().split('\t')
		annotation = component[0]
		description = component[1]
		uniprot = component[6]

		description_info = description.split('@')
		if description_info[0] != 'p':
			gene = description_info[1]
			annotation_split_1 = annotation.split(':')
			chrom = annotation_split_1[0]
			annotation_split_2 = annotation_split_1[1].split('..')
			start = annotation_split_2[0]
			annotation_split_3 = annotation_split_2[1].split(',')
			end = annotation_split_3[0]
			strand = annotation_split_3[1]

			if not gene.startswith('ENST'):
				total_count += 1
				gene_set.add(gene)
				file_out.write(chrom + '\t' + start + '\t' + end + '\t' + strand + '\t' + gene + '\n')

gene_count = len(gene_set)
print 'TOTAL COUNT:\t' + str(total_count)
print 'GENE COUNT:\t' + str(gene_count)
