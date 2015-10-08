define = dict()
with open("defines") as DEF:
	for line in DEF:
		if len(line) > 1:
			words = line.split(" ")
			define[words[0]] = words[1][:-1]

with open("tablas.dml", "w") as fout:
    with open("tablas_con_defines.dml", "r") as fin:
        for line in fin:
			newLine = line
			for word in define:
				newLine = newLine.replace(word,define[word])
			fout.write(newLine)
