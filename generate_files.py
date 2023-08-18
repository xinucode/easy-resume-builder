import resume_info
import latex_resume
import yaml
import argparse
import logging

#add progress bar and info throughout

if __name__=="__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("info", help="your resume info configuration yaml")
    parser.add_argument('files', nargs='+', help='yaml configuration for files to be generated')
    args = parser.parse_args()
    info_file = args.info
    
    logging.basicConfig(format='%(asctime)s - %(message)s',level=logging.INFO)
    
    logging.info('Loading information...')
    this_resume_info = resume_info.ResumeInfo(info_file)
    these_resume_files = []
    logging.info('Done loading information. Configuring...')
    for file in args.files:
        with open(file) as config_file:
            this_config = yaml.safe_load(config_file)
            for item in this_config:
                file_type = None
                if type(item)==str:
                    file_type = item
                elif type(item)==dict:
                    file_type = list(item.keys())[0]
                    
                if file_type=="Latex Resume":
                    these_resume_files.append(latex_resume.LatexResume(this_resume_info, item, len(these_resume_files)) )
                else:
                    loggin.warning(f'Not set up to generate "{file_type}" files.')
        
    logging.info('Configuring done. Generating files...')
        
    for file in these_resume_files:
        file.generate()