<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="logo/claritycv-logo-dark.svg">
    <img src="logo/claritycv-logo.svg" alt="ClarityCV" width="440">
  </picture>
</p>

<p align="center"><strong>Clear structure. Focused content. Native Chinese typesetting.</strong></p>

<p align="center">
  <a href="README.md">English</a> · <a href="README.zh-CN.md">简体中文</a>
  <br>
  <img src="https://img.shields.io/badge/engine-XeLaTeX-008080?logo=latex" alt="XeLaTeX">
  <img src="https://img.shields.io/badge/interface-4%20commands-E16F4F" alt="Four template commands">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-153B55" alt="MIT License"></a>
</p>

## What is ClarityCV?

ClarityCV is a lightweight LaTeX résumé class designed for Chinese-language job applications. It centralizes typography, spacing, color, and layout rules in `claritycv.cls`, so users can focus on content instead of repeatedly adjusting complex formatting code.

Résumé content favors standard LaTeX commands such as `\section`, `itemize`, `enumerate`, `\href`, and `\textbf`, with a small specialized interface only for headers, contacts, and experience entries.

## Highlights

- **A deliberately small interface:** Only four template-specific commands cover global setup, headers, contacts, and experience entries; ordinary content stays in standard LaTeX.
- **Chinese typesetting out of the box:** Built on `ctexart` and XeLaTeX, with defaults for fonts, sizes, line spacing, section rhythm, and page layout tuned for Chinese technical résumés.
- **Content separated from presentation:** Recommended visual defaults live in `claritycv.cls`; users mainly maintain résumé content and add options only when changing the design.
- **Standard LaTeX behavior preserved:** `\section`, `itemize`, `enumerate`, `\href`, and `\textbf` work normally, without redefining bold text or applying synthetic bolding.
- **Flexible without unnecessary complexity:** One `\resumeentry` command supports plain rows, colored banners, logos, separators, and font weights, while the class formats separate start and end dates consistently.
- **An adjustable résumé header:** The portrait is optional and supports overlay or flow layouts, sizing, alignment, and horizontal or vertical positioning.
- **Complete standalone style examples:** The recommended default, modern color blocks, classic clean, and minimal monochrome examples share the same base typography and spacing, and each compiles independently.

## Preview

All four examples use the same fictional copy, portrait, and base typography. Only public options change their colors, section rules, and entry styles, making the themes easy to compare.

Click a preview to open its PDF, or select **Source** to inspect the corresponding standalone `.tex` document.

<table>
  <tr>
    <td width="50%" align="center">
      <strong>Recommended default</strong><br>
      <a href="claritycv.pdf"><img src="previews/default-resume.png" alt="Recommended default résumé" width="100%"></a><br>
      <a href="claritycv.tex">Source</a> · <a href="claritycv.pdf">PDF</a>
    </td>
    <td width="50%" align="center">
      <strong>Modern color blocks</strong><br>
      <a href="examples/modern-colorblocks.pdf"><img src="previews/modern-colorblocks.png" alt="Modern color blocks résumé" width="100%"></a><br>
      <a href="examples/modern-colorblocks.tex">Source</a> · <a href="examples/modern-colorblocks.pdf">PDF</a>
    </td>
  </tr>
  <tr>
    <td width="50%" align="center">
      <strong>Classic clean</strong><br>
      <a href="examples/classic-clean.pdf"><img src="previews/classic-clean.png" alt="Classic clean résumé" width="100%"></a><br>
      <a href="examples/classic-clean.tex">Source</a> · <a href="examples/classic-clean.pdf">PDF</a>
    </td>
    <td width="50%" align="center">
      <strong>Minimal monochrome</strong><br>
      <a href="examples/minimal-mono.pdf"><img src="previews/minimal-mono.png" alt="Minimal monochrome résumé" width="100%"></a><br>
      <a href="examples/minimal-mono.tex">Source</a> · <a href="examples/minimal-mono.pdf">PDF</a>
    </td>
  </tr>
</table>

## Quick start

### Requirements

- TeX Live 2022 or later, or a recent MiKTeX release.
- XeLaTeX as the compiler.
- The complete project directory, including the class, fonts, and images.

### Compile

Edit `claritycv.tex`, then run from the project root:

```bash
latexmk -xelatex claritycv.tex
```

Without `latexmk`, run XeLaTeX twice:

```bash
xelatex claritycv.tex
xelatex claritycv.tex
```

On Overleaf, upload the complete project, choose **XeLaTeX**, and set `claritycv.tex` as the main document.

## Minimal example

```tex
\documentclass{claritycv}

\begin{document}

\resumeheader{Your Name}{%
  \resumecontact{\faPhone}{Phone: 138-0000-0000}
  \resumecontact{\faEnvelope}{Email: \href{mailto:hello@example.com}{hello@example.com}}
}

\section{Education}
\resumeentry{Example University}{Computer Science}{2021.09}{2025.06}

\section{Projects}
\begin{itemize}
  \item \textbf{Project:} Designed and delivered a complete data workflow.
\end{itemize}

\end{document}
```

## Core interface

Only four template-specific commands are required:

| Command | Purpose |
| --- | --- |
| `\resumesetup{...}` | Override document-wide visual defaults |
| `\resumeheader[...]{Name}{Contacts}` | Render the name, contact area, and optional portrait |
| `\resumecontact{Icon}{Content}` | Add one contact item with automatic wrapping |
| `\resumeentry[...]{Title}{Subtitle}{Start}{End}` | Render a plain or banner entry with a generated date range |

Everything else should use standard LaTeX wherever possible.

## Document-wide setup

The recommended appearance already lives in `claritycv.cls`. Call `\resumesetup` only for values you want to change:

```tex
\definecolor{MyTheme}{RGB}{35,82,112}
\resumesetup{
  color=MyTheme,
  font=modern,
  section-line=gradient,
  entry-separator=bar
}
```

| Key | Accepted values | Default |
| --- | --- | --- |
| `color` | Any defined color | `ResumeClassic` |
| `font` | `classic`, `modern` | `classic` |
| `section-font` | `simhei`, `modern` | `simhei` |
| `section-font-name` | Installed font name | not set |
| `section-line` | `solid`, `gradient` | `solid` |
| `section-size` | LaTeX length | `12.4bp` |
| `body-size` | LaTeX length | `9.2pt` |
| `name-weight` | `inherit`, `regular`, `bold` | `inherit` |
| `section-weight` | `regular`, `bold` | `bold` |
| `entry-style` | `plain`, `banner` | `plain` |
| `entry-color` | Any defined color | `black` |
| `entry-separator` | `dash`, `bar` | `dash` |
| `entry-weight` | `regular`, `bold` | `bold` |
| `section-before-skip` | LaTeX length | `0.85em` |
| `section-line-gap` | LaTeX length | `0.24em` |
| `section-after-skip` | LaTeX length | `0.38em` |
| `section-line-width` | LaTeX length | `0.55pt` |

## Header and portrait

The name size belongs to `\resumeheader`, not the document-wide style:

```tex
\resumeheader[
  photo={images/avatar.png},
  name-size=16bp,
  photo-x-shift=-1mm,
  photo-y-shift=0.5mm
]{Your Name}{Contact information}
```

| Key | Accepted values | Default |
| --- | --- | --- |
| `name-size` | LaTeX length | `14.8bp` |
| `photo` | Image path or `none` | no portrait |
| `layout` | `overlay`, `flow` | `overlay` |
| `align` | `top`, `center`, `bottom` | `bottom` |
| `photo-width` | LaTeX length | `2.75cm` |
| `photo-max-height` | LaTeX length | `3.15cm` |
| `photo-line-gap` | LaTeX length | `0.18em` |
| `photo-x-shift` | Negative left, positive right | `0pt` |
| `photo-y-shift` | Negative down, positive up | `0pt` |
| `column-gap` | LaTeX length | `1em` |
| `name-gap` | LaTeX length | `0.35em` |
| `after-skip` | LaTeX length | `0.15em` |

The image is scaled proportionally within its maximum width and height. ClarityCV does not crop transparent or blank regions from the source image.

Omit `photo` or use `photo=none` for a text-only header:

```tex
\resumeheader{Your Name}{Contact information}
```

## Entries and date ranges

For a plain entry:

```tex
\resumeentry{Organization}{Role}{2023.07}{2025.03}
```

For a branded banner:

```tex
\resumeentry[
  style=banner,
  color=ResumeSky,
  logo={images/logo-stellar-tech.png},
  separator=bar,
  weight=bold
]{Company}{Position}{2024.07}{Present}
```

The final two arguments are always the start and end values. Do not type `--` or surrounding spaces; the class generates them consistently.

| Key | Accepted values | Default |
| --- | --- | --- |
| `style` | `plain`, `banner` | global `entry-style` |
| `color` | Any defined color | global `entry-color` |
| `logo` | Image path | none |
| `separator` | `dash`, `bar` | global `entry-separator` |
| `weight` | `regular`, `bold` | global `entry-weight` |
| `divider` | `none`, `before`, `after` | `none` |
| `date-width` | LaTeX length | `9.3em` |
| `text-shift` | LaTeX length; banner only | `0.4ex` |
| `padding-y` | LaTeX length; banner only | `0.14em` |

Use `weight=regular` when one entry should not be bold.

## Standard LaTeX content

Use `itemize` for unnumbered points:

```tex
\begin{itemize}
  \item First point
  \item Second point
\end{itemize}
```

Use `enumerate` for numbered steps:

```tex
\begin{enumerate}
  \item First step
  \item Second step
\end{enumerate}
```

The class supplies résumé-friendly spacing and theme-colored markers while preserving normal nesting behavior.

Links and emphasis also use standard commands:

```tex
\href{https://example.com}{Display text}
\url{https://example.com}
\textcolor{ResumeAccent}{\textbf{Highlighted result}}
```

ClarityCV does not redefine `\textbf` or apply fake bolding. It uses the normal Bold face provided by the active font family.

## Project structure

```text
.
├─ claritycv.tex            Recommended complete example
├─ claritycv.cls            ClarityCV document class
├─ claritycv.pdf            Compiled recommended example
├─ examples/                Three independent style examples and PDFs
├─ previews/                PNG previews used by this README
├─ images/                  Fictional portrait and example company logos
├─ logo/                    ClarityCV brand assets
├─ fonts/                   Bundled Latin and icon fonts
├─ README.md                English documentation
├─ README.zh-CN.md          Simplified Chinese documentation
└─ LICENSE                  MIT License
```

Compile an additional example from the project root with:

```bash
latexmk -xelatex -outdir=examples examples/modern-colorblocks.tex
```

## Acknowledgements

The documentation presentation takes inspiration from the clear project-first structure used by [Awesome-CV](https://github.com/posquit0/Awesome-CV). ClarityCV's class implementation, examples, and logo assets are maintained independently.

## License

ClarityCV is released under the [MIT License](LICENSE).
