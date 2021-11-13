# -*- coding: UTF-8 -*-
import sys
file=sys.argv[1]
old=sys.argv[2]
new=sys.argv[3]

print('File path: '+file)

with open(u''+file, 'r+') as f:
	content = f.read()
	f.seek(0,0)
	f.truncate()
	f.write(content.replace(old, new))

