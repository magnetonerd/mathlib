  !**********************************************
  !Program to calculate the linear interpolation
  !of the function f(x)=sinc(x^2) using 10 points
  !as simulated measured data. Data is saved to
  !a text file for graphical use elsewhere--
  !gnuplot,Excel,MATLAB,...
  !**********************************************
PROGRAM LINEARINTERP
  IMPLICIT NONE
  !LINE SPACE REPRESENTED BY ARRAYS, PTS DEFINES THE NUMBER
  !OF POINTS TO USE
  INTEGER, PARAMETER::PTS = 100
  INTEGER, PARAMETER::DPTS = 10
  DOUBLE PRECISION, PARAMETER::INTERVAL = 5.0D0
  !DECLARE THE VARIABLES YOU ARE GOUNG TO USE.
  !SINGLE DIMESION ARRAYS OF SIZE PTS
  DOUBLE PRECISION, DIMENSION(PTS)::X,G1,G2
  DOUBLE PRECISION, DIMENSION(DPTS, 2)::D
  DOUBLE PRECISION::F, ALPHA, P
  INTEGER I, K, M
  EXTERNAL F
  ALPHA = INTERVAL/PTS
  M = (PTS - 1)/(DPTS - 1)
  DO I = 1,PTS
     P = I          !ASSIGNMENT CONVERTS INT INTO REAL
     X(I) = P*ALPHA !SET UP THE X VALUES WHICH ARE FLOATS.
  END DO
  !ASSIGNING THE DATA POINTS WE ARE TAKING AS "MEASUREMENTS"
  !HERE WE USE 10 EQUIDISTANT POINTS
  DO K = 1, DPTS
     D(K,1) = X((K-1)*M + 1)
     D(K,2) = F(D(K,1))
  END DO
  CALL LINEAR(X, D, G1, G2, M, PTS, DPTS)
  !WRITE THE DATA TO A TEXT FILE.
  !FW.D FLOAT TOTAL-WIDTH. DECIMAL-RANGE
  !THE OUTPUT WILL BE SPACE DELIMITED USING 2X
  OPEN(UNIT = 1, FILE = "linear_interp_data.txt")
  WRITE(1,100) (X(I), F(X(I)), G1,G2, I=1, PTS)
100 FORMAT(4(F16.10,2X))
  CLOSE(1)
END PROGRAM LINEARINTERP
!************************************************************
DOUBLE PRECISION FUNCTION F(X)
  DOUBLE PRECISION X
  F = SIN(X**2)/(X**2)
END FUNCTION F
!************************************************************
SUBROUTINE LINEAR(X,D,G1,G2,M,PTS,DPTS)
  !DECLARE THE VARIABLES YOU ARE GOING TO USE.
  !SINGLE DIMENSION ARRAYS OF SIZE PTS
  INTEGER I, J, K, M, PTS, DPTS
  DOUBLE PRECISION, DIMENSION(PTS)::X,G1,G2
  DOUBLE PRECISION, DIMENSION(DPTS,2)::D
  DOUBLE PRECISION::C1, C2
  !ASSIGN THE DATA POINTS WE ARE TAKING AS "MEASUREMENTS"
  !TO OUR APPROXIMATION FUNCTION G(X)
  DO K = 1, DPTS
     G1((K-1)*M + 1) = D(K, 2)
     G2((K-1)*m + 1) = D(K, 2)
  END DO
  !CALCULATE THE LINEAR INTERPOLATION. MAX J IS REDUCED TO
  !DPTS-1 AS INDEX I WOULD GO PAST LAST "MEASURED" DATA POINT
  !OTHERWISE. THE VALUES FOR I SELECT THE X AND F(X) BETWEEN
  !THE "MEASURED" POINTS
  DO J = 1, DPTS-1
     DO I = (J-1)*M+2, M*J
        !NESTED LOOP. HERE J REMAINS CONSTANT WHILE I ITERATES
        !D(J,1),D(J+1,1),D(J,2),AND D(J+1,2) ARE OUR X AND F(X)
        !"MEASUREMENT" VALUES, RESPECTIVELY
        C1 = (X(I) - D(J+1,1))/(D(J,1) - D(J+1,1))
        C2 = (X(I) - D(J,1))/(D(J+1,1) - D(J,1))
        G1(I) = D(J,2) + C2*(D(J+1,2) - D(J,2))!NON-SYMMETRIC FORM
        G2(I) = C1*D(J,2)+C2*D(J+1,2)!SYMMETRIC FORM
     END DO
  END DO
  RETURN
END SUBROUTINE LINEAR