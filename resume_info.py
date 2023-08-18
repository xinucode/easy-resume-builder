import yaml
import os

class ExtSiteInfo:
    def __init__(self, name, link, image = None, latex_header_id=None):
        self.name = name
        self.link = link
        self.image = image
        self.latex_header_id = latex_header_id
    
    def __str__(self):
        return f"{self.name}: {self.link}"
        
class HigherEducation:
    def __init__(self, name, degree=None, abbreviation=None, dates=None, gpa = None, minors = None, location = None):
        self.name = name
        self.degree = degree
        self.abbreviation = abbreviation
        self.dates = dates
        self.gpa = gpa
        self.minors = minors
        self.location = location
        
    def __str__(self):
        if self.abbreviation:
            return f"{self.name} ({self.abbreviation})"
        else:
            return self.name
        
class ResearchProject:
    def __init__(self, name, summary=None, institution=None, abbreviation=None, dates=None, location = None, advisor=None):
        self.name = name
        self.summary = summary
        self.institution = institution
        self.abbreviation = abbreviation
        self.dates = dates
        self.location = location
        self.advisor = advisor
        
    def __str__(self):
        # if self.advisor and self.abbreviation:
            # return f"{self.name} ({self.advisor}, {self.abbreviation})"
        # if self.advisor and self.institution:
            # return f"{self.name} ({self.advisor}, {self.institution})"
        # elif self.advisor:
            # return f"{self.name} ({self.advisor})"
        if self.abbreviation:
            return f"{self.name} ({self.abbreviation})"
        elif self.institution:
            return f"{self.name} ({self.institution})"
        else:
            return self.name

class ResumeInfo:
    
    all_other_info = {}
    
    def __init__(self, info_file):

        with open(info_file) as config_file:
            try:
                self.all_other_info = yaml.safe_load(config_file)
            except yaml.YAMLError as exc:
                print(exc)
            
        self.name = self.all_other_info.pop( "Name", "Jo Jenkins")
        self.contact_info = self.all_other_info.pop( "Contact", [])
        self.websites = [ExtSiteInfo(**options) for options in self.all_other_info.pop( "Websites", [])]
        self.education = [HigherEducation(**options) for options in self.all_other_info.pop( "Education", [])]
        self.research = [ResearchProject(**options) for options in self.all_other_info.pop( "Research Projects", [])]
        self.objective = self.all_other_info.pop( "Objective", None )
        self.position = self.all_other_info.pop( "Position", None )
			
if __name__ == "__main__":
    info_file = os.path.join("raw_resume_data", "cv.yml")
    this_resume = ResumeInfo( info_file )
    print( this_resume.name+":" )
    print( "\tObjective", this_resume.objective )
    print( "\tContact Info:" )
    for contact in this_resume.contact_info:
        item = list(contact.keys())[0]
        print( f"\t\t{item}: {contact[item]}" )
    print( "\tOnline Presence:" )
    for website in this_resume.websites:
        print( "\t\t", website )
    print( "\tEducation:" )
    for education in this_resume.education:
        print( "\t\t", education )