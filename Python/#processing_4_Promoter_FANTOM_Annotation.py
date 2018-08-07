import sys
import time

input_filename = str(sys.argv[1])

file_in = open(input_filename, 'r')
file_out = open(input_filename + '.promoter.ann', 'w')

file_prompter = open('Hackathon_Peng_Promoter_FANTOM_hg19_new.txt', 'r')
chr_promoter_ranges_dict = dict()
chr_promoter_ranges_gene_dict = dict()
for eachpromoter in file_prompter:
	component = eachpromoter.strip().split('\t')
	CHROM = component[0]
	START = component[1]
	END = component[2]
	RANGE = START + '-' + END
	GENE = component[4]

	if CHROM not in chr_promoter_ranges_dict.keys():
		chr_promoter_ranges_dict[CHROM] = set()
		chr_promoter_ranges_dict[CHROM].add(RANGE)
		chr_promoter_ranges_gene_dict[CHROM] = dict()
		chr_promoter_ranges_gene_dict[CHROM][RANGE] = GENE
	else:
		chr_promoter_ranges_dict[CHROM].add(RANGE)
		chr_promoter_ranges_gene_dict[CHROM][RANGE] = GENE

match_line = 0
match_promoter = 0
counting= 0
beinning = time.time()

if input_filename.endswith('vcf'):
	for eachline in file_in:
		if not eachline.startswith('#'):
			counting += 1
			if counting % 1000 == 0:
				print counting, round((time.time()-beinning)/60.0, 2)

			component = eachline.strip().split('\t')
			CHROM = component[0]
			POS = int(component[1])
			ID = component[2]
			REF = component[3]
			ALT = component[4]
			START = POS
			END = POS + len(REF) - 1
			if not CHROM.startswith('chr'):
				CHROM = 'chr' + CHROM

			OUTPUT_set = set()
			for each_RANGE in chr_promoter_ranges_dict[CHROM]:
				each_RANGE_INFO = each_RANGE.split('-')
				promoter_START = int(each_RANGE_INFO[0])
				promoter_END = int(each_RANGE_INFO[1])
				MESSAGE = ''
				if START <= promoter_START and END >= promoter_END:
					MESSAGE = 'complete_cut'
				elif START >= promoter_START and END <= promoter_END:
					MESSAGE = 'internal_cut'
				elif (promoter_START <= START <= promoter_END) and END > promoter_END:
					MESSAGE = 'right_cut'
				elif START < promoter_START and (promoter_START <= END <= promoter_END):
					MESSAGE = 'left_cut'

				if MESSAGE != '':
					promoter_RANGE = str(promoter_START) + '-' + str(promoter_END)
					promoter_GENE = chr_promoter_ranges_gene_dict[CHROM][promoter_RANGE]
					promoter_OUTPUT = promoter_GENE + ':' + MESSAGE
					OUTPUT_set.add(promoter_OUTPUT)
					match_promoter += 1

			if OUTPUT_set:
				OUTPUT = ''
				for eachOUTPUT in OUTPUT_set:
					OUTPUT += eachOUTPUT + ','
				OUTPUT = OUTPUT[-1]
				match_line += 1
				file_out.write(CHROM+'\t'+str(POS)+'\t'+ID+'\t'+REF+'\t'+ALT+'\t'+OUTPUT+'\n')


elif input_filename.endswith('bedpe'):
	for eachline in file_in:
		if not eachline.startswith('#'):
			counting += 1
			if counting % 1000 == 0:
				print counting, round((time.time()-beinning)/60.0, 2)

			component = eachline.strip().split('\t')
			CHROM1 = component[0]
			START1 = int(component[1])
			END1 = int(component[2])
			if not CHROM1.startswith('chr'):
				CHROM1 = 'chr' + CHROM1

			CHROM2 = component[3]
			START2 = int(component[4])
			END2 = int(component[5])
			if not CHROM2.startswith('chr'):
				CHROM2 = 'chr' + CHROM2

			OUTPUT1 = ''
			OUTPUT_set1 = set()
			for each_RANGE in chr_promoter_ranges_dict[CHROM1]:
				each_RANGE_INFO = each_RANGE.split('-')
				promoter_START = int(each_RANGE_INFO[0])
				promoter_END = int(each_RANGE_INFO[1])
				MESSAGE = ''
				if START1 <= promoter_START and END1 >= promoter_END:
					MESSAGE = 'complete_cut'
				elif START1 >= promoter_START and END1 <= promoter_END:
					MESSAGE = 'internal_cut'
				elif (promoter_START <= START1 <= promoter_END) and END1 > promoter_END:
					MESSAGE = 'right_cut'
				elif START1 < promoter_START and (promoter_START <= END1 <= promoter_END):
					MESSAGE = 'left_cut'

				if MESSAGE != '':
					promoter_RANGE = str(promoter_START) + '-' + str(promoter_END)
					promoter_GENE = chr_promoter_ranges_gene_dict[CHROM1][promoter_RANGE]
					promoter_OUTPUT = promoter_GENE + ':' + MESSAGE
					OUTPUT_set1.add(promoter_OUTPUT)
					match_promoter += 1

			OUTPUT_set2 = set()
			for each_RANGE in chr_promoter_ranges_dict[CHROM2]:
				each_RANGE_INFO = each_RANGE.split('-')
				promoter_START = int(each_RANGE_INFO[0])
				promoter_END = int(each_RANGE_INFO[1])
				MESSAGE = ''
				if START2 <= promoter_START and END2 >= promoter_END:
					MESSAGE = 'complete_cut'
				elif START2 >= promoter_START and END2 <= promoter_END:
					MESSAGE = 'internal_cut'
				elif (promoter_START <= START2 <= promoter_END) and END2 > promoter_END:
					MESSAGE = 'right_cut'
				elif START2 < promoter_START and (promoter_START <= END2 <= promoter_END):
					MESSAGE = 'left_cut'

				if MESSAGE != '':
					promoter_RANGE = str(promoter_START) + '-' + str(promoter_END)
					promoter_GENE = chr_promoter_ranges_gene_dict[CHROM2][promoter_RANGE]
					promoter_OUTPUT = promoter_GENE + ':' + MESSAGE
					OUTPUT_set2.add(promoter_OUTPUT)
					match_promoter += 1

			if not OUTPUT_set1 and not OUTPUT_set2:
				pass
			elif OUTPUT_set1 and not OUTPUT_set2:
				match_line += 1
				OUTPUT1 = ''
				for eachOUTPUT in OUTPUT_set1:
					OUTPUT1 += eachOUTPUT + ','
				OUTPUT1 = OUTPUT1[-1]
				OUTPUT2 = '.'
				file_out.write(eachline.strip() + '\t' + OUTPUT1 + '\t' + OUTPUT2 + '\n')
			elif not OUTPUT_set1 and not OUTPUT_set2:
				match_line += 1
				OUTPUT2 = ''
				for eachOUTPUT in OUTPUT_set2:
					OUTPUT2 += eachOUTPUT + ','
				OUTPUT2 = OUTPUT2[-1]
				OUTPUT1 = '.'
				file_out.write(eachline.strip() + '\t' + OUTPUT1 + '\t' + OUTPUT2 + '\n')
			elif OUTPUT_set1 and OUTPUT_set2:
				match_line += 1
				OUTPUT1 = ''
				for eachOUTPUT in OUTPUT_set1:
					OUTPUT1 += eachOUTPUT + ','
				OUTPUT1 = OUTPUT1[-1]
				OUTPUT2 = ''
				for eachOUTPUT in OUTPUT_set2:
					OUTPUT2 += eachOUTPUT + ','
				OUTPUT2 = OUTPUT2[-1]
				file_out.write(eachline.strip() + '\t' + OUTPUT1 + '\t' + OUTPUT2 + '\n')

print 'match_line:\t' + str(match_line)
print 'match_promoter:\t' + str(match_promoter)
