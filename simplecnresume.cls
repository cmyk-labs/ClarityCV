% simplecnresume.cls -- SimpleCNResume-LaTeX-Template 文档类
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{simplecnresume}[2026/09/01 v1.12 SimpleCNResume-LaTeX-Template class]

% 章节线可选：solidline（默认纯色）或 gradientline（渐变）。
\newif\ifresumesolidsectionline
\resumesolidsectionlinetrue
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
\usetikzlibrary{calc}

% 仓库已附带 TeX Gyre Termes 字体，确保不同系统上的英文显示一致。
\setmainfont{texgyretermes}[
  Path=fonts/Main/,
  Extension=.otf,
  UprightFont=*-regular,
  BoldFont=*-bold,
  ItalicFont=*-italic,
  BoldItalicFont=*-bolditalic
]
% 现代模式使用 TeX Live 标配的 TeX Gyre Heros 作为英文无衬线字体。
\setsansfont{texgyreheros}[
  Extension=.otf,
  UprightFont=*-regular,
  BoldFont=*-bold,
  ItalicFont=*-italic,
  BoldItalicFont=*-bolditalic
]

% 现代中文字体按跨平台可用性自动选择，避免把观感偏旧的 FandolHei
% 作为首选；它只承担最终兜底，保证纯 TeX Live 环境仍可编译。
\IfFontExistsTF{Microsoft YaHei}{%
  \newCJKfontfamily\resumemoderncjk{Microsoft YaHei}%
  \def\resumemoderncjkfontname{Microsoft YaHei}%
}{\IfFontExistsTF{Source Han Sans SC}{%
  \newCJKfontfamily\resumemoderncjk{Source Han Sans SC}%
  \def\resumemoderncjkfontname{Source Han Sans SC}%
}{\IfFontExistsTF{Noto Sans CJK SC}{%
  \newCJKfontfamily\resumemoderncjk{Noto Sans CJK SC}%
  \def\resumemoderncjkfontname{Noto Sans CJK SC}%
}{\IfFontExistsTF{PingFang SC}{%
  \newCJKfontfamily\resumemoderncjk{PingFang SC}%
  \def\resumemoderncjkfontname{PingFang SC}%
}{\IfFontExistsTF{DengXian}{%
  \newCJKfontfamily\resumemoderncjk{DengXian}%
  \def\resumemoderncjkfontname{DengXian}%
}{%
  \newCJKfontfamily\resumemoderncjk{FandolHei}%
  \def\resumemoderncjkfontname{FandolHei}%
}}}}}

% v4 的模块标题实际使用系统 SimHei；默认轻度伪粗 1.3，避免系统字体
% 缺少 Bold 字形时 \bfseries 静默回退到常规粗细。缺少 SimHei 时回退到现代字体。
\IfFontExistsTF{SimHei}{%
  \newCJKfontfamily\resumesimheicjk[AutoFakeBold=1.3]{SimHei}%
}{%
  \newcommand{\resumesimheicjk}{\resumemoderncjk}%
}

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
\def\resumesectionlinewidth{0.4pt}

% 整体主色：ResumeClassic（经典深蓝）、ResumeModern（现代中蓝）或自定义颜色名。
\NewDocumentCommand{\refreshresumesectionline}{}{%
  \pgfdeclarehorizontalshading{resume@section@line}{\resumesectionlinewidth}{
    color(0cm)=(ResumePrimary);
    color(1cm)=(white)
  }%
}
\NewDocumentCommand{\setresumecolor}{m}{%
  \colorlet{ResumePrimary}{#1}%
  \refreshresumesectionline
}
\setresumecolor{ResumeClassic}

% 可配置字号；行距会根据字号自动缩放。
\newdimen\resumenamefontsize
\newdimen\resumesectionfontsize
\newdimen\resumebodyfontsize
% 姓名保持 14bp，模块标题降为 12.5bp，与正文形成更协调的层级。
\resumenamefontsize=14bp
\resumesectionfontsize=12.5bp
\resumebodyfontsize=9.3pt
\def\resumesectionfontweight{\bfseries}
\def\resumesectionfont{\resumesimheicjk}
% 姓名默认继承模块标题的字体与字重，仅字号保持独立；name-weight 仍可手动覆盖。
\def\resumenamefont{\resumesectionfont}
\def\resumenamefontweight{\resumesectionfontweight}
% 默认使用正式、稳定的宋体/衬线组合；可通过 font-mode=modern 切换为现代无衬线。
\def\resumebodyfont{\rmfamily\songti}

% 头部与章节间距使用自然高度；下面的值只控制上限、对齐策略和留白。
\newif\ifresumeheaderphoto
\resumeheaderphototrue
\newif\ifresumeheaderphotooverlay
\resumeheaderphotooverlaytrue
\newif\ifresumeheaderpendingphoto
\resumeheaderpendingphotofalse
\def\resumeheaderphotoalignment{bottom}
\def\resumeheaderphotowidth{2.8cm}
\def\resumeheaderphotomaxheight{3.2cm}
\def\resumeheaderphototrim{0 0 0 0}
\def\resumeheaderphotolinegap{0.18em}
\def\resumeheaderphotoxshift{0pt}
\def\resumeheaderphotoyshift{0pt}
\def\resumeheadercolumngap{1em}
\def\resumeheadernamegap{0.35em}
\def\resumeheaderafterskip{0.15em}
\def\resumesectionbeforeskip{1.05em}
\def\resumesectionlinegap{0.28em}
\def\resumesectionafterskip{0.42em}
\def\resumeprojectdividerbeforeskip{0.35em}
\def\resumeprojectdividerafterskip{0.35em}
\def\resumeprojectdividerwidth{0.35pt}
\def\resumebannertextshift{0.4ex}
\def\resumebannerpaddingtop{0.12em}
\def\resumebannerpaddingbottom{0.12em}
\def\resumebannerdatewidth{9.3em}

% 集中式样式入口。旧的 documentclass 选项与 \setresumecolor 仍可继续使用。
\def\resumedefaultseparator{bar}
\pgfkeys{
  /simplecnresume/.is family,
  /simplecnresume,
  color/.code={\setresumecolor{#1}},
  font-mode/.is choice,
  font-mode/modern/.code={\def\resumebodyfont{\sffamily\resumemoderncjk}},
  font-mode/classic/.code={\def\resumebodyfont{\rmfamily\songti}},
  section-font/.is choice,
  section-font/simhei/.code={\def\resumesectionfont{\resumesimheicjk}},
  section-font/modern/.code={\def\resumesectionfont{\resumemoderncjk}},
  section-font-name/.code={%
    \setCJKfamilyfont{resumesectioncustom}{#1}%
    \def\resumesectionfont{\CJKfamily{resumesectioncustom}}%
  },
  section-line/.is choice,
  section-line/gradient/.code={\resumesolidsectionlinefalse},
  section-line/solid/.code={\resumesolidsectionlinetrue},
  entry-separator/.is choice,
  entry-separator/dash/.code={\def\resumedefaultseparator{dash}},
  entry-separator/bar/.code={\def\resumedefaultseparator{bar}},
  name-size/.code={\resumenamefontsize=#1\relax},
  section-size/.code={\resumesectionfontsize=#1\relax},
  body-size/.code={\resumebodyfontsize=#1\relax},
  name-weight/.is choice,
  name-weight/inherit/.code={\def\resumenamefontweight{\resumesectionfontweight}},
  name-weight/regular/.code={\def\resumenamefontweight{\mdseries}},
  name-weight/bold/.code={\def\resumenamefontweight{\bfseries}},
  name-bold/.is choice,
  name-bold/true/.code={\def\resumenamefontweight{\bfseries}},
  name-bold/false/.code={\def\resumenamefontweight{\mdseries}},
  section-weight/.is choice,
  section-weight/regular/.code={\def\resumesectionfontweight{\mdseries}},
  section-weight/bold/.code={\def\resumesectionfontweight{\bfseries}},
  section-bold/.is choice,
  section-bold/true/.code={\def\resumesectionfontweight{\bfseries}},
  section-bold/false/.code={\def\resumesectionfontweight{\mdseries}},
  header-photo/.is choice,
  header-photo/true/.code={\resumeheaderphototrue},
  header-photo/false/.code={\resumeheaderphotofalse},
  header-photo-layout/.is choice,
  header-photo-layout/overlay/.code={\resumeheaderphotooverlaytrue},
  header-photo-layout/flow/.code={\resumeheaderphotooverlayfalse},
  header-photo-align/.is choice,
  header-photo-align/top/.code={\def\resumeheaderphotoalignment{top}},
  header-photo-align/center/.code={\def\resumeheaderphotoalignment{center}},
  header-photo-align/bottom/.code={\def\resumeheaderphotoalignment{bottom}},
  header-photo-width/.store in=\resumeheaderphotowidth,
  header-photo-max-height/.store in=\resumeheaderphotomaxheight,
  header-photo-trim/.store in=\resumeheaderphototrim,
  header-photo-line-gap/.store in=\resumeheaderphotolinegap,
  header-photo-x-shift/.store in=\resumeheaderphotoxshift,
  header-photo-y-shift/.store in=\resumeheaderphotoyshift,
  header-column-gap/.store in=\resumeheadercolumngap,
  header-name-gap/.store in=\resumeheadernamegap,
  header-after-skip/.store in=\resumeheaderafterskip,
  section-before-skip/.store in=\resumesectionbeforeskip,
  section-line-gap/.store in=\resumesectionlinegap,
  section-after-skip/.store in=\resumesectionafterskip,
  section-line-width/.code={%
    \def\resumesectionlinewidth{#1}%
    \refreshresumesectionline
  },
  project-divider-before-skip/.store in=\resumeprojectdividerbeforeskip,
  project-divider-after-skip/.store in=\resumeprojectdividerafterskip,
  project-divider-width/.store in=\resumeprojectdividerwidth,
  banner-text-shift/.store in=\resumebannertextshift,
  banner-padding-y/.code={%
    \def\resumebannerpaddingtop{#1}%
    \def\resumebannerpaddingbottom{#1}%
  },
  banner-date-width/.store in=\resumebannerdatewidth,
  /simplecnresume/header/.is family,
  /simplecnresume/header,
  photo/.is choice,
  photo/true/.code={\resumeheaderphototrue},
  photo/false/.code={\resumeheaderphotofalse},
  photo-layout/.is choice,
  photo-layout/overlay/.code={\resumeheaderphotooverlaytrue},
  photo-layout/flow/.code={\resumeheaderphotooverlayfalse},
  photo-align/.is choice,
  photo-align/top/.code={\def\resumeheaderphotoalignment{top}},
  photo-align/center/.code={\def\resumeheaderphotoalignment{center}},
  photo-align/bottom/.code={\def\resumeheaderphotoalignment{bottom}},
  photo-width/.store in=\resumeheaderphotowidth,
  photo-max-height/.store in=\resumeheaderphotomaxheight,
  photo-trim/.store in=\resumeheaderphototrim,
  photo-line-gap/.store in=\resumeheaderphotolinegap,
  photo-x-shift/.store in=\resumeheaderphotoxshift,
  photo-y-shift/.store in=\resumeheaderphotoyshift,
  column-gap/.store in=\resumeheadercolumngap,
  name-gap/.store in=\resumeheadernamegap,
  after-skip/.store in=\resumeheaderafterskip
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
\AtBeginDocument{\normalsize\resumebodyfont}

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

% overlay 模式在头部记录照片顶部锚点，在首个模块横线确定后再以前景层绘制。
% 两个真实页面坐标之间的距离决定照片可用高度，因此不会越过横线。
\newsavebox{\resumeheaderidentitybox}
\newsavebox{\resumeheaderoverlayportraitbox}
\newdimen\resumeheaderphotoavailableheight
\newdimen\resumeheaderactivephotolinegap
\newdimen\resumeheaderactivephotoxshift
\newdimen\resumeheaderactivephotoyshift

\NewDocumentCommand{\resumeheaderphotolimitmark}{}{%
  \ifresumeheaderpendingphoto
    \nointerlineskip
    \hbox to \linewidth{%
      \hfill
      \tikz[remember picture,overlay]{%
        \coordinate (resume-header-photo-limit) at (0,0);%
      }%
    }%
    \nointerlineskip
  \fi
}

\NewDocumentCommand{\resumeheaderdrawpendingphoto}{}{%
  \ifresumeheaderpendingphoto
    \nointerlineskip
    \hbox to \linewidth{%
      \hfill
      \tikz[remember picture,overlay]{%
        \path let
          \p1=(resume-header-photo-top),
          \p2=(resume-header-photo-limit)
        in \pgfextra{%
          \global\resumeheaderphotoavailableheight=\y1\relax
          \global\advance\resumeheaderphotoavailableheight by -\y2\relax
          \global\advance\resumeheaderphotoavailableheight by \resumeheaderactivephotoyshift\relax
          \global\advance\resumeheaderphotoavailableheight by -\resumeheaderactivephotolinegap\relax
          \ifdim\resumeheaderphotoavailableheight<1pt
            \global\resumeheaderphotoavailableheight=1pt
          \fi
        };%
        \node[
          anchor=north east,
          inner sep=0pt,
          outer sep=0pt,
          xshift=\resumeheaderactivephotoxshift,
          yshift=\resumeheaderactivephotoyshift
        ]
          at (resume-header-photo-top) {%
            \ifdim\dimexpr\ht\resumeheaderoverlayportraitbox+\dp\resumeheaderoverlayportraitbox\relax>\resumeheaderphotoavailableheight
              \resizebox{!}{\resumeheaderphotoavailableheight}{\usebox{\resumeheaderoverlayportraitbox}}%
            \else
              \usebox{\resumeheaderoverlayportraitbox}%
            \fi
          };%
      }%
    }%
    \nointerlineskip
    \global\resumeheaderpendingphotofalse
  \fi
}

\NewDocumentCommand{\resumesection}{m}{%
  \Needspace{3.5\baselineskip}%
  \par\addvspace{\resumesectionbeforeskip}%
  {\fontsize{\resumesectionfontsize}{\dimexpr6\resumesectionfontsize/5\relax}\selectfont
   \resumesectionfont\resumesectionfontweight\color{ResumePrimary}#1}\par
  \nobreak\vspace{\resumesectionlinegap}%
  \resumeheaderphotolimitmark
  \ifresumesolidsectionline
    \begingroup
      \color{ResumePrimary}\hrule height \resumesectionlinewidth
    \endgroup
  \else
    \nointerlineskip
    % 使用当前 \linewidth 直接绘制渐变色带，因而修改 geometry、
    % 栏宽或 minipage 宽度都不会产生固定宽度溢出。
    \hbox to \linewidth{%
      \begin{tikzpicture}
        \shade[left color=ResumePrimary,right color=white]
          (0pt,0pt) rectangle (\linewidth,\resumesectionlinewidth);
      \end{tikzpicture}\hfil
    }%
  \fi
  \resumeheaderdrawpendingphoto
  \nobreak\vspace{\resumesectionafterskip}%
}

\newsavebox{\resumecontactbox}
\NewDocumentCommand{\resumecontact}{m m}{%
  \begingroup
  % 短联系项保持原来的行内排列；自然宽度超过信息栏时自动切换为
  % “固定图标列 + 自适应文本列”，只在个人信息区域内换行。
  \sbox{\resumecontactbox}{{\zihao{5}\color{black}#1}\hspace{0.28em}#2}%
  \ifdim\wd\resumecontactbox>\linewidth
    \par\noindent
    \setlength{\tabcolsep}{0pt}%
    \renewcommand{\tabularxcolumn}[1]{m{##1}}%
    \begin{tabularx}{\linewidth}{@{}>{\centering\arraybackslash}m{1.25em}@{\hspace{0.28em}}>{\raggedright\arraybackslash}X@{}}
      {\zihao{5}\color{black}#1} & #2
    \end{tabularx}%
    \par
  \else
    \usebox{\resumecontactbox}\hspace{0.8em}\allowbreak
  \fi
  \endgroup
}

% 链接文字使用 url 的可断行规则，同时保留 href 的实际跳转目标。
\NewDocumentCommand{\resumelink}{m m}{\href{#1}{\nolinkurl{#2}}}

% 姓名和联系方式的自然高度决定头部高度。
\NewDocumentCommand{\resumeheaderidentity}{m m}{%
  \begingroup
  {\fontsize{\resumenamefontsize}{\dimexpr6\resumenamefontsize/5\relax}\selectfont
   \resumenamefont\resumenamefontweight\color{ResumePrimary}#1}\par
  \vspace{\resumeheadernamegap}%
  \let\\\newline
  {#2}\par
  \endgroup
}

% 照片只受最大宽高约束，保持原始比例；未给路径时显示通用占位框。
\NewDocumentCommand{\resumeheaderportrait}{m}{%
  \ifstrempty{#1}{%
    \begin{tikzpicture}[baseline=(current bounding box.center)]
      \draw[rounded corners=2pt,draw=ResumeDivider,fill=ResumeDivider!18]
        (0,0) rectangle (\resumeheaderphotowidth,\resumeheaderphotomaxheight);
      \node[color=ResumeMuted,yshift=0.35cm] at (current bounding box.center)
        {\fontsize{26}{26}\selectfont\faUser};
      \node[color=ResumeMuted,font=\scriptsize,yshift=-0.55cm] at (current bounding box.center)
        {照片（可选）};
    \end{tikzpicture}%
  }{%
    % graphicx 的 trim 解析器不会主动展开包含四个值的宏；先把完整
    % 选项展开，再交给 \includegraphics，允许 photo-trim 使用统一参数。
    \edef\resumeheadergraphicoptions{%
      width=\resumeheaderphotowidth,
      height=\resumeheaderphotomaxheight,
      trim=\resumeheaderphototrim,
      clip,
      keepaspectratio
    }%
    \expandafter\includegraphics\expandafter[\resumeheadergraphicoptions]{#1}%
  }%
}

% #1 为 t/c/b，两个自然高度的盒子据此顶部/居中/底部对齐。
\NewDocumentCommand{\resumeheaderrow}{m m m}{%
  \makebox[\linewidth][l]{%
    \begin{minipage}[#1]{\dimexpr\linewidth-\resumeheaderphotowidth-\resumeheadercolumngap\relax}
      \ifstrequal{#1}{t}{\vspace{0pt}}{}%
      #2
    \end{minipage}%
    \hspace{\resumeheadercolumngap}%
    \begin{minipage}[#1]{\resumeheaderphotowidth}
      \ifstrequal{#1}{t}{\vspace{0pt}}{}%
      \centering#3\par
    \end{minipage}%
  }%
}

% 默认 overlay 布局：左栏保持自然高度，照片不参与纵向占位。
% 照片稍后由首个 \resumesection 以前景层放回这里记录的右上锚点。
\NewDocumentCommand{\resumeheaderoverlayrow}{m m m}{%
  \sbox{\resumeheaderidentitybox}{%
    \begin{minipage}[t]{\dimexpr\linewidth-\resumeheaderphotowidth-\resumeheadercolumngap\relax}
      \vspace{0pt}%
      \resumeheaderidentity{#1}{#2}%
    \end{minipage}%
  }%
  \global\setbox\resumeheaderoverlayportraitbox=\hbox{\resumeheaderportrait{#3}}%
  \global\resumeheaderactivephotolinegap=\resumeheaderphotolinegap\relax
  \global\resumeheaderactivephotoxshift=\resumeheaderphotoxshift\relax
  \global\resumeheaderactivephotoyshift=\resumeheaderphotoyshift\relax
  \global\resumeheaderpendingphototrue
  \makebox[\linewidth][l]{%
    \usebox{\resumeheaderidentitybox}%
    \hfill
    \tikz[remember picture,overlay]{%
      \coordinate (resume-header-photo-top)
        at (0,\the\ht\resumeheaderidentitybox);%
    }%
  }%
}

% #1 可选照片路径；#2 可选局部参数；#3 姓名；#4 联系信息。
% 局部参数：photo、photo-layout、photo-align、photo-width、photo-max-height、
% photo-trim、photo-line-gap、photo-x-shift、photo-y-shift、
% column-gap、name-gap、after-skip。
\NewDocumentCommand{\resumeheader}{O{} O{} m m}{%
  \par\noindent
  \begingroup
  \pgfkeys{/simplecnresume/header/.cd,#2}%
  \global\resumeheaderpendingphotofalse
  \ifresumeheaderphoto
    \ifresumeheaderphotooverlay
      \resumeheaderoverlayrow{#3}{#4}{#1}%
    \else
      \ifdefstring{\resumeheaderphotoalignment}{top}{%
        \resumeheaderrow{t}{\resumeheaderidentity{#3}{#4}}{\resumeheaderportrait{#1}}%
      }{%
        \ifdefstring{\resumeheaderphotoalignment}{bottom}{%
          \resumeheaderrow{b}{\resumeheaderidentity{#3}{#4}}{\resumeheaderportrait{#1}}%
        }{%
          \resumeheaderrow{c}{\resumeheaderidentity{#3}{#4}}{\resumeheaderportrait{#1}}%
        }%
      }%
    \fi
  \else
    \resumeheaderidentity{#3}{#4}%
  \fi
  \par\nobreak\vspace{\resumeheaderafterskip}%
  \endgroup
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
    top=\resumebannerpaddingtop,
    bottom=\resumebannerpaddingbottom,
    before skip=0.28em,
    after skip=0.18em
  ]
    \begingroup
    \setlength{\tabcolsep}{0pt}%
    \setlength{\fboxsep}{1pt}%
    % 取消表格默认 strut 在 Logo 下方制造的额外着色高度；
    % 色块高度只由实际内容与 banner-padding-y 决定。
    \renewcommand{\arraystretch}{0}%
    \renewcommand{\tabularxcolumn}[1]{m{##1}}%
    \begin{tabularx}{\linewidth}{@{}>{\centering\arraybackslash}m{1.65em}@{\hspace{0.45em}}>{\raggedright\arraybackslash}X>{\raggedleft\arraybackslash}m{\resumebannerdatewidth}@{}}
      \if\relax\detokenize{#2}\relax
        \colorbox{#1}{\makebox[1.25em][c]{\color{white}\strut\faBuilding}}%
      \else
        \includegraphics[width=1.55em,height=1.55em,keepaspectratio]{#2}%
      \fi
      & \raisebox{\resumebannertextshift}{%
          \parbox[c]{\hsize}{%
            \raggedright\bfseries
            #3\hspace{0.35em}%
            \textcolor{ResumeMuted}{\rule[0.5ex]{0.32cm}{0.5pt}}%
            \hspace{0.35em}#4\par
          }%
        }
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
  \par\addvspace{\resumeprojectdividerbeforeskip}%
  \begingroup
    \color{ResumeDivider}\hrule height \resumeprojectdividerwidth
  \endgroup
  \nobreak\vspace{\resumeprojectdividerafterskip}%
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
