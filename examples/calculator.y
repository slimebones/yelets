#loop

def State struct (first int, second int, operator int)
def state State (first=0, second=0, operator="+")

print "Enter the first value"
    > input
    > cast * int
    > unwrap * "Should be a number"
    > state.set first=*
    ~> print "Enter the operator"
    > input
    > state.set operator=*
    ~> print "Enter the second value"
    > input
    > cast * int
    > unwrap * "Should be a number"
    > state.set second=*

eq state.operator "+"
    > add state.first state.second
    > printf "Result {0}"
eq state.operator "-"
    > sub state.first state.second
    > printf "Result {0}"
eq state.operator "*"
    > mul state.first state.second
    > printf "Result {0}"
eq state.operator "/"
    > div state.first state.second
    > printf "Result {0}"
