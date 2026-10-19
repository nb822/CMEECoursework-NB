import csv

#read a file containing:
#'Species', 'Infraorder', 'Family', 'Distribution', 'Body mass (kg)'
with open ('data/testcsv.csv', 'r', newline = '') as f:

    csvread = csv.reader(f)
    temp = []
    for row in csvread:
        temp.append(tuple(row))
        print(row)
        print("The species is", row[0])

      