####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################
import sys
import string
import os


c_a_one_filename = '/home/alex/B/Work/Gronass/data/c_a_one.txt'
all_hf_files = os.listdir('data/All')
c_a_dict = {}
hf_files = []

for hf_file in all_hf_files:
	if ((('authors' in hf_file) == True) and ('.tsv' in hf_file)):
		hf_files.append(hf_file)

print 'HFs selected'

c_a_one_fd = open(c_a_one_filename, 'r')
for line in c_a_one_fd:
	aut = string.split(line[:-1], '\t')[0]
	cat = string.split(line[:-1], '\t')[1]
	if (c_a_dict.has_key(cat) == False):
		c_a_dict[cat] = []
	c_a_dict[cat].append(aut)
c_a_one_fd.close()
print 'Dict built'


keys =  sorted(c_a_dict.keys())
print 'Keys sorted'


for cat in keys:
	c_a_dict[cat] = set(c_a_dict[cat])
print 'Dict set'


for i in range(len(keys)):
	cat = keys[i]
	for hf_file in hf_files:
		print hf_file, keys[i]
		cat_hf_filename = '/home/alex/B/Work/Gronass/data/' + str(i) + '_' + hf_file
		fd_hf_all = open('/home/alex/B/Work/Gronass/data/All/' + hf_file, 'r')
		fd_hf_cat = open(cat_hf_filename, 'w')
		for line in fd_hf_all:
			aut = string.split(line[:-1], '\t')[0]
			if ((aut in c_a_dict[cat]) == True):
				fd_hf_cat.write(line)
		fd_hf_all.close()
		fd_hf_cat.close()


cats_filename = 'cats.txt'
fd_cats = open(cats_filename, 'w')
for i in range(len(keys)):
	cat = keys[i]
	fd_cats.write(cat + '\t' + str(i) + '\n')

fd_cats.close()



