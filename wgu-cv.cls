% wgu-cv.cls
% -------------------------------------------------------------
% This class is from
% https://github.com/WGUNDERWOOD/wgu-cv
%
% Author:
% William G Underwood
% https://github.com/WGUNDERWOOD
%
% Requirements:
% LuaLaTeX
% BibTeX
%
% wgu-cv: a LaTeX class for a clean modern CV or resume.


% Identify class
% -------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wgu-cv}[LaTeX class for writing a CV or resume]


% Require packages
% -------------------------------------------------------------
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
\RequirePackage[default]{cantarell}
\RequirePackage{sourcecodepro}


% Define variables
% -------------------------------------------------------------
\def\yourname#1{\def\@yourname{#1}}
\def\youraddress#1{\def\@youraddress{#1}}
\def\youremail#1{\def\@youremail{#1}}
\def\yourphone#1{\def\@yourphone{#1}}


% Document settings 
% -------------------------------------------------------------
% No indents
\setlength\parindent{0pt}

% Bibliography style in-line
\bibliographystyle{abbrvnat}

% Enable footer
\pagestyle{fancy}

% No header
\renewcommand{\headrulewidth}{0pt}

% Add date to footer
\rfoot{\today}

% Format lists
\setlist{leftmargin=0.5cm, itemsep=-0.2em, topsep=4pt, after=\vspace*{0.2cm}}

% Clickable mailto links
\newcommand{\cvlink}[1]{\href{mailto:#1}{\nolinkurl{#1}}}

% No bibliography
\AtBeginDocument{\nobibliography*}


% Header formatting
% -------------------------------------------------------------
% Format title
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

% Format section headers
\newcommand{\cvsection}[1]{%
  \vspace{0.4cm}%
  \par\hbox{\large\textbf{#1}\strut}%
  \vspace{-8pt}%
  \rule{\textwidth}{1.5pt}%
  \vspace*{-0.2cm}
}

% Format subsection headers
\newcommand{\cvsubsection}[4]{%
  \textbf{#1}%
  \hfill\textbf{#3 -- #4}%
  \ifthenelse{%
    \equal{#2}{}%
  }%
  {}%
  {\\ \textbf{#2}}%
} 

