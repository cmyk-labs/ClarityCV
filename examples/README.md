# 独立排版示例

本目录提供三份完整的 ClarityCV 示例。根目录 `claritycv.tex` 直接使用 `claritycv.cls` 的默认风格；本目录示例继承这套默认值，只通过 `\resumesetup` 覆盖各自与默认风格不同的主题参数：

| 示例 | 条目样式 | 主题差异 |
| --- | --- | --- |
| `classic-clean.tex` | 普通条目、渐变细线 | 墨蓝主题与砖红强调；`8.6pt` 紧凑正文 |
| `modern-colorblocks.tex` | Logo 公司色块、较粗章节线 | 深青主题；蓝色与粉色 Logo 分别匹配同色系色块；`8.8pt` 正文 |
| `minimal-mono.tex` | 普通条目、极细章节线 | 黑灰单色主题 |

每个 `.tex` 都包含完整导言区、头部和正文，不依赖 `\input`、共享正文或 `\Example...` 包装命令。三个示例与根目录 `claritycv.tex` 使用同一套虚构文案及 `images/placeholder-id-photo-transparent.png` 虚构照片，文档类不会裁切图片透明区域。

示例正文同时展示：

```tex
\begin{itemize}
  \item 无编号列举
\end{itemize}

\begin{enumerate}
  \item 有编号列举
\end{enumerate}
```

从项目根目录单独编译任意示例：

```bash
latexmk -xelatex -output-directory=examples examples/classic-clean.tex
latexmk -xelatex -output-directory=examples examples/modern-colorblocks.tex
latexmk -xelatex -output-directory=examples examples/minimal-mono.tex
```
