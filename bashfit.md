# bashfit

This document is inverse of what needs to be done on the **bash pitfalls** http://mywiki.wooledge.org/BashPitfalls

I would like to write a short things as what needs to be done instead of what not. however, one must be reading the article to know more.

## loops
If you are iterating the loops for the filenames and incase you come across any **white spaces** it should also be considered from the same existing path..

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

## copy
while copying the file containing any **word splitting** or **path expansion**
copy would fail if there are **IFS** set or any globbing etc..

Note: you don't have to double quote the string in bash, until they have metachars or pattern chars..

```
cp -- $src $dest
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
