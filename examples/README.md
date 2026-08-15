# 差异化排版示例

本目录提供 4 个差异明显的 `SimpleCNResume-LaTeX-Template` 风格预设。前两个构成主要对照，另外两个补充展示自定义颜色、可选字重与黑灰极简风格。

证件照及 Logo 均引用项目根目录下的 `images/` 素材。每份示例内部的两段工作经历保持同一种公司栏风格。

| 风格 | 公司栏 | 项目标题 | 章节与强调 | PDF | 源文件 |
| --- | --- | --- | --- | --- | --- |
| 经典简洁 | 黑色普通行 | 黑色、加粗、横杠 | 经典蓝渐变线、暗红结果 | [预览](classic-clean.pdf) | [TeX](classic-clean.tex) |
| 现代色块 | 双 Logo 品牌色块 | 现代蓝、加粗、竖线 | 现代蓝实线、金色结果 | [预览](modern-colorblocks.pdf) | [TeX](modern-colorblocks.tex) |
| 紫色轻量 | 紫色普通行 | 紫色、不加粗、竖线 | 紫色渐变线、金色结果 | [预览](purple-light.pdf) | [TeX](purple-light.tex) |
| 黑灰极简 | 黑色普通行 | 黑色、不加粗、竖线 | 黑灰实线、黑色结果 | [预览](minimal-mono.pdf) | [TeX](minimal-mono.tex) |

所有示例共用 [example-content.tex](example-content.tex) 中的虚构正文。各主文件只负责定义风格组件，因此可以直接复制其中的配置和命令覆盖方式。

## 重新编译

请在项目根目录执行，例如：

```bash
latexmk -xelatex -output-directory=examples examples/modern-colorblocks.tex
```
