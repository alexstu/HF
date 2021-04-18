####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################
import sys
import string
import os


s_a_one_filename = '/home/alex/B/Work/Gronass/02/data/s_a_one.txt'
all_hf_files = os.listdir('data/All')
s_a_dict = {}
hf_files = []

for hf_file in all_hf_files:
	if ((('authors' in hf_file) == True) and ('.tsv' in hf_file)):
		hf_files.append(hf_file)

print 'HFs selected'

s_a_one_fd = open(s_a_one_filename, 'r')
for line in s_a_one_fd:
	aut = string.split(line[:-1], '\t')[0]
	subcat = string.split(line[:-1], '\t')[1]
	if (s_a_dict.has_key(subcat) == False):
		s_a_dict[subcat] = []
	s_a_dict[subcat].append(aut)
s_a_one_fd.close()
print 'Dict built'


keys =  sorted(s_a_dict.keys())
print 'Keys sorted'


for subcat in keys:
	s_a_dict[subcat] = set(s_a_dict[subcat])
print 'Dict set'


for i in range(len(keys)):
	subcat = keys[i]
	for hf_file in hf_files:
		print hf_file, keys[i]
		subcat_hf_filename = '/home/alex/B/Work/Gronass/02/data/' + str(i) + '_' + hf_file
		fd_hf_all = open('/home/alex/B/Work/Gronass/02/data/All/' + hf_file, 'r')
		fd_hf_subcat = open(subcat_hf_filename, 'w')
		for line in fd_hf_all:
			aut = string.split(line[:-1], '\t')[0]
			if ((aut in s_a_dict[subcat]) == True):
				fd_hf_subcat.write(line)
		fd_hf_all.close()
		fd_hf_subcat.close()


subcats_filename = 'subcats.txt'
fd_subcats = open(subcats_filename, 'w')
for i in range(len(keys)):
	subcat = keys[i]
	fd_subcats.write(subcat + '\t' + str(i+1) + '\n')

fd_subcats.close()



