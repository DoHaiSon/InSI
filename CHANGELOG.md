# 
# [v1.2.0](https://github.com/DoHaiSon/InSI/releases/tag/v1.2.0) (2023-06-17)

### InSI docs website, dynamic InSI resolution, help, ref, and more

**InSI docs website**: [https://dohaison.github.io/InSI](https://dohaison.github.io/InSI).

**Core Functions**:
- Renamed from InSysID to InSI, [#1](https://github.com/DoHaiSon/InSI/issues/1).
- Re-constructed the dashboard layout: figure options to the menu bar area, [#3](https://github.com/DoHaiSon/InSI/issues/3).
- Text changed: "Criterion" => Performance and "Params" => "Parameters", [#4](https://github.com/DoHaiSon/InSI/issues/4).
- Replaced SNR and Err on the Toolbox Workspace by Output type and Run time, [#5](https://github.com/DoHaiSon/InSI/issues/5).
- Export input parameters and output error rate to the Matlab workspace in a struct, [#6](https://github.com/DoHaiSon/InSI/issues/6).
- Renamed and more modulations: QAM-4 => 4-QAM, QAM-64, 128, 256, [#7](https://github.com/DoHaiSon/InSI/issues/7).
- New dashboard title, load output figure title and dashboard title from the comment of algorithms instead of params.m file, [#8](https://github.com/DoHaiSon/InSI/issues/8), [#9](https://github.com/DoHaiSon/InSI/issues/9).
- New help button in select input parameters menu, the massage dialog box of help as shown in the command window and access the original paper URL, [#10](https://github.com/DoHaiSon/InSI/issues/10).
- Disable the hold on figure option when users had multiple output types, [#11](https://github.com/DoHaiSon/InSI/issues/11). 
- Full name + notation of input parameters menu, [#13](https://github.com/DoHaiSon/InSI/issues/13).
- Dynamic the size of the InSI toolbox and texts in any screen resolution and scale, [#14](https://github.com/DoHaiSon/InSI/issues/14), [#16](https://github.com/DoHaiSon/InSI/issues/16), [#17](https://github.com/DoHaiSon/InSI/issues/17).
- Load logos of VNU-UET, Orleans, AVITECH, PRISME Lab, Viettel-M3, and NAFOSTED onto the InSI dashboard, [#15](https://github.com/DoHaiSon/InSI/issues/15).
- InSI modtool version 1.2.0, [#18](https://github.com/DoHaiSon/InSI/issues/18).
- [New menu bar for bug report and license.](https://github.com/DoHaiSon/InSI/commit/cb59e6639e597e7106d5d4576f8be353c887a361)

**Bugs fixed**:
- In Matlab version 2016 and earlier, handles.figmode property is Label not Text, [#12](https://github.com/DoHaiSon/InSI/issues/12).
- [fixed issue: when user closes the questdlg, nothing return.](https://github.com/DoHaiSon/InSI/commit/d0ac896b6227874dadc134960f6922a1a2d3dbe1)
- [convert OnOffSwitchState enumeration to char: working in R2006A](https://github.com/DoHaiSon/InSI/commit/df65b57872f7529a85f69e16a49671f71ad632e4).
- [move close_InSI after addpath](https://github.com/DoHaiSon/InSI/commit/9d2abba04844d0b7fa78dd2de9d851352c36105f)
- More and more small bugs fixed.

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