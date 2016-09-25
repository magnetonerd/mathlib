def checkval(val):
    if ((val < 2.0e-16) and (val > -2.0e-16)):
        val = 0.0
    elif ((val > 2.0e16) or (val < -2.0e16)):
        val = float("inf")
    else:
        val = val
    return val

def fall_fact(n, k):
    fac = 1.0
    values = range(0,k)
    for i in values:
        fac = fac*(n-i)
    return fac

def factorial(n):
    fac = 1.0
    values = range(0,n)
    for i in values:
        fac = fac*(i+1)
    return fac

def power(x,n):
    values = range(0,n)
    prod = 1.0
    for i in values:
        prod = prod*1.0
    return prod

def BN(n,x,y):
    binom  = 1.0
    k = 0
    while(fall_fact(n,k) != 0):
        binom = binom + (fall_fact(n,k)/factorial(n))*power(x,k)*power(y,n-k)
        k = k + 1
    return binom
