# Appunti

## paste, merge orizzontale con duckd

```bash
duckdb -json -c "SELECT  one.*, two.*
    FROM 'in1.csv' AS one
    POSITIONAL JOIN 'in2.csv' AS two"
```

in1.csv

```
a,b
1,2
3,4
```

in2.csv

```
c,d
5,6
7,8
```

## paste, merge orizzontale con miller

```bash
mlr --csv join --ul -j line_num -f <(mlr --csv put '$line_num=NR' in1.csv) then cut -x -f line_num <(mlr --csv put '$line_num=NR' in2.csv)
```

Vedi https://github.com/johnkerl/miller/discussions/1811#discussioncomment-13354791
