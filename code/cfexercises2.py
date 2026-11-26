#I predict it will return 4 'hello's' as 12/3 = 4
def hello_1(x):
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')

hello_1(12)


# i predict it will return 4 'hello's' as only 3 and 8 fulfil first loop while 7 and 11 fulfil the second loop, 3 fulfils both but won't fire on the elseloop
def hello_2(x):
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')

hello_2(12)

# should return 14 'hello's' as 17-3 = 14
def hello_3(x, y):
    for i in range(x, y):
        print('hello')
    print(' ')

hello_3(3, 17)

# should return 5 'hello's' as 15/3 = 5
def hello_4(x):
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')

hello_4(0)

#Once it reaches 31 it prints 'hello' 7 times. It prints hello once at 18. Total should be 8.
def hello_5(x):
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')

hello_5(12)

# WHILE loop with BREAK. Should print 'hello' 6 times before breaking (numbers 0-5)
def hello_6(x, y):
    while x: # while x is True
        print("hello! " + str(y))
        y += 1 # increment y by 1 
        if y == 6:
            break
    print(' ')

hello_6 (True, 0)