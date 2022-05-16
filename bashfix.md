# bashfix

This document is inverse of what needs to be done on the (**bash pitfalls**) [http://mywiki.wooledge.org/BashPitfalls]

I would like to write a short things as what needs to be done instead of what not. however, one must be reading the article to know more.

## loops
If you are iterating the loops for the filenames and incase you come across any **white spaces** it should also be considered from the same existing path.

```
for file in ./*.csv
do
  some command "$file"
done
```

if there are no .csv files in the folder then for loop would be exited, hence the best code would be ..
```
while IFS= read -r -d '' file
do
  some command "$file"
done < <(find . type f -name '*.csv' -print 0)
```

; can be replaced by a newline, but not all newlines can be replaced by ;

```
for i in {1..10}; do
  ./something &
done
```

if there are other vars which are using $n for arthematic expressions, then you must strongly use the below C syntax kind of for looping.

```
n=10
for ((i=1; i<=n; i++)); do
  echo "$i"
done
```

## copy
while copying the file containing any **word splitting** or **path expansion**
copy would fail if there are **IFS** set or any globbing etc..

Note: you don't have to double quote the string in bash, until they have metachars or pattern chars..

```
cp -- "$src" "$dest"
```

sometimes when there is word splitting or shell expansions, its not safe to use an *echo* statement.
```
touch "$PWD"/file{1..10}.zip
var="*.zip"   # var contains an asterisk, a period, and the word "zip"
echo "$var"   # writes *.zip
echo $var     # writes the list of files which end with .zip
```

## variable assignments
**Note:** you must have a variable assigned when you are performing a test conditions, else it would have nothing to test operator leading to an error that *unary operator expected*

```
[[ $foo == bar ]]  # foo must be declared before using in test conditions
```

## change directory
its always better to quote the directory always as the result of variable expansion which undergoes word splitting, pathname substitution etc
```
cd -P -- "$(dirname -- "$f")"
```

## test usage
always use && or || when you are using testing condition, but never split as bash parser would recognize as two separate commands.
```
[[ $foo = bar && $bar = foo ]]
[[ $foo > 7 ]] # wrong, no arithmetic expressions
```

**Note:** Never use test commands for any arithmetic operations, they are only used for expressions that are treated as "string", instead use as below
```
(( $foo > ))
```

## subshell
if you were to use the var in the program, never use any pipe as it would create a new sub-shell, which can't remember the value of the vars.

```
grep foo bar | while read -r; do ((count++)); done # grep won't reach the while loop as it already created a new subshell.
```

```
PATMATCH = grep foo bar <filename>
while read -r; do ((count++)); done <"$PATMATCH"
```

## test command []
[ is a command, not a syntax marker for the if statement.  Bash only passes ] as argument to the [ command, which requires ] to be the last argument only to make scripts look better.

[ : you must always quote the substitution
[[ : since there is no globbing or pattern matching, you don't have to quote.

```
if [ false ]; then echo "HELP"; fi
if test false; then echo "HELP"; fi
if grep -q fooregex myfile; then echo "word to be checked"; fi

[ -n "$foo" ]
[ -n "$(some command with a "$file" in it)" ]

# doesn't require double quotes
[[ -n $foo ]]
```

**Note:** *if [[ bar = "$foo" ]]* are separate arguments to it. There must be whitespace between each pair of arguments, so the shell knows where each argument begins and ends.
**[ [ a = b ] && [ c = d ] ]** **wrong** as it wont accept *&&* or *||* , hence use this
```
if [[ a = b && c = d ]]
```

**Note:** The == operator is not valid for the POSIX [ command.
*Use = or the [[ keyword instead*.

```
[ bar = "$foo" ] && echo yes  # Right !
[[ bar == $foo ]] && echo yes # Right !
```

when the RHS of the '=' is not quoted
bash does pattern matching against it, instead of treating it as a string.
if bar contains *, the result will always be true.
*if [[ $foo = "$bar" ]]*. if you quote the right-hand side of =~ it also forces a simple string comparison, rather than a regular expression
*if [[ $foo =~ 'some RE' ]]*

```
foo="test123"
re="test123"
if [[ $foo =~ $re ]];
then
  echo 'pattern match'
else
  echo 'pattern not match'
fi
```

## read
Never is any *$* before any read statement.
```
IFS= read -r line
```

**Note:** Never read and write to the same file using the pipeline.
instead use any text editor to do.
```
printf %s\\n ',s/foo/bar/g' w q | ed -s file
sed 's/foo/bar/g' file > tmpfile && mv tmpfile file
```

## here document
useful tool for embedding large blocks of textual data in a script.
redirection of the lines of text in the script to the standard input of a command.

```
cat <<EOF
Hello world
How's it going?
EOF
```
**Note:** Using quotes like that is fine -- it works great, in all shells -- but it doesn't let you just drop a block of lines into the script. There's syntactic markup on the first and last line. If you want to have your lines untouched by shell syntax, and don't want to spawn a cat command.

```
printf %s "\
Hello world
How's it going?
"
```
## super user / switch user

You want to pass -c 'some command' to a shell, which means you need a username before the -c
```
su root -c 'some command'
```
sudo mycmd > /myfile

If the redirection must be executed with sudo-granted privileges, then you need a wrapper..
```
sudo sh -c 'mycmd > /myfile'
```
you can use tee
```
mycmd | sudo tee /myfile >/dev/null
```

Globbing is also done before the command is executed. If the directory isn't readable by your normal user privileges, then you may need the globbing to be done in a shell that has the sudo-granted privileges.

```
sudo sh -c 'ls /foo/*'
```

## xargs
xargs splits on whitespace. This is unfortunate because whitespace is allowed in filenames and commonly used by GUI users. xargs also treats ' and "

```
find . -type f | xargs wc # error but warns  
echo * | xargs wc # no error, but warns
```

instead use xargs -0:

```
printf '%s\0' * | xargs -0 wc
find . -type f -name '*famous*' -print0 | xargs -0 wc
find . -type f -name '*4*' -exec wc {} +
```

## date
common way idiom is to define one time in the script and always use it when required.

```
eval "$(date +'month=%m day=%d year=%Y dayname="%A" monthname="%B"')"
```





## change directory (cd)
If you don't check for errors from the cd command, you might end up executing bar in the wrong place.

```
cd /foo; bar
```
This could be a major disaster, if for example bar happens to be rm -f *.
```
cd /foo || { echo >2& "No such directory to check-in"; exit 1 }
```

## multiple command executions

```
i=0
true && ((i++)) || ((i--))  # WRONG!
echo "$i"                   # Prints 0
```

What happened here? It looks like i should be 1, but it ends up 0. Why? Because both the i++ and the i-- were executed. The ((i++)) command has an exit status, and that exit status is derived from a C-like evaluation of the expression inside the parentheses. That expression's value happens to be 0 (the initial value of i), and in C, an expression with an integer value of 0 is considered false. So ((i++)) (when i is 0) has an exit status of 1 (false), and therefore the ((i--)) command is executed as well.

if you need safety,

```
i=0
if true; then
  ((i++))
else
  ((i--))
fi
echo "$i"    # Prints 1
```

## positional arguments
The double-quoted "$@" is special magic that causes each parameter to be used as a single word.

myscript.sh
```
echo "------ at ------"

for x in $@
do
  echo "params without quotes:" "$x"
done

echo

for x in "$@"
do
  echo "params with quotes:" "$x"
done

or  # the below code also works.

for x
do
  echo "param: '$x'"
done

echo "------ star ------"

for x in $*
do
  echo "params without quotes:" "$x"
done

echo
for x in "$*"
do
  echo "params with quotes:" "$x"
done
```

```
./myscript.sh 'arg 1' 1 2 3
```

## local substitution
local var=$(cmd) is treated as an assignment, while in other shells (like dash), local var=$(cmd) is not treated as an assignment.

hence always the best practice is to,
```
local var
var=$(cmd)
rc=$?
```

export and local commands do not necessarily constitute an assignment, In some shells (like Bash), export foo=~/bar will undergo tilde expansion; in others, it will not

hence always the best practice is to,
```
foo=~/bar; export foo    # Right!
export foo="$HOME/bar"   # Right!
```

## single quotes/double quotes
var="World"
**single quote:** No substitution in variables.
**double quotes:** It substitutes in variables.
```
echo 'Hello $var' # prints 'Hello $var'
echo "Hello $var" # prints 'Hello World'
```

## process
if you need to find the PID, use *pgrep program* instead of *ps -ef | grep program*

## bash re-directions
```
foo() {
  echo "This is stdout"
  echo "This is stderr" 1>&2
}
foo >/dev/null 2>&1             # produces no output
foo 2>&1 >/dev/null             # writes "This is stderr" on the screen
```

Why do the results differ? In the first case, >/dev/null is performed first, and therefore the standard output of the command is sent to /dev/null. Then, the 2>&1 is performed, which causes standard error to be sent to the same place that standard output is already going. So both of them are discarded.

In the second example, 2>&1 is performed first. This means standard error is sent to wherever standard output happens to be going -- in this case, the user's terminal. Then, standard output is sent to /dev/null and is therefore discarded. So when we run foo the second time, we see only its standard error, not its standard output..
