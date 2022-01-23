# Original message

Hello CRAN

This is a small update to fix bugs in unit tests that implied a wrong usage of `all.equal()`.

CRAN checks were okay, with the usual warning about qpdf. The note about time is new to me.

-- R CMD check results ------------ MetricsWeighted 0.5.4 ----
Duration: 1m 13.6s

> checking for unstated dependencies in examples ... OK
   WARNING
  'qpdf' is needed for checks on size reduction of PDFs

> checking for future file timestamps ... NOTE
  unable to verify current time

0 errors √ | 1 warning x | 1 note x
