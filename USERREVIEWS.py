
# import numpy and csv
import csv as csv
import numpy as np

#reading CSV-file userreviews and defining the variables of the csvfile
with open ('/home/pi/RSL/userreviews.csv') as data:
    readdata = csv.reader(data)
    header = next(readdata)
    data = list(readdata)
   
#after defining the variables,the lengt of list is printed to see how many rows there are
print ("the length of userreview file is", len(data))

#after checking we see that the data is a nested list.
#the buildup is as follows: 0 =moviename, 1=metascore, 2=author, etc...

#making data list smaller,beacause to much to analyse 200000 rows
movies = data[:][0]
for i in range (0,2000):
    movies = [data [i][0].split(";") for i in range (0,2000)]

#making list X of movies
X = []
for i in range (0,2000):
    X += [movies[i][2]]

#making list Y of authors(2) with favo movie
Y = []
nameFfilm = "war-for-the-planet-of-the-apes"
for i in range(0,2000):
    if movies[i][0] == nameFfilm:
        Y += [movies[i][2]]
    
#making list Z of other recommend movies of authors
Z = []
for j in range (0,len(Y)):
    recfilm = Y[j]
    for i in range (0,2000):
        if movies[i][2] == recfilm:
            Z += [movies[i][0]]

#printing list Z in a csv using numpy
np.savetxt("recommendationbasedonreview.csv",
           Z,
           delimiter =", ",
           fmt ='% s')