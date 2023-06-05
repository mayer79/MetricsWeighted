# MetricsWeighted 1.0.2

Hello CRAN

This update fixes a problem with latex ("text" instead of "textrm") introduced in the last release, yielding warnings/errors on

- r-oldrel-macos-arm64
- r-oldrel-macos-x86_64

## Checks

### R-CMD

 checking HTML version of manual ... NOTE
  Skipping checking HTML validation: no command 'tidy' found
  
### Winbuilder

Status: OK

### RHub

- Skipping checking HTML validation: no command 'tidy' found
- Skipping checking math rendering: package 'V8' unavailable

### RevDep: OK (flashlight)
