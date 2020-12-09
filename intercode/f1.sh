# return value of the fucntion via echo

# Method 1 

function f1(){
	if [ $# -ne 1 ]; then 
		echo "Usage ./f1 arg1"
		exit 1
	else
		echo "Method-1, Hello $1"
	fi
}

f1 $1


# Method 2 

function f2(){
	echo "$1"

}

echo "Method-2, Hello $(f2 $1)"
