import pylatex
import resume_info as ri
import os, shutil
import datetime
import progressbar
import logging

def date_sort( item ):
    return item['date_obj']

class HeaderInfo:
    def __init__(self, name, **args):
        self.name = name
        self.position = args.pop("position",r"\ ")
        self.info_sort = args.pop(
            "header_list",
            [
                "mobile",
                "email",
                "birth",
                "homepage",
                "github",
                "linkedin",
                "gitlab",
                "stackoverflow",
                "twitter",
                "skype",
                "reddit",
                "orcid",
                "researchgate",
                "gscholar",
                "extrainfo",
                "location",
            ]
        )
        #make order an input
        self.info = {
            "mobile":None,
            "email":None,
            "birth":None,
            "homepage":None,
            "github":None,
            "linkedin":None,
            "gitlab":None,
            "stackoverflow":None,
            "twitter":None,
            "skype":None,
            "reddit":None,
            "orcid":None,
            "researchgate":None,
            "gscholar":None,
            "extrainfo": None,
            "location":None,
        }
        for item in self.info.keys():
            if item in args.keys():
                self.info[item] = args.pop( item, None )
                
        #check that there is at least one item
        
    def export_info(self, document):
        document.preamble.append(pylatex.Command('name', [pylatex.NoEscape(item) for item in self.name.split(" ")] ))
        document.preamble.append(pylatex.Command('position', pylatex.NoEscape(self.position) ))
        for item in self.info_sort:
            if self.info[item] is not None:
                document.preamble.append(pylatex.Command(item, pylatex.NoEscape(self.info[item]) ))
        
        
class LatexResume:
    sections = ["Objective", "Education", "Publications", "Research Projects", "Technical Skills", "Computer Skills","Skills", 
                "Conferences","Workshops", "Conferences and Workshops","Presentations", "Invited Talks","Awards and Honors",
                "Clubs and Affiliations","Licenses and Certifications", "Volunteer Services", "References", "Other Skills"]
    # sub_dir = "latex_build"
	
    def __init__( self, resume_info, resume_format, index ):
        self.resume_info = resume_info
        if type(resume_format)==dict:
            self.resume_format = resume_format['Latex Resume']
        else: 
            self.resume_format = {}
        self.index = index
        
        self.sections = self.resume_format.pop("section_list",self.sections)
        self.name = self.resume_format.pop("name","")
        
        if not os.path.exists( self.sub_dir ):
            os.mkdir( self.sub_dir )
            
        shutil.copytree( "latex_support_files", self.sub_dir, dirs_exist_ok=True )
        
    @property
    def sub_dir( self ):
        if self.name:
            return f"{self.name}_{self.index}"
        return f"latex_build_{self.index}"
        
    @property
    def out_file_name( self ):
        return str(self.resume_info.name.replace(" ","_")+"_Resume")
        
    def check_section( self, section):
        if section=="Objective":
            if self.resume_info.objective:
                return True
        elif section=="Education":
            if self.resume_info.education:
                return True
        elif section=="Research Projects":
            if self.resume_info.research:
                return True
        elif section in self.resume_info.all_other_info.keys():
            return True
        return False
        
        
    def generate_section( self, section, doc):
        # if section=="Research Projects" or section=="Education" or section=="Conferences":
            # doc.append(pylatex.Command('medskip'))
        doc.append(pylatex.Command('begin',"cventries"))
        if section=="Objective":
            doc.append(pylatex.NoEscape("\n"))
            doc.append(pylatex.Command('cventryone', [pylatex.NoEscape(self.resume_info.objective)]))
            doc.append(pylatex.NoEscape("\n"))
        elif section=="Education":
            doc.append(pylatex.NoEscape("\n"))
            for ed in self.resume_info.education:
                extra = ""
                if ed.minors:
                    if len(ed.minors)>1:
                        extra = ", "+pylatex.utils.italic("Minors in ")
                    else:
                        extra = ", "+pylatex.utils.italic("Minor in ")
                    extra += pylatex.utils.italic(", ".join(ed.minors))
                doc.append(pylatex.Command('cventryfour', [pylatex.NoEscape(ed.degree+extra),str(ed),ed.gpa,ed.dates]))
                # doc.append(pylatex.NoEscape("\n"))
            doc.append(pylatex.NoEscape("\n"))
        elif section in ["Computer Skills","Technical Skills","Skills"]:
            doc.append(pylatex.NoEscape("\n"))
            doc.append(pylatex.NoEscape("\skillsetstyle{"))
            with doc.create(pylatex.Tabularx(5*'X')) as table:
                skills = self.resume_info.all_other_info[section]
                grouped_skills = [skills[n:n+5] for n in range(0, len(skills), 5)]
                for group in grouped_skills:
                    if 'LaTeX' in group or 'latex' in group or 'laTeX' in group:
                        latex_variations = ['LaTeX','latex','laTeX']
                        group = [pylatex.NoEscape("\LaTeX ") if item in latex_variations else item for item in group]
                    if len(group)<5:
                        group = group+[pylatex.NoEscape("\ ")]*(5-len(group))
                    table.add_row( group )
            doc.append(pylatex.NoEscape("}"))
            doc.append(pylatex.NoEscape("\n"))
        elif section=="Publications":
            bibfile = self.resume_info.all_other_info[section]['bibfile']
            shutil.copy( bibfile, self.sub_dir )
            for item in self.resume_info.all_other_info[section]['list']:
                doc.append(pylatex.Command('nocite',pylatex.NoEscape(item)))
            doc.append(pylatex.Command('thisbibstyle',pylatex.Command('bibliography',"publications")))
            # doc.append(pylatex.Command('normalsize'))
        elif section=="Research Projects":
            doc.append(pylatex.NoEscape("\n"))
            for res in self.resume_info.research:
                doc.append(pylatex.Command('cventryfour', [ pylatex.NoEscape("Advisor: "+pylatex.utils.italic(pylatex.NoEscape(res.advisor))+". "+res.summary),str(res),res.location,res.dates]))
                # doc.append(pylatex.NoEscape("\n"))
            doc.append(pylatex.NoEscape("\n"))
        elif section in ["Conferences","Workshops","Conferences and Workshops","Awards and Honors","Licenses and Certifications"]:
            for item in self.resume_info.all_other_info[section]:
                try:
                    item["date_obj"] = datetime.datetime.strptime( item["date"], "%B %Y" )
                except: 
                    item["date_obj"] = datetime.datetime.strptime( item["date"], "%b %Y" )
                    
            self.resume_info.all_other_info[section].sort( key=date_sort )
            self.resume_info.all_other_info[section].reverse()
            
            doc.append(pylatex.NoEscape("\n"))
            for item in self.resume_info.all_other_info[section]:
                doc.append(pylatex.Command('cventrytwo', [item['name'],f"{item['location']}, {item['date']}"]))
            doc.append(pylatex.NoEscape("\n"))
        elif section in ["Presentations","Invited Talks"]:
            doc.append(pylatex.NoEscape("\n"))
            
            for item in self.resume_info.all_other_info[section]:
                try:
                    item["date_obj"] = datetime.datetime.strptime( item["date"], "%B %d, %Y" )
                except: 
                    item["date_obj"] = datetime.datetime.strptime( item["date"], "%b %d, %Y" )
            self.resume_info.all_other_info[section].sort( key=date_sort )
            self.resume_info.all_other_info[section].reverse()
            
            for item in self.resume_info.all_other_info[section]:
                doc.append(pylatex.Command('cventryfour', [pylatex.NoEscape(pylatex.utils.italic(item['type'])+": "+item['title']),pylatex.NoEscape(item['host']),item['location'], item['date']]))
                # doc.append(pylatex.NoEscape("\n"))
            doc.append(pylatex.NoEscape("\n"))
            
        elif section in ["Volunteer Services"]:
            doc.append(pylatex.NoEscape("\n"))
            for item in self.resume_info.all_other_info[section]:
                doc.append(pylatex.Command('cventrytwo', [item['name'],f"{item['location']}, {item['date']}"]))
            doc.append(pylatex.NoEscape("\n"))
        elif section=="References":
            doc.append(pylatex.NoEscape("\n"))
            for item in self.resume_info.all_other_info[section]:
                doc.append(pylatex.Command('cventrytwo', [pylatex.NoEscape(item['name']),item['email']]))
            doc.append(pylatex.NoEscape("\n"))
        elif section in ["Clubs and Affiliations"]:
            doc.append(pylatex.NoEscape("\n"))
            for item in self.resume_info.all_other_info[section]:
                doc.append(pylatex.Command('cventryfour', [pylatex.NoEscape(item['position']),pylatex.NoEscape(item['name']),item['location'], item['date']]))
                # doc.append(pylatex.NoEscape("\n"))
            doc.append(pylatex.NoEscape("\n"))
            
        doc.append(pylatex.Command('end',"cventries"))
        
    def check_available_fonts( self, file_contents, font_item, font_name):
        fonts = os.listdir( os.path.join(self.sub_dir,"fonts") )
        file_tags = ["Italic","Bold","BoldItalic"]
        setting_tags = [f"{mod}Font=*-{mod}," for mod in file_tags]
        for setting_tag, file_tag in zip(setting_tags, file_tags):
            file_contents = file_contents.replace( f"{font_item}{setting_tag}", setting_tag if f"{font_name}-{file_tag}.ttf" in fonts or f"{font_name}-{file_tag}.otf" in fonts else "%")
        return file_contents
        
    def set_style(self, item_tag, style, file_contents, defaults = ['Barrbar', 35, 'text', []] ):
    
        title_font = style.get('font', defaults[0])
        title_font_size = style.get('size', defaults[1])
        title_font_color = style.get('color', defaults[2])
        title_modifiers = style.get('modifiers', defaults[3])
        fn_font_size = f"{title_font_size}pt"
        fn_font_color = title_font_color
        fn_modifiers = title_modifiers
        
        if title_font=="default" or title_font=="sourcesanspro":
            if title_font=="default":
                file_contents = file_contents.replace(f"{item_tag}FontTag", r"\rm")
            else:
                file_contents = file_contents.replace(f"{item_tag}FontTag", r"\sourcesanspro")
            input_font_tag = f"""\\newfontfamily\{item_tag}font[
  Path=\@fontdir,
  UprightFont=*-Regular,
  {item_tag}FontItalicFont=*-Italic,
  {item_tag}FontBoldFont=*-Bold,
  {item_tag}FontBoldItalicFont=*-BoldItalic,
]{{{item_tag}Font}}
"""
            file_contents = file_contents.replace(input_font_tag, "")
        
        file_contents = self.check_available_fonts(file_contents, f"{item_tag}Font", title_font)
        file_contents = file_contents.replace(f"{item_tag}FontTag", f"\\{item_tag}font")
        file_contents = file_contents.replace(f"{item_tag}FontSize", fn_font_size)
        file_contents = file_contents.replace(f"{item_tag}FontColor", fn_font_color)
        file_contents = file_contents.replace(f"{item_tag}FontBold", r'\bfseries' if 'b' in fn_modifiers else "")
        file_contents = file_contents.replace(f"{item_tag}FontItalics", r'\itshape' if 'i' in fn_modifiers else "")
        file_contents = file_contents.replace(f"{item_tag}FontSC", r'\scshape' if 's' in fn_modifiers else "")
        
        file_contents = file_contents.replace(f"{item_tag}Font", title_font)
        return file_contents
        
        
    def generate(self):
        logging.info('Generating Latex Resume...')
        bar = progressbar.ProgressBar(maxval=len(self.sections)+1,
            widgets=[progressbar.Percentage(), ' ', 
            progressbar.Bar(marker=progressbar.RotatingMarker()),' ', 
            progressbar.ETA()]).start()
        i=0
        
        #make modifications to awesome-cv.cls
        with open( os.path.join(self.sub_dir, "awesome-cv.cls"), "r") as f:
            file_contents = f.read()
            
        with open( os.path.join(self.sub_dir, "awesome-cv.cls"), "w") as f:
        
            style_info = self.resume_format.pop('style_info', {})
            title_style = style_info.pop('name', {})
            file_contents = self.set_style( "FirstName", title_style, file_contents)
            file_contents = self.set_style( "LastName", title_style, file_contents)
            file_contents = self.set_style( "Name", title_style, file_contents)
            
            ptitle_style = style_info.pop('position_title', {})
            file_contents = self.set_style( "PositionTitle", ptitle_style, file_contents, ['Roboto', 10, 'awesome', []])
            
            links_style = style_info.pop('links', {})
            file_contents = self.set_style( "Links", links_style, file_contents, ['Roboto', 8, 'text', ['b']])
            
            section_style = style_info.pop('section_header', {})
            file_contents = self.set_style( "Section", section_style, file_contents, ['default', 16, 'awesome', ['b']])
            
            footer_style = style_info.pop('footer', {})
            file_contents = self.set_style( "Footer", footer_style, file_contents, ['sourcesanspro', 8, 'lighttext', ['s']])
            
            footer_style = style_info.pop('subsection_header', {}) #doesn't do anything
            file_contents = self.set_style( "Subsection", footer_style, file_contents, ['default', 12, 'text', []])
            
            footer_style = style_info.pop('paragraph', {}) #doesn't do anything
            file_contents = self.set_style( "Paragraph", footer_style, file_contents, ['default', 8, 'text', []])
            
            footer_style = style_info.pop('bibliography', {}) 
            file_contents = self.set_style( "Bib", footer_style, file_contents, ['default', 8, 'graytext', []])
            
            footer_style = style_info.pop('entry_title', {})
            file_contents = self.set_style( "EntryTitle", footer_style, file_contents, ['default', 10, 'darktext', ['b']])
            
            footer_style = style_info.pop('entry_position', {})
            file_contents = self.set_style( "EntryPosition", footer_style, file_contents, ['default', 8, 'graytext', []])
            
            footer_style = style_info.pop('entry_date', {}) 
            file_contents = self.set_style( "EntryDate", footer_style, file_contents, ['default', 8, 'graytext', ['i']])
            
            footer_style = style_info.pop('entry_location', {}) 
            file_contents = self.set_style( "EntryLocation", footer_style, file_contents, ['default', 8, 'darktext', ['s']])
            
            footer_style = style_info.pop('skills', {}) 
            file_contents = self.set_style( "Skillset", footer_style, file_contents, ['default', 9, 'text', ['s']])
            
            f.write(file_contents)
            
        #make modifications to JHEP.bst
        with open( os.path.join(self.sub_dir, "JHEP.bst"), "r") as f:
            file_contents = f.read()
            
        with open( os.path.join(self.sub_dir, "JHEP.bst"), "w") as f:
            name = self.resume_info.name.split(" ")
            last_name = name[-1]
            first_init = name[0][0]
            author_name = f"{first_init}.~{last_name}"
            file_contents = file_contents.replace("RESUMENAME",author_name)
            f.write(file_contents)
            
    
        #make input
        geometry_options = {"left":"1.4cm", "top":".8cm", "right":"1.4cm", "bottom":"1.8cm", "footskip":".5cm"}
        doc = pylatex.Document(geometry_options=geometry_options,documentclass=pylatex.NoEscape('awesome-cv'), document_options=["11pt", "a4paper"], fontenc=None, inputenc=None)
        doc.packages.append(pylatex.Package('hyperref'))
        doc.packages.append(pylatex.Package('lastpage'))
        doc.packages.append(pylatex.Package('tabularx'))
        # doc.packages.append(pylatex.Package('amssymb'))
        doc.packages.append(pylatex.Package('etoolbox'))
        doc.packages.append(pylatex.Package('graphicx,calc'))
        doc.preamble.append(pylatex.Command('definecolor', ['link', 'RGB','28,74,238']))
        doc.preamble.append(pylatex.Command('bibliographystyle', "JHEP")) #make input
        doc.preamble.append(pylatex.NoEscape('\patchcmd{\\thebibliography}{\section*{\\refname}}{}{}{}'))
        
        #make input\renewcommand{\familydefault}{\rmdefault}
        doc.preamble.append(pylatex.Command('renewcommand', [pylatex.Command('familydefault'),pylatex.Command('rmdefault')]))
        doc.preamble.append(pylatex.Command('setbool', ['acvSectionColorHighlight','true']))
        doc.preamble.append(pylatex.Command('colorlet', ['awesome',pylatex.NoEscape('awesome-emerald')])) #make input
        doc.preamble.append(pylatex.Command('renewcommand', [pylatex.Command('acvHeaderSocialSep'),pylatex.NoEscape(r'\quad')]))
        doc.preamble.append(pylatex.Command('renewcommand', [pylatex.Command('section'),pylatex.Command('cvsection')]))
        doc.preamble.append(pylatex.Command('renewcommand', [pylatex.Command('itemize'),pylatex.Command('cvitems')]))
        
        doc.preamble.append(pylatex.NoEscape(r"\makeatletter"))
        doc.preamble.append(pylatex.Command('patchcmd', [pylatex.Command('@sectioncolor'),pylatex.Command(r'color'), pylatex.NoEscape(r'\mdseries\color')]))
        doc.preamble.append(pylatex.NoEscape(r"\makeatother"))
        
        contact_info = {}
        info_sort = self.resume_format.pop( "header_list", [])
        if info_sort:
            contact_info["header_list"] = info_sort
            
        sites = []
        if self.resume_info.position is not None:
            contact_info['position'] = self.resume_info.position
            # self.resume_info.all_other_info[section]
        for site in self.resume_info.websites:
            if site.latex_header_id is not None:
                sites.append( {site.latex_header_id: site.link} )
        for item in self.resume_info.contact_info+sites:
            for key in item.keys():
                if key not in contact_info.keys():
                    contact_info[key] = item[key]
                else:
                    i = 2
                    while True:
                        new_key = key+str(i)
                        if new_key not in contact_info.keys():
                            contact_info[new_key] = item[key]
                            break
                        i+=1
        header = HeaderInfo( self.resume_info.name, **contact_info )
        header.export_info(doc)
        
        doc.append(pylatex.Command('makecvheader'))
        doc.append(pylatex.Command('makecvfooter',[pylatex.NoEscape(r'Last updated: \today'),
                                                    pylatex.NoEscape(self.resume_info.name+"~~~·~~~Résumé"),
                                                    pylatex.NoEscape(r'\thepage \ / \pageref{LastPage}')]))
        
        #make order an input
        doc.append(pylatex.Command('medskip'))
        doc.append(pylatex.NoEscape("\n"))
        if self.check_section("Conferences") and self.check_section("Workshops") and "Conferences and Workshops" in self.sections:
            self.resume_info.all_other_info["Conferences and Workshops"] = self.resume_info.all_other_info.pop("Conferences") + self.resume_info.all_other_info.pop("Workshops") 
        
        bar.update(i)
        i+=1
        for section in self.sections:
            if self.check_section(section):
                this_section = pylatex.Section(section)
                self.generate_section(section,this_section)
                this_section.generate_tex(os.path.join(self.sub_dir,section))
                doc.append(pylatex.Command('input',section))
            bar.update(i)
            i+=1
                                    
       
        doc.generate_pdf(os.path.join(self.sub_dir,self.out_file_name), clean_tex=False, clean=False, compiler="lualatex", compiler_args=['-synctex=1', '-interaction=nonstopmode'], silent=True)
        bar.finish()
        if "Publications" in self.sections:
            logging.info('Running Bibtex...')
            os.system( f"bibtex -include-directory={self.sub_dir} {os.path.join(self.sub_dir,self.out_file_name)}" )
        logging.info('Generating PDF...')
        doc.generate_pdf(os.path.join(self.sub_dir,self.out_file_name), clean_tex=False, clean=True, compiler="lualatex", compiler_args=['-synctex=1', '-interaction=nonstopmode'], silent=True)
        
# if __name__=="__main__":
    # info_file = os.path.join("raw_resume_data", "cv.yml")
    # this_resume = ri.ResumeInfo( info_file )
    # this_latex_resume = LatexResume( this_resume, {} )
    # this_latex_resume.generate()