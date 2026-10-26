# bash-script for running gaussian

Note: You can copy the tools to a folder you are running gaussian jobs, or you can make it [global as described below too](#make-all-scripts-work-on-any-folder-global). 

Make the script executable by running `chmod` as below. You need to do this only once for the file. 

```
chmod u+x <scriptname>
```

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

You need to run `chmod` only once to make the file executable. This script will run automatically in the background. Any console output will be logged as a `g16batch.txt` file.

## gtime.sh
[gtime.sh](tools/gtime.sh) This tool is for obtaining Total Time Elapsed and Job CPU Time where a gaussian input file has multi links in it. Just download the tool as it is and use as before.

## checkg16.sh

[checkg16.sh](tools/checkg16.sh) This script check if g16 job is still running or not. If job is completed then it check all log files in the folder for error and would compress all log files too if you want it compressed as `logs.zip` files.

## Make All scripts work on any folder (global)

Download all `tools` to your home directory, then add the following lines on your `.profile` file (edit using `vi` or `nano`).

```
#some personal tools for gaussian
export PATH="$HOME/tools:$PATH"
```

Now, you do not need to copy each tool on every folder you want to run. So, you can just run the commands like `g16batch.sh`, `gtime.sh` or `checkg16.sh` anywhere. You can also remove the `.sh` extension from the filename in `tools` and then you can just run command like `g16batch`, `gtime` or `checkg16` anywhere.
