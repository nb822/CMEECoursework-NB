#finds square root
def foo_1(x):
    return x ** 0.5

#returns the biggest number
def foo_2(x , y):
    if x > y:
        return x
    return y

#orders numbers from smallest to largest
def foo_3(x, y, z):
    if x > y:
        x , y = y , x
    if x > z:
        x , z = z , x
    if y > z:
        y , z = z , y
    return x , y , z

def foo_4(x):
    result = 1
    #loops through each number between 1 and x
    for i in range(1, x + 1):
        #loops through multiplies result by each subsequent number up to x, exponentially increasing the result
        result = result * i
    return result

#does the same thing as foo_4 but recursively; nests the function within itself
def foo_5(x):
    if x == 1:
        return 1
    return x * foo_5(x - 1)

def foo_6(x):
    facto = 1
    while x >= 1:
        facto = facto * x
        x -= 1
    return facto

