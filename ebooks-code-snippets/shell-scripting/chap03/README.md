# variables

**Bash reserved vars**

$BASH_VERSION, version of bash that you are running

$PIPESTATUS, which tells you the return codes of the commands in the last-run pipeline

$RANDOM will keep returning random numbers until you assign it a value

$SECONDS, an integer which goes up by one every second

**shopt**, enabled shell options, that are around 40 which are more useful and interesting options

all the bash vars are documented here,
https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html

## SHELLOPTS

SHELLOPTS is similar to BASHOPTS; it is a list of -o options set. So if you set -o vi

syntax:

```
~ ❯ echo $SHELLOPTS
braceexpand:emacs:hashall:histexpand:history:interactive-comments:monitor
~ ❯ set -e
~ ❯ echo $SHELLOPTS
braceexpand:emacs:errexit:hashall:histexpand:history:interactive-comments:monitor
~ ❯ set +o errexit
~ ❯ echo $SHELLOPTS
braceexpand:emacs:hashall:histexpand:history:interactive-comments:monitor
~ ❯
```

-e / -o errexit — Exit if any command returns a non-zero exit status code. This can be useful if you are sure that every single command in a script must succeed, and that exiting otherwise is the safest thing to do.

-f / -o noglob — Disables pathname expansion.

-m / -o monitor — If set (which it is by default), when a background command completes, you will get a line the next time bash displays a new prompt

pipefail:  alternative to PIPESTATUS variable, ifs off which is by default. the return code of a pipeline will be that of the rightmost command that returned a non-zero exit status.

if *set -o pipefail* is not set, you would get the return status of the below command to be successful, which is wrong.

```
~ ❯ echo $SHELLOPTS
braceexpand:emacs:hashall:histexpand:history:interactive-comments:monitor
~ ❯ cat /etc/hosts | grep 192.147 | cut -f1
~ ❯ echo $?
0
~ ❯
```

after enabling pipefail, you would be able to find the complete command has been successful or not... hence we would required to be enabled.

```
~ ❯ set -o pipefail
~ ❯ echo $SHELLOPTS
braceexpand:emacs:hashall:histexpand:history:interactive-comments:monitor:pipefail
~ ❯
~ ❯ cat /etc/hosts | grep 192.147 | cut -f1
~ ✗ echo $?
1
```

## BASH_COMMAND

its the name of currently executing command. shell builtin which can be useful in a *trap* call.

This simple recipe runs a sequence of commands, and tells you what the script was doing when you pressed ^C to interrupt it.

[trap.sh](https://github.com/samperay/scripting/blob/master/ebooks-code-snippets/shell-scripting/chap03/trap.sh)

## Debugging vars

BASH_SOURCE, FUNCNAME, LINENO and BASH_LINENO are incredibly useful debugging variables

[debug](https://github.com/samperay/scripting/tree/master/ebooks-code-snippets/shell-scripting/chap03/debug)

## BASH_VERSION

better would be to test before executing the bash variables

```
if [ -z "$BASH_VERSION" ]
  then
    echo "Not a bash version"
  else
    echo "yes, you are using bash version $BASH_VERSION"
fi
```

## PIPESTATUS

PIPESTATUS is an array of the exit status of the last-run pipeline or command.

This works for PIPESTATUS[0], but for the subsequent calls PIPESTATUS has been reset by the successful echo command

[pipestatus.sh](https://github.com/samperay/scripting/blob/master/ebooks-code-snippets/shell-scripting/chap03/pipestatus.sh)
