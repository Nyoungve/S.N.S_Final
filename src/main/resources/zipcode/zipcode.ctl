load data
infile 'c:\zipcode.csv'
append
into table zipcode
fields terminated by ','
(       ZIPCODE,
        area1,
        area2,
        area3,
        area4
)