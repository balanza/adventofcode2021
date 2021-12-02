# adventofcode2021
Rockin' Prolog for  https://adventofcode.com/2021 

### How to run 
Scripts are meant to run with [SWI-Prolog](https://www.swi-prolog.org/) implementation. Each day has its file, each file has its questions in the shape of predicates with 0-arity.
```prolog
$ swipl 01/main.pl
?- question_one.
```

Download `swipl` from [its website](https://www.swi-prolog.org/Download.html) or use the official Docker image instead:

```bash
function swipl(){
    #!/bin/bash
    CNT_DIR="/code"
    if [ -n "$1" ]; then file="$CNT_DIR/$1"; fi
    docker run --rm -it -v "$(pwd)/:$CNT_DIR" swipl swipl "$file"
}
```
