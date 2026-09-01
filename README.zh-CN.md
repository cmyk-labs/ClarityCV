# SimpleCNResume-LaTeX-Template

<p>
  <a href="README.md"><img src="https://img.shields.io/badge/English-switch-555555" alt="English"></a>
  <a href="README.zh-CN.md"><img src="https://img.shields.io/badge/简体中文-当前-0B5394" alt="简体中文"></a>
</p>

一款简洁、可配置的通用中文简历 LaTeX 模板。简历内容集中在 `resume.tex`，字体、间距、颜色和可复用组件统一定义在 `simplecnresume.cls` 中。

## 排版预览

点击预览图可打开对应 PDF。所有预设采用相同的内容结构，便于直接比较排版差异。

<table>
  <tr>
    <td width="50%" align="center">
      <strong>推荐默认版</strong><br>
      <a href="resume.pdf"><img src="previews/default-resume.png" alt="推荐默认版简历预览" width="100%"></a><br>
      <a href="resume.tex">源文件</a>
    </td>
    <td width="50%" align="center">
      <strong>现代色块版</strong><br>
      <a href="examples/modern-colorblocks.pdf"><img src="previews/modern-colorblocks.png" alt="现代色块版预览" width="100%"></a><br>
      <a href="examples/modern-colorblocks.tex">源文件</a>
    </td>
  </tr>
  <tr>
    <td width="50%" align="center">
      <strong>经典简洁版</strong><br>
      <a href="examples/classic-clean.pdf"><img src="previews/classic-clean.png" alt="经典简洁版预览" width="100%"></a><br>
      <a href="examples/classic-clean.tex">源文件</a>
    </td>
    <td width="50%" align="center">
      <strong>黑灰极简版</strong><br>
      <a href="examples/minimal-mono.pdf"><img src="previews/minimal-mono.png" alt="黑灰极简版预览" width="100%"></a><br>
      <a href="examples/minimal-mono.tex">源文件</a>
    </td>
  </tr>
</table>

## 特点

- 中文开箱即用，使用 XeLaTeX 编译。
- 简历内容与排版定义分离。
- 可统一配置现代黑体或经典宋体模式、主题色、章节线、条目分隔符、字号和版面间距。
- 头部默认采用自适应前景照片：人物顶部与姓名平齐，照片不撑高内容，并自动限制在首个模块横线上方；也可隐藏、微调位置或切回流式布局。
- 普通条目与带 Logo 的公司色块可自由选择。
- 较长标题自动换行，时间仍保持右对齐。
- 支持多页内容，并尽量避免章节标题和下一行内容被拆开。
- 联系方式和奖项图标统一为黑色，减少无关的视觉强调。
- 附带证件照与 Logo 占位素材。
- 提供三套额外排版预设及编译后预览。

## 环境要求

- TeX Live 2022 或更新版本，或较新的 MiKTeX。
- 编译器必须选择 XeLaTeX。
- 需要完整的 LaTeX 发行版；英文正文字体已经放在 `fonts/` 中。

## 快速开始

克隆或下载整个项目后，从项目根目录编译：

```bash
latexmk -xelatex resume.tex
```

没有 `latexmk` 时，可连续运行两次：

```bash
xelatex resume.tex
xelatex resume.tex
```

在 Overleaf 中使用时，请上传整个项目，将编译器设为 XeLaTeX，并把 `resume.tex` 设为主文档。

## 目录结构

```text
.
├─ resume.tex              # 简历内容和用户配置入口
├─ simplecnresume.cls      # 排版定义与可复用命令
├─ fontawesome.sty         # 本地图标兼容宏包
├─ fonts/                  # 字体文件
├─ images/                 # 证件照与 Logo 素材
├─ previews/               # 从全部 PDF 生成的 PNG 预览
├─ examples/               # 额外预设、源文件与 PDF
├─ LICENSE                 # MIT 开源协议
├─ README.md               # 英文文档
├─ README.zh-CN.md         # 简体中文文档
└─ resume.pdf              # 推荐默认版 PDF
```

## 全局配置

当前推荐样式已经写入 `simplecnresume.cls`，直接使用文档类即可继承全部默认值。只有需要改变个别样式时，才在 `resume.tex` 导言区用 `\resumesetup` 覆盖对应项。

```tex
\documentclass{simplecnresume}

% 只填写需要覆盖的配置；未填写项继续继承类默认值。
\resumesetup{
  font-mode=modern,
  color=ResumeModern
}
```

| 配置项 | 可选值 | 默认值 | 作用范围 |
| --- | --- | --- | --- |
| `color` | `ResumeClassic`、`ResumeModern` 或已经定义的颜色名 | `ResumeClassic` | 姓名、章节标题、章节线、列表圆点、序号及主题色条目 |
| `font-mode` | `modern`、`classic` | `classic` | `classic` 使用 FandolSong + TeX Gyre Termes 正文；`modern` 自动选择现代中文无衬线字体并搭配 TeX Gyre Heros |
| `section-line` | `gradient`、`solid` | `solid` | 章节标题下方的渐变线或纯色线 |
| `entry-separator` | `dash`、`bar` | `bar` | 条目标题与副标题之间的短横杠或竖线 |
| `name-size` | 合法的 LaTeX 长度 | `14bp` | 姓名字号；默认略大于 `12.5bp` 的模块标题 |
| `section-size` | 合法的 LaTeX 长度 | `12.5bp` | 模块标题字号；与 9.3pt 正文保持约 1.34 倍层级 |
| `body-size` | 合法的 LaTeX 长度 | `9.3pt` | 正文字号，正文行距自动随之缩放 |
| `name-weight` | `inherit`、`regular`、`bold` | `inherit` | 姓名默认继承模块标题字重，也可单独覆盖 |
| `name-bold` | `true`、`false` | 未设置 | 姓名字重的兼容布尔写法；设置后会覆盖继承行为 |
| `section-font` | `simhei`、`modern` | `simhei` | 模块标题字体；`simhei` 复刻 v4，`modern` 使用现代中文字体链 |
| `section-font-name` | 已安装的字体名称 | 无 | 用任意系统字体覆盖模块标题字体，如 `{Microsoft YaHei}` |
| `section-weight` | `regular`、`bold` | `bold` | 模块标题字重；SimHei 默认使用 1.3 的轻度伪粗 |
| `section-bold` | `true`、`false` | `true` | 是否统一加粗所有 `\resumesection`，是 `section-weight` 的布尔写法 |
| `header-photo` | `true`、`false` | `true` | 全局显示或隐藏头部照片栏 |
| `header-photo-layout` | `overlay`、`flow` | `overlay` | 默认以前景层绘制照片，不占用纵向高度；`flow` 恢复照片参与排版的双栏布局 |
| `header-photo-align` | `top`、`center`、`bottom` | `bottom` | 仅在 `flow` 布局中控制照片相对个人信息栏的纵向对齐 |
| `header-photo-width` | 合法的 LaTeX 长度 | `2.8cm` | 照片最大宽度及照片栏宽度 |
| `header-photo-max-height` | 合法的 LaTeX 长度 | `3.2cm` | 照片最大高度；照片始终保持原始比例 |
| `header-photo-trim` | `左 下 右 上` 四个长度 | `0 0 0 0` | 裁掉照片文件自带的透明边或空白边 |
| `header-photo-line-gap` | 合法的 LaTeX 长度 | `0.18em` | 前景照片底部与首个模块横线之间的最小留白 |
| `header-photo-x-shift` | 合法的 LaTeX 长度 | `0pt` | 手动水平微调；正值向右、负值向左 |
| `header-photo-y-shift` | 合法的 LaTeX 长度 | `0pt` | 手动垂直微调；正值向上、负值向下，向下时仍会缩放以避免越过横线 |
| `header-column-gap` | 合法的 LaTeX 长度 | `1em` | 个人信息与照片栏之间的距离 |
| `header-name-gap` | 合法的 LaTeX 长度 | `0.35em` | 姓名与联系方式之间的距离 |
| `header-after-skip` | 合法的 LaTeX 长度 | `0.15em` | 整个头部之后的附加距离 |
| `section-before-skip` | 合法的 LaTeX 长度 | `1.05em` | 模块标题与上一段内容之间的距离 |
| `section-line-gap` | 合法的 LaTeX 长度 | `0.28em` | 模块标题与横线之间的间隔 |
| `section-after-skip` | 合法的 LaTeX 长度 | `0.42em` | 模块横线与正文之间的距离 |
| `section-line-width` | 合法的 LaTeX 长度 | `0.4pt` | 渐变或纯色模块横线的粗细 |
| `project-divider-before-skip` | 合法的 LaTeX 长度 | `0.35em` | 项目分隔线上方的留白 |
| `project-divider-after-skip` | 合法的 LaTeX 长度 | `0.35em` | 项目分隔线下方的留白 |
| `project-divider-width` | 合法的 LaTeX 长度 | `0.35pt` | 项目分隔线的粗细 |
| `banner-text-shift` | 合法的 LaTeX 长度 | `0.4ex` | Logo 公司栏中文字的垂直微调；正值向上，日期仍自然居中 |
| `banner-padding-y` | 合法的 LaTeX 长度 | `0.12em` | Logo 公司栏色块的上下内边距；外部留白不受影响 |
| `banner-date-width` | 合法的 LaTeX 长度 | `9.3em` | Logo 公司栏右侧时间列宽度；中间公司/岗位列自动使用剩余空间并换行 |

只填写需要调整的字号即可：

```tex
\resumesetup{
  name-size=24pt,
  section-size=15pt,
  body-size=9.5pt
}
```

增大正文字号后，内容可能自然延伸到下一页。

### 字体模式切换

```tex
% 现代技术型：现代中文无衬线 + 英文无衬线。
\resumesetup{font-mode=modern}

% 经典正式型：回到原来的中文宋体 + 英文衬线。
\resumesetup{font-mode=classic}
```

`modern` 首选微软雅黑；缺少该字体时依次尝试思源黑体、Noto Sans CJK、苹方、等线，最后才回退到 FandolHei。姓名默认与模块标题共同使用 SimHei、主题色和相同字重，仅字号独立；系统没有 SimHei 时两者都自动回退到现代字体链。`classic` 只把正文及联系方式恢复为宋体/衬线组合。

模块标题字体可以单独切换或传入任意已安装字体：

```tex
\resumesetup{section-font=simhei}              % v4 风格
\resumesetup{section-font=modern}              % 现代字体链
\resumesetup{section-font-name={Microsoft YaHei}} % 指定系统字体
```

### 自定义主题色

先用 xcolor 定义颜色，再交给 `\resumesetup`：

```tex
\definecolor{MyResumeColor}{RGB}{80,90,140}

\resumesetup{
  color=MyResumeColor,
  section-line=solid,
  entry-separator=bar
}
```

旧写法 `gradientline`、`solidline` 文档类选项和 `\setresumecolor{...}` 仍然兼容。

纯色线和渐变线都会按当前位置的 `\linewidth` 绘制；调整页面边距、分栏或在 `minipage` 中使用时，不需要手动填写横线长度。

## 内容命令

### 头部、联系方式与章节

```tex
\resumeheader[images/placeholder-id-photo-transparent.png][photo-trim={0 0 0 168bp}]{示例姓名}{%
  \resumecontact{\faPhone}{联系电话：138-0000-0000}
  \resumecontact{\faEnvelope}{邮箱：\resumelink{mailto:hello@example.com}{hello@example.com}}\\
  \resumecontact{\faGlobe}{个人主页：\resumelink{https://example.com}{https://example.com}}
  \\
  \resumecontact{\faGithub}{GitHub：\resumelink{https://github.com/your-name}{https://github.com/your-name}\hspace{0.35em}\resumehighlight[ResumeGold]{（\faStar\hspace{0.25em}100+ Star）}}
}

\resumesection{工作经历}
```

头部不设置固定高度，由姓名和联系方式的实际内容自然撑开。照片默认作为前景叠层从姓名顶部向下绘制，不参与纵向占位；首个 `\resumesection` 的横线会自动成为下边界，空间不足时照片按比例缩小并保留 `header-photo-line-gap`。照片路径省略后显示通用占位框，联系方式图标始终保持黑色。

照片文件若在人物上方自带透明或纯色空边，可用 `photo-trim={左 下 右 上}` 先裁掉空边，使“人物可见顶部”真正与姓名平齐。仓库占位图的上边是 `168bp`；换成已经紧边裁好的证件照后删除该参数即可。

短联系方式仍可在同一行排列；当单项自然宽度超过个人信息栏时，`\resumecontact` 会自动改用固定图标列和可换行文本列。邮箱及 URL 推荐用 `\resumelink{实际链接}{显示文字}`，避免长地址侵入照片栏。

第二个可选参数只作用于当前头部，可覆盖全局设置：

```tex
% 当前简历不显示照片，个人信息自动使用整行宽度。
\resumeheader[][photo=false,name-gap=0.4em,after-skip=0.2em]{姓名}{联系信息}

% 当前前景照片的尺寸、裁边和位置微调；正 x 向右，正 y 向上。
\resumeheader[images/avatar.png][
  photo-width=2.6cm,
  photo-max-height=3.1cm,
  photo-trim={0 0 0 8bp},
  photo-x-shift=-1mm,
  photo-y-shift=-0.5mm,
  column-gap=1.2em
]{姓名}{联系信息}

% 如需照片参与头部高度计算，可回退为原来的流式双栏布局。
\resumeheader[images/avatar.png][photo-layout=flow,photo-align=bottom]{姓名}{联系信息}
```

局部参数与全局参数的对应关系如下：

| 当前头部参数 | 对应全局参数 |
| --- | --- |
| `photo` | `header-photo` |
| `photo-layout` | `header-photo-layout` |
| `photo-align` | `header-photo-align` |
| `photo-width` | `header-photo-width` |
| `photo-max-height` | `header-photo-max-height` |
| `photo-trim` | `header-photo-trim` |
| `photo-line-gap` | `header-photo-line-gap` |
| `photo-x-shift` | `header-photo-x-shift` |
| `photo-y-shift` | `header-photo-y-shift` |
| `column-gap` | `header-column-gap` |
| `name-gap` | `header-name-gap` |
| `after-skip` | `header-after-skip` |

### 普通条目

```tex
\resumeentry{单位或项目}{岗位或副标题}{时间}
```

完整命令格式：

```tex
\resumeentry*[颜色][分隔符]{标题}{副标题}{时间}
```

- 星号表示取消加粗。
- `颜色` 默认是 `black`，也可填写 `ResumePrimary` 或任意已定义颜色。
- `分隔符` 支持 `dash`、`bar`；省略后跟随全局设置。
- 标题或副标题较长时会自动换行，时间保持右对齐。

示例：

```tex
\resumeentry[black][dash]{学校名称}{专业与学历}{2020.09 -- 2024.06}
\resumeentry[ResumePrimary][bar]{项目名称}{项目副标题}{2024.08 -- 2025.01}
\resumeentry*[black][bar]{轻量标题}{副标题}{时间}
```

### 带 Logo 的公司色块

```tex
\resumebanner[ResumeSky][images/logo-stellar-tech.png]
  {公司名称}{岗位名称}{2024.07 -- 至今}
```

第一个可选参数是色块颜色，第二个是 Logo 路径。Logo 路径留空时使用通用公司图标：

```tex
\resumebanner[ResumeOrange][]{公司名称}{岗位名称}{时间}
```

公司与岗位过长时会在中间列自动换行，右侧时间列保持固定并始终位于色块内；可通过 `banner-date-width` 调整时间栏宽度。

### 列表与重点结果

```tex
\begin{resumeitems}
  \item \textbf{工作内容：}负责流程设计并完成服务交付。
  \item \textbf{业务结果：}准确率达到 \resumehighlight{91\%}。
\end{resumeitems}
```

`\resumehighlight` 默认使用 `ResumeAccent`，也可选择内置金色或自定义颜色：

```tex
\resumehighlight{78\% 提升至 91\%}
\resumehighlight[ResumeGold]{2.4k stars}

\definecolor{MyHighlightColor}{RGB}{160,90,180}
\resumehighlight[MyHighlightColor]{自定义强调内容}
```

### 介绍内容中的行内序号

序号放在加粗小标题后的正文中，不需要额外手动添加空格：

```tex
\begin{resumedetails}
  \item \textbf{数据管线：}\resumecircled{1}第一项；\resumecircled{2}第二项。
  \item \textbf{检索优化：}\resumeparen{1}第一项；\resumeparen{2}第二项。
  \item \textbf{效果评测：}\resumerightparen{1}第一项；\resumerightparen{2}第二项。
  \item \textbf{稳定性设计：}不带序号的普通说明。
\end{resumedetails}
```

三个命令分别显示 `①②`、`（1）（2）` 和 `1）2）`。`\resumecircled` 已经包含圈号缩放、基线校正和尾部间距。

### 教育背景

```tex
\resumeentry[black]{学校名称}{专业名称 \quad 学历}{起止时间}
\begin{resumeitems}
  \item \textbf{GPA：}3.7/4.0（专业前 10\%）。
  \item \textbf{荣誉奖项：}奖学金、优秀毕业生。
  \item \textbf{主修课程：}数据结构、数据库系统、机器学习。
\end{resumeitems}
```

### 奖项与竞赛

```tex
\resumesection{奖项与竞赛}
\begin{resumeawards}
  \resumeaward{竞赛奖项}
  \resumeaward{奖学金或学术荣誉}
  \resumeaward{创新竞赛奖项}
  \resumeaward{建模竞赛奖项}
\end{resumeawards}
```

`resumeawards` 使用黑色奖杯图标，并自动排列为两栏。

## 风格预设

额外预设的源码和 PDF 位于 `examples/`，它们共用 `examples/example-content.tex`，只覆盖与风格相关的命令。

从项目根目录编译预设：

```bash
latexmk -xelatex -output-directory=examples examples/modern-colorblocks.tex
```

## 开源协议

本项目采用 [MIT License](LICENSE)。

Copyright (c) 2026 SimpleCNResume Contributors
