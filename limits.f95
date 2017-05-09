program limits
  implicit none

  double precision::epsilon, prec
  integer:: i
  integer, parameter:: n = 60

  prec = 1.0d0
  epsilon = 1.0d0

  do i = 1, n
     epsilon = epsilon/2.
     prec = 1.0 + epsilon
     write(*,*)i, prec, epsilon
  end do

end program limits
