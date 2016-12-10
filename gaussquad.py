from numpy import *

EPS = 1e-15

def gaussxw(N):
    a = linspace(3,4*N-1,N)/(4*N+2)
    x = cos(pi*a)

    delta = 1.0
    while delta>EPS:
        p0 = [1.0]*N
        p1 = x
        for k in range(1,N):
            p0,p1 = p1, ((2*k+1)*x*p1-k*p0)/(k+1)
        dP = (N+1)*(x*p1-p0)/(x**2-1)
        dx = p1/dP
        x -= dx
        delta = max(abs(dx))

    w = 2*(N+1)**2/(N**2*(1-x**2)*dP**2)
    return x,w

def gaussxwab(N,a,b):
    x,w = gaussxw(N)
    return 0.5*(b-a)*x+0.5*(b+a),0.5*(b-a)*w
