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
p_j_filename = '/home/alex/B/Work/Gronass/all/trajectories/data/paper_database_journal.txt'
j_s_filename = '/home/alex/B/Work/Gronass/all/trajectories/data/journal_metadata.txt'
s_a_filename = '/home/alex/B/Work/Gronass/02/data/s_a.txt'

p_a_dict = {}
j_p_dict = {}
s_j_dict = {}

a_p_fd = open(a_p_filename, 'r')
p_j_fd = open(p_j_filename, 'r')
j_s_fd = open(j_s_filename, 'r')
s_a_fd = open(s_a_filename, 'w')

for line in a_p_fd:
	if (('paperID' in line) == True):
		continue
	aut = string.split(line[:-1], '|')[1]
	pap = string.split(line[:-1], '|')[0]
	if (p_a_dict.has_key(pap) == False):
		p_a_dict[pap] = []
	p_a_dict[pap].append(aut)

print 'p_a_dict built'
for line in p_j_fd:
	if (('paperID' in line) == True):
		continue
	pap = string.split(line[:-1], '|')[0]
	jou = string.split(line[:-1], '|')[2]
	if (j_p_dict.has_key(jou) == False):
		j_p_dict[jou] = []
	j_p_dict[jou].append(pap)

print 'j_p_dict built'

for line in j_s_fd:

	if (('journalID' in line) == True):
		continue

	jou = string.split(line[:-1], '|')[0]
	subcats = string.split(string.split(line[:-1], '|')[3], '$')

	for subcat in subcats:

		if (s_j_dict.has_key(subcat) == False):
			s_j_dict[subcat] = []

		s_j_dict[subcat].append(jou)

print 's_j_dict built'

for subcat in s_j_dict.keys():
	for jou in s_j_dict[subcat]:
		if ((j_p_dict.has_key(jou)) == False):
			continue
		for pap in j_p_dict[jou]:
			if ((p_a_dict.has_key(pap)) == False):
				continue
			for aut in p_a_dict[pap]:

				out_line = subcat + '\t' + aut + '\n'
				s_a_fd.write(out_line)


a_p_fd.close()
p_j_fd.close()
j_s_fd.close()
s_a_fd.close()
