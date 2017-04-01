# gtdprojects.sh

A simple `bash` script to handle GTD projects. A project in the [GTD](http://gettingthingsdone.com/) method is simply an outcome which requires more than one action to reach.

I manage my projects as folders. **One project equals one folder.**
In each project's folder, I put reference material, notes, etc.

This script is intended to be used in conjunction with [topydo](https://github.com/bram85/topydo), a GTD friendly task manager (based on the [todo.txt](http://todotxt.com/) file format). However, I'll try to make this script usable on its own.

## **This is a work in progress**

Please be aware that this script is in its early stages!

## Usage

### Getting help
Run `gtdprojects.sh -h` for general help and `gtdprojects.sh help <command>` for command specific help.

### Create a new project

`gtdprojects.sh create PROJECT_NAME` creates a new directory in your root folder. Currently, a prefix is added (YEAR-MONTH, e.g. 2017-04).

*Tip*: I use a bash alias `alias mkproject='gtdprojects.sh create'`.

## Setup

### Root folder of projects

You can either set the root folder directly in the script by modifying the `path` variable; or by adding the `GTD_PROJECTS_PATH` to your environment variables. For example, you can add `export GTD_PROJECTS_PATH="$HOME/GTDProjects"` in your `.bashrc`.

## Implemented features

* Create project

## Planned features

* List projects
* Change directory to project
* Archive project
