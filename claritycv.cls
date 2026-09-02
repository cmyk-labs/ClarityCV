% claritycv.cls -- ClarityCV 中文简历文档类
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{claritycv}[2026/09/03 v2.3 ClarityCV class]

% 未识别的文档类选项直接交给 ctexart；模板自身统一通过 \resumesetup 配置。
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

\LoadClass[UTF8,a4paper,fontset=fandol]{ctexart}

\RequirePackage[top=0.6cm,left=1.5cm,right=1.5cm,bottom=1.5cm]{geometry}
\RequirePackage{fontspec}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{fontawesome}
\RequirePackage{tikz}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{multicol}
\RequirePackage{tabularx}
\RequirePackage{etoolbox}
\RequirePackage{needspace}
\RequirePackage[skins]{tcolorbox}
\usetikzlibrary{calc}

% 仓库内置英文字体，保证跨平台输出一致。
\setmainfont{texgyretermes}[
  Path=fonts/Main/,
  Extension=.otf,
  UprightFont=*-regular,
  BoldFont=*-bold,
  ItalicFont=*-italic,
  BoldItalicFont=*-bolditalic
]
\setsansfont{texgyreheros}[
  Extension=.otf,
  UprightFont=*-regular,
  BoldFont=*-bold,
  ItalicFont=*-italic,
  BoldItalicFont=*-bolditalic
]

% 现代中文字体按可用性自动回退。
\IfFontExistsTF{Microsoft YaHei}{%
  \newCJKfontfamily\scr@moderncjk{Microsoft YaHei}%
}{\IfFontExistsTF{Source Han Sans SC}{%
  \newCJKfontfamily\scr@moderncjk{Source Han Sans SC}%
}{\IfFontExistsTF{Noto Sans CJK SC}{%
  \newCJKfontfamily\scr@moderncjk{Noto Sans CJK SC}%
}{\IfFontExistsTF{PingFang SC}{%
  \newCJKfontfamily\scr@moderncjk{PingFang SC}%
}{\IfFontExistsTF{DengXian}{%
  \newCJKfontfamily\scr@moderncjk{DengXian}%
}{%
  \newCJKfontfamily\scr@moderncjk{FandolHei}%
}}}}}

% SimHei 本身已经是黑体，不再叠加 AutoFakeBold；\textbf 始终走标准字重。
\IfFontExistsTF{SimHei}{%
  \newCJKfontfamily\scr@sectioncjk[BoldFont=SimHei]{SimHei}%
}{%
  \let\scr@sectioncjk\scr@moderncjk
}

\definecolor{ResumeClassic}{RGB}{20,66,105}
\definecolor{ResumeModern}{RGB}{0,111,175}
\colorlet{ResumePrimary}{ResumeClassic}
\definecolor{ResumeAccent}{RGB}{166,82,52}
\definecolor{ResumeGold}{RGB}{210,143,0}
\definecolor{ResumeDivider}{RGB}{198,211,223}
\definecolor{ResumeMuted}{RGB}{96,108,120}
\definecolor{ResumeSky}{RGB}{18,164,224}
\definecolor{ResumePink}{RGB}{238,88,151}
\definecolor{ResumeOrange}{RGB}{239,84,28}
\definecolor{ResumeYellow}{RGB}{235,183,0}

% ---------- 默认样式 ----------
\newdimen\scr@namefontsize
\newdimen\scr@sectionfontsize
\newdimen\scr@bodyfontsize
\scr@namefontsize=14.8bp
\scr@sectionfontsize=12.4bp
\scr@bodyfontsize=9.2pt

\def\scr@sectionfont{\scr@sectioncjk}
\def\scr@sectionweight{\bfseries}
\def\scr@namefont{\scr@sectionfont}
\def\scr@nameweight{\scr@sectionweight}
\def\scr@bodyfont{\rmfamily\songti}

\newif\ifscr@sectionlinesolid
\scr@sectionlinesolidtrue
\def\scr@sectionlinewidth{0.55pt}
\def\scr@sectionbeforeskip{0.85em}
\def\scr@sectionlinegap{0.24em}
\def\scr@sectionafterskip{0.38em}

\def\scr@defaultentrystyle{plain}
\def\scr@defaultentrycolor{black}
\def\scr@defaultentryseparator{dash}
\def\scr@defaultentryweight{\bfseries}

% 头部命令的默认参数。
\newif\ifscr@headerphoto
\scr@headerphotofalse
\newif\ifscr@headerphotooverlay
\scr@headerphotooverlaytrue
\newif\ifscr@headerpendingphoto
\scr@headerpendingphotofalse
\def\scr@headerphotofile{}
\def\scr@headerphotoalignment{bottom}
\def\scr@headerphotowidth{2.75cm}
\def\scr@headerphotomaxheight{3.15cm}
\def\scr@headerphotolinegap{0.18em}
\def\scr@headerphotoxshift{0pt}
\def\scr@headerphotoyshift{0pt}
\def\scr@headercolumngap{1em}
\def\scr@headernamegap{0.35em}
\def\scr@headerafterskip{0.15em}

% ---------- 单一全局配置入口 ----------
\pgfkeys{
  /claritycv/.is family,
  /claritycv,
  color/.code={\colorlet{ResumePrimary}{#1}},
  font/.is choice,
  font/classic/.code={\def\scr@bodyfont{\rmfamily\songti}},
  font/modern/.code={\def\scr@bodyfont{\sffamily\scr@moderncjk}},
  section-font/.is choice,
  section-font/simhei/.code={\def\scr@sectionfont{\scr@sectioncjk}},
  section-font/modern/.code={\def\scr@sectionfont{\scr@moderncjk}},
  section-font-name/.code={%
    \setCJKfamilyfont{scrsectioncustom}{#1}%
    \def\scr@sectionfont{\CJKfamily{scrsectioncustom}}%
  },
  section-line/.is choice,
  section-line/solid/.code={\scr@sectionlinesolidtrue},
  section-line/gradient/.code={\scr@sectionlinesolidfalse},
  section-size/.code={\scr@sectionfontsize=#1\relax},
  body-size/.code={\scr@bodyfontsize=#1\relax},
  name-weight/.is choice,
  name-weight/inherit/.code={\def\scr@nameweight{\scr@sectionweight}},
  name-weight/regular/.code={\def\scr@nameweight{\mdseries}},
  name-weight/bold/.code={\def\scr@nameweight{\bfseries}},
  section-weight/.is choice,
  section-weight/regular/.code={\def\scr@sectionweight{\mdseries}},
  section-weight/bold/.code={\def\scr@sectionweight{\bfseries}},
  entry-style/.is choice,
  entry-style/plain/.code={\def\scr@defaultentrystyle{plain}},
  entry-style/banner/.code={\def\scr@defaultentrystyle{banner}},
  entry-color/.store in=\scr@defaultentrycolor,
  entry-separator/.is choice,
  entry-separator/dash/.code={\def\scr@defaultentryseparator{dash}},
  entry-separator/bar/.code={\def\scr@defaultentryseparator{bar}},
  entry-weight/.is choice,
  entry-weight/regular/.code={\def\scr@defaultentryweight{\mdseries}},
  entry-weight/bold/.code={\def\scr@defaultentryweight{\bfseries}},
  section-before-skip/.store in=\scr@sectionbeforeskip,
  section-line-gap/.store in=\scr@sectionlinegap,
  section-after-skip/.store in=\scr@sectionafterskip,
  section-line-width/.store in=\scr@sectionlinewidth
}
\NewDocumentCommand{\resumesetup}{m}{\pgfkeys{/claritycv,#1}}

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

\renewcommand\normalsize{%
  \@setfontsize\normalsize
    {\scr@bodyfontsize}%
    {\dimexpr113\scr@bodyfontsize/90\relax}%
}
\AtBeginDocument{\normalsize\scr@bodyfont}

% ---------- 标准 LaTeX 列表 ----------
% itemize：无编号列举；enumerate：有编号列举。一级与二级均可直接嵌套。
\setlist[itemize,1]{
  label={\color{ResumePrimary}\textbullet},
  leftmargin=2em,
  itemsep=0.25em,
  topsep=0.15em,
  parsep=0pt,
  partopsep=0pt
}
\setlist[itemize,2]{
  label={\color{ResumePrimary}\textopenbullet},
  leftmargin=1.8em,
  itemsep=0.16em,
  topsep=0.1em,
  parsep=0pt,
  partopsep=0pt
}
\setlist[enumerate,1]{
  label={\color{ResumePrimary}\arabic*.},
  ref=\arabic*,
  leftmargin=2.2em,
  itemsep=0.18em,
  topsep=0.1em,
  parsep=0pt,
  partopsep=0pt
}
\setlist[enumerate,2]{
  label={\color{ResumePrimary}（\arabic*）},
  ref=\arabic{enumi}.\arabic*,
  leftmargin=2.8em,
  itemsep=0.14em,
  topsep=0.08em,
  parsep=0pt,
  partopsep=0pt
}

% ---------- 头部 ----------
\pgfkeys{
  /claritycv/header/.is family,
  /claritycv/header,
  name-size/.code={\scr@namefontsize=#1\relax},
  photo/.code={%
    \ifstrequal{#1}{none}{%
      \scr@headerphotofalse
      \def\scr@headerphotofile{}%
    }{%
      \scr@headerphototrue
      \def\scr@headerphotofile{#1}%
    }%
  },
  layout/.is choice,
  layout/overlay/.code={\scr@headerphotooverlaytrue},
  layout/flow/.code={\scr@headerphotooverlayfalse},
  align/.is choice,
  align/top/.code={\def\scr@headerphotoalignment{top}},
  align/center/.code={\def\scr@headerphotoalignment{center}},
  align/bottom/.code={\def\scr@headerphotoalignment{bottom}},
  photo-width/.store in=\scr@headerphotowidth,
  photo-max-height/.store in=\scr@headerphotomaxheight,
  photo-line-gap/.store in=\scr@headerphotolinegap,
  photo-x-shift/.store in=\scr@headerphotoxshift,
  photo-y-shift/.store in=\scr@headerphotoyshift,
  column-gap/.store in=\scr@headercolumngap,
  name-gap/.store in=\scr@headernamegap,
  after-skip/.store in=\scr@headerafterskip
}

\newsavebox{\scr@contactbox}
\NewDocumentCommand{\resumecontact}{m m}{%
  \begingroup
  \sbox{\scr@contactbox}{{\zihao{5}\color{black}#1}\hspace{0.28em}#2}%
  \ifdim\wd\scr@contactbox>\linewidth
    \par\noindent
    \setlength{\tabcolsep}{0pt}%
    \renewcommand{\tabularxcolumn}[1]{m{##1}}%
    \begin{tabularx}{\linewidth}{@{}>{\centering\arraybackslash}m{1.25em}@{\hspace{0.28em}}>{\raggedright\arraybackslash}X@{}}
      {\zihao{5}\color{black}#1} & #2
    \end{tabularx}%
    \par
  \else
    \usebox{\scr@contactbox}\hspace{0.8em}\allowbreak
  \fi
  \endgroup
}

\newsavebox{\scr@headeridentitybox}
\newsavebox{\scr@headeroverlayportraitbox}
\newdimen\scr@headerphotoavailableheight
\newdimen\scr@headeractivephotolinegap
\newdimen\scr@headeractivephotoxshift
\newdimen\scr@headeractivephotoyshift

\newcommand*{\scr@headerphotolimitmark}{%
  \ifscr@headerpendingphoto
    \nointerlineskip
    \hbox to \linewidth{%
      \hfill
      \tikz[remember picture,overlay]{%
        \coordinate (scr-header-photo-limit) at (0,0);%
      }%
    }%
    \nointerlineskip
  \fi
}

\newcommand*{\scr@headerdrawpendingphoto}{%
  \ifscr@headerpendingphoto
    \nointerlineskip
    \hbox to \linewidth{%
      \hfill
      \tikz[remember picture,overlay]{%
        \path let
          \p1=(scr-header-photo-top),
          \p2=(scr-header-photo-limit)
        in \pgfextra{%
          \global\scr@headerphotoavailableheight=\y1\relax
          \global\advance\scr@headerphotoavailableheight by -\y2\relax
          \global\advance\scr@headerphotoavailableheight by \scr@headeractivephotoyshift\relax
          \global\advance\scr@headerphotoavailableheight by -\scr@headeractivephotolinegap\relax
          \ifdim\scr@headerphotoavailableheight<1pt
            \global\scr@headerphotoavailableheight=1pt
          \fi
        };%
        \node[
          anchor=north east,
          inner sep=0pt,
          outer sep=0pt,
          xshift=\scr@headeractivephotoxshift,
          yshift=\scr@headeractivephotoyshift
        ] at (scr-header-photo-top) {%
          \ifdim\dimexpr\ht\scr@headeroverlayportraitbox+\dp\scr@headeroverlayportraitbox\relax>\scr@headerphotoavailableheight
            \resizebox{!}{\scr@headerphotoavailableheight}{\usebox{\scr@headeroverlayportraitbox}}%
          \else
            \usebox{\scr@headeroverlayportraitbox}%
          \fi
        };%
      }%
    }%
    \nointerlineskip
    \global\scr@headerpendingphotofalse
  \fi
}

\newcommand*{\scr@headeridentity}[2]{%
  \begingroup
  {\fontsize{\scr@namefontsize}{\dimexpr6\scr@namefontsize/5\relax}\selectfont
   \scr@namefont\scr@nameweight\color{ResumePrimary}#1}\par
  \vspace{\scr@headernamegap}%
  \let\\\newline
  {#2}\par
  \endgroup
}

\newcommand*{\scr@headerportrait}{%
  \includegraphics[
    width=\scr@headerphotowidth,
    height=\scr@headerphotomaxheight,
    keepaspectratio
  ]{\scr@headerphotofile}%
}

\newcommand*{\scr@headerrow}[3]{%
  \makebox[\linewidth][l]{%
    \begin{minipage}[#1]{\dimexpr\linewidth-\scr@headerphotowidth-\scr@headercolumngap\relax}
      \ifstrequal{#1}{t}{\vspace{0pt}}{}%
      #2
    \end{minipage}%
    \hspace{\scr@headercolumngap}%
    \begin{minipage}[#1]{\scr@headerphotowidth}
      \ifstrequal{#1}{t}{\vspace{0pt}}{}%
      \centering#3\par
    \end{minipage}%
  }%
}

\newcommand*{\scr@headeroverlayrow}[2]{%
  \sbox{\scr@headeridentitybox}{%
    \begin{minipage}[t]{\dimexpr\linewidth-\scr@headerphotowidth-\scr@headercolumngap\relax}
      \vspace{0pt}%
      \scr@headeridentity{#1}{#2}%
    \end{minipage}%
  }%
  \global\setbox\scr@headeroverlayportraitbox=\hbox{\scr@headerportrait}%
  \global\scr@headeractivephotolinegap=\scr@headerphotolinegap\relax
  \global\scr@headeractivephotoxshift=\scr@headerphotoxshift\relax
  \global\scr@headeractivephotoyshift=\scr@headerphotoyshift\relax
  \global\scr@headerpendingphototrue
  \makebox[\linewidth][l]{%
    \usebox{\scr@headeridentitybox}%
    \hfill
    \tikz[remember picture,overlay]{%
      \coordinate (scr-header-photo-top) at (0,\the\ht\scr@headeridentitybox);%
    }%
  }%
}

% 头部只有一个可选键值参数；photo=none 或图片路径。
\NewDocumentCommand{\resumeheader}{O{} m m}{%
  \par\noindent
  \begingroup
  \pgfkeys{/claritycv/header/.cd,#1}%
  \global\scr@headerpendingphotofalse
  \ifscr@headerphoto
    \ifscr@headerphotooverlay
      \scr@headeroverlayrow{#2}{#3}%
    \else
      \ifdefstring{\scr@headerphotoalignment}{top}{%
        \scr@headerrow{t}{\scr@headeridentity{#2}{#3}}{\scr@headerportrait}%
      }{%
        \ifdefstring{\scr@headerphotoalignment}{bottom}{%
          \scr@headerrow{b}{\scr@headeridentity{#2}{#3}}{\scr@headerportrait}%
        }{%
          \scr@headerrow{c}{\scr@headeridentity{#2}{#3}}{\scr@headerportrait}%
        }%
      }%
    \fi
  \else
    \scr@headeridentity{#2}{#3}%
  \fi
  \par\nobreak\vspace{\scr@headerafterskip}%
  \endgroup
}

% ---------- 标准 \section 的简历样式 ----------
\newcommand*{\scr@sectionrule}{%
  \scr@headerphotolimitmark
  \ifscr@sectionlinesolid
    \begingroup
      \color{ResumePrimary}\hrule height \scr@sectionlinewidth
    \endgroup
  \else
    \nointerlineskip
    \hbox to \linewidth{%
      \begin{tikzpicture}
        \shade[left color=ResumePrimary,right color=white]
          (0pt,0pt) rectangle (\linewidth,\scr@sectionlinewidth);
      \end{tikzpicture}\hfil
    }%
  \fi
  \scr@headerdrawpendingphoto
}

\newcommand*{\scr@sectionaftertitle}{%
  \par\nobreak\vspace{\scr@sectionlinegap}%
  \scr@sectionrule
}

\ctexset{
  section={
    numbering=false,
    afterindent=true,
    beforeskip=\scr@sectionbeforeskip,
    afterskip=\scr@sectionafterskip,
    format={\fontsize{\scr@sectionfontsize}{\dimexpr6\scr@sectionfontsize/5\relax}\selectfont
      \scr@sectionfont\scr@sectionweight\color{ResumePrimary}},
    aftertitle={\scr@sectionaftertitle}
  }
}
\AddToHook{cmd/section/before}{\Needspace{3.5\baselineskip}}

% ---------- 统一条目命令 ----------
\def\scr@entrystyle{plain}
\def\scr@entrycolor{black}
\def\scr@entryseparator{bar}
\def\scr@entryweight{\bfseries}
\def\scr@entrylogo{}
\def\scr@entrydivider{none}
\def\scr@entrydatewidth{9.3em}
\def\scr@entrytextshift{0.4ex}
\def\scr@entrypadding{0.14em}

\pgfkeys{
  /claritycv/entry/.is family,
  /claritycv/entry,
  style/.is choice,
  style/plain/.code={\def\scr@entrystyle{plain}},
  style/banner/.code={\def\scr@entrystyle{banner}},
  color/.store in=\scr@entrycolor,
  logo/.store in=\scr@entrylogo,
  separator/.is choice,
  separator/dash/.code={\def\scr@entryseparator{dash}},
  separator/bar/.code={\def\scr@entryseparator{bar}},
  weight/.is choice,
  weight/regular/.code={\def\scr@entryweight{\mdseries}},
  weight/bold/.code={\def\scr@entryweight{\bfseries}},
  divider/.is choice,
  divider/none/.code={\def\scr@entrydivider{none}},
  divider/before/.code={\def\scr@entrydivider{before}},
  divider/after/.code={\def\scr@entrydivider{after}},
  date-width/.store in=\scr@entrydatewidth,
  text-shift/.store in=\scr@entrytextshift,
  padding-y/.store in=\scr@entrypadding
}

\newcommand*{\scr@entryseparatorcontent}{%
  \ifdefstring{\scr@entryseparator}{bar}{%
    \hspace{0.32em}{\color{ResumeMuted}|}\hspace{0.32em}%
  }{%
    \hspace{0.3em}{\color{ResumeMuted}\rule[0.5ex]{0.28cm}{0.45pt}}\hspace{0.3em}%
  }%
}

\newcommand*{\scr@entrydividerline}{%
  \Needspace{3\baselineskip}%
  \par\addvspace{0.35em}%
  \begingroup
    \color{ResumeDivider}\hrule height 0.35pt
  \endgroup
  \nobreak\vspace{0.35em}%
}

% 日期始终由开始、结束两个参数组成，连接符和两侧间距由文档类统一生成。
\newcommand*{\scr@entrydaterange}[2]{%
  \mbox{#1\hspace{0.28em}--\hspace{0.28em}#2}%
}

\newcommand*{\scr@plainentry}[3]{%
  \Needspace{2\baselineskip}%
  \par\noindent
  \setlength{\tabcolsep}{0pt}%
  \renewcommand{\tabularxcolumn}[1]{m{##1}}%
  \begin{tabularx}{\linewidth}{@{}>{\raggedright\arraybackslash}X>{\raggedleft\arraybackslash}m{\scr@entrydatewidth}@{}}
    {\color{\scr@entrycolor}\scr@entryweight #1}%
    \ifstrempty{#2}{}{%
      \scr@entryseparatorcontent
      {\color{\scr@entrycolor}\scr@entryweight #2}%
    }%
    & {\color{ResumeMuted}#3}
  \end{tabularx}%
  \par
}

\newsavebox{\scr@entrylogobox}
\newdimen\scr@entrylogowidth
\newcommand*{\scr@bannerentry}[3]{%
  \Needspace{2.5\baselineskip}%
  \begin{tcolorbox}[
    enhanced,
    frame hidden,
    boxrule=0pt,
    colback=\scr@entrycolor!9,
    borderline west={3pt}{0pt}{\scr@entrycolor},
    arc=2pt,
    boxsep=0pt,
    left=0.72em,
    right=0.72em,
    top=\scr@entrypadding,
    bottom=\scr@entrypadding,
    before skip=0.28em,
    after skip=0.18em
  ]
    \setlength{\tabcolsep}{0pt}%
    \renewcommand{\arraystretch}{0}%
    \renewcommand{\tabularxcolumn}[1]{m{##1}}%
    \scr@entrylogowidth=0pt\relax
    \def\scr@entrylogogap{0pt}%
    \ifdefempty{\scr@entrylogo}{}{%
      \def\scr@entrylogogap{0.45em}%
      \sbox{\scr@entrylogobox}{%
        \includegraphics[width=3.15em,height=1.55em,keepaspectratio]{\scr@entrylogo}%
      }%
      \scr@entrylogowidth=\wd\scr@entrylogobox
      \advance\scr@entrylogowidth by 0.1em\relax
    }%
    \begin{tabularx}{\linewidth}{@{}>{\centering\arraybackslash}m{\scr@entrylogowidth}@{\hspace{\scr@entrylogogap}}>{\raggedright\arraybackslash}X>{\raggedleft\arraybackslash}m{\scr@entrydatewidth}@{}}
      \ifdefempty{\scr@entrylogo}{}{\usebox{\scr@entrylogobox}}%
      & \raisebox{\scr@entrytextshift}{%
          \parbox[c]{\hsize}{%
            \raggedright\scr@entryweight
            #1%
            \ifstrempty{#2}{}{\scr@entryseparatorcontent #2}%
            \par
          }%
        }
      & {\scr@entryweight #3}
    \end{tabularx}%
  \end{tcolorbox}%
}

% style=plain|banner；weight=bold|regular，省略时继承 entry-weight（类默认 bold）。
% 其余视觉差异均通过同一个可选键值参数设置。
% 必选参数依次为：主标题、副标题、开始时间、结束时间。
\NewDocumentCommand{\resumeentry}{O{} m m m m}{%
  \begingroup
  \let\scr@entrystyle\scr@defaultentrystyle
  \let\scr@entrycolor\scr@defaultentrycolor
  \let\scr@entryseparator\scr@defaultentryseparator
  \let\scr@entryweight\scr@defaultentryweight
  \def\scr@entrylogo{}%
  \def\scr@entrydivider{none}%
  \def\scr@entrydatewidth{9.3em}%
  \def\scr@entrytextshift{0.4ex}%
  \def\scr@entrypadding{0.14em}%
  \pgfkeys{/claritycv/entry/.cd,#1}%
  \ifdefstring{\scr@entrydivider}{before}{\scr@entrydividerline}{}%
  \ifdefstring{\scr@entrystyle}{banner}
    {\scr@bannerentry{#2}{#3}{\scr@entrydaterange{#4}{#5}}}
    {\scr@plainentry{#2}{#3}{\scr@entrydaterange{#4}{#5}}}%
  \ifdefstring{\scr@entrydivider}{after}{\scr@entrydividerline}{}%
  \endgroup
}

\endinput
