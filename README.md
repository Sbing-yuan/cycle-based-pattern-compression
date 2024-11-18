# Cycle-based pattern compression
Test pattern compression flow, CP/FT test machine have maximum input file size. 
Therefore pattern compression is necessary.
## Usage
perl cmprs_cyc_pat.pl \<PAT_FILE\>

Output file: \<PAT_FILE\>.cmprs
## Input File
```
SCL SDA       
repeat 60000 > - 11
             > - 10
             > - 01
             > - 01
             > - 11
             > - 11
             > - 11
             > - 11
             > - 11
             > - 01
             > - 01
             > - 11
             > - 11
             > - 11
             > - 11
             > - 11
```
## Output File
```
SCL SDA       
repeat 60000 > - 11
             > - 10
repeat 2     > - 01
repeat 5     > - 11
repeat 2     > - 01
repeat 5     > - 11
```
