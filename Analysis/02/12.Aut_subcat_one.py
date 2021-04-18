####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################
import sys
import string




s_a_filename = '/home/alex/B/Work/Gronass/02/data/s_a.txt'
s_a_one_filename = '/home/alex/B/Work/Gronass/02/data/s_a_one.txt'

a_s_dict = {}
a_s_one_dict = {}

s_a_fd = open(s_a_filename, 'r')
s_a_one_fd = open(s_a_one_filename, 'w')


for line in s_a_fd:
	aut = string.split(line[:-1], '\t')[1]
	subcat = string.split(line[:-1], '\t')[0]
	if (a_s_dict.has_key(aut) == False):
		a_s_dict[aut] = []
	a_s_dict[aut].append(subcat)

print "a_s_dict built"

for aut in a_s_dict.keys():
	cur_freq_cat = {}
	for subcat in a_s_dict[aut]:
		cur_freq_cat[a_s_dict[aut].count(subcat)] = subcat
	out_line = aut + '\t' + cur_freq_cat[max(cur_freq_cat.keys())] + '\n'
	s_a_one_fd.write(out_line)


s_a_fd.close()
s_a_one_fd.close()

