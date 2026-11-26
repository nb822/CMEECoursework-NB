#ORIGINAL code to learn how to debug code in Python. If un-commented, will throw a ZeroDivisionError.
#     y = x
#     for i in range(x):
#         y = y-1
#         z = x/y
#     return z

# #buggyfunc(20)

#Uses try and except to not throw an error when it reaches ZeroDivisionError. Instead, it prints a message and continues the loop.
def buggyfunc(x):
    y = x
    for i in range(x):
        try: 
            y = y-1
            z = x/y
        except ZeroDivisionError:
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This didn't work;{x = }; {y = }")
        else:
            print(f"OK; {x = }; {y = }, {z = };")
    return z

buggyfunc(20)