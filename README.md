# bash-script for running gaussian

[g16batch.sh](g16batch.sh) would batch run g16 base on a README file.

How to use it?
Create a README file in a folder as follows:

```
# Please run g16 jobs in the following order
# This is a comments and will not run

# List the file sequence as below, you can use .gjf or without
cyclohexane 
hydronium_ion.gjf
methylcarbanion 
```
Then run the following commands. 

```
chmod u+x g16batch.sh
./g16batch.sh
```

You need to run `chmod` only once to make the file executable.
