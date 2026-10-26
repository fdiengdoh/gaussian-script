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
Copy [g16batch.sh](g16batch.sh) to the folder containing gaussian file. Then run the following commands.

```
chmod u+x g16batch.sh
./g16batch.sh
```

You need to run `chmod` only once to make the file executable.

## Make the script work on any folder

I made a folder `tools` on my home directory and place the [g16batch.sh](g16batch.sh) in `tools` then added the following lines on my `.profile` file

```
#some personal tools
export PATH="$HOME/tools:$PATH"
```

Now, I do not need to copy [g16batch.sh](g16batch.sh) on every folder I want to batch run. So, I just run the command `g16batch.sh` anywhere.
