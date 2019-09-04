% LaTeX class for a clean modern CV or resume.
% Written by William G Underwood.
% Requires LuaLaTeX to compile.
% Requires fonts Source Code Pro (Monospace) and Cantarell (Regular, Oblique, Bold)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wgu-cv}[LaTeX class for writing a CV or resume]

\LoadClass[10pt,a4paper]{article}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{hyperref}
\RequirePackage{fontspec}
\RequirePackage[UKenglish]{babel}
\RequirePackage{microtype}
\RequirePackage{natbib}
\RequirePackage{bibentry}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{ifthen}
\RequirePackage{multicol}
\RequirePackage{needspace}

% personal details
\def\yourname#1{\def\@yourname{#1}}
\def\youraddress#1{\def\@youraddress{#1}}
\def\youremail#1{\def\@youremail{#1}}
\def\yourphone#1{\def\@yourphone{#1}}

% set fonts
\setmainfont[
  ItalicFont={Cantarell-Oblique},
  BoldFont={Cantarell-Bold}]
  {Cantarell}
\setmonofont{Source Code Pro}

% no indents
\setlength\parindent{0pt}

% bibliography style in-line
\bibliographystyle{abbrvnat}

% enable footer
\pagestyle{fancy}

% no header
\renewcommand{\headrulewidth}{0pt}

% add date to footer
\rfoot{\today}

% format lists
\setlist{leftmargin=0.5cm, itemsep=-0.2em, topsep=4pt, after=\vspace*{0.2cm}}

% clickable mailto links
\newcommand{\cvlink}[1]{\href{mailto:#1}{\nolinkurl{#1}}}

% no bibliography
\AtBeginDocument{\nobibliography*}

% format title
\renewcommand{\maketitle}{%
  \vspace*{-1.7cm}%
  \begin{center}%
    \begin{huge}%
      \MakeUppercase{\@yourname} \\
    \end{huge}%
    \vspace{0.3cm}%
    \@youraddress \\
    \href{mailto:\@youremail}{\nolinkurl{\@youremail}} \\
    \@yourphone%
  \end{center}%
}

% format section headers
\newcommand{\cvsection}[1]{%
  \vspace{0.4cm}%
  \par\hbox{\large\textbf{#1}\strut}%
  \vspace{-8pt}%
  \rule{\textwidth}{1.5pt}%
  \vspace*{-0.2cm}
}

% format subsection headers
\newcommand{\cvsubsection}[4]{%
  \textbf{#1}%
  \hfill\textbf{#3 -- #4}%
  \ifthenelse{%
    \equal{#2}{}%
  }%
  {}%
  {\\ \textbf{#2}}%
} 

