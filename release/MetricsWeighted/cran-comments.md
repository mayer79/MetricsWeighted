Hello CRAN maintainers

I have now added rmarkdown to the list of "suggested"" packages in order to deal with the
fact that knitr won't keep importing it, see the mail extract from Kurt Hornik below:

"
These have Markdown vignettes without at least suggesting one of
markdown or rmarkdown, which currently "works" because markdown is a
strong dependency of knitr.  However, the knitr maintainer wants to
change this so that knitr only suggests markdown in the future.

With the current CRAN version of knitr, building your package vignettes
now fails with something like

  The 'markdown' package should be declared as a dependency of the
  'unrepx' package (e.g., in the 'Suggests' field of DESCRIPTION),
  because the latter contains vignette(s) built with the 'markdown'
  package. Please see https://github.com/yihui/knitr/issues/1864 for
  more information.

(for vignette engine knitr::knitr et al) or

  The 'rmarkdown' package should be declared as a dependency of the
  'validate' package (e.g., in the 'Suggests' field of DESCRIPTION),
  because the latter contains vignette(s) built with the 'rmarkdown'
  package. Please see https://github.com/yihui/knitr/issues/1864 for
  more information.

(for vignette engine knitr::rmarkdown).

See

  https://github.com/yihui/knitr/issues/1864

for more information.

Can you please add the missing dependencies and submit a new version of
your package to CRAN as quickly as possible?

Please fix before 2021-05-14 to safely retain your package on CRAN.

Best
-k

""
