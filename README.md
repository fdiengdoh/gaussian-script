# bash-script for running gaussian

## g16batch.sh
[g16batch.sh](tools/g16batch.sh) would batch run g16 base on a README file.

How to use it?
Create a README file in a folder as follows (check [sample](sample) folder):

```
# Please run g16 jobs in the following order
# This is a comments and will not run

# List the file sequence as below, you can use .gjf or without
cyclohexane 
hydronium_ion.gjf
methylcarbanion 
```
Copy [g16batch.sh](tools/g16batch.sh) to the folder containing gaussian file. Then run the following commands.

```
chmod u+x g16batch.sh
./g16batch.sh
```

You need to run `chmod` only once to make the file executable.

## gtime.sh
[gtime.sh](tools/gtime.sh) This tool is for obtaining Total Time Elapsed and Job CPU Time where a gaussian input file has multi links in it. Just download the tool as it is and use as before.

## checkg16.sh

[checkg16.sh](tools/checkg16.sh) This script check if g16 job is still running or not. If job is completed then it check all log files in the folder for error etc.

## Make All scripts work on any folder (global)

Download all `tools` to your home directory, then add the following lines on your `.profile` file (edit using `vi` or `nano`).

```
#some personal tools for gaussian
export PATH="$HOME/tools:$PATH"
```

Now, I do not need to copy each tool on every folder I want to run. So, I just run the command like `g16batch.sh`, `gtime.sh` or `checkg16.sh` anywhere. You can also remove the `.sh` extension from the filename in tools and then you can just run command like `g16batch`, `gtime` or `checkg16` anywhere.
