import csv
import urllib2
from tabulate import tabulate
import sys

print 'Number of arguments:', len(sys.argv), 'arguments.'
print 'Argument List:', str(sys.argv[1:])
print 'argument: ' + str(sys.argv[1])

ticker = str(sys.argv[1])

url = "http://financials.morningstar.com/ajax/ReportProcess4CSV.html?t=" + ticker + "&reportType=cf&period=12&dataType=A&order=asc&columnYear=10&number=3"

response = urllib2.urlopen(url)
cr = csv.reader(response)

# list used to populate all the rows
filledlist = []

for row in cr:
    # Change names  for vizualisation
    if row[0] == "Depreciation & amortization":
        row[0] = "...Depreciation & amortization".rjust(4)

    # populate list
    if len(row) > 3:
        filledlist.append(row)

    # more populations
    if row[0] == "Net income":
        filledlist.append(['Addbacks:','','','','','',''])
    if row[0] == "Net cash provided by operating activities":
        filledlist.append(['','','','','','',''])
    if row[0] == "Net cash used for investing activities":
        filledlist.append(['','','','','','',''])
    if row[0] == "Net cash provided by (used for) financing activities":
        filledlist.append(['','','','','','',''])

# Takes a list and formats its nicely on print
print tabulate(filledlist)
#with open('file.csv', 'rb') as f:
#    reader = csv.reader(f)
#    your_list = list(reader)
