% simplecnresume.cls -- SimpleCNResume-LaTeX-Template 文档类
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{simplecnresume}[2026/08/15 v1.2 SimpleCNResume-LaTeX-Template class]

% 章节线可选：gradientline（默认渐变）或 solidline（深蓝实线）。
\newif\ifresumesolidsectionline
\resumesolidsectionlinefalse
\DeclareOption{gradientline}{\resumesolidsectionlinefalse}
\DeclareOption{solidline}{\resumesolidsectionlinetrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

\LoadClass[UTF8,a4paper,fontset=fandol]{ctexart}

\RequirePackage[top=0.6cm,left=1.5cm,right=1.5cm,bottom=1.5cm]{geometry}
\RequirePackage{fontspec}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{fontawesome}
\RequirePackage{pifont}
\RequirePackage{tikz}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{multicol}
\RequirePackage{tabularx}
\RequirePackage{etoolbox}
\RequirePackage{needspace}
\RequirePackage[skins]{tcolorbox}

% 仓库已附带 TeX Gyre Termes 字体，确保不同系统上的英文显示一致。
\setmainfont{texgyretermes}[
  Path=fonts/Main/,
  Extension=.otf,
  UprightFont=*-regular,
  BoldFont=*-bold,
  ItalicFont=*-italic,
  BoldItalicFont=*-bolditalic
]

\definecolor{ResumeClassic}{RGB}{0,51,102}
\definecolor{ResumeModern}{RGB}{0,111,175}
\colorlet{ResumePrimary}{ResumeClassic}
\definecolor{ResumeAccent}{RGB}{170,52,46}
\definecolor{ResumeGold}{RGB}{210,143,0}
\definecolor{ResumeDivider}{RGB}{198,211,223}
\definecolor{ResumeMuted}{RGB}{96,108,120}
\definecolor{ResumeSky}{RGB}{18,164,224}
\definecolor{ResumePink}{RGB}{238,88,151}
\definecolor{ResumeOrange}{RGB}{239,84,28}
\definecolor{ResumeYellow}{RGB}{235,183,0}

% 整体主色：ResumeClassic（经典深蓝）、ResumeModern（现代中蓝）或自定义颜色名。
\NewDocumentCommand{\setresumecolor}{m}{%
  \colorlet{ResumePrimary}{#1}%
  \pgfdeclarehorizontalshading{resume@section@line}{0.45pt}{
    color(0cm)=(ResumePrimary);
    color(17cm)=(white)
  }%
}
\setresumecolor{ResumeClassic}

% 可配置字号；行距会根据字号自动缩放。
\newdimen\resumenamefontsize
\newdimen\resumesectionfontsize
\newdimen\resumebodyfontsize
% 22bp 与 14bp 分别等同于原来的 \zihao{2}、\zihao{4}。
\resumenamefontsize=22bp
\resumesectionfontsize=14bp
\resumebodyfontsize=9pt

% 集中式样式入口。旧的 documentclass 选项与 \setresumecolor 仍可继续使用。
\def\resumedefaultseparator{dash}
\pgfkeys{
  /simplecnresume/.is family,
  /simplecnresume,
  color/.code={\setresumecolor{#1}},
  section-line/.is choice,
  section-line/gradient/.code={\resumesolidsectionlinefalse},
  section-line/solid/.code={\resumesolidsectionlinetrue},
  entry-separator/.is choice,
  entry-separator/dash/.code={\def\resumedefaultseparator{dash}},
  entry-separator/bar/.code={\def\resumedefaultseparator{bar}},
  name-size/.code={\resumenamefontsize=#1\relax},
  section-size/.code={\resumesectionfontsize=#1\relax},
  body-size/.code={\resumebodyfontsize=#1\relax}
}
\NewDocumentCommand{\resumesetup}{m}{\pgfkeys{/simplecnresume,#1}}

\hypersetup{
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  filecolor=black,
  urlcolor=black
}
\urlstyle{same}
\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}

\makeatletter
\renewcommand\normalsize{%
  \@setfontsize\normalsize
    {\resumebodyfontsize}%
    {\dimexpr113\resumebodyfontsize/90\relax}%
}
\makeatother
\AtBeginDocument{\normalsize}

% 列表样式：普通内容与项目细节；数字标记放在标题后的正文中。
\newlist{resumeitems}{itemize}{1}
\setlist[resumeitems]{
  label={\color{ResumePrimary}\textbullet},
  leftmargin=2em,
  itemsep=0.25em,
  topsep=0.15em,
  parsep=0pt,
  partopsep=0pt
}
\newlist{resumedetails}{itemize}{1}
\setlist[resumedetails]{
  label={\color{ResumePrimary}\textbullet},
  leftmargin=2em,
  itemsep=0.16em,
  topsep=0.1em,
  parsep=0pt,
  partopsep=0pt
}
\NewDocumentCommand{\resumecircled}{m}{%
  \raisebox{-0.08ex}{%
    \scalebox{1.4}{\color{ResumePrimary}\ding{\numexpr171+#1\relax}}%
  }\hspace{0.4em}%
}
\NewDocumentCommand{\resumeparen}{m}{{\color{ResumePrimary}\bfseries（#1）}}
\NewDocumentCommand{\resumerightparen}{m}{{\color{ResumePrimary}\bfseries #1）}}

\NewDocumentCommand{\resumesection}{m}{%
  \Needspace{3.5\baselineskip}%
  \par\addvspace{0.75em}%
  {\fontsize{\resumesectionfontsize}{\dimexpr6\resumesectionfontsize/5\relax}\selectfont
   \heiti\bfseries\color{ResumePrimary}#1}\par
  \ifresumesolidsectionline
    \vspace{-0.38em}%
    {\color{ResumePrimary}\rule{\linewidth}{1.05pt}}\par
    \vspace{0.16em}%
  \else
    \vspace{-0.45em}%
    \pgfuseshading{resume@section@line}\par
    \vspace{0.2em}%
  \fi
}

\NewDocumentCommand{\resumecontact}{m m}{%
  {\zihao{5}\color{black}#1}\hspace{0.28em}#2\hspace{0.8em}%
}

% #1 可选照片路径；#2 姓名；#3 联系信息。
\NewDocumentCommand{\resumeheader}{o m m}{%
  \noindent
  \begin{minipage}[t][2.4cm][t]{0.74\linewidth}
    \vspace{0pt}%
    {\fontsize{\resumenamefontsize}{\dimexpr6\resumenamefontsize/5\relax}\selectfont
     \heiti\bfseries\color{ResumePrimary}#2}\par
    \vspace{0.65em}%
    {#3}
  \end{minipage}%
  \hfill
  \begin{minipage}[t][2.4cm][t]{0.21\linewidth}
    \raggedleft\vspace{0pt}%
    \IfNoValueTF{#1}{%
      \begin{tikzpicture}
        \draw[rounded corners=2pt,draw=ResumeDivider,fill=ResumeDivider!18]
          (0,0) rectangle (2.4,2.85);
        \node[color=ResumeMuted] at (1.2,1.6) {\fontsize{26}{26}\selectfont\faUser};
        \node[color=ResumeMuted,font=\scriptsize] at (1.2,0.8) {照片（可选）};
      \end{tikzpicture}%
    }{%
      \makebox[\linewidth][r]{%
        \smash{\raisebox{-3.15cm}{%
          \includegraphics[width=2.8cm,height=3.6cm,keepaspectratio]{#1}%
        }}%
      }%
    }%
  \end{minipage}\par
  \vspace{-0.5em}%
}

% 可选的公司品牌栏：#1 品牌色；#2 Logo 路径；#3 公司；#4 岗位；#5 时间。
\NewDocumentCommand{\resumebanner}{O{ResumeSky} O{} m m m}{%
  \Needspace{2.5\baselineskip}%
  \begin{tcolorbox}[
    enhanced,
    frame hidden,
    boxrule=0pt,
    colback=#1!9,
    borderline west={3pt}{0pt}{#1},
    arc=2pt,
    boxsep=0pt,
    left=0.72em,
    right=0.72em,
    top=0.38em,
    bottom=0.38em,
    before skip=0.28em,
    after skip=0.18em
  ]
    \begingroup
    \setlength{\tabcolsep}{0pt}%
    \setlength{\fboxsep}{1pt}%
    \renewcommand{\tabularxcolumn}[1]{m{##1}}%
    \begin{tabularx}{\linewidth}{@{}>{\centering\arraybackslash}m{1.65em}@{\hspace{0.45em}}>{\raggedright\arraybackslash}X>{\raggedleft\arraybackslash}m{9.3em}@{}}
      \if\relax\detokenize{#2}\relax
        \colorbox{#1}{\makebox[1.25em][c]{\color{white}\strut\faBuilding}}%
      \else
        \includegraphics[width=1.55em,height=1.55em,keepaspectratio]{#2}%
      \fi
      & {\bfseries #3\hspace{0.35em}\textcolor{ResumeMuted}{\rule[0.5ex]{0.32cm}{0.5pt}}\hspace{0.35em}#4}
      & {\bfseries #5}
    \end{tabularx}%
    \endgroup
  \end{tcolorbox}%
}

% 星号表示不加粗；可选参数依次为颜色和分隔符（auto/dash/bar）。
% 左栏自动换行，右栏保留稳定的时间宽度。
\NewDocumentCommand{\resumeentry}{s O{black} O{auto} m m m}{%
  \Needspace{2\baselineskip}%
  \par\noindent
  \begingroup
  \ifstrequal{#3}{auto}{%
    \edef\resumelocalseparator{\resumedefaultseparator}%
  }{%
    \def\resumelocalseparator{#3}%
  }%
  \setlength{\tabcolsep}{0pt}%
  \renewcommand{\tabularxcolumn}[1]{m{##1}}%
  \begin{tabularx}{\linewidth}{@{}>{\raggedright\arraybackslash}X>{\raggedleft\arraybackslash}m{9.3em}@{}}
    {\color{#2}\IfBooleanF{#1}{\bfseries}#4}%
    \if\relax\detokenize{#5}\relax\else
      \ifdefstring{\resumelocalseparator}{bar}{%
        \hspace{0.32em}{\color{ResumeMuted}|}\hspace{0.32em}%
      }{%
        \hspace{0.3em}{\color{ResumeMuted}\rule[0.5ex]{0.28cm}{0.45pt}}\hspace{0.3em}%
      }%
      {\color{#2}\IfBooleanF{#1}{\bfseries}#5}%
    \fi
    & {\color{ResumeMuted}#6}
  \end{tabularx}%
  \endgroup
  \par
}

% 结果强调色默认为 ResumeAccent；可选 ResumeGold 或任意已定义颜色。
\NewDocumentCommand{\resumehighlight}{O{ResumeAccent} m}{{\bfseries\color{#1}#2}}

\NewDocumentCommand{\resumeprojectdivider}{}{%
  \Needspace{3\baselineskip}%
  \par\vspace{0.1em}%
  {\color{ResumeDivider}\rule{\linewidth}{0.35pt}}\par
  \vspace{0.35em}%
}

\NewDocumentCommand{\resumeaward}{m}{%
  \par\hangindent=1.8em\hangafter=1
  {\color{black}\faTrophy}\hspace{0.55em}#1\par
}

\NewDocumentEnvironment{resumeawards}{}{%
  \setlength{\multicolsep}{0pt}%
  \setlength{\premulticols}{0pt}%
  \setlength{\postmulticols}{0pt}%
  \begin{multicols}{2}
  \setlength{\columnsep}{1.4em}%
}{%
  \end{multicols}%
}

\endinput
