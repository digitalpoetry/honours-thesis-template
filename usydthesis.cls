% LaTeX2e thesis style.    by David Symonds, 2003
%
%   This LaTeX style file is for a University of Sydney thesis.
%
%   (based on a style file by Andrew Mathas)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{usydthesis}

%\include{config}

% options %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}

\ProcessOptions
\LoadClass[a4paper,oneside,11pt,reqno]{amsbook}

\hfuzz=4pt
\vfuzz=4pt

% packages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% for the University crest
\usepackage{epsfig}
\usepackage{graphicx}

% cross-references
\usepackage{style/prettyref}

% Maths and algorithms
\usepackage{amssymb,amsmath}
\newcommand{\theHalgorithm}{\arabic{algorithm}}
\usepackage[ruled]{algorithm}
\usepackage{algorithmic}

% Fancy footnotes
\usepackage[stable]{style/footmisc}

% times fonts look better
\usepackage{times}
\usepackage[T1]{fontenc}
\usepackage{textcomp}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% we now change a few things in the standard amsbook setup

% sections are numbered within the chapters
\numberwithin{section}{chapter}
\numberwithin{equation}{chapter}

\def\chapter{%
  \cleardoublepage
  \thispagestyle{plain}\global\@topnum\z@
  \@afterindenttrue \secdef\@chapter\@schapter}
\def\pagechapter{%
  \clearpage
  \thispagestyle{plain}\global\@topnum\z@
  \@afterindenttrue \secdef\@chapter\@schapter}

% section numbers in appendices shouldn't have a dot in them
% \def\appendix{\par
%   \c@chapter\z@ \c@section\z@
%   \let\chaptername\appendixname
%   \def\thechapter{\@Alph\c@chapter}
%   \renewcommand\thesection{\thechapter{}\arabic{section}}
% }

%%put dotfill in toc entries and make chapter entries bold
\def\contentsname{\normalfont\scshape{Contents}}
\def\@tocline#1#2#3#4#5#6#7{\relax
\ifnum #1>\c@tocdepth % then omit
\else
  \par \addpenalty\@secpenalty\addvspace{#2}%
  \begingroup \hyphenpenalty\@M
  \@ifempty{#4}{%
    \@tempdima\csname r@tocindent\number#1\endcsname\relax
  }{%
    \@tempdima#4\relax
  }%
  \parindent\z@ \leftskip#3\relax \advance\leftskip\@tempdima\relax
  \rightskip\@pnumwidth plus4em \parfillskip-\@pnumwidth
  {#5\leavevmode\hskip-\@tempdima #6}\nobreak\relax
  \ifnum #1>0 % only dot for entries below chapter level
    \dotfill\hbox to\@pnumwidth{\@tocpagenum{#5{#7}}}\par
  \else
    \hfill\hbox to\@pnumwidth{\@tocpagenum{#5{#7}}}\par
  \fi
  \nobreak
  \endgroup
\fi
}
\def\l@chapter{\@tocline{0}{8pt plus1pt}{0pt}{}{\bfseries}}
\def\l@subsection{\@tocline{2}{0pt}{30pt}{}{}}
% tocline parameters:
%   1: depth (0=chapter, 1=section, etc.)
%   2: spacing above
%   3: indent
%   4: ?
%   5: font modifier
%   6: TOC entry
%   7: page number

% chapter at top of chapters should be \sc rather than in capitals
\def\@makechapterhead#1{\global\topskip 7.5pc\relax
  \begingroup
  \fontsize{\@xivpt}{18}\bfseries\centering
    \ifnum\c@secnumdepth>\m@ne
      \leavevmode \hskip-\leftskip
      \rlap{\vbox to\z@{\vss
          \centerline{\normalsize\mdseries
              \@xp{\scshape\chaptername}\enspace\thechapter}
          \vskip 3pc}}\hskip\leftskip\fi
     #1\par \endgroup
  \vskip 2pt \hrulefill
  \skip@34\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@ }

% the standard amsbook headings are not very good %%%%
\def\partrunhead#1#2#3{%
  \@ifnotempty{#2}{\ignorespaces#1 #2\unskip\@ifnotempty{#3}{ }}%
  \textsc{#3}
}

\let\chapterrunhead\partrunhead
\let\sectionrunhead\partrunhead

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% date on title page of thesis
\def\Today{\number\day\space\ifcase\month\or January\or February\or March\or
  April\or May\or June\or July\or August\or September\or
  October\or November\or December\fi\space\number\year}

\def\@sid#1{\textsc{sid}: #1}
\def\@supervisor#1{Supervisor: #1}
\def\@assocsupervisor#1{Associate Supervisor: #1}

% thesis title page
\def\@maketitle{
  \cleardoublepage\thispagestyle{empty}%
  \begingroup \topskip\z@skip
    \null\vfil
    \begingroup
    \LARGE\bfseries \centering
    \openup\medskipamount
    \@title\par\vspace{30pt}%
    \centering\mdseries{\sc \authors}\par
    \centering\@sid{\sid}\par\bigskip
    \endgroup
    \vfil
    \begin{center}
      \vfil
      \fontsize{12}{12}
      \centering\@supervisor{\supervisor}
      \@ifundefined{assocsupervisor}{} {
       \\ \centering\@assocsupervisor{\assocsupervisor}
        }
      \par\bigskip
      This thesis is submitted in partial fulfillment of\\
      the requirements for the degree of\\
      \degree
    \vfil
      {\department\\
      The University of Sydney\\
      Australia}\\
    \vfil
      \Today
    \vskip50mm
      \includegraphics[width=102mm]{style/usyd-primary-colour}\\
    \end{center}
  \endgroup
  %\cleardoublepage
  \newpage
}

% insert page break after tableofcontents
\def\tableofcontents{%
  \@starttoc{toc}\contentsname\newpage
}

% control spacing in the bibliograph and fix up the toc entry
\def\thebibliography#1{
  \c@chapter\z@ \c@section\z@\let\chaptername\relax
  \chapter*{References}
\singlespace
  \list
  {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
  \advance\leftmargin\labelsep
  \itemsep 11pt \parsep\z@\topsep\z@\parskip\z@
  \usecounter{enumi}}
  \def\newblock{\hskip .11em plus .33em minus .07em}
  \sloppy\clubpenalty4000\widowpenalty4000
  \sfcode`\.=1000\relax
}

\def\@lbibitem[#1]#2{\item[]\hspace{-\parindent}\if@filesw
      { \def\protect##1{\string ##1\space}\immediate
        \write\@auxout{\string\bibcite{#2}{#1}}\fi\ignorespaces}}

\def\@bibitem#1{\item\if@filesw \immediate\write\@auxout
       {\string\bibcite{#1}{\the\c@enumi}}\fi\ignorespaces}

% Maybe some people do not want subsection headings indented
%\def\subsection{\@startsection{subsection}{2}%
%  \z@{0.7\linespacing}{.5\linespacing}%
%  {\normalfont\bfseries}}

\def\section{\@startsection {section}{1}{\z@}{-2.0ex plus
    -0.5ex minus -.2ex}{1.5ex plus 0.3ex minus .2ex}{\Large\bf\raggedright}}
\def\subsection{\@startsection{subsection}{2}{\z@}{-1.8ex plus
    -0.5ex minus -.2ex}{0.8ex plus .2ex}{\large\bf\raggedright}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{1.5ex plus
   0.5ex minus .2ex}{0.5ex plus .2ex}{\normalsize\bf\raggedright}}
\def\paragraph{\@startsection{paragraph}{4}{\z@}{1.5ex plus
   0.5ex minus .2ex}{-1em}{\normalsize\bf}}
\def\subparagraph{\@startsection{subparagraph}{5}{\parindent}{1.5ex plus
   0.5ex minus .2ex}{-1em}{\normalsize\bf}}

% global macros %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Use "... \LaTeX{} ..." when mentioning LaTeX
\input texnames.sty

% Paragraphs should not have their initial line indented, but instead we want
% a blank line between paragraphs. We do not want this for some stuff, so use
% the "\setupParagraphs" command just before the first chapter
\newcommand{\setupParagraphs}{
    \setlength{\parindent}{0cm}
    \addtolength{\parskip}{0.5\baselineskip}
}

% change the default labels for enumerate
%\renewcommand{\labelenumi}{\alph{enumi})}
%\renewcommand{\labelenumii}{(\roman{enumii})}

% Algorithms should be numbered 'A', 'B', etc.
%\renewcommand{\thealgorithm}{\Alph{algorithm}}

% Figures should be numbered globally
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\thechapter.\arabic{table}}

\renewcommand{\theequation}{\thechapter.\arabic{equation}}


% some utilities
\newcommand*{\marginnote}[1]
    {\mbox{}\marginpar{$\leftarrow$ \small #1}\ignorespaces}
\newcommand{\attention}[1][\attentionsymbol]
    {\mbox{}\marginpar{\raggedright #1}}
\newcommand*{\attentionsymbol}{$\leftarrow$ \large\bfseries !}

% maths stuff
\newtheorem{lemma}{Lemma}
\newcommand{\sd}[2]{#1 \triangle #2}

\newcommand{\data}[1]{\texttt{#1}}

\newcommand{\seesec}[1]{(see \Sec{#1})}
\newcommand{\seefig}[1]{(see \Fig{#1})}
\newcommand{\seeapp}[1]{(see \App{#1})}
\newcommand{\seetab}[1]{(see \Tab{#1})}

\def\Sec#1{Section~\ref{#1}}
\def\Fig#1{Figure~\ref{#1}}
\def\Eqn#1{Equation~\ref{#1}}
\def\App#1{Appendix~\ref{#1}}
\def\sec#1{section~\ref{#1}}
\def\fig#1{figure~\ref{#1}}
\def\eqn#1{equation~\ref{#1}}
\def\Tab#1{Table~\ref{#1}}
\def\tab#1{table~\ref{#1}}

\newcommand{\NB}{N.B.\@\xspace}
\newcommand{\eg}{e.g.}
\newcommand{\Eg}{E.g.}
\newcommand{\ie}{i.e.}
\newcommand{\Ie}{I.e.}
\newcommand{\etc}{etc.}
\newcommand{\etal}{{\em et al}.}
\newcommand{\etseq}{{\em et seq}.}
\newcommand{\precis}{pr\'ecis}
\newcommand{\Precis}{Pr\'ecis}
\newcommand{\role}{r\^ole}
\newcommand{\Role}{R\^ole}
\newcommand{\tm}{\raisebox{1ex}{\tiny TM}}
\newcommand{\cpright}{\raisebox{1ex}{\tiny\copyright}}
\newcommand{\degrees}{\raisebox{1.2ex}{\tiny\ensuremath{\circ}}}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% remove final '.' from section numbers (text)
% short title in TOC
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \edef\@toclevel{\ifnum#2=\@m 0\else\number#2\fi}%
  \ifnum #2>\c@secnumdepth \let\@secnumber\@empty
  \else \@xp\let\@xp\@secnumber\csname the#1\endcsname\fi
  \@tempskipa #5\relax
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \edef\@secnumpunct{%
      \ifdim\@tempskipa>\z@ % not a run-in section heading
        \@ifnotempty{#8}{\@nx\enspace}%
      \else \@nx\enspace
      \fi
    }%
    \protected@edef\@svsec{%
      \ifnum#2<\@m
        \@ifundefined{#1name}{}{%
          \ignorespaces\csname #1name\endcsname\space
        }%
      \fi
      \@seccntformat{#1}%
    }%
  \fi
  \ifdim \@tempskipa>\z@ % then this is not a run-in section heading
    \begingroup #6\relax
    \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty\@M #8\par}%
    \endgroup
  \csname #1mark\endcsname{#7}%
    \ifnum#2>\@m \else \@tocwrite{#1}{#7}\fi
  \else
  \def\@svsechd{#6\hskip #3\@svsec
    \@ifnotempty{#8}{\ignorespaces#8\unskip
       \@addpunct.}%
    \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
  }%
  \fi
  \global\@nobreaktrue
  \@xsect{#5}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% remove '.' after section number (TOC)
\renewcommand{\tocsection}[3]{%
  \indentlabel{\@ifnotempty{#2}{\ignorespaces#1 #2\quad}}#3}
\let\tocsubsection\tocsection
\let\tocsubsubsection\tocsection
\let\l@paragraph\l@subsubsection
\let\tocparagraph\tocsection
\let\l@subparagraph\l@subsubsection
\let\tocsubparagraph\tocsection
\let\tocpart\tocsection
\let\tocchapter\tocsection
\renewcommand{\tocappendix}[3]{%
  \indentlabel{#1\@ifnotempty{#2}{ #2}\quad}#3}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% table and figure captions use ':' not '.'
\long\def\@makecaption#1#2{%
  \setbox\@tempboxa\vbox{\color@setgroup
    \advance\hsize-2\captionindent\noindent
    \@captionfont\@captionheadfont#1\@xp\@ifnotempty\@xp
        {\@cdr#2\@nil}{:\@captionfont\upshape\enspace#2}%
    \unskip\kern-2\captionindent\par
    \global\setbox\@ne\lastbox\color@endgroup}%
  \ifhbox\@ne % the normal case
    \setbox\@ne\hbox{\unhbox\@ne\unskip\unskip\unpenalty\unkern}%
  \fi
  \ifdim\wd\@tempboxa=\z@ % this means caption will fit on one line
    \setbox\@ne\hbox to\columnwidth{\hss\kern-2\captionindent\box\@ne\hss}%
  \else % tempboxa contained more than one line
    \setbox\@ne\vbox{\unvbox\@tempboxa\parskip\z@skip
        \noindent\unhbox\@ne\advance\hsize-2\captionindent\par}%
  \fi
  \ifnum\@tempcnta<64 % if the float IS a figure...
    \addvspace\abovecaptionskip
    \hbox to\hsize{\kern\captionindent\box\@ne\hss}%
  \else % if the float IS NOT a figure...
    \addvspace\abovecaptionskip
    \hbox to\hsize{\kern\captionindent\box\@ne\hss}%
    \nobreak
    \vskip\belowcaptionskip
  \fi
\relax
}


\endinput
