# easy-resume-builder
A simply resume builder that uses python to take a yaml config file, then converts it to whatever format you like. Formats include latex, html, and rtf. 

## To Run

use the command
```
python generate_files.py info.yml resume_config.yml [resume_config2.yml...]
```

Where the `info.yml` is the file where all of the resume's object info is stored. The remaining arguments are the config file(s) of all of the documents that should be produced. The formatting for these config files can be found in the documentation below. 

## Info Config File
Example
```
Name: Sarah Skinner
Position: Graduate Student #optional
Objective: Study physics ig. #optional
Contact: #optional
    - email: sarahski@andrew.cmu.edu #optional
    - location: Pittsburgh, PA #optional
    - mobile: (417)298-6783 #optional
    - orcid: 0000-0003-4326-9643 #optional
    ...
Websites: #optional
    - name: Personal Website
      link: xinucode.github.io
      image: https://github.com/xinucode/xinucode.github.io/raw/main/logos/MeLogo3-white-outline.png #optional
      latex_header_id: homepage #optional
    ...
Education: #optional
    - name: Missouri University of Science and Technology
      abbreviation: Missouri S&T
      dates: June 2016 - Dec 2019
      degree: B.S. Physics
      gpa: 3.9/4.0
      minors: #optional
      - Computer Science
      - Mathematics
      location: Rolla, MO
	...
Computer Skills: #optional
    - Python
    - LaTeX
    ...
Publications: #optional
    - BULAVA2023116105
    - PhysRevE.102.032108
    ...
Research Projects: #optional
    - name: Calculating Resonance Information from Lattice QCD
      dates: Jan 2021 - Present
      summary: Investigation into how resonances impact the scattering of hadrons.
      institution: Carnegie Mellon University
      abbreviation: CMU
      location: Pittsburgh, PA
      advisor: Dr. Colin Morningstar
	...
      
Conferences: #optional
    - name: American Physical Society Topical Group on Hadronic Physics Meeting
      date: April 2023
      location: Minneapolis, MI
    ...

Workshops: #optional
    - name: Hampton University Graduate Studies (HUGS) Program (Jefferson Lab)
      date: June 2022
      location: Newport News, VA
    ...
```

## Resume Format Config
Example:
```
- Latex Resume
- Latex Resume:
  header_info:  #optional
    - homepage
    - email
    ...
...
```
