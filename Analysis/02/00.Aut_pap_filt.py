####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################
import sys
import string



alpha=15
a_p_filename = '/home/alex/B/Work/Gronass/all/trajectories/data/paper_database_author.txt'
#a_p_filt_filename = '/home/alex/B/Work/Gronass/02/data/paper_database_author_nofilt.txt'
a_p_filt_filename = '/home/alex/B/Work/Gronass/02/data/author_filt_' + str(alpha) + '.txt'



a_p_dict = {}

a_p_fd = open(a_p_filename, 'r')
a_p_filt_fd = open(a_p_filt_filename, 'w')

for line in a_p_fd:
	if (('paperID' in line) == True):
		continue
	aut = string.split(line[:-1], '|')[1]
	pap = string.split(line[:-1], '|')[0]
	if (a_p_dict.has_key(aut) == False):
		a_p_dict[aut] = []
	a_p_dict[aut].append(pap)

print 'a_p_dict built'

for aut in a_p_dict.keys():
	if (len(a_p_dict[aut]) > alpha):
		a_p_filt_fd.write(aut + '\n')



a_p_fd.close()
a_p_filt_fd.close()

