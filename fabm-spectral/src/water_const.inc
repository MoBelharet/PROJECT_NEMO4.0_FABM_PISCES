real(rk), parameter :: a_w(33) = (/ &
      6.112000e-01_rk, 7.620000e-02_rk, 4.610000e-02_rk, 1.820000e-02_rk, 6.300000e-03_rk, 5.100000e-03_rk, 8.300000e-03_rk, 1.190000e-02_rk, 2.150000e-02_rk, 4.070000e-02_rk, &
      5.500000e-02_rk, 8.490000e-02_rk, 1.995000e-01_rk, 2.850000e-01_rk, 3.512000e-01_rk, 4.559000e-01_rk, 6.433000e-01_rk, 1.444900e+00_rk, 2.390000e+00_rk, 3.738200e+00_rk, &
      2.748050e+01_rk, 1.934700e+01_rk, 6.718000e+01_rk, 9.499760e+01_rk, 3.631256e+02_rk, 1.118607e+03_rk, 9.448757e+02_rk, 5.195995e+02_rk, 6.467179e+02_rk, 3.768561e+03_rk, &
      2.628083e+03_rk, 4.376230e+05_rk, 1.338404e+06_rk &
   /)
real(rk), parameter :: b_w(33) = (/ &
      5.670000e-02_rk, 1.870000e-02_rk, 1.350000e-02_rk, 1.000000e-02_rk, 7.600000e-03_rk, 5.800000e-03_rk, 4.500000e-03_rk, 3.600000e-03_rk, 2.900000e-03_rk, 2.300000e-03_rk, &
      1.900000e-03_rk, 1.600000e-03_rk, 1.400000e-03_rk, 1.200000e-03_rk, 9.000000e-04_rk, 7.000000e-04_rk, 7.000000e-04_rk, 6.000000e-04_rk, 4.000000e-04_rk, 2.000000e-04_rk, &
      0.000000e+00_rk, 0.000000e+00_rk, 0.000000e+00_rk, 0.000000e+00_rk, 0.000000e+00_rk, 0.000000e+00_rk, 0.000000e+00_rk, 0.000000e+00_rk, 0.000000e+00_rk, 0.000000e+00_rk, &
      0.000000e+00_rk, 0.000000e+00_rk, 0.000000e+00_rk &
   /)
real(rk), parameter :: lambda_w(33) = (/ &
      2.500000e+02_rk, 3.250000e+02_rk, 3.500000e+02_rk, 3.750000e+02_rk, 4.000000e+02_rk, 4.250000e+02_rk, 4.500000e+02_rk, 4.750000e+02_rk, 5.000000e+02_rk, 5.250000e+02_rk, &
      5.500000e+02_rk, 5.750000e+02_rk, 6.000000e+02_rk, 6.250000e+02_rk, 6.500000e+02_rk, 6.750000e+02_rk, 7.000000e+02_rk, 7.250000e+02_rk, 7.750000e+02_rk, 8.500000e+02_rk, &
      9.500000e+02_rk, 1.050000e+03_rk, 1.150000e+03_rk, 1.250000e+03_rk, 1.350000e+03_rk, 1.450000e+03_rk, 1.550000e+03_rk, 1.650000e+03_rk, 1.750000e+03_rk, 1.900000e+03_rk, &
      2.200000e+03_rk, 2.900000e+03_rk, 3.700000e+03_rk &
   /)
integer, parameter :: nlambda_w = 33