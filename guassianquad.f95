Program GuassianQuad
  implicit none

  integer, parameter::p = 16
  integer::k,n
  real(kind=p), allocatable::r(:,:)
  real(kind=p)::z,a,b,exact

  do n = 1,20
     a = 1.0_p
     b = 4.0_p

     r = guassquad(n)

     z = (b-a)/2._p*dot_product(r(2,:),exp((b+a)/2.0_p+r(1,:)*(b-a)/2._p))

     exact = exp(b) - exp(a)

     print"(I0,1X,G0,1X,G10.2)",n,z,z-exact
  end do
  
contains
  function guassquad(n) result(r)
    integer::n,i,iter
    real(kind=p), parameter::pi = acos(-1._p)
    real(kind=p)::r(2,n),x,f,df,dx
    real(kind=p), allocatable::p0(:),p1(:),tmp(:)

    p0 = [1._p]
    p1 = [1._p,0._p]

    do k = 2,n
       tmp = ((2*k-1)*[p1,0._p]-(k-1)*[0._p,0._p,p0])/k
       p0 = p1
       p1 = tmp
    end do

    do i = 1,n
       x = cos(pi*(i-0.25_p)/(n+0.5_p))
       dx = 1._p
       iter = 1

       do while(abs(dx).gt.10.0*epsilon(dx) .and. iter.le.10)
          f = p1(1)
          df = 0._p

          do k = 2, size(p1)
             df = f + x*df
             f = p1(k) + x*f
          end do

          dx = f/df
          x = x - dx
          iter = iter + 1
       end do

       r(1,I) = x
       r(2,i) = 2.0_p/((1.0_p-x**2)*df**2)
    end do
  end function guassquad
end program GuassianQuad
