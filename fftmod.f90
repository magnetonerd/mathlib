module fft_mod
  implicit none
contains

  subroutine fft(a,m,inv)
    !fft with n = 2^m. a(n) complex data in input and
    !corresponding fourier coefficients in the output
    !inv inversion flag- inverse(1) not(0)
    implicit none

    integer:: n,n_half,m,i,j,k,l,l1,l2,ip,inv
    double precision, parameter:: pi=acos(-1.0)
    double precision:: q,wr,wi
    complex*16::a(*),u,w,t

    n = 2**m
    n_half = n/2

    !Rearrange the data into the bit reversed order
    !This is the interweaving of the evens and odds

    j = 1

    do i = 1, n-1
       if(i.lt.j)then
          t = a(j)
          a(j) = a(i)
          a(i) = t
       end if

       k = n_half

       do while(k.lt.j)
          j = j-k
          k = k/2
       end do

       j = j+k
    end do

    !perform addition on the reordered data at all levels
    !this is the fft

    l2 = 1

    do l = 1,m
       l1 = l2
       l2 = 2*l2
       q = pi/l1
       u = (1.d0,0.d0)
       wr = cos(q)
       wi = sin(q)
       w = cmplx(wr,-wi)

       if(inv.eq.1)then
          w = conjg(w)
       end if

       do j = 1,l1
          do i = j,n,l2
             ip = i+ l1
             t = a(ip)*u
             a(ip) = a(i)-t
             a(i) = a(i)+t
          end do

          u = u*w
       end do
    end do

    !Apply 1/n if not doing the inverse transform

    if(inv.ne.1)then
       do i = 1,n
          a(i) = a(i)/n
       end do
    end if

  end subroutine fft
end module fft_mod
