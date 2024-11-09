def State struct (first int, second int, operator int)
def state State (first=0, second=0, operator="+")

loop
    > print "Enter the first value"
    > input
    > cast * int
    > unwrap * "Should be number"
    > state.set first=*
    > print "Enter the operator"
    > input
    > state.set operator=*
    > print "Enter the second value"
    > input
    > cast * int
    > unwrap * "Should be number"
    > state.set second=*
