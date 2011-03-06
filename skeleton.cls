% Identification
\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{skeleton}

\DeclareOption{fullserif}{
	\newcommand{\@fullserif}{}
}

\DeclareOption{detailedhead}{
	\newcommand{\@detailedhead}{}
}

\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{memoir}
}

\ProcessOptions\relax


% Load Article Class
\LoadClass{memoir}

\RequirePackage{arrayjob}
\RequirePackage{multido}
\RequirePackage{xifthen}
%
%LAYOUT SETTINGS
%
\semiisopage
\settrims{0.5\trimtop}{0.5\trimedge}
\checkandfixthelayout

\newcommand{\partysize}{\large}
\newcommand{\@temp}{}

%
%PARAGRAPH NUMBERING
%

%Set up counter
\newcounter{legalcount} %Create the counter
\setcounter{legalcount}{0} %Set it to zero

%Create paragraph command
\newcommand{\pa}{\refstepcounter{legalcount}\hangfrom{\makebox[0em][r]{\thelegalcount. }}}

%
% LEGAL HEADING AND SIGNATURE
%

% Set up commands for inputing case information


\newcommand{\@casenumber}{}
\newcommand{\casenumber}[1]{\renewcommand{\@casenumber}{#1}}

\newarray\Claimants
\newarray\ClDescr

\newcounter{claimantcount}
\setcounter{claimantcount}{0} %We have no claimants until a \claimant{} is issued.

\newcommand{\@claimant}{}
\newcommand{\claimant}[2][Claimant]{
	\stepcounter{claimantcount}
	\Claimants(\value{claimantcount})={#2}
	\ClDescr(\value{claimantcount})={#1}
	\ifthenelse{\value{claimantcount}=1}{
		\renewcommand{\@claimant}{#2}
	}{}
}

\newarray\Respondents
\newarray\RpDescr

\newcounter{respondentcount}
\setcounter{respondentcount}{0} %We have no claimants until a \respondent{} is issued.

\newcommand{\@respondent}{}
\newcommand{\respondent}[2][Respondent]{
	\stepcounter{respondentcount}
	\Respondents(\value{respondentcount})={#2}
	\RpDescr(\value{respondentcount})={#1}
	\ifthenelse{\value{respondentcount}=1}{
		\renewcommand{\@respondent}{#2}
	}{}
}


\newcommand{\@venue}{}
\newcommand{\venue}[1]{\renewcommand{\@venue}{#1}}

\newcommand{\@doctype}{}
\newcommand{\doctype}[1]{\renewcommand{\@doctype}{#1}}

\newcommand{\@counsel}{}
\newcommand{\counsel}[1]{\renewcommand{\@counsel}{#1}}

\newcommand{\@chambers}{}
\newcommand{\chambers}[1]{\renewcommand{\@chambers}{#1}}

% Create Legal Heading
\newcommand{\legalhead}
{
\thispagestyle{empty}

\noindent
\begin{minipage}[t]{.45\linewidth}
\vspace{0pt}
\raggedright
\noindent \textsc{In the \newline \@venue}
\end{minipage}
\hfill
\begin{minipage}[t]{.45\linewidth}
\vspace{0pt}
\raggedleft
\noindent \textsc{\@casenumber}
\end{minipage}


\vspace{0.5ex} 
\noindent \textsc{Between}

\vspace{1ex}

\begin{center}

\multido{\iClaimant=1+1}{\value{claimantcount}}{%
	\noindent
	\partysize
	\parbox{0.215\textwidth}{%
		\ifthenelse{\isundefined{\@detailedhead}}
		{\rule{2mm}{0pt}}
		{\small (\iClaimant)}
	}
	\parbox{0.55\textwidth}{%
		\centering \textsc{\Claimants(\iClaimant)}
	}
	\parbox{0.215\textwidth}{%
		\ifthenelse{\isundefined{\@detailedhead}}
		{\rule{2mm}{0pt}}
		{\raggedleft \small \textsc{[\ClDescr(\iClaimant)]}}
	}
	\newline
	\normalsize
	\newline
}
\vspace{-1em}
\small -and-
\vspace{1em}

\multido{\iRespondent=1+1}{\value{respondentcount}}{%
	\noindent
	\partysize
	\parbox{0.215\textwidth}{%
		\ifthenelse{\isundefined{\@detailedhead}}
		{\rule{2mm}{0pt}}
		{\small (\iRespondent)}
	}
	\parbox{0.55\textwidth}{%
		\centering \textsc{\Respondents(\iRespondent)}
	}
	\parbox{0.215\textwidth}{%
		\ifthenelse{\isundefined{\@detailedhead}}
		{\rule{2mm}{0pt}}
		{\raggedleft \small \textsc{[\RpDescr(\iRespondent)]}}
	}
	\newline
	\normalsize
	\newline
}
\vspace{-1.6em}

\large
\rule{10cm}{0.1mm}\\
\@doctype\\
\rule[1ex]{10cm}{0.1mm}\\
\end{center}
}
% Create Short Heading for Internal Docs
\newcommand{\shorthead}
{
\thispagestyle{empty}
\begin{center}
\noindent \textsc{\@claimant} v.
\textsc{\@respondent}\\
\rule{7cm}{0.2mm}\\
\@doctype\\
\rule{7cm}{0.2mm}\\
\end{center}
}

% Create Legal Signature
\newcommand{\sign}
{
\begin{flushright}
\textsc{\@counsel}\\*
\textsc{\@chambers}\\*
\@date
\end{flushright}}

%
%SECTIONS
%

% Suppress numbered sections
\setcounter{secnumdepth}{-2}


\ifthenelse{\isundefined{\@fullserif}}{
%Format Section
\renewcommand\section{\@startsection
{section}{1}{0mm}%
{-\baselineskip}%
{0.5\baselineskip}%
{\sffamily\large}%
}

%Format SubSection
\renewcommand\subsection{\@startsection
{subsection}{2}{0mm}%
{-\baselineskip}%
{0.5\baselineskip}%
{\sffamily\normalsize}%
}

%Format SubSubSection
\renewcommand\subsubsection{\@startsection
{subsubsection}{3}{0mm}%
{-\baselineskip}%
{0.5\baselineskip}%
{\sffamily\normalsize\slshape}%
}

}{
%Format Section
\renewcommand\section{\@startsection
{section}{1}{0mm}%
{-\baselineskip}%
{0.5\baselineskip}%
{\Large}%
}

%Format SubSection
\renewcommand\subsection{\@startsection
{subsection}{2}{0mm}%
{-\baselineskip}%
{0.25\baselineskip}%
{\large}%
}

%Format SubSubSection
\renewcommand\subsubsection{\@startsection
{subsubsection}{3}{0mm}%
{-\baselineskip}%
{0.1\baselineskip}%
{\normalsize\slshape}%
}
}

%Format Paragraph
\renewcommand\paragraph{\@startsection
{paragraph}{4}{0mm}%
{-\baselineskip}%
{0.1\baselineskip}%
{\normalfont\normalsize}%
}
%
%FORMATTING
%

%Load Fonts: palatino and helvetica
\usepackage[sc]{mathpazo}
\usepackage{helvet}

%Use letters in enumerate
\renewcommand{\labelenumi}{\alph{enumi}.}
\renewcommand{\labelenumii}{\arabic{enumii})}

%Adjust distance after paragraphs
\setlength{\parskip}{1em}

%Apply running headers
\makepagestyle{running}
\makepsmarks{running}{%
\nouppercaseheads
\createmark{chapter}{both}{nonumber}{}{}
\createmark{section}{right}{shownumber}{}{. \space} 
\createplainmark{toc}{both}{\contentsname} 
\createplainmark{lof}{both}{\listfigurename} 
\createplainmark{lot}{both}{\listtablename}
\createplainmark{bib}{both}{\bibname} 
\createplainmark{index}{both}{\indexname} 
\createplainmark{glossary}{both}{\glossaryname}
}

\makeheadrule{running}{\textwidth}{0.2pt}
\makeevenhead{running}{}{}{\rightmark} 
\makeoddhead{running}{}{}{\rightmark}
\makeevenfoot{running}{}{}{\thepage}
\makeoddfoot{running}{}{}{\thepage}

%Format Table of Contents
\usepackage{titletoc}
\contentsmargin{0pt}
\titlecontents{section}[0pt]
	{\ssfseries\large\thecontentspage\quad}
	{}{}{}{}
\newcommand\xquad
	{\hspace{1em plus.4em minus.4em}}
\titlecontents*{subsection}[0pt]
	{\filright\small}{}{}
	{,~\thecontentspage}
	[\xquad\textbullet\xquad][]
\setcounter{tocdepth}{2}


%Typeset legislation
\newenvironment{statquote}%
{%
\vspace{-2ex}%
\begin{list}{}%
{%
\setlength{\topsep}{0ex}%
\setlength{\partopsep}{1ex}%
\setlength{\parsep}{0.5ex}%
\setlength{\itemsep}{0ex}%
\addtolength{\leftmargin}{1em}%
\addtolength{\rightmargin}{1.5em}%
}%
\item[]}%
{\end{list}%
\vspace{1ex}%
}%

\newenvironment{instatquote}%
{%
\vspace{-4ex}%
\begin{list}{}%
{%
\setlength{\topsep}{0ex}%
\setlength{\partopsep}{1ex}%
\setlength{\parsep}{0.5ex}%
\setlength{\itemsep}{0ex}%
}%
\item[]}%
{\end{list}%
}%

\newcommand*\statquotelabel[1]{}

\newcommand{\stat}[2]{
\item[(#1)]#2
}

\newcommand{\stathead}[2]{
\item[\textbf{#1}]\textbf{#2}
}