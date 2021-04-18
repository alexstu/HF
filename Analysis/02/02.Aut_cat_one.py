####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################
import sys
import string




c_a_filename = '/home/alex/B/Work/Gronass/02/data/c_a.txt'
c_a_one_filename = '/home/alex/B/Work/Gronass/02/data/c_a_one.txt'

a_c_dict = {}
a_c_one_dict = {}

c_a_fd = open(c_a_filename, 'r')
c_a_one_fd = open(c_a_one_filename, 'w')


for line in c_a_fd:
	aut = string.split(line[:-1], '\t')[1]
	cat = string.split(line[:-1], '\t')[0]
	if (a_c_dict.has_key(aut) == False):
		a_c_dict[aut] = []
	a_c_dict[aut].append(cat)
		

for aut in a_c_dict.keys():
	cur_freq_cat = {}
	for cat in a_c_dict[aut]:
		cur_freq_cat[a_c_dict[aut].count(cat)] = cat
	out_line = aut + '\t' + cur_freq_cat[max(cur_freq_cat.keys())] + '\n'
	c_a_one_fd.write(out_line)


c_a_fd.close()
c_a_one_fd.close()

