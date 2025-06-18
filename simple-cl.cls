% Author:
% Matus Cvengros

% ---------------------------------------------------------------
%	Class Settings
% ---------------------------------------------------------------
\ProvidesClass{simple-cl}[2025-06-16 v1.0.0]
\NeedsTeXFormat{LaTeX2e}

\RequirePackage{keyval}

\newif\ifcv@sourcesanspro
\cv@sourcesansprofalse

\DeclareOption{font=sourcesanspro}{\cv@sourcesansprotrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax

\LoadClass{article}
\setlength{\parindent}{0em}

% ---------------------------------------------------------------
%	Packages
% ---------------------------------------------------------------
\input{glyphtounicode}
\pdfgentounicode=1
\RequirePackage[english]{babel}								% language typography
\RequirePackage[utf8]{inputenc}								% input encoding
\RequirePackage[T1]{fontenc}								% output encoding
% Conditionally load Source Sans Pro
\ifcv@sourcesanspro
	\RequirePackage[default]{sourcesanspro}					% Source Sans Pro
	\newcommand*{\fontlight}{\fontseries{l}\selectfont}		% definition of Source Sans Pro Light
	\RequirePackage{sansmath}								% Sans Serif in math (close approximate)
	\sansmath												% enable for the math environment
\else
	\RequirePackage{lmodern} 								% use a bit nicer version of Computer Modern
\fi
\RequirePackage{geometry}									% for layout settings
\RequirePackage{fancyhdr}									% for ehader and footer settings
\RequirePackage{lastpage} 									% for page numbering
\RequirePackage{xcolor}										% to define custom colors
\RequirePackage{fontawesome5}								% for icons
\RequirePackage[
	colorlinks=true,
	urlcolor=linkcolor
]
{hyperref}													% links
\RequirePackage{csquotes}									% quotation marks
\RequirePackage{changepage}									% for adjustwidth
\RequirePackage{array}										% for some table manipulation commands
\RequirePackage{enumitem}									% to change line spacings between itemize items
\setlist[itemize]{
	itemsep=0.1em,
	topsep=0.1em
}
\RequirePackage{xifthen}									% to add if-else statements
\RequirePackage{ragged2e}									% to use \justifying inside tabular* cells
\RequirePackage{graphicx}									% images
\RequirePackage{mwe}										% includes example-image, example-image-a
\RequirePackage{xparse}										% parsing for multi-optional commands

% ---------------------------------------------------------------
%	Layout Configuration
% ---------------------------------------------------------------
% Configure page margins with geometry
\geometry{left=2.5cm, top=1cm, right=2.5cm, bottom=2cm, footskip=1.0 cm}
% Use fancy for all pages globally
\pagestyle{fancy}
% Clear all header & footer fields
\fancyhf{}

% ---------------------------------------------------------------
%	Colors
% ---------------------------------------------------------------
\definecolor{lightgray}{gray}{0.4}
\definecolor{darkgray}{gray}{0.2}
\definecolor{linkcolor}{RGB}{0, 79, 144}

% ---------------------------------------------------------------
%	Styles for the CV Elements
% ---------------------------------------------------------------
% Header separation of social media links
\newcommand*{\headersocialsep}{\quad\textbar\quad}

% Footer text
\newcommand*{\footerstyle}[1]{{\footnotesize\scshape\color{lightgray} #1}}

% ---------------------------------------------------------------
%	Class Variables
% ---------------------------------------------------------------
% First and last name
\newcommand*{\@firstname}{}
\newcommand*{\@lastname}{}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\printname}{\@firstname~\@lastname}
% Define other personal info
\newcommand*{\position}[1]{\def\@position{#1}}
\newcommand*{\address}[1]{\def\@address{#1}}
\newcommand*{\mobile}[1]{\def\@mobile{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}
\newcommand*{\github}[1]{\def\@github{#1}}
\newcommand*{\linkedin}[1]{\def\@linkedin{#1}}
% Quote
\renewcommand*{\quote}[1]{\def\@quote{#1}}

% Recipient information
\newcommand*{\recentity}[1]{\def\@recentity{#1}}
\newcommand*{\printrecentity}{\@recentity}
\newcommand*{\recname}[1]{\def\@recname{#1}}
\newcommand*{\recaddress}[1]{\def\@recaddress{#1}}

% ---------------------------------------------------------------
%	Utilities Configuration
% ---------------------------------------------------------------
% Definition for the width of the main entry text
\newlength{\entrywidth}
\setlength{\entrywidth}{\dimexpr\textwidth - 0.5cm\relax}

% Column types in tabular environments
\newcolumntype{L}[1]{>{\normalsize\raggedright\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\newcolumntype{C}[1]{>{\normalsize\centering\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\newcolumntype{R}[1]{>{\normalsize\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}

% ---------------------------------------------------------------
%	Header Configuration
% ---------------------------------------------------------------
% Remove horizontal offset for header and footer
\fancyhfoffset{0em}
% Remove header rule
\renewcommand{\headrulewidth}{0pt}

% Create header command
\newcommand*{\makeclheader}{%
	\raggedleft%
	{\Huge\@firstname~\bfseries\@lastname}\\[0.5em]%
	{\scshape\@position}\\[0.5em]%
	{\footnotesize\color{darkgray}\textit\@address}\\[0.25em]%
	{\footnotesize%
		\faMobile~\@mobile
		\headersocialsep
		\href{mailto:\@email}{\color{black}\faEnvelope~\@email}
		\headersocialsep
		\href{https://www.github.com/\@github}{\color{black}\faGithub~\@github}
		\headersocialsep
		\href{https://www.linkedin.com/in/\@linkedin}{\color{black}\faLinkedin~\@linkedin}
	}\\[0.5cm]%
	{\color{darkgray}\textit\@quote}\\[0.5cm]%
}

% ---------------------------------------------------------------
%	Footer Configuration
% ---------------------------------------------------------------
\newcommand*{\makeclfooter}{%
	\fancyfoot{}%
	\fancyfoot[L]{\footerstyle{\today}}%
	\fancyfoot[C]{\footerstyle{\printname~~~$\cdot$~~~Cover Letter}}%
}

% ---------------------------------------------------------------
%	Recipient Configuration
% ---------------------------------------------------------------
\newcommand*{\makeclrecipient}{%
	\vspace*{1cm}
	\raggedright%
	\setlength\tabcolsep{0pt}%
	\setlength{\extrarowheight}{0pt}%
	\begin{tabular*}{\entrywidth}{L{0.5\textwidth} R{0.5\textwidth}}
		{\large\bfseries\@recname} & {\normalsize\fontlight\today}
	\end{tabular*}%
	\\[1em]%
	{\scshape\@recentity}\\[0.25em]%
	{\footnotesize\color{darkgray}\textit\@recaddress}\\[0.5cm]%
	\vspace*{0.5cm}
}

% ---------------------------------------------------------------
%	Signature Configuration
% ---------------------------------------------------------------
\newcommand*{\makeclsignature}{%
	\vspace*{1cm}
	\raggedright%
	{\small\fontlight Sincerely,\\[0.5em]}
	{\small\fontlight\printname}
}

% ---------------------------------------------------------------
%	Section Configurations
% ---------------------------------------------------------------
% Definition of horizontal rule for a section title
\newcommand*{\sectionrulefill}[2][\textwidth]{%
	\noindent
	\makebox[#1][l]{\textbf{#2}~\leaders\hrule height 0.8pt \hfill}
}

% Section definition
\newcommand*{\clsection}[1]{%
	\vspace*{1.5em}%
	\phantomsection%
	\sectionrulefill{\normalfont\bfseries\large #1}%
	\vspace*{-0.5em}%
}

% ---------------------------------------------------------------
%	Configuration of Environments for the Main Body of Text
% ---------------------------------------------------------------
\newenvironment{clbody}{%
	\vspace*{0em}%
	\justifying
	\normalfont%
	\small\fontlight%
	\begin{adjustwidth}{0cm}{0cm}%
}{\end{adjustwidth}}