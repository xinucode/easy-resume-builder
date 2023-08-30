# easy-resume-builder
A simply resume builder that uses python to take a yaml config file, then converts it to whatever format you like. Formats include latex, html, and rtf. 

Example Doaument:
<object data="https://xinucode.github.io/posters/Sarah_Skinner_Resume.pdf" type="application/pdf" width="700px" height="700px">
    <embed src="https://xinucode.github.io/posters/Sarah_Skinner_Resume.pdf">
        <p>This browser does not support PDFs. Please download the PDF to view it: <a href="https://xinucode.github.io/posters/Sarah_Skinner_Resume.pdf">Download PDF</a>.</p>
    </embed>
</object>

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
Contact: #optional (need at least one entry)
    - email: me@mail.com #optional
    - location: Pittsburgh, PA #optional
    - mobile: (123)456-7890 #optional
    - orcid: 0000-0003-4326-9643 #optional
    ...
Websites: #optional
    - name: Personal Website
      link: xinucode.github.io
      image: https://github.com/xinucode/xinucode.github.io/raw/main/logos/MeLogo3-white-outline.png #optional
      latex_header_id: homepage #optional, latex_header_id's include:
			# "homepage","github","linkedin","gitlab","stackoverflow","twitter",
			# "skype","reddit", "researchgate","gscholar", "extrainfo"
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
Example #1:
```
- Latex Resume #applies all defaults
```
This example creates a latex resume with all defaults given. It inserts all the given information into the resume.

Example #2:
```
- Latex Resume:
    name: skinner_cv #optional, specifies name for build directory
    style_info: #optional, specifies style of certain entities
      skills: #optional, sets style of skill list
        font: default #use font name downloaded into "fonts" folder 
							#or "default" or "sourcesanspro"
        size: 15 #(pt)
        color: green #color of text
        modifiers: [i,b] #i = italics, b=bold, s=scshape
      position_title: #optional, same format as skills
		...
      # other elements that can be styled include: name, links, section_header
		#footer, bibliography, entry_title, entry_position, entry_date, entry_location
    header_list: #optional, specifies which items to include in info list and in
					#what order
    - homepage
    - email
    - github
    - linkedin
    - gscholar
    section_list: #optional, specifies which items to include in section list
					# and in what order (if no info for section is given, then 
					# it's not included
    - Objective
    - Education
    - Publications
    - Research Projects
    - Computer Skills
    - Conferences
    - Workshops
    - Conferences and Workshops #if includes, "Conferences" and "Workshops" sections
									#are omitted
    - Invited Talks
...
```
This example specifies more of the formatting and ordering of the document. If sections/item are to be excluded,
create a list of all items to include and omit the excluded items. Multiple resumes can be formatted in one file.
