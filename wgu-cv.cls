%! TeX root = WGUnderwood.tex

% class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wgu-cv}

% packages
\LoadClass[10pt]{article}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{hyperref}
\RequirePackage{fontspec}
\RequirePackage{microtype}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{ifthen}

% variables
\def\yourname#1{\def\@yourname{#1}}
\def\youraddress#1{\def\@youraddress{#1}}
\def\youremail#1{\def\@youremail{#1}}
\def\yourwebsite#1{\def\@yourwebsite{#1}}

% settings
\setmainfont{Libre Baskerville}[Scale=0.9]
\setmonofont{Source Code Pro}[Scale=0.97]
\geometry{a4paper}
\setlength\parindent{0pt}
\bibliographystyle{abbrvnat}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\cfoot{\thepage}
\rfoot{\today}
\setlist{leftmargin=0.5cm, itemsep=-0.2em, topsep=6pt, after=\vspace*{0cm}}

% arxiv
\newcommand{\arxiv}[1]{%
  \href{https://arxiv.org/abs/#1}{%
  \texttt{arXiv{:}{\allowbreak}#1}}%
}

% github
\newcommand{\github}[1]{%
  GitHub: \href{https://github.com/#1}{%
  \texttt{#1}}%
}

% title
\renewcommand{\maketitle}{%
  \vspace*{-1.7cm}%
  \begin{center}%
    \begin{huge}%
      \@yourname \\
    \end{huge}%
    \vspace{0.5cm}%
    \@youraddress \\
    \vspace{0.16cm}%
    \begin{minipage}{0.45\textwidth}%
      \centering%
      \href{mailto:\@youremail}{\nolinkurl{\@youremail}}%
    \end{minipage}%
    \begin{minipage}{0.45\textwidth}%
      \centering%
      \href{https://\@yourwebsite}{\nolinkurl{\@yourwebsite}}%
    \end{minipage}
    \vspace{0.3cm}%
  \end{center}%
}

% section
\newcommand{\cvsection}[1]{%
  \par\hbox{\large\textbf{#1}\strut}%
  \vspace{-7pt}%
  \rule{\textwidth}{0.8pt}%
  \vspace*{0.2cm}%
}

% subsection
\newcommand{\cvsubsection}[2]{%
  \textbf{#1}%
  \hfill{#2}%
}

% subsubsection
\newcommand{\cvsubsubsection}[1]{%
  \\%
  \textit{#1}%
}
