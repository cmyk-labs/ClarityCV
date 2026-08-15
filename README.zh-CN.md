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
      <strong>紫色轻量版</strong><br>
      <a href="examples/purple-light.pdf"><img src="previews/purple-light.png" alt="紫色轻量版预览" width="100%"></a><br>
      <a href="examples/purple-light.tex">源文件</a>
    </td>
  </tr>
  <tr>
    <td width="50%" align="center">
      <strong>黑灰极简版</strong><br>
      <a href="examples/minimal-mono.pdf"><img src="previews/minimal-mono.png" alt="黑灰极简版预览" width="100%"></a><br>
      <a href="examples/minimal-mono.tex">源文件</a>
    </td>
    <td width="50%"></td>
  </tr>
</table>

## 特点

- 中文开箱即用，使用 XeLaTeX 编译。
- 简历内容与排版定义分离。
- 可统一配置主题色、章节线、条目分隔符和字号。
- 普通条目与带 Logo 的公司色块可自由选择。
- 较长标题自动换行，时间仍保持右对齐。
- 支持多页内容，并尽量避免章节标题和下一行内容被拆开。
- 联系方式和奖项图标统一为黑色，减少无关的视觉强调。
- 附带证件照与 Logo 占位素材。
- 提供四套额外排版预设及编译后预览。

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

在 `resume.tex` 导言区使用 `\resumesetup`。所有配置项都是可选的，省略时使用默认值。

```tex
\documentclass{simplecnresume}

\resumesetup{
  color=ResumeClassic,
  section-line=solid,
  entry-separator=bar
}
```

| 配置项 | 可选值 | 默认值 | 作用范围 |
| --- | --- | --- | --- |
| `color` | `ResumeClassic`、`ResumeModern` 或已经定义的颜色名 | `ResumeClassic` | 姓名、章节标题、章节线、列表圆点、序号及主题色条目 |
| `section-line` | `gradient`、`solid` | `gradient` | 章节标题下方的渐变线或纯色线 |
| `entry-separator` | `dash`、`bar` | `dash` | 条目标题与副标题之间的短横杠或竖线 |
| `name-size` | 合法的 LaTeX 长度 | `22bp` | 姓名字号，默认效果等同于 `\zihao{2}` |
| `section-size` | 合法的 LaTeX 长度 | `14bp` | 模块标题字号，默认效果等同于 `\zihao{4}` |
| `body-size` | 合法的 LaTeX 长度 | `9pt` | 正文字号，正文行距自动随之缩放 |

只填写需要调整的字号即可：

```tex
\resumesetup{
  name-size=24pt,
  section-size=15pt,
  body-size=9.5pt
}
```

增大正文字号后，内容可能自然延伸到下一页。

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

## 内容命令

### 头部、联系方式与章节

```tex
\resumeheader[images/avatar.png]{姓名}{%
  \resumecontact{\faPhone}{联系电话：138-0000-0000}
  \resumecontact{\faEnvelope}{邮箱：hello@example.com}\\
  \resumecontact{\faGlobe}{个人主页：https://example.com}
}

\resumesection{工作经历}
```

照片路径可以省略；省略后显示通用照片占位框。联系方式图标不跟随主题色，始终保持黑色。

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

Copyright (c) 2026 CMYK Labs (cmyk-labs)
