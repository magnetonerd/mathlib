"""
This is an implementation of gaussian quadrature. 
The specific purpose here is to calculate the 
sample points and weights for the integration
of a user defined function.
"""
from numpy import *

EPS = 1e-15 #We don't live in a perfect world. So, quit pretending that we do

#Calculating the sample points and weights on the interval [-1,1]
def gaussxw(N): 
    a = linspace(3,4*N-1,N)/(4*N+2) #Divides space up into discrete locations
    x = cos(pi*a) #approximations to the zeros of the Legendre Polynomials

    delta = 1.0 #initializer for the max dx value
    
    #Performing newton's method to find the roots of legendre
    while delta>EPS:
        p0 = [1.0]*N #An array of size N where all elements are initialized to 1.0
        p1 = x #a copy of x 
        #Recussion definition of Legendre Polynomials
        for k in range(1,N):
            p0,p1 = p1, ((2*k+1)*x*p1-k*p0)/(k+1) #this has to be done as one line. Two lines confudes interpreter
        dP = (N+1)*(x*p1-p0)/(x**2-1) #Derivative of Legendre Polynomials with respect to x
        dx = p1/dP #Seperation between the initial geuss and and new point using newton;s method
        x -= dx #New geuss of location of root. Once loop finishes these are the sample points
        delta = max(abs(dx)) #The maximum seperation during iteration

    w = 2*(N+1)**2/(N**2*(1-x**2)*dP**2) #the weights
    return x,w

#This is so that an arbitrary interval can be used.
def gaussxwab(N,a,b):
    x,w = gaussxw(N)
    return 0.5*(b-a)*x+0.5*(b+a),0.5*(b-a)*w
