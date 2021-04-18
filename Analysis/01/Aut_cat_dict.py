####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################
import sys
import string




a_p_filename = '/home/alex/B/Work/Gronass/all/trajectories/data/paper_database_author.txt'
p_j_filename = '/home/alex/B/Work/Gronass/all/trajectories/data/paper_database_journal.txt'
j_c_filename = '/home/alex/B/Work/Gronass/all/trajectories/data/journal_metadata.txt'
c_a_filename = '/home/alex/B/Work/Gronass/data/c_a.txt'

p_a_dict = {}
j_p_dict = {}
c_j_dict = {}

a_p_fd = open(a_p_filename, 'r')
p_j_fd = open(p_j_filename, 'r')
j_c_fd = open(j_c_filename, 'r')
c_a_fd = open(c_a_filename, 'w')

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

for line in j_c_fd:

	if (('journalID' in line) == True):
		continue

	jou = string.split(line[:-1], '|')[0]
	cats = string.split(string.split(line[:-1], '|')[2], '$')

	for cat in cats:

		if (c_j_dict.has_key(cat) == False):
			c_j_dict[cat] = []

		c_j_dict[cat].append(jou)

print 'c_j_dict built'

for cat in c_j_dict.keys():
	for jou in c_j_dict[cat]:
		if ((j_p_dict.has_key(jou)) == False):
			continue
		for pap in j_p_dict[jou]:
			if ((p_a_dict.has_key(pap)) == False):
				continue
			for aut in p_a_dict[pap]:

				out_line = cat + '\t' + aut + '\n'
				c_a_fd.write(out_line)


a_p_fd.close()
p_j_fd.close()
j_c_fd.close()
c_a_fd.close()
