# 
# [v1.1.0](https://github.com/DoHaiSon/InfoSysID_Toolbox/releases/tag/v1.1.0) (2023-05-16)

### #1 Python support and docs of core functions

**InfoSysID Toolbox: Supports more algorithms:**
- CE Mode:
  -  ZF for OFDM systems.
  - MMSE for OFDM systems.
  - SB-MRE algorithm (our proposed)

- CRB Mode: 
  - Fisher Information Neural Estimation (FINE): T. T. Duy, L. V. Nguyen, V. -D. Nguyen, N. L. Trung and K. Abed-Meraim, "Fisher Information Neural Estimation," in _2022 30th European Signal Processing Conference (EUSIPCO)_, Belgrade, Serbia, 2022, pp. 2111-2115.
  
**Core Functions:**
- Python support: python script, e.g., FINE, will be run outside of MatLab, and the results are imported into InfoSysID Toolbox.
- Docs for a part of core functions (/Shared/General).
- Close all InfoSysID toolbox windows before opening a new one.
- Added an open reference paper button to each algorithm in the toolbox.

**Bugs fixed:**
- Fixed dir too long in Linux when booting.
- Used char variables instead of strings to support older MatLab versions.
- More and more minor bug fixes in GitHub commits.

# [v1.0.1](https://github.com/DoHaiSon/InfoSysID_Toolbox/releases/tag/v1.0.1) (2022-11-23)

### Hotfix start and modtool script

**Bugs fixed:**
- start script: `add_path` is not working in old windows versions (i.e., XP, 7) due to the limitation of characters in an array.
  - Fixed: ignored .git folder via `genpath_exclude` function 
- modtool script: syntax `text = fileread(filename,Encoding=encoding)` not working in older Matlab version.
  - Fixed: ignored `Encoding` argument.

# [v1.0.0](https://github.com/DoHaiSon/InfoSysID_Toolbox/releases/tag/v1.0.0) (2022-11-19)

### Channel estimation (CE): Full algorithms support.

- This version supported all old Blind Toolbox algorithms (the results are verified with default input arguments)
- InfoSysID_modtool v1.0.0: supported users undo (back button).

**InfoSysID Toolbox:**
CE Mode: Supported all Algorithms from the old toolbox version in 4 types of outputs, i.e., SER, BER, MSE Sigal, and MSE Channel.
- CR
  - Standard
  - Minimum
  - Minimum White
  - Unbiased
- CS
  - Standard
  - LSFBL
  - LSFNL
  - MNS
  - OMNS
 - SCMA
 - SMNS
- FI
- LSS
- OP
- TSML

**InfoSysID modtool:**
- Add functionals for the Back button: helps users to modify their previous inputs.

**Core Functions:**
- Supported SER, MSE Signal, and MSE channel outputs.
- Support input channel from input files (.mat).

**Bugs fixed:**
- Fixed workspace value for edit box
- Fixed some typo docs

# [v0.2.0](https://github.com/DoHaiSon/InfoSysID_Toolbox/releases/tag/v0.2.0) (2022-11-07)

### InfoSysID_modtool v0.1.0

This version focused on releasing a new tool called "modtool", which helps users create modules to integrate their algorithms into the Toolbox.
(FYI: a template module consists of interfaces and the main function)


**Core Functions:**
- InfoSysID_modtool v0.1.0:  GUI supports automatically generating new modules. 
**Bugs fixed:**
- Fixed bugs related to the dependence library in the Channel estimation algorithms.

# [v0.1.1](https://github.com/DoHaiSon/InfoSysID_Toolbox/releases/tag/v0.1.1) (2022-10-19)

### Channel estimation (CE): Blind algorithms support

**InfoSysID Toolbox:**
CE Mode: Supported all Algorithms from the old toolbox version if they use Bit err rate / Sym err rate output.
- CMA:
  - CMA Analytical
  - CMA Newton
  - CMA Gradient
  - CMA Gradient adaptive
  - CMA Gradient block
  - CMA Gradient Unidimensional
- GRDA
- LP
- MRE:
  - MRE quadratic constraint
  - MRE linear constraint
  - MRE adaptive
- SS

**Core functions:**
- Updated custom x, and y labels, or title for each algorithm.
- Full function Generate channel
- Used mfilename instead of getActive dir

**Bugs fixed:**
- Miss the shape of the params window when users switch the algorithms.
- Fixed Workspace in single fig mode

# [v0.1.0](https://github.com/DoHaiSon/InfoSysID_Toolbox/releases/tag/v0.1.0) (2022-10-04)

### The first InfoSysID Toolbox release
Core functions and some CRB & CE algorithms