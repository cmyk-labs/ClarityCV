% claritycv.cls -- ClarityCV 中文简历文档类
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{claritycv}[2026/09/04 v2.12 ClarityCV class]

% 未识别的文档类选项直接交给 ctexart；模板自身统一通过 \resumesetup 配置。
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

% 延续 v4 的 Windows 中文字体配置：正文宋体，标题黑体。
\LoadClass[UTF8,a4paper,fontset=windows]{ctexart}

% 所有页面共用相同的上下安全留白；后续页不再贴近纸张边缘。
\RequirePackage[top=1.25cm,left=1.5cm,right=1.5cm,bottom=1.25cm]{geometry}
\RequirePackage{fontspec}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{fontawesome}
\RequirePackage{tikz}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{pifont}
\RequirePackage{multicol}
\RequirePackage{tabularx}
\RequirePackage{etoolbox}
\RequirePackage{needspace}
\RequirePackage[skins]{tcolorbox}
\usetikzlibrary{calc}

% 延续 v4 的西文字体；中文字体由上面的 ctex Windows 字体集提供。
\setmainfont{Times New Roman}
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
\definecolor{ResumeAccent}{RGB}{200,38,38}
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
\scr@namefontsize=16bp
\scr@sectionfontsize=14bp
\scr@bodyfontsize=9pt

\def\scr@sectionfont{\scr@sectioncjk}
\def\scr@sectionweight{\bfseries}
\def\scr@namefont{\scr@sectionfont}
\def\scr@nameweight{\scr@sectionweight}
\def\scr@headernamecolor{ResumePrimary}
% 使用 CJK 主字体族，使 \textbf 与 v4 一样自动从宋体切换到黑体。
\def\scr@bodyfont{\rmfamily}

\newif\ifscr@sectionlinesolid
\scr@sectionlinesolidtrue
\def\scr@sectionlinewidth{0.55pt}
\def\scr@sectionbeforeskip{0.2em}
\def\scr@sectionlinegap{0.24em}
\def\scr@sectionafterskip{0.55em}
\def\scr@sectionlistextraskip{3.5pt}

\def\scr@defaultentrystyle{plain}
\def\scr@defaultentrycolor{ResumePrimary}
\def\scr@defaultentryseparator{dash}
% 主标题和副标题保持同级，日期降级；与正文小标题通过字号和颜色拉开层次。
% 颜色值 entry 表示跟随 entry-color，便于只改一个主题色。
\def\scr@defaultentrytitlecolor{entry}
\def\scr@defaultentrysubtitlecolor{entry}
\def\scr@defaultentrydatecolor{ResumeMuted}
\def\scr@defaultentrytitleweight{\bfseries}
\def\scr@defaultentrysubtitleweight{\bfseries}
\def\scr@defaultentrydateweight{\mdseries}
\def\scr@defaultentryheadingsize{9.4pt}
\def\scr@defaultentrydivider{none}
\def\scr@defaultentrydatewidth{9.3em}
\def\scr@defaultentrytextshift{0.4ex}
\def\scr@defaultentrypaddingleft{0.72em}
\def\scr@defaultentrypaddingright{0pt}
\def\scr@defaultentrypaddingy{0.14em}
\def\scr@defaultentrybannertint{6}
\def\scr@defaultentrybannerborderwidth{2.5pt}
\def\scr@defaultentrybannerradius{2pt}
\def\scr@defaultentrybeforeskip{0.65em}
\def\scr@defaultentryafterskip{0.1em}

% 头部命令的默认参数。
\newif\ifscr@headerphoto
\scr@headerphotofalse
\newif\ifscr@headerphotooverlay
\scr@headerphotooverlaytrue
\newif\ifscr@headerpendingphoto
\scr@headerpendingphotofalse
\def\scr@headerphotofile{}
\def\scr@headerphotoalignment{center}
\def\scr@headerphotowidth{2.75cm}
\def\scr@headerphotomaxheight{3.15cm}
\def\scr@headerphotolinegap{0.18em}
\def\scr@headerphotoxshift{0pt}
\def\scr@headerphotoyshift{0pt}
\def\scr@headercolumngap{1em}
% 姓名视作头部模块标题：标题到联系信息、联系信息到下一模块分别
% 对齐普通 section 的“标题到正文”和“正文到下一标题”视觉间距。
\def\scr@headernamegap{0.78em}
\def\scr@headerafterskip{0.98em}

% 联系方式的默认参数；字号默认跟随正文，用户覆盖后则使用指定值。
\def\scr@defaultcontacticoncolor{black}
\def\scr@defaultcontacttextcolor{black}
\def\scr@defaultcontacticonsize{10.5bp}
\def\scr@defaultcontacttextsize{\scr@bodyfontsize}
\def\scr@defaultcontacttextweight{\mdseries}
\def\scr@defaultcontacticonwidth{1.25em}
\def\scr@defaultcontacticongap{0.28em}
\def\scr@defaultcontactitemgap{0.8em}

% 三种行内编号共用样式；带圈数字无粗体字库，bold 时在命令内部做光学校正。
\def\scr@defaultnumbercolor{inherit}
\def\scr@defaultnumberweight{\bfseries}
\def\scr@defaultnumberstrength{bold}
\def\scr@defaultnumberscale{1}

% ---------- 单一全局配置入口 ----------
\pgfkeys{
  /claritycv/.is family,
  /claritycv,
  page-top-margin/.code={\geometry{top=#1}},
  page-bottom-margin/.code={\geometry{bottom=#1}},
  color/.code={\colorlet{ResumePrimary}{#1}},
  accent-color/.code={\colorlet{ResumeAccent}{#1}},
  muted-color/.code={\colorlet{ResumeMuted}{#1}},
  divider-color/.code={\colorlet{ResumeDivider}{#1}},
  font/.is choice,
  font/classic/.code={\def\scr@bodyfont{\rmfamily}},
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
  entry-title-weight/.is choice,
  entry-title-weight/regular/.code={\def\scr@defaultentrytitleweight{\mdseries}},
  entry-title-weight/bold/.code={\def\scr@defaultentrytitleweight{\bfseries}},
  entry-subtitle-weight/.is choice,
  entry-subtitle-weight/regular/.code={\def\scr@defaultentrysubtitleweight{\mdseries}},
  entry-subtitle-weight/bold/.code={\def\scr@defaultentrysubtitleweight{\bfseries}},
  entry-date-weight/.is choice,
  entry-date-weight/regular/.code={\def\scr@defaultentrydateweight{\mdseries}},
  entry-date-weight/bold/.code={\def\scr@defaultentrydateweight{\bfseries}},
  entry-title-color/.store in=\scr@defaultentrytitlecolor,
  entry-subtitle-color/.store in=\scr@defaultentrysubtitlecolor,
  entry-date-color/.store in=\scr@defaultentrydatecolor,
  entry-heading-size/.store in=\scr@defaultentryheadingsize,
  entry-divider/.is choice,
  entry-divider/none/.code={\def\scr@defaultentrydivider{none}},
  entry-divider/before/.code={\def\scr@defaultentrydivider{before}},
  entry-divider/after/.code={\def\scr@defaultentrydivider{after}},
  entry-date-width/.store in=\scr@defaultentrydatewidth,
  entry-text-shift/.store in=\scr@defaultentrytextshift,
  entry-padding-left/.store in=\scr@defaultentrypaddingleft,
  entry-padding-right/.store in=\scr@defaultentrypaddingright,
  entry-padding-y/.store in=\scr@defaultentrypaddingy,
  entry-banner-tint/.store in=\scr@defaultentrybannertint,
  entry-banner-border-width/.store in=\scr@defaultentrybannerborderwidth,
  entry-banner-radius/.store in=\scr@defaultentrybannerradius,
  entry-before-skip/.store in=\scr@defaultentrybeforeskip,
  entry-after-skip/.store in=\scr@defaultentryafterskip,
  header-name-size/.code={\scr@namefontsize=#1\relax},
  header-name-color/.store in=\scr@headernamecolor,
  header-name-weight/.is choice,
  header-name-weight/inherit/.code={\def\scr@nameweight{\scr@sectionweight}},
  header-name-weight/regular/.code={\def\scr@nameweight{\mdseries}},
  header-name-weight/bold/.code={\def\scr@nameweight{\bfseries}},
  header-layout/.is choice,
  header-layout/overlay/.code={\scr@headerphotooverlaytrue},
  header-layout/flow/.code={\scr@headerphotooverlayfalse},
  header-photo-align/.is choice,
  header-photo-align/top/.code={\def\scr@headerphotoalignment{top}},
  header-photo-align/center/.code={\def\scr@headerphotoalignment{center}},
  header-photo-align/bottom/.code={\def\scr@headerphotoalignment{bottom}},
  header-photo-width/.store in=\scr@headerphotowidth,
  header-photo-max-height/.store in=\scr@headerphotomaxheight,
  header-photo-line-gap/.store in=\scr@headerphotolinegap,
  header-photo-x-shift/.store in=\scr@headerphotoxshift,
  header-photo-y-shift/.store in=\scr@headerphotoyshift,
  header-column-gap/.store in=\scr@headercolumngap,
  header-name-gap/.store in=\scr@headernamegap,
  header-after-skip/.store in=\scr@headerafterskip,
  contact-icon-color/.store in=\scr@defaultcontacticoncolor,
  contact-text-color/.store in=\scr@defaultcontacttextcolor,
  contact-icon-size/.store in=\scr@defaultcontacticonsize,
  contact-text-size/.store in=\scr@defaultcontacttextsize,
  contact-text-weight/.is choice,
  contact-text-weight/regular/.code={\def\scr@defaultcontacttextweight{\mdseries}},
  contact-text-weight/bold/.code={\def\scr@defaultcontacttextweight{\bfseries}},
  contact-icon-width/.store in=\scr@defaultcontacticonwidth,
  contact-icon-gap/.store in=\scr@defaultcontacticongap,
  contact-item-gap/.store in=\scr@defaultcontactitemgap,
  number-color/.store in=\scr@defaultnumbercolor,
  number-weight/.is choice,
  number-weight/inherit/.code={%
    \def\scr@defaultnumberweight{}%
    \def\scr@defaultnumberstrength{inherit}%
  },
  number-weight/regular/.code={%
    \def\scr@defaultnumberweight{\mdseries}%
    \def\scr@defaultnumberstrength{regular}%
  },
  number-weight/bold/.code={%
    \def\scr@defaultnumberweight{\bfseries}%
    \def\scr@defaultnumberstrength{bold}%
  },
  number-scale/.store in=\scr@defaultnumberscale,
  section-before-skip/.store in=\scr@sectionbeforeskip,
  section-line-gap/.store in=\scr@sectionlinegap,
  section-after-skip/.store in=\scr@sectionafterskip,
  section-list-extra-skip/.store in=\scr@sectionlistextraskip,
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
% 双栏奖项区域的顶部留白与其他章节正文保持一致。
\setlength{\multicolsep}{5.5pt}
% 单页简历尾部空间通常较短，允许双栏区域在剩余两行高度时开始。
\setlength{\premulticols}{2\baselineskip}

\renewcommand\normalsize{%
  \@setfontsize\normalsize
    {\scr@bodyfontsize}%
    {\dimexpr110\scr@bodyfontsize/90\relax}%
}
\AtBeginDocument{\normalsize\scr@bodyfont}

% ---------- 标准 LaTeX 列表 ----------
% itemize：无编号列举；enumerate：有编号列举。一级与二级均可直接嵌套。
% 三种中文简历常用编号，可用于正文或 enumitem 的 label 参数。
% cvC / cvP / cvR 分别表示 circle / parentheses / right parenthesis。
% 默认统一增强视觉重量；命令可选参数只覆盖当前编号。
\pgfkeys{
  /claritycv/number/.is family,
  /claritycv/number,
  color/.store in=\scr@numbercolor,
  weight/.is choice,
  weight/inherit/.code={%
    \def\scr@numberweight{}%
    \def\scr@numberstrength{inherit}%
  },
  weight/regular/.code={%
    \def\scr@numberweight{\mdseries}%
    \def\scr@numberstrength{regular}%
  },
  weight/bold/.code={%
    \def\scr@numberweight{\bfseries}%
    \def\scr@numberstrength{bold}%
  },
  scale/.store in=\scr@numberscale
}

\newcommand*{\scr@numberprepare}[1]{%
  \let\scr@numbercolor\scr@defaultnumbercolor
  \let\scr@numberweight\scr@defaultnumberweight
  \let\scr@numberstrength\scr@defaultnumberstrength
  \let\scr@numberscale\scr@defaultnumberscale
  \pgfkeys{/claritycv/number/.cd,#1}%
  \ifdefstring{\scr@numbercolor}{inherit}{}{\color{\scr@numbercolor}}%
}

\newcommand*{\scr@circlednumberglyph}[1]{%
  \ifnum#1<1 \textcircled{#1}%
  \else\ifnum#1>10 \textcircled{#1}%
  \else\ding{\numexpr171+#1\relax}%
  \fi\fi
}

\NewDocumentCommand{\cvC}{O{} m}{%
  \begingroup
  \scr@numberprepare{#1}%
  \ifdefstring{\scr@numberstrength}{bold}
    {\scalebox{\scr@numberscale}{\scalebox{1.06}{{\scr@numberweight\scr@circlednumberglyph{#2}}}}}%
    {\scalebox{\scr@numberscale}{{\scr@numberweight\scr@circlednumberglyph{#2}}}}%
  \endgroup
}
\NewDocumentCommand{\cvP}{O{} m}{%
  \begingroup
  \scr@numberprepare{#1}%
  \ifdefstring{\scr@numberscale}{1}
    {{\scr@numberweight（#2）}}%
    {\scalebox{\scr@numberscale}{{\scr@numberweight（#2）}}}%
  \endgroup
}
\NewDocumentCommand{\cvR}{O{} m}{%
  \begingroup
  \scr@numberprepare{#1}%
  \ifdefstring{\scr@numberscale}{1}
    {{\scr@numberweight #2）}}%
    {\scalebox{\scr@numberscale}{{\scr@numberweight #2）}}}%
  \endgroup
}

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

% 标准 section 紧接列表时，补足 v4 中横线到首条正文的视觉距离。
% 标记会在普通段落或条目标题开始时清除，因此不改变其他列表间距。
\newif\ifscr@sectionbodypending
\scr@sectionbodypendingfalse
\newcommand*{\scr@sectionlistgap}{%
  \ifscr@sectionbodypending
    \vspace{\scr@sectionlistextraskip}%
  \fi
  \global\scr@sectionbodypendingfalse
}
\AtBeginEnvironment{itemize}{\scr@sectionlistgap}
\AtBeginEnvironment{enumerate}{\scr@sectionlistgap}
% multicols 已自带合适的顶部留白，避免其内部列表重复补偿。
\AtBeginEnvironment{multicols}{\global\scr@sectionbodypendingfalse}
\AddToHook{para/begin}{\global\scr@sectionbodypendingfalse}

% ---------- 头部 ----------
\pgfkeys{
  /claritycv/header/.is family,
  /claritycv/header,
  name-size/.code={\scr@namefontsize=#1\relax},
  name-color/.store in=\scr@headernamecolor,
  name-weight/.is choice,
  name-weight/inherit/.code={\def\scr@nameweight{\scr@sectionweight}},
  name-weight/regular/.code={\def\scr@nameweight{\mdseries}},
  name-weight/bold/.code={\def\scr@nameweight{\bfseries}},
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

\pgfkeys{
  /claritycv/contact/.is family,
  /claritycv/contact,
  icon-color/.store in=\scr@contacticoncolor,
  text-color/.store in=\scr@contacttextcolor,
  icon-size/.store in=\scr@contacticonsize,
  text-size/.store in=\scr@contacttextsize,
  text-weight/.is choice,
  text-weight/regular/.code={\def\scr@contacttextweight{\mdseries}},
  text-weight/bold/.code={\def\scr@contacttextweight{\bfseries}},
  icon-width/.store in=\scr@contacticonwidth,
  icon-gap/.store in=\scr@contacticongap,
  item-gap/.store in=\scr@contactitemgap
}

\newcommand*{\scr@contacticonstyle}{%
  \fontsize{\scr@contacticonsize}{\dimexpr6\scr@contacticonsize/5\relax}\selectfont
  \color{\scr@contacticoncolor}%
}
\newcommand*{\scr@contacttextstyle}{%
  \fontsize{\scr@contacttextsize}{\dimexpr6\scr@contacttextsize/5\relax}\selectfont
  \scr@contacttextweight\color{\scr@contacttextcolor}%
}

\newsavebox{\scr@contactbox}
\NewDocumentCommand{\resumecontact}{O{} m m}{%
  \begingroup
  \let\scr@contacticoncolor\scr@defaultcontacticoncolor
  \let\scr@contacttextcolor\scr@defaultcontacttextcolor
  \let\scr@contacticonsize\scr@defaultcontacticonsize
  \let\scr@contacttextsize\scr@defaultcontacttextsize
  \let\scr@contacttextweight\scr@defaultcontacttextweight
  \let\scr@contacticonwidth\scr@defaultcontacticonwidth
  \let\scr@contacticongap\scr@defaultcontacticongap
  \let\scr@contactitemgap\scr@defaultcontactitemgap
  \pgfkeys{/claritycv/contact/.cd,#1}%
  % 使链接文字也遵循本条 text-color，而不是被文档级 urlcolor 覆盖。
  \hypersetup{%
    linkcolor=\scr@contacttextcolor,
    filecolor=\scr@contacttextcolor,
    urlcolor=\scr@contacttextcolor
  }%
  \sbox{\scr@contactbox}{{\scr@contacticonstyle #2}\hspace{\scr@contacticongap}{\scr@contacttextstyle #3}}%
  \ifdim\wd\scr@contactbox>\linewidth
    \par\noindent
    \setlength{\tabcolsep}{0pt}%
    \renewcommand{\tabularxcolumn}[1]{m{##1}}%
    \begin{tabularx}{\linewidth}{@{}>{\centering\arraybackslash}m{\scr@contacticonwidth}@{\hspace{\scr@contacticongap}}>{\raggedright\arraybackslash}X@{}}
      {\scr@contacticonstyle #2} & {\scr@contacttextstyle #3}
    \end{tabularx}%
    \par
  \else
    \usebox{\scr@contactbox}\hspace{\scr@contactitemgap}\allowbreak
  \fi
  \endgroup
}

\newsavebox{\scr@headeridentitybox}
\newsavebox{\scr@headeroverlayportraitbox}
\newdimen\scr@headerphotoavailableheight
\newdimen\scr@headeractivephotolinegap
\newdimen\scr@headeractivephotoxshift
\newdimen\scr@headeractivephotoyshift
\newdimen\scr@headerphotoautoshift
\newdimen\scr@headerphotototalyshift

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
          \global\advance\scr@headerphotoavailableheight by -\scr@headeractivephotolinegap\relax
          \ifdim\scr@headerphotoavailableheight<1pt
            \global\scr@headerphotoavailableheight=1pt
          \fi
          % 图片较短时在头部可用高度内自动对齐；过高时仍按可用高度缩放。
          \global\scr@headerphotoautoshift=0pt
          \ifdim\dimexpr\ht\scr@headeroverlayportraitbox+\dp\scr@headeroverlayportraitbox\relax<\scr@headerphotoavailableheight
            \global\scr@headerphotoautoshift=\scr@headerphotoavailableheight
            \global\advance\scr@headerphotoautoshift by
              -\dimexpr\ht\scr@headeroverlayportraitbox+\dp\scr@headeroverlayportraitbox\relax
            \ifdefstring{\scr@headerphotoalignment}{top}{%
              \global\scr@headerphotoautoshift=0pt
            }{%
              \ifdefstring{\scr@headerphotoalignment}{center}{%
                \global\divide\scr@headerphotoautoshift by 2
              }{}%
              \global\scr@headerphotoautoshift=-\scr@headerphotoautoshift
            }%
          \fi
          \global\scr@headerphotototalyshift=\scr@headeractivephotoyshift
          \global\advance\scr@headerphotototalyshift by \scr@headerphotoautoshift
        };%
        \node[
          anchor=north east,
          inner sep=0pt,
          outer sep=0pt,
          xshift=\scr@headeractivephotoxshift,
          yshift=\scr@headerphotototalyshift
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
   \scr@namefont\scr@nameweight\color{\scr@headernamecolor}#1}\par
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
  \global\scr@sectionbodypendingtrue
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
\def\scr@entrycolor{ResumePrimary}
\def\scr@entryseparator{dash}
\def\scr@entrytitlecolor{black}
\def\scr@entrysubtitlecolor{black}
\def\scr@entrydatecolor{ResumeMuted}
\def\scr@entrytitleweight{\bfseries}
\def\scr@entrysubtitleweight{\bfseries}
\def\scr@entrydateweight{\mdseries}
\def\scr@entryheadingsize{9.4pt}
\def\scr@entrylogo{}
\def\scr@entrydivider{none}
\def\scr@entrydatewidth{9.3em}
\def\scr@entrytextshift{0.4ex}
\def\scr@entrypaddingleft{0.72em}
\def\scr@entrypaddingright{0pt}
\def\scr@entrypaddingy{0.14em}
\def\scr@entrybannertint{6}
\def\scr@entrybannerborderwidth{2.5pt}
\def\scr@entrybannerradius{2pt}
\def\scr@entrybeforeskip{0.65em}
\def\scr@entryafterskip{0.1em}

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
  title-weight/.is choice,
  title-weight/regular/.code={\def\scr@entrytitleweight{\mdseries}},
  title-weight/bold/.code={\def\scr@entrytitleweight{\bfseries}},
  subtitle-weight/.is choice,
  subtitle-weight/regular/.code={\def\scr@entrysubtitleweight{\mdseries}},
  subtitle-weight/bold/.code={\def\scr@entrysubtitleweight{\bfseries}},
  date-weight/.is choice,
  date-weight/regular/.code={\def\scr@entrydateweight{\mdseries}},
  date-weight/bold/.code={\def\scr@entrydateweight{\bfseries}},
  title-color/.store in=\scr@entrytitlecolor,
  subtitle-color/.store in=\scr@entrysubtitlecolor,
  date-color/.store in=\scr@entrydatecolor,
  heading-size/.store in=\scr@entryheadingsize,
  divider/.is choice,
  divider/none/.code={\def\scr@entrydivider{none}},
  divider/before/.code={\def\scr@entrydivider{before}},
  divider/after/.code={\def\scr@entrydivider{after}},
  date-width/.store in=\scr@entrydatewidth,
  text-shift/.store in=\scr@entrytextshift,
  padding-left/.store in=\scr@entrypaddingleft,
  padding-right/.store in=\scr@entrypaddingright,
  padding-y/.store in=\scr@entrypaddingy,
  banner-tint/.store in=\scr@entrybannertint,
  banner-border-width/.store in=\scr@entrybannerborderwidth,
  banner-radius/.store in=\scr@entrybannerradius,
  before-skip/.store in=\scr@entrybeforeskip,
  after-skip/.store in=\scr@entryafterskip
}

% entry 表示继承本条的 color；其他值按普通 xcolor 颜色名处理。
\newcommand*{\scr@entryapplycolor}[1]{%
  \ifdefstring{#1}{entry}{\color{\scr@entrycolor}}{\color{#1}}%
}

\newcommand*{\scr@entryseparatorcontent}{%
  \ifdefstring{\scr@entryseparator}{bar}{%
    \hspace{0.32em}{\color{ResumeMuted}|}\hspace{0.32em}%
  }{%
    \hspace{0.3em}{\color{ResumeMuted}\rule[0.5ex]{0.25cm}{0.5pt}}\hspace{0.3em}%
  }%
}

\newcommand*{\scr@entryheadingstyle}{%
  \fontsize{\scr@entryheadingsize}{\dimexpr6\scr@entryheadingsize/5\relax}\selectfont
}

\newcommand*{\scr@entrydividerline}{%
  \Needspace{3\baselineskip}%
  \par\addvspace{0.35em}%
  \begingroup
    \color{ResumeDivider}\hrule height 0.35pt
  \endgroup
  \nobreak\vspace{0.35em}%
}

% 日期通常由开始、结束两个参数组成；任一侧为空时仅显示非空内容。
\newcommand*{\scr@entrydaterange}[2]{%
  \ifstrempty{#1}{%
    \ifstrempty{#2}{}{\mbox{#2}}%
  }{%
    \ifstrempty{#2}{\mbox{#1}}{\mbox{#1\hspace{0.28em}-\hspace{0.28em}#2}}%
  }%
}

\newcommand*{\scr@plainentry}[3]{%
  \Needspace{2\baselineskip}%
  \par\noindent
  \setlength{\tabcolsep}{0pt}%
  \renewcommand{\tabularxcolumn}[1]{m{##1}}%
  \begin{tabularx}{\linewidth}{@{}>{\raggedright\arraybackslash}X>{\raggedleft\arraybackslash}m{\scr@entrydatewidth}@{}}
    {\scr@entryheadingstyle\scr@entryapplycolor{\scr@entrytitlecolor}\scr@entrytitleweight #1}%
    \ifstrempty{#2}{}{%
      \scr@entryseparatorcontent
      {\scr@entryheadingstyle\scr@entryapplycolor{\scr@entrysubtitlecolor}\scr@entrysubtitleweight #2}%
    }%
    & {\scr@entryapplycolor{\scr@entrydatecolor}\scr@entrydateweight #3}
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
    colback=\scr@entrycolor!\scr@entrybannertint,
    borderline west={\scr@entrybannerborderwidth}{0pt}{\scr@entrycolor},
    arc=\scr@entrybannerradius,
    boxsep=0pt,
    left=\scr@entrypaddingleft,
    right=\scr@entrypaddingright,
    top=\scr@entrypaddingy,
    bottom=\scr@entrypaddingy,
    before skip=0pt,
    after skip=0pt
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
            \raggedright
            {\scr@entryheadingstyle\scr@entryapplycolor{\scr@entrytitlecolor}\scr@entrytitleweight #1}%
            \ifstrempty{#2}{}{%
              \scr@entryseparatorcontent
              {\scr@entryheadingstyle\scr@entryapplycolor{\scr@entrysubtitlecolor}\scr@entrysubtitleweight #2}%
            }%
            \par
          }%
        }
      & {\scr@entryapplycolor{\scr@entrydatecolor}\scr@entrydateweight #3}
    \end{tabularx}%
  \end{tcolorbox}%
}

% 所有视觉参数默认继承 \resumesetup；可选参数只覆盖当前条目。
% 必选参数依次为：主标题、副标题、开始时间、结束时间；日期允许任一侧留空。
\NewDocumentCommand{\resumeentry}{O{} m m m m}{%
  \begingroup
  \let\scr@entrystyle\scr@defaultentrystyle
  \let\scr@entrycolor\scr@defaultentrycolor
  \let\scr@entryseparator\scr@defaultentryseparator
  \let\scr@entrytitlecolor\scr@defaultentrytitlecolor
  \let\scr@entrysubtitlecolor\scr@defaultentrysubtitlecolor
  \let\scr@entrydatecolor\scr@defaultentrydatecolor
  \let\scr@entrytitleweight\scr@defaultentrytitleweight
  \let\scr@entrysubtitleweight\scr@defaultentrysubtitleweight
  \let\scr@entrydateweight\scr@defaultentrydateweight
  \let\scr@entryheadingsize\scr@defaultentryheadingsize
  \def\scr@entrylogo{}%
  \let\scr@entrydivider\scr@defaultentrydivider
  \let\scr@entrydatewidth\scr@defaultentrydatewidth
  \let\scr@entrytextshift\scr@defaultentrytextshift
  \let\scr@entrypaddingleft\scr@defaultentrypaddingleft
  \let\scr@entrypaddingright\scr@defaultentrypaddingright
  \let\scr@entrypaddingy\scr@defaultentrypaddingy
  \let\scr@entrybannertint\scr@defaultentrybannertint
  \let\scr@entrybannerborderwidth\scr@defaultentrybannerborderwidth
  \let\scr@entrybannerradius\scr@defaultentrybannerradius
  \let\scr@entrybeforeskip\scr@defaultentrybeforeskip
  \let\scr@entryafterskip\scr@defaultentryafterskip
  \pgfkeys{/claritycv/entry/.cd,#1}%
  % 不同条目容器自带的顶部留白不同；仅在紧接 section 时做光学校准，
  % 使横线到首行正文的距离与直接跟随列表的章节一致。
  \ifscr@sectionbodypending
    \ifdefstring{\scr@entrystyle}{banner}
      {\vspace{5pt}}%
      {\vspace{1pt}}%
    \global\scr@sectionbodypendingfalse
  \else
    \par\addvspace{\scr@entrybeforeskip}%
  \fi
  \ifdefstring{\scr@entrydivider}{before}{\scr@entrydividerline}{}%
  \ifdefstring{\scr@entrystyle}{banner}
    {\scr@bannerentry{#2}{#3}{\scr@entrydaterange{#4}{#5}}}
    {\scr@plainentry{#2}{#3}{\scr@entrydaterange{#4}{#5}}}%
  \ifdefstring{\scr@entrydivider}{after}{\scr@entrydividerline}{}%
  % banner 与 plain 的容器基线不同；内部补偿 4pt 后共用同一个用户间距参数。
  \ifdefstring{\scr@entrystyle}{banner}
    {\par\nobreak\vspace{\dimexpr\scr@entryafterskip+4pt\relax}}%
    {\par\nobreak\vspace{\scr@entryafterskip}}%
  \endgroup
}

\endinput
