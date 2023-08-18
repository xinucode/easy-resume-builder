%line163  这里被我修改了（完全注释掉了）

%% Start of file `awesome-cv.cls'.
% Awesome CV Class File
%
% This class has been downloaded from:
% https://github.com/posquit0/Awesome-CV
%
% Author:
% Claud D. Park <posquit0.bj@gmail.com>
% http://www.posquit0.com
%
% Notes:
% 1) This class file defines the structure and layout of the template file (cv.tex, resume.tex).
% 2) It has been written in such a way that under most circumstances you
% should not need to edit it.
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)
%


%-------------------------------------------------------------------------------
%                Identification
%-------------------------------------------------------------------------------
\ProvidesClass{awesome-cv}[2020/12/20 Curriculum Vitae-Yin]
\NeedsTeXFormat{LaTeX2e}


%-------------------------------------------------------------------------------
%                Class options
%
% (need to be done before the external package loading, for example because
% we need \paperwidth, \paperheight and \@ptsize to be defined before loading
% geometry and fancyhdr)
%-------------------------------------------------------------------------------
% Options for draft or final
\DeclareOption{draft}{\setlength\overfullrule{8pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
% Inherit options of article
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}


%-------------------------------------------------------------------------------
%                3rd party packages
%-------------------------------------------------------------------------------
%
\RequirePackage[dvipsnames]{xcolor}
%+中文
\RequirePackage{CJK}
% Needed to make fixed length table
\RequirePackage{array}
% Needed to handle list environment
\RequirePackage{enumitem}
% Needed to handle text alignment
\RequirePackage{ragged2e}
% Needed to configure page layout
\RequirePackage{geometry}
% Needed to make header & footer effeciently
\RequirePackage{fancyhdr}
% Needed to manage colors
\RequirePackage{xcolor}
% Needed to use \ifxetex-\else-\fi statement
\RequirePackage{ifxetex}
% Needed to use \if-\then-\else statement
\RequirePackage{xifthen}
% Needed to use a toolbox of programming tools
\RequirePackage{etoolbox}
% Needed to change line spacing in specific environment
\RequirePackage{setspace}
% Needed to manage fonts
\RequirePackage[quiet]{fontspec}
% To support LaTeX quoting style
\defaultfontfeatures{Ligatures=TeX}
% Needed to manage math fonts
\RequirePackage{unicode-math}
% Needed to use icons from font-awesome
% (https://github.com/posquit0/latex-fontawesome)
\RequirePackage{fontawesome5}
\RequirePackage[default,opentype]{sourcesanspro}
% Needed for the photo ID
\RequirePackage[skins]{tcolorbox}
% Needed to deal a paragraphs
\RequirePackage{parskip}
% Needed to deal hyperlink
\RequirePackage[hidelinks,unicode]{hyperref}
\hypersetup{%
  pdftitle={resume},
  pdfauthor={},
  pdfsubject={},
  pdfkeywords={}
}



%-------------------------------------------------------------------------------
%                Configuration for directory locations
%-------------------------------------------------------------------------------
% Configure a directory location for fonts(default: 'fonts/')
\newcommand*{\fontdir}[1][fonts/]{\def\@fontdir{#1}}
\fontdir


%-------------------------------------------------------------------------------
%                Configuration for layout
%-------------------------------------------------------------------------------
%% Page Layout
% Configure page margins with geometry
\geometry{left=2.0cm, top=1.5cm, right=2.0cm, bottom=2.0cm, footskip=.5cm, includehead}

%% Header & Footer
% Set offset to each header and footer
\fancyhfoffset{0em}
% Remove head rule
\renewcommand{\headrulewidth}{0pt}
% Clear all header & footer fields
\fancyhf{}
% Enable if you want to make header or footer using fancyhdr
\pagestyle{fancy}


%-------------------------------------------------------------------------------
%                Configuration for colors
%-------------------------------------------------------------------------------
% Gray-scale colors
\definecolor{white}{HTML}{FFFFFF}
\definecolor{black}{HTML}{000000}
\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{5D5D5D}
\definecolor{lightgray}{HTML}{999999}
% Basic colors
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}
% Text colors
\definecolor{darktext}{HTML}{414141}
\colorlet{text}{darkgray}
\colorlet{graytext}{gray}
\colorlet{lighttext}{lightgray}
% Awesome colors
\definecolor{awesome-emerald}{HTML}{00A388}
\definecolor{awesome-skyblue}{HTML}{0395DE}
\definecolor{awesome-red}{HTML}{DC3522}
\definecolor{awesome-pink}{HTML}{EF4089}
\definecolor{awesome-orange}{HTML}{FF6138}
\definecolor{awesome-nephritis}{HTML}{27AE60}
\definecolor{awesome-concrete}{HTML}{95A5A6}
\definecolor{awesome-darknight}{HTML}{131A28}
\definecolor{awesome-SEUgreen}{HTML}{4D7C2C}
\colorlet{awesome}{awesome-red}

% Boolean value to switch section color highlighting
\newbool{acvSectionColorHighlight}
\setbool{acvSectionColorHighlight}{true}

% Awesome section color
\newcommand*{\sectioncolor}[1]{%
  \ifbool{acvSectionColorHighlight}{{\color{awesome}#1}}{#1}
}

%-------------------------------------------------------------------------------
%                Configuration for fonts
%-------------------------------------------------------------------------------
% Set the FontAwesome font to be up-to-date.
%这里被我修改了\newfontfamily\FA[Path=\@fontdir]{FontAwesome}
% Set font for header (default is Roboto)
\newfontfamily\headerfont[
  Path=\@fontdir,
  UprightFont=*-Regular,
  PositionTitleFontItalicFont=*-Italic,
  PositionTitleFontBoldFont=*-Bold,
  PositionTitleFontBoldItalicFont=*-BoldItalic,
]{PositionTitleFont}

\newfontfamily\namefont[
  Path=\@fontdir,
  UprightFont=*-Regular,
  NameFontItalicFont=*-Italic,
  NameFontBoldFont=*-Bold,
  NameFontBoldItalicFont=*-BoldItalic,
]{NameFont}

\newfontfamily\headerlinkfont[
  Path=\@fontdir,
  UprightFont=*-Regular,
  LinksFontItalicFont=*-Italic,
  LinksFontBoldFont=*-Bold,
  LinksFontBoldItalicFont=*-BoldItalic,
]{LinksFont}

\newfontfamily\Sectionfont[
  Path=\@fontdir,
  UprightFont=*-Regular,
  SectionFontItalicFont=*-Italic,
  SectionFontBoldFont=*-Bold,
  SectionFontBoldItalicFont=*-BoldItalic,
]{SectionFont}

%]{PlayfairDisplay}%

\newcommand*{\footerfont}{\sourcesanspro}%
\newcommand*{\bodyfont}{\rm}%\sourcesanspro
\newcommand*{\bodyfontlight}{\rm}%\sourcesansprolght

%-------------------------------------------------------------------------------
%                Configuration for styles
%-------------------------------------------------------------------------------
% Configure styles for each CV elements
% For fundamental structures
\newcommand*{\headerfirstnamestyle}[1]{{\fontsize{FirstNameFontSize}{1em}\namefontFirstNameFontBoldFirstNameFontItalics\color{FirstNameFontColor} #1}} %
\newcommand*{\headerlastnamestyle}[1]{{\fontsize{LastNameFontSize}{1em}\namefontLastNameFontBoldLastNameFontItalics\color{LastNameFontColor} #1}}
\newcommand*{\headerpositionstyle}[1]{{\fontsize{PositionTitleFontSize}{1em}\headerfontPositionTitleFontBoldPositionTitleFontItalics\color{PositionTitleFontColor} #1}}
\newcommand*{\headeraddressstyle}[1]{{\fontsize{LinksFontSize}{1em}\headerlinkfontLinksFontBoldLinksFontItalics\color{LinksFontColor} #1}} 
\newcommand*{\headersocialstyle}[1]{{\fontsize{LinksFontSize}{1em}\headerlinkfontLinksFontBoldLinksFontItalics\color{LinksFontColor} #1}}
\newcommand*{\headerquotestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\itshape\color{darktext} #1}}
\newcommand*{\footerstyle}[1]{{\fontsize{8pt}{1em}\footerfont\scshape\color{lighttext} #1}}
\newcommand*{\sectionstyle}[1]{{\fontsize{SectionFontSize}{1em}SectionFontTagSectionFontBoldSectionFontItalics\color{SectionFontColor} #1}} %
\newcommand*{\subsectionstyle}[1]{{\fontsize{12pt}{1em}\bodyfont\textcolor{text}{#1}}} %\scshape
\newcommand*{\paragraphstyle}{\fontsize{9pt}{1em}\bodyfont\upshape\color{text}} %
\newcommand*{\thisbibstyle}{\fontsize{10pt}{1em}\bodyfont\color{graytext}} %

% For elements of entry
\newcommand*{\entrytitlestyle}[1]{{\fontsize{10pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\entrypositionstyle}[1]{{\fontsize{8pt}{1em}\bodyfont\color{graytext} #1}}%\scshape
\newcommand*{\entrydatestyle}[1]{{\fontsize{8pt}{1em}\bodyfontlight\slshape\color{graytext} #1}}%
\newcommand*{\entrylocationstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\slshape\color{text} #1}}
\newcommand*{\descriptionstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\upshape\color{text} #1}} %

% For elements of subentry
\newcommand*{\subentrytitlestyle}[1]{{\fontsize{8pt}{1em}\bodyfont\mdseries\color{graytext} #1}}
\newcommand*{\subentrypositionstyle}[1]{{\fontsize{7pt}{1em}\bodyfon\scshapet\color{graytext} #1}} %
\newcommand*{\subentrydatestyle}[1]{{\fontsize{7pt}{1em}\bodyfontlight\slshape\color{graytext} #1}} %
\newcommand*{\subentrylocationstyle}[1]{{\fontsize{7pt}{1em}\bodyfontlight\slshape\color{text} #1}}
\newcommand*{\subdescriptionstyle}[1]{{\fontsize{8pt}{1em}\bodyfontlight\upshape\color{text} #1}} % 

% For elements of honor
\newcommand*{\honortitlestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\color{graytext} #1}}
\newcommand*{\honorpositionstyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\honordatestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\color{graytext} #1}}
\newcommand*{\honorlocationstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\slshape\color{texts} #1}}

% For elements of skill
\newcommand*{\skilltypestyle}[1]{{\fontsize{10pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\skillsetstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\color{text} #1}}

%%% For elements of CV Tags
%\newcommand*{\cvtag}[1]{%
%	\tikz[baseline]\node[anchor=base,draw,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.0ex,text depth=0ex]{\smallsize{#1}};
%}
%
%\newcommand*{\cvtagbf}[1]{%
%	\tikz[baseline]\node[anchor=base,draw,rounded corners,very thick,inner xsep=1ex,inner ysep =0.75ex,text height=1.0ex,text depth=.25ex]{\textbf{#1}};
%}



%-------------------------------------------------------------------------------
%                Commands for personal information
%-------------------------------------------------------------------------------
% Define photo ID
% Usage: \photo[circle|rectangle,edge|noedge,left|right]{<path-to-image>}
\newcommand{\photo}[2][circle,edge,left]{%
  \def\@photo{#2}
  \@for\tmp:=#1\do{%
    \ifthenelse{\equal{\tmp}{circle} \or \equal{\tmp}{rectangle}}%
      {\let\@photoshape\tmp}{}%
    \ifthenelse{\equal{\tmp}{edge} \or \equal{\tmp}{noedge}}%
      {\let\@photoedge\tmp}{}%
    \ifthenelse{\equal{\tmp}{left} \or \equal{\tmp}{right}}%
      {\let\@photoalign\tmp}{}%
  }%
}
\def\@photoshape{circle}
\def\@photoedge{edge}
\def\@photoalign{left}

%想在左侧加个校徽 暂未实现
%% Define sign ID
%% Usage: \sign[circle|rectangle,edge|noedge,left|right]{<path-to-image>}
%\newcommand{\sign}[2][circle,edge,left]{%
%  \def\@sign{#2}
%  \@for\tmp:=#1\do{%
%    \ifthenelse{\equal{\tmp}{circle} \or \equal{\tmp}{rectangle}}%
%      {\let\@photoshape\tmp}{}%
%    \ifthenelse{\equal{\tmp}{edge} \or \equal{\tmp}{noedge}}%
%      {\let\@photoedge\tmp}{}%
%    \ifthenelse{\equal{\tmp}{left} \or \equal{\tmp}{right}}%
%      {\let\@photoalign\tmp}{}%
%  }%
%}
%\def\@photoshape{circle}
%\def\@photoedge{edge}
%\def\@photoalign{left}

% Define writer's name
% Usage: \name{<firstname>}{<lastname>}
% Usage: \firstname{<firstname>}
% Usage: \lastname{<lastname>}
% Usage: \familyname{<familyname>}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
\newcommand*{\lastname}[1]{\def\@lastname{#1}}
\newcommand*{\familyname}[1]{\def\@lastname{#1}}
\def\@familyname{\@lastname}

% Define writer's address
% Usage: \address{<address>}
\newcommand*{\address}[1]{\def\@address{#1}}

% Define writer's position
% Usage: \name{<position>}
\newcommand*{\position}[1]{\def\@position{#1}}

% Defines writer's mobile (optional)
% Usage: \mobile{<mobile number>}
\newcommand*{\mobile}[1]{\def\@mobile{#1}}

% Defines writer's email (optional)
% Usage: \email{<email adress>}
\newcommand*{\email}[1]{\def\@email{#1}}

% Defines writer's email (optional)
% Usage: \birth{<date of birth>}
\newcommand*{\birth}[1]{\def\@birth{#1}}

% Defines writer's homepage (optional)
% Usage: \homepage{<url>}
\newcommand*{\homepage}[1]{\def\@homepage{#1}}

% Defines writer's orcid (optional)
% Usage: \orcid{<url>}
\newcommand*{\orcid}[1]{\def\@orcid{#1}}

% Defines writer's researchgate (optional)
% Usage: \researchgate{<url>}
\newcommand*{\researchgate}[1]{\def\@researchgate{#1}}

% Defines writer's github (optional)
% Usage: \github{<github-nick>}
\newcommand*{\github}[1]{\def\@github{#1}}

% Defines writer's gitlab (optional)
% Usage: \gitlab{<gitlab-nick>}
\newcommand*{\gitlab}[1]{\def\@gitlab{#1}}

% Defines writer's stackoverflow profile (optional)
% Usage: \stackoverflow{<so userid>}{<so username>}
%   e.g.https://stackoverflow.com/users/123456/sam-smith
%       would be \stackoverflow{123456}{sam-smith}
\newcommand*{\stackoverflow}[2]{\def\@stackoverflowid{#1}\def\@stackoverflowname{#2}}

% Defines writer's linked-in (optional)
% Usage: \linkedin{<linked-in-nick>}
\newcommand*{\linkedin}[1]{\def\@linkedin{#1}}

% Usage: \twitter{<twitter handle>}
\newcommand*{\twitter}[1]{\def\@twitter{#1}}

% Defines writer's skype (optional)
% Usage: \skype{<skype account>}
\newcommand*{\skype}[1]{\def\@skype{#1}}

% Defines writer's reddit (optional)
% Usage: \reddit{<reddit account>}
\newcommand*{\reddit}[1]{\def\@reddit{#1}}

% Defines writer's location (optional)
% Usage: \location{<location name>}
\newcommand*{\location}[1]{\def\@location{#1}}

% Defines writer's location (optional)
% Usage: \location{<location name>}
\newcommand*{\gscholar}[1]{\def\@gscholar{#1}}

% Defines writer's twitter (optional)
% Defines writer's extra informations (optional)
% Usage: \extrainfo{<extra informations>}
\newcommand*{\extrainfo}[1]{\def\@extrainfo{#1}}

% Defines writer's quote (optional)
% Usage: \quote{<quote>}
\renewcommand*{\quote}[1]{\def\@quote{#1}}


%-------------------------------------------------------------------------------
%                Commands for extra
%-------------------------------------------------------------------------------
%% Define helper macros a user can change easily
% Header
\newcommand{\acvHeaderNameDelim}{\space}
\newcommand{\acvHeaderAfterNameSkip}{.4mm}
\newcommand{\acvHeaderAfterPositionSkip}{.4mm}
\newcommand{\acvHeaderAfterAddressSkip}{-.5mm}
\newcommand{\acvHeaderIconSep}{\textcolor{white}{-}}
\newcommand{\acvHeaderSocialSep}{\quad\textbar\quad}
\newcommand{\acvHeaderAfterSocialSkip}{0mm}%6mm
\newcommand{\acvHeaderAfterQuoteSkip}{5mm}

% Others
\newcommand{\acvSectionTopSkip}{0mm}
\newcommand{\acvSectionContentTopSkip}{0mm}


%-------------------------------------------------------------------------------
%                Commands for utilities
%-------------------------------------------------------------------------------
% Use to align an element of tabular table
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

% Use to draw horizontal line with specific thickness
\def\vhrulefill#1{\leavevmode\leaders\hrule\@height#1\hfill \kern\z@}

% Use to execute conditional statements by checking empty string
\newcommand*{\ifempty}[3]{\ifthenelse{\isempty{#1}}{#2}{#3}}


%-------------------------------------------------------------------------------
%                Commands for elements of CV structure
%-------------------------------------------------------------------------------
% Define a header for CV
% Usage: \makecvheader
\newcommand*{\makecvheader}[1][C]{%
  \newcommand*{\drawphoto}{%
    \ifthenelse{\isundefined{\@photo}}{}{%
      \newlength{\photodim}
      \ifthenelse{\equal{\@photoshape}{circle}}%
        {\setlength{\photodim}{1.3cm}}%
        {\setlength{\photodim}{1.8cm}}%
      \ifthenelse{\equal{\@photoedge}{edge}}%
        {\def\@photoborder{darkgray}}%
        {\def\@photoborder{none}}%
      \begin{tikzpicture}[scale=0.1] %
        \node[\@photoshape, draw=\@photoborder, line width=0.3mm, text width=2.5cm, minimum height= 3.5 cm, fill overzoom image=\@photo] () {};
      \end{tikzpicture}
    }%
  }
  \newlength{\headertextwidth}
  \newlength{\headerphotowidth}
  \ifthenelse{\isundefined{\@photo}}{
    \setlength{\headertextwidth}{\textwidth}
    \setlength{\headerphotowidth}{0cm}
  }{%
    \setlength{\headertextwidth}{0.76\textwidth}
    \setlength{\headerphotowidth}{0.24\textwidth}
  }%

  \begin{minipage}[c]{\headerphotowidth}%
    \ifthenelse{\equal{\@photoalign}{left}}{\raggedright\drawphoto}{}
  \end{minipage}
  \begin{minipage}[c]{\headertextwidth}
    \ifthenelse{\equal{#1}{L}}{\raggedright}{\ifthenelse{\equal{#1}{R}}{\raggedleft}{\centering}}
    \headerfirstnamestyle{\@firstname}\headerlastnamestyle{{}\acvHeaderNameDelim\@lastname}%
    \\[\acvHeaderAfterNameSkip]%
    \ifthenelse{\isundefined{\@position}}{}{\headerpositionstyle{\@position\\[\acvHeaderAfterPositionSkip]}}%
    
    \headersocialstyle{%
      \newbool{isstart}%
      \setbool{isstart}{true}%
      \ifthenelse{\isundefined{\@mobile}}%
        {}%
        {%
          \faPhone\acvHeaderIconSep\@mobile%
          \setbool{isstart}{false}%
        }%
      \ifthenelse{\isundefined{\@birth}}%
        {}%
        {%
         \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \faBirthdayCake\acvHeaderIconSep\@birth%
          \setbool{isstart}{false}%
        }%
    \ifthenelse{\isundefined{\@email}}%
    {}%
    {%
    	\ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
    	\href{mailto:\@email}{\faEnvelope\acvHeaderIconSep\@email}%
    }%
      \ifthenelse{\isundefined{\@homepage}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{\@homepage}{\faHome\acvHeaderIconSep\@homepage}%
        }%
      \ifthenelse{\isundefined{\@github}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://github.com/\@github}{\faGithub\acvHeaderIconSep\@github}%
        }%
      \ifthenelse{\isundefined{\@gitlab}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://gitlab.com/\@gitlab}{\faGitlab\acvHeaderIconSep\@gitlab}%
        }%
      \ifthenelse{\isundefined{\@stackoverflowid}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://stackoverflow.com/users/\@stackoverflowid}{\faStackOverflow\acvHeaderIconSep\@stackoverflowname}%
        }%
      \ifthenelse{\isundefined{\@linkedin}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://www.linkedin.com/in/\@linkedin}{\faLinkedin\acvHeaderIconSep\@linkedin}%
        }%
      \ifthenelse{\isundefined{\@twitter}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://twitter.com/\@twitter}{\faTwitter\acvHeaderIconSep\@twitter}%
        }%
      \ifthenelse{\isundefined{\@skype}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \faSkype\acvHeaderIconSep\@skype%
        }%
      \ifthenelse{\isundefined{\@reddit}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://www.reddit.com/user/\@reddit}{\faReddit\acvHeaderIconSep\@reddit}%
        }%
      \ifthenelse{\isundefined{\@gscholar}}%
		{}%
		{%
		\ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
		\href{https://www.\@gscholar}{\faGraduationCap\acvHeaderIconSep Google\textcolor{white}{-}Scholar(\@gscholar)}%
		}%
	  \ifthenelse{\isundefined{\@orcid}}%
		{}%
		{%
		\ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
		\href{https://orcid.org/\@orcid}{\faOrcid\acvHeaderIconSep\@orcid}%
		}%
      \ifthenelse{\isundefined{\@researchgate}}%
		{}%
		{%
		\ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
		\href{https://www.researchgate.net/profile/\@researchgate}{\faResearchgate\acvHeaderIconSep\@researchgate}%
		}%
	  \ifthenelse{\isundefined{\@extrainfo}}%
		{}%
		{%
		\ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
		\@extrainfo%
		}%
      \ifthenelse{\isundefined{\@location}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          {\faMapMarker*\acvHeaderIconSep\@location}
        }%
    } \\[\acvHeaderAfterSocialSkip]%
\ifthenelse{\isundefined{\@address}}%
 {}%
 {\headeraddressstyle
 	{\faMapMarker \acvHeaderIconSep \@address\\
 		[\acvHeaderAfterAddressSkip]
 	}
 }%
    \ifthenelse{\isundefined{\@quote}}%
      {}%
      {\headerquotestyle{\@quote\\}\vspace{\acvHeaderAfterQuoteSkip}}%
  \end{minipage}%
  \begin{minipage}[c]{\headerphotowidth}%
    \ifthenelse{\equal{\@photoalign}{right}}{\raggedleft\drawphoto}{}
  \end{minipage}
}

% Define a footer for CV
% Usage: \makecvfooter{<left>}{<center>}{<right>}
\newcommand*{\makecvfooter}[3]{%
  \fancyfoot{}
  \fancyfoot[L]{\footerstyle{#1}}
  \fancyfoot[C]{\footerstyle{#2}}
  \fancyfoot[R]{\footerstyle{#3}}
}

% Define a section for CV
% Usage: \cvsection{<section-title>}
\newcommand{\cvsection}[1]{%
  \vspace{\acvSectionTopSkip}
  \sectionstyle{#1}
  \phantomsection
  \color{gray}\vhrulefill{0.9pt}
}

% Define a subsection for CV
% Usage: \cvsubsection{<subsection-title>}
\newcommand{\cvsubsection}[1]{%
  \vspace{\acvSectionContentTopSkip}
  \vspace{-3mm}
  \subsectionstyle{#1}
  \phantomsection
}

% Define a paragraph for CV
\newenvironment{cvparagraph}{%
  \vspace{\acvSectionContentTopSkip}
  \vspace{-3mm}
  \paragraphstyle
}{%
  \par
  \vspace{2mm}
}

% Define an environment for cventry
\newenvironment{cventries}
{%
  \vspace{\acvSectionContentTopSkip}
  %\begin{center}
}
{
 % \end{center}
}
% Define an entry of cv information
% Usage: \cventry{<position>}{<title>}{<location>}{<date>}{<description>}
\newcommand*{\cventry}[5]{%
 \vspace{-3.5mm}  
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    \ifempty{#1#3#4}
      {\entrytitlestyle{#2}\setlength{\leftmargin}{-20em} \noindent\\
        \multicolumn{1}{L{\textwidth}}{\descriptionstyle{#5}}}
      {\ifempty{#2#3}
          {\entrypositionstyle{#1} & \entrydatestyle{#4} \\}
          {\entrytitlestyle{#2} & \entrylocationstyle{#3} \\
            \entrypositionstyle{#1} & \entrydatestyle{#4} \\}
        \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#5}}}
  \end{tabular*}%  
}

% Define an environment for cvsubentry
\newenvironment{cvsubentries}{%
  \begin{center}
}{%
  \end{center}
}
% Define a subentry of cv information
% Usage: \cvsubentry{<position>}{<title>}{<date>}{<description>}
\newcommand*{\cvsubentry}[4]{%
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    \setlength\leftskip{0.2cm}
    \subentrytitlestyle{#2} & \ifthenelse{\equal{#1}{}}
      {\subentrydatestyle{#3}}{}
    \ifthenelse{\equal{#1}{}}
      {}
      {\subentrypositionstyle{#1} & \subentrydatestyle{#3} \\}
    \ifthenelse{\equal{#4}{}}
      {}
      {\multicolumn{2}{L{17.0cm}}{\subdescriptionstyle{#4}} \\}
  \end{tabular*}
}

% Define an environment for cvhonor
\newenvironment{cvhonors}{%
  \vspace{\acvSectionContentTopSkip}
  \vspace{-2mm}
  \begin{center}
    \setlength\tabcolsep{0pt}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} C{2.5cm} L{\textwidth - 4.0cm} R{1.5cm}}
}{%
    \end{tabular*}
  \end{center}
}
% Define a line of cv information(honor, award or something else)
% Usage: \cvhonor{<position>}{<title>}{<location>}{<date>}
\newcommand*{\cvhonor}[3]{%
  \honordatestyle{#3} & \quad   \honortitlestyle{#1} & \honorlocationstyle{#2} \\
}

% Define an environment for cvskill
\newenvironment{cvskills}{%
  \vspace{\acvSectionContentTopSkip}
%  \vspace{-4.0mm}
  \begin{center}
    \setlength\tabcolsep{1ex}
    \setlength{\extrarowheight}{1pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} l L{\textwidth * \real{0.9}}}
}{%
    \end{tabular*}
  \end{center}
}
% Define a line of cv information(skill)
% Usage: \cvskill{<type>}{<skillset>}
\newcommand*{\cvskill}[2]{%
	\skilltypestyle{#1} & \skillsetstyle{#2} \\
}

% Define an environment for cvitems(for cventry)
\newenvironment{cvitems}{%
  \vspace{-4.0mm}
  \begin{justify}
  \begin{itemize}[leftmargin=2ex, nosep, noitemsep]
    \setlength{\parskip}{0pt}
    \renewcommand{\labelitemi}{\bullet}
}{%
  \end{itemize}
  \end{justify}
  \vspace{-4.0mm}
}

% Define an environment for cvitems(for cventry)
\newenvironment{cvitemize2}{%
  \vspace{-4.0mm}
  \begin{justify}
  \begin{enumerate}[leftmargin=4ex, nosep, noitemsep]
    \setlength{\parskip}{0pt}
    \renewcommand{\labelenumi}{[\theenumi]}
}{%
  \end{enumerate}
  \end{justify}
  \vspace{-4.0mm}
}