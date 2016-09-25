import math

def checkval(val):
    if ((val < 2.0e-16) and (val > -2.0e-16)):
        val = 0.0
    elif ((val > 2.0e16) or (val < -2.0e16)):
        val = float("inf")
    else:
        val = val
    return val

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
        prod = prod*x
    return prod

def expfunc(x):
    N = 200
    p = N/2
    total = 0
    values1 = range(0,N)
    values2 = range(0,p)
    powers = [0]*N
    factorials = [0]*N
    comp = [0]*N
    for i in values1:
        powers[i] = power(x,i)
        factorials[i] = factorial(i)
        comp[i] = powers[i]/factorials[i]
    for i in values1:
        total = total + comp[i]
    val = checkval(total)
    return val

def sinfunc(x):
    N = 200
    p = N/2
    total = 0
    values1 = range(0,N)
    values2 = range(0,p)
    powers = [0]*N
    factorials = [0]*N
    comp = [0]*N
    for i in values1:
        powers[i] = power(x,i)
        factorials[i] = factorial(i)
        comp[i] = powers[i]/factorials[i]
    for i in values2:
        total = total + (-1)**i*comp[2*i+1]
    val = checkval(total)
    return val

def cscfunc(x):
    if(sinfunc(x) == 0.0):
        val = float("inf")
    else:
        val = sinfunc(x)**(-1)
        val = checkval(val)
    return val

def cosfunc(x):
    N = 200
    p = N/2
    total = 0
    values1 = range(0,N)
    values2 = range(0,p)
    powers = [0]*N
    factorials = [0]*N
    comp = [0]*N
    for i in values1:
        powers[i] = power(x,i)
        factorials[i] = factorial(i)
        comp[i] = powers[i]/factorials[i]
    for i in values2:
        total = total + (-1)**i*comp[2*i]
    val = checkval(total)
    return val

def secfunc(x):
    if(cosfunc(x) == 0.0):
        val = float("inf")
    else:
        val = cosfunc(x)**(-1)
        val = checkval(val)
    return val

def tanfunc(x):
    if(cosfunc(x) == 0.0):
        val = float("inf")
    else:
        val = sinfunc(x)/cosfunc(x)
        val = checkval(val)
    return val

def cotfunc(x):
    if(sinfunc(x) == 0.0):
        val = float("inf")
    else:
        val = tanfunc(x)**(-1)
        val = checkval(val)
    return val
