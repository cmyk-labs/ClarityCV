<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="logo/claritycv-logo-dark.svg">
    <img src="logo/claritycv-logo.svg" alt="ClarityCV" width="440">
  </picture>
</p>

<p align="center"><strong>结构清晰，内容聚焦，为中文简历而设计。</strong></p>

<p align="center">
  <a href="README.md">English</a> · <a href="README.zh-CN.md">简体中文</a>
  <br>
  <img src="https://img.shields.io/badge/engine-XeLaTeX-008080?logo=latex" alt="XeLaTeX">
  <img src="https://img.shields.io/badge/interface-4%20commands-E16F4F" alt="四个模板命令">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-153B55" alt="MIT License"></a>
</p>

## ClarityCV 是什么？

ClarityCV 是一款面向中文求职场景的轻量级 LaTeX 简历文档类。它将字体、间距、颜色和版面规则集中封装在 `claritycv.cls` 中，让用户专注于简历内容，而不必反复调整复杂的排版代码。

正文优先使用 `\section`、`itemize`、`enumerate`、`\href` 和 `\textbf` 等标准 LaTeX 命令，只在简历头部、联系方式和经历条目等特定场景提供少量专用接口。

## 项目亮点

- **简洁而克制的接口**：只提供全局设置、简历头部、联系方式和经历条目四个模板命令，其余内容尽量使用标准 LaTeX 写法。
- **开箱即用的中文排版**：基于 `ctexart` 与 XeLaTeX，默认字体、字号、行距、章节间距和页面布局已针对中文技术简历调校。
- **内容与样式分离**：推荐排版参数集中在 `claritycv.cls` 中，用户主要维护简历内容，只有需要改变视觉效果时才填写可选参数。
- **尊重标准 LaTeX 行为**：直接支持 `\section`、`itemize`、`enumerate`、`\href` 和 `\textbf`，不重定义标准加粗命令，也不叠加伪粗效果。
- **灵活但不过度复杂**：同一个 `\resumeentry` 可切换普通条目、彩色色块、Logo、分隔符和字重；开始与结束时间分开填写，格式由文档类统一生成。
- **可调节的简历头部**：照片完全可选，支持叠放或正常分栏，并可通过参数控制尺寸、对齐方式及上下左右位置。
- **完整独立的风格示例**：提供推荐默认版、现代色块版、经典简洁版和黑灰极简版；四份文档使用一致的基础字体和间距，每个示例均可独立编译。

## 排版预览

四套示例使用同一套虚构文案、照片和基础排版，只通过公开参数改变颜色、章节线和条目样式，便于直观比较不同主题。

点击预览图可打开 PDF，点击“源文件”可查看对应的独立 `.tex` 文档。

<table>
  <tr>
    <td width="50%" align="center">
      <strong>推荐默认版</strong><br>
      <a href="claritycv.pdf"><img src="previews/default-resume.png" alt="推荐默认版简历" width="100%"></a><br>
      <a href="claritycv.tex">源文件</a> · <a href="claritycv.pdf">PDF</a>
    </td>
    <td width="50%" align="center">
      <strong>现代色块版</strong><br>
      <a href="examples/modern-colorblocks.pdf"><img src="previews/modern-colorblocks.png" alt="现代色块版简历" width="100%"></a><br>
      <a href="examples/modern-colorblocks.tex">源文件</a> · <a href="examples/modern-colorblocks.pdf">PDF</a>
    </td>
  </tr>
  <tr>
    <td width="50%" align="center">
      <strong>经典简洁版</strong><br>
      <a href="examples/classic-clean.pdf"><img src="previews/classic-clean.png" alt="经典简洁版简历" width="100%"></a><br>
      <a href="examples/classic-clean.tex">源文件</a> · <a href="examples/classic-clean.pdf">PDF</a>
    </td>
    <td width="50%" align="center">
      <strong>黑灰极简版</strong><br>
      <a href="examples/minimal-mono.pdf"><img src="previews/minimal-mono.png" alt="黑灰极简版简历" width="100%"></a><br>
      <a href="examples/minimal-mono.tex">源文件</a> · <a href="examples/minimal-mono.pdf">PDF</a>
    </td>
  </tr>
</table>

## 快速开始

### 环境要求

- TeX Live 2022 或更新版本，或者较新的 MiKTeX。
- 使用 XeLaTeX 编译。
- 保留完整项目目录，包括文档类、字体与图片资源。

### 编译

修改 `claritycv.tex` 后，在项目根目录执行：

```bash
latexmk -xelatex claritycv.tex
```

没有 `latexmk` 时，连续执行两次 XeLaTeX：

```bash
xelatex claritycv.tex
xelatex claritycv.tex
```

在 Overleaf 中，请上传完整项目、选择 **XeLaTeX**，并将 `claritycv.tex` 设为主文档。

## 最小示例

```tex
\documentclass{claritycv}

\begin{document}

\resumeheader{姓名}{%
  \resumecontact{\faPhone}{联系电话：138-0000-0000}
  \resumecontact{\faEnvelope}{邮箱：\href{mailto:hello@example.com}{hello@example.com}}
}

\section{教育经历}
\resumeentry{示例大学}{计算机科学与技术}{2021.09}{2025.06}

\section{项目经历}
\begin{itemize}
  \item \textbf{项目内容：}设计并交付一套完整的数据处理流程。
\end{itemize}

\end{document}
```

## 核心接口

只需要使用四个模板专用命令：

| 命令 | 作用 |
| --- | --- |
| `\resumesetup{...}` | 覆盖整份文档的视觉默认值 |
| `\resumeheader[...]{姓名}{联系方式}` | 排版姓名、联系方式和可选照片 |
| `\resumecontact{图标}{内容}` | 添加一项可自动换行的联系方式 |
| `\resumeentry[...]{标题}{副标题}{开始}{结束}` | 排版普通或色块条目，并自动生成时间范围 |

除此之外的内容尽量直接使用标准 LaTeX 命令。

## 全局排版设置

推荐效果的默认值已经放在 `claritycv.cls` 中。只有需要改变效果时才调用 `\resumesetup`：

```tex
\definecolor{MyTheme}{RGB}{35,82,112}
\resumesetup{
  color=MyTheme,
  font=modern,
  section-line=gradient,
  entry-separator=bar
}
```

| 参数 | 可选值或格式 | 默认值 |
| --- | --- | --- |
| `color` | 已定义的颜色名 | `ResumeClassic` |
| `font` | `classic`、`modern` | `classic` |
| `section-font` | `simhei`、`modern` | `simhei` |
| `section-font-name` | 已安装字体名称 | 不设置 |
| `section-line` | `solid`、`gradient` | `solid` |
| `section-size` | LaTeX 长度 | `12.4bp` |
| `body-size` | LaTeX 长度 | `9.2pt` |
| `name-weight` | `inherit`、`regular`、`bold` | `inherit` |
| `section-weight` | `regular`、`bold` | `bold` |
| `entry-style` | `plain`、`banner` | `plain` |
| `entry-color` | 已定义的颜色名 | `black` |
| `entry-separator` | `dash`、`bar` | `dash` |
| `entry-weight` | `regular`、`bold` | `bold` |
| `section-before-skip` | LaTeX 长度 | `0.85em` |
| `section-line-gap` | LaTeX 长度 | `0.24em` |
| `section-after-skip` | LaTeX 长度 | `0.38em` |
| `section-line-width` | LaTeX 长度 | `0.55pt` |

## 头部与照片

姓名字号属于 `\resumeheader`，不是全局排版参数：

```tex
\resumeheader[
  photo={images/avatar.png},
  name-size=16bp,
  photo-x-shift=-1mm,
  photo-y-shift=0.5mm
]{姓名}{联系方式}
```

| 参数 | 可选值或格式 | 默认值 |
| --- | --- | --- |
| `name-size` | LaTeX 长度 | `14.8bp` |
| `photo` | 图片路径或 `none` | 不显示照片 |
| `layout` | `overlay`、`flow` | `overlay` |
| `align` | `top`、`center`、`bottom` | `bottom` |
| `photo-width` | LaTeX 长度 | `2.75cm` |
| `photo-max-height` | LaTeX 长度 | `3.15cm` |
| `photo-line-gap` | LaTeX 长度 | `0.18em` |
| `photo-x-shift` | 负值向左，正值向右 | `0pt` |
| `photo-y-shift` | 负值向下，正值向上 | `0pt` |
| `column-gap` | LaTeX 长度 | `1em` |
| `name-gap` | LaTeX 长度 | `0.35em` |
| `after-skip` | LaTeX 长度 | `0.15em` |

照片只在最大宽高范围内按比例缩放。ClarityCV 不会裁切图片中的透明区域或空白区域。

省略 `photo` 或使用 `photo=none` 即可得到纯文字头部：

```tex
\resumeheader{姓名}{联系方式}
```

## 条目与时间范围

普通条目：

```tex
\resumeentry{单位名称}{岗位名称}{2023.07}{2025.03}
```

带 Logo 的色块条目：

```tex
\resumeentry[
  style=banner,
  color=ResumeSky,
  logo={images/logo-stellar-tech.png},
  separator=bar,
  weight=bold
]{公司名称}{岗位名称}{2024.07}{至今}
```

最后两个参数始终分别填写开始时间和结束时间。不要手写 `--` 或两侧空格，文档类会统一生成。

| 参数 | 可选值或格式 | 默认值 |
| --- | --- | --- |
| `style` | `plain`、`banner` | 继承全局 `entry-style` |
| `color` | 已定义的颜色名 | 继承全局 `entry-color` |
| `logo` | 图片路径 | 无 |
| `separator` | `dash`、`bar` | 继承全局 `entry-separator` |
| `weight` | `regular`、`bold` | 继承全局 `entry-weight` |
| `divider` | `none`、`before`、`after` | `none` |
| `date-width` | LaTeX 长度 | `9.3em` |
| `text-shift` | LaTeX 长度，仅影响色块 | `0.4ex` |
| `padding-y` | LaTeX 长度，仅影响色块 | `0.14em` |

单独取消某个条目的加粗效果，可以使用 `weight=regular`。

## 标准 LaTeX 内容

无编号内容使用 `itemize`：

```tex
\begin{itemize}
  \item 第一项
  \item 第二项
\end{itemize}
```

有编号内容使用 `enumerate`：

```tex
\begin{enumerate}
  \item 第一步
  \item 第二步
\end{enumerate}
```

文档类只为两种环境提供适合简历的间距、缩进和主题色标记，标准嵌套行为保持不变。

链接与强调同样使用标准命令：

```tex
\href{https://example.com}{显示文字}
\url{https://example.com}
\textcolor{ResumeAccent}{\textbf{重点结果}}
```

ClarityCV 不会重定义 `\textbf`，也不会叠加伪粗效果；它直接使用当前字体族提供的正常 Bold 字形。

## 项目结构

```text
.
├─ claritycv.tex            推荐的完整示例
├─ claritycv.cls            ClarityCV 文档类
├─ claritycv.pdf            推荐示例的编译结果
├─ examples/                三套独立风格示例及 PDF
├─ previews/                README 使用的 PNG 预览图
├─ images/                  虚构照片与示例公司 Logo
├─ logo/                    ClarityCV 品牌资源
├─ fonts/                   内置英文字体与图标字体
├─ README.md                英文说明
├─ README.zh-CN.md          简体中文说明
└─ LICENSE                  MIT License
```

在项目根目录编译其他示例：

```bash
latexmk -xelatex -outdir=examples examples/modern-colorblocks.tex
```

## 致谢

文档展示方式参考了 [Awesome-CV](https://github.com/posquit0/Awesome-CV) 清晰的“项目介绍—预览—快速开始—使用说明”结构。ClarityCV 的文档类实现、示例和 Logo 资源均独立维护。

## 开源协议

ClarityCV 采用 [MIT License](LICENSE)。
