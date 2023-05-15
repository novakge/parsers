# project-parsers
Parsers for multiple project datasets like PSPLIB (ProGen), MMLIB (RanGen1/2), Real-life (ProTrack), Boctor, Patterson [...]

0. Table of Contents


1. About/Goal/description
 Parse standard project datasets with different formats in Matlab format as an input for simulations


2. Prerequisites
 Mathworks MATLAB R2017a


3. Installation instructions 
 Copy the files to Matlab working directory
 
3.1 Folders
```
├                         <- Root directory
├── src                   <- Code directory for matlab source files
├── data                  <- Containing several standard datasets
│   ├── e.g. j30          <- Folder of example dataset
│   ├── e.g. j30_out      <- Example (parsed) result data output folder
│   ├── e.g. mmlib50      <- Folder of example dataset
│   ├── ...               <- ...
├── doc                   <- Contains additional documentation, results, info etc.
├── test_data             <- Directory for test related datasets, mat files etc.
├── tool                  <- Contains additional tools, converters, generators etc.
```

4. Features and examples

4.1 Parse RanGen 1-2 (Patterson format) files in Matlab
    
    input: file with patterson format (e.g. *.rcp)
    
    example: >> PDM = parse_rangen('data/Patterson/pat80.rcp', 1) where 1=NTP trade-off problem type (single mode)
    
    output: PDM file containing PDM = [DSM,TD,CD,{QD,RD}], format depending on the selected simulation type (trade-off problem)

4.2 Parse ProTrack files in Matlab
    
    input: file with protrack format (e.g. *.p2x) in xml
    
    example: >> PDM = parse_protrack('data/protrack/C2011-09 Commercial IT Project.p2x',1) where 1=NTP trade-off problem type (single mode)
    
    output: PDM file containing PDM = [DSM,TD,CD,{QD,RD}], format depending on the selected simulation type (trade-off problem)

4.3 Parse PSPLIB or MMLIB files in Matlab
    
    input: file with PSPLIB/MMLIB library format (e.g. *.mm)
    
    example: >> PDM = parse_xlib('data/mmlib100',1) where 1=NTP, 2=CTP, 3=DTP simulation trade-off problem type (multi-mode)
    
    output: PDM file containing PDM = [DSM,TD,CD,{QD,RD}], format depending on the selected simulation type (trade-off problem)
    
4.4 Parse Boctor files in Matlab
   
    input: file with Boctor library format (e.g. *.prb)
    
    example: >> PDM = parse_boctor('data/boctor100',1) where 1=NTP, 2=CTP, 3=DTP simulation trade-off problem type (multi-mode)
    
    output: PDM file containing PDM = [DSM,TD,CD,{QD,RD}], format depending on the selected simulation type (trade-off problem)
    
4.5 Export parsed data to *.mat files (batch process all files in a directory)
    It is possible to export the parsed data to *.mat files, including the desired runtime/workspace variables for all type of trade-off problems (NTP,CTP,DTP) automatically or manually.
    
    input: folder containing datasets for parsing and exporting to *.mat
    
    example: >> save_rangen('data/Patterson')
    
    example output: ../data/Patterson_output containing all the converted matlab binaries *.mat for all trade-off problem type with naming like *_NTP.mat, *_DTP.mat *_CTP.mat and *_DSM.mat.

4.6 Export all datasets
    It is also possible to batch process all datasets with the available parsers.
    
    input: existing data folder
    
    example: >> save_all
    
    example output: ../data/<dataset_folder>_output containing all the converted matlab binaries *.mat for all supported trade-off problem types for the specific dataset with naming like *_NTP.mat, *_DTP.mat *_CTP.mat *_DSM.mat.


5. Tests

Each folder contains the relevant unit tests for the parsers.
To run the corresponding unit tests:

    examples: >> results = run(parse_rangen_test) or equivalent >> runtests('parse_rangen_test')
    
    examples: >> results = run(parse_protrack_test) or equivalent >> runtests('parse_protrack_test')
    
    examples: >> results = run(parse_xlib_test) or equivalent >> runtests('parse_xlib_test')

Note: ../test_data contains the necessary input files for the provided unit tests.

6. Other documents and files

- All supported datasets are in the main folder of each parser package. For example ../data/RG30 contains the RG30 dataset and it's files in the actual format.
- An overview excel is provided in ../doc/datasets_info.xlsx folder summarizing the available (supported/not yet supported) datasets and their formats etc.
- Mario Vanhoucke's summary excel is provided in ../doc/Datasets with Parameters and BKS (Version 3 - 2017).xlsx for all the datasets and their indicator scores/values. This is a good source for cross-validating calculations with the parser e.g. I1-I6 etc.
- ../tools/rangen/Rangen.exe is an application for generating new project data in patterson format (Vanhoucke et al.). Also can be used to generate new data with desired indicator values and then cross-check with the parser.
- ../tools/PMConverter/PMConverter.exe is a useful application to convert real-life project data excel files (can also be an own project file based on template) and protrack format *.p2x, vice versa. This can also be used to test the parser on artificial / modified projects or used for debugging.
- ../doc/boctor_format.xlsx contains "reverse engineered" information regarding the format/structure of Boctor dataset (not all details published in original paper)


7. Changelog (README.md, this file)

- 1.0 initial revision: documenting rangenx_v2 and protrack parsers, NovakG, 18.05.2018.
- 1.1 update for all-in-one parser like folder names, add psplib/mmlib support etc., NovakG, 14.08.2018.
- 1.2 minor update after adding Boctor dataset, NovakG, 18.03.2021.
- 1.3 minor update, remark for RG300(_corr) removed, NovakG, 17.04.2023.
- 1.4 minor update for code structure according to guideline and authors


8. Links, useful docs

- Patterson format description and examples: http://www.p2engine.com/p2reader/patterson_format
- Already available results for comparison (Vanhoucke et al.): http://www.projectmanagement.ugent.be/sites/default/files/files/datasets/AboutData.zip
- Summary excel including indicators (Vanhoucke et al.): http://www.projectmanagement.ugent.be/sites/default/files/files/datasets/Datasets%20with%20Parameters%20and%20BKS.xlsx
- Useful tool for reading xml files in human readable format: https://www.samltool.com/prettyprint.php
- To easily prepare e.g. test files, Excel<->ProTrack converter can be found at http://ghbonne.github.io/PMConverter
- Unit tests in Matlab howto and examples: https://www.mathworks.com/help/matlab/matlab-unit-test-framework.html
- Real-life project data (Vanhoucke et al.) http://www.projectmanagement.ugent.be/?q=research/data/realdata


9. Authors

Gergely Novák, Zsolt Tibor Kosztyán, 2018-2023

10. Contribution

Please contact before making a pull request.

11. License

This project is licensed under the terms of the GNU General Public License v3.0.
