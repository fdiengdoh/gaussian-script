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

## checkg16.sh

[checkg16.sh](tools/checkg16.sh) This script check if g16 job is still running or not. 

Why I build this tool? Well, when I run jobs on a server with my own user account, I would login, then use `top` command to check if my job is still running. Now, after all jobs are completed, I would have to download all log files to my pc for analysis. So, this tool does two jobs, check if g16 job is completed or not for my queue, if completed, it would zip all log files as a single file, make it easier for me to download.

Your use case might not be same as mine, especially if a research group is sharing the same login username.

## gtime.sh
[gtime.sh](tools/gtime.sh) This tool is for obtaining Total Time Elapsed and Job CPU Time where a gaussian input file has multi links in it. 

Why I build this tool? I was running some jobs, then after the jobs completed in about 48 hours, the last line of log file shows only 2 hours of elapsed times. I know that multistep calculation would reset elapsed time, but my curious mind just want to know exactly how much time really has elapsed. 

Again, this might be the most useless tool for you. But, maybe just download the tool as it is.

## Make All scripts work on any folder (global)

Download all `tools` to your home directory, then add the following lines on your `.profile` file (edit using `vi` or `nano`).

```
#some personal tools for gaussian
export PATH="$HOME/tools:$PATH"
```

Now, you do not need to copy each tool on every folder you want to run. So, you can just run the commands like `g16batch.sh`, `gtime.sh` or `checkg16.sh` anywhere. You can also remove the `.sh` extension from the filename in `tools` and then you can just run command like `g16batch`, `gtime` or `checkg16` anywhere.
