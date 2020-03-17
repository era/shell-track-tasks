# Shell Track Task

Every time I start working for a new company they have a list of software that we are allowed to install in the computers. 

Due to this, I always have to use a different software set to keep track of what I'm doing. I do not need anything fancy, I just want:

- Track what I have done yesterday so I can report in the standups:
    - Add new tasks
    - Describe tasks for a given day
- Have the historical data on local storage (most companies do not allow cloud usage for internal things)

The goals:
- As little as possible third-party libraries (I need to run this in any machine)
- It must be fast
- It must be simple

That's why this tool was born. The data is stored as a JSON, so if you want to export/import it should be easy.

- Dependencies:
    - jq
    - moreutils (due to sponge)


## Usage

You need to setup where the entries should be saved: `SHELL_TRACK_TASK_FILE='/tmp/my.json'`

### Commands

- Add a new entry: `tt.sh -a 'Doing some good work'`
- List yesterday tasks: `tt.sh -f -1d`
- List all tasks: `tt.sh -l`


### Tip
I normally add a alias to my dotfile:
`alias track="sh PATH_TO_THE_REPO/tt.sh"`


☭