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

All four examples use the same fictional copy and portrait. Public options change their colors, section rules, entry styles, and small density adjustments where needed to keep each showcase on one A4 page.

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
- The v4 typography defaults require Times New Roman, SimSun, and SimHei to be installed on the system.
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

On Overleaf, upload the complete project, choose **XeLaTeX**, and set `claritycv.tex` as the main document. Because Overleaf does not provide these Windows fonts by default, upload legally licensed font files or select an available font set in `claritycv.cls`.

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
| `\resumecontact[...]{Icon}{Content}` | Add one contact item with automatic wrapping |
| `\resumeentry[...]{Title}{Subtitle}{Start}{End}` | Render a plain or banner entry with a generated date range |

Everything else should use standard LaTeX wherever possible.

## Document-wide setup

The recommended appearance already lives in `claritycv.cls`. Call `\resumesetup` only for values you want to change:

```tex
\definecolor{MyTheme}{RGB}{35,82,112}
\resumesetup{
  page-top-margin=1.25cm,
  page-bottom-margin=1.25cm,
  color=MyTheme,
  font=modern,
  section-line=gradient,
  entry-separator=bar,
  entry-title-weight=bold,
  entry-subtitle-weight=bold,
  entry-date-weight=regular,
  entry-banner-tint=6,
  header-name-color=ResumePrimary,
  header-name-weight=inherit,
  header-photo-align=center,
  header-name-gap=0.78em,
  header-after-skip=0.98em,
  contact-icon-color=black,
  contact-text-color=black
}
```

Styles use three override levels: the class supplies polished defaults, `\resumesetup` changes the whole document, and keys in a command's optional argument affect that invocation only. Global keys use the `entry-`, `header-`, `contact-`, or `number-` prefix; local keys omit that prefix. The root `claritycv.tex` declares no duplicate global setup and directly demonstrates the class defaults; each example overrides only values that differ from that baseline.

| Key | Accepted values | Default |
| --- | --- | --- |
| `page-top-margin` | LaTeX length | `1.25cm` |
| `page-bottom-margin` | LaTeX length | `1.25cm` |
| `color` | Any defined color | `ResumeClassic` |
| `accent-color` | Any defined color | `ResumeAccent` (standard red) |
| `muted-color` | Any defined color | `ResumeMuted` |
| `divider-color` | Any defined color | `ResumeDivider` |
| `font` | `classic`, `modern` | `classic` |
| `section-font` | `simhei`, `modern` | `simhei` |
| `section-font-name` | Installed font name | not set |
| `section-line` | `solid`, `gradient` | `solid` |
| `section-size` | LaTeX length | `14bp` |
| `body-size` | LaTeX length | `9pt` |
| `section-weight` | `regular`, `bold` | `bold` |
| `entry-style` | `plain`, `banner` | `plain` |
| `entry-color` | Any defined color | `ResumePrimary` |
| `entry-separator` | `dash`, `bar` | `dash` |
| `entry-title-weight` | `regular`, `bold` | `bold` |
| `entry-subtitle-weight` | `regular`, `bold` | `bold` |
| `entry-date-weight` | `regular`, `bold` | `regular` |
| `entry-title-color` | `entry` or any defined color | `entry` |
| `entry-subtitle-color` | `entry` or any defined color | `entry` |
| `entry-date-color` | `entry` or any defined color | `ResumeMuted` |
| `entry-heading-size` | LaTeX length | `9.4pt` |
| `entry-divider` | `none`, `before`, `after` | `none` |
| `entry-date-width` | LaTeX length | `9.3em` |
| `entry-text-shift` | LaTeX length; banner only | `0.4ex` |
| `entry-padding-left` | LaTeX length; banner only | `0.72em` |
| `entry-padding-right` | LaTeX length; banner only | `0pt` |
| `entry-padding-y` | LaTeX length; banner only | `0.14em` |
| `entry-banner-tint` | Mix percentage from `0` to `100` | `6` |
| `entry-banner-border-width` | LaTeX length | `2.5pt` |
| `entry-banner-radius` | LaTeX length | `2pt` |
| `entry-before-skip` | Previous body to next entry heading | `0.65em` |
| `entry-after-skip` | Unified additional heading-to-body distance | `0.1em` |
| `header-name-size` | LaTeX length | `16bp` |
| `header-name-color` | Any defined color | `ResumePrimary` |
| `header-name-weight` | `inherit`, `regular`, `bold` | `inherit` |
| `header-layout` | `overlay`, `flow` | `overlay` |
| `header-photo-align` | `top`, `center`, `bottom` | `center` |
| `header-photo-width` | LaTeX length | `2.75cm` |
| `header-photo-max-height` | LaTeX length | `3.15cm` |
| `header-photo-line-gap` | LaTeX length | `0.18em` |
| `header-photo-x-shift` | LaTeX length | `0pt` |
| `header-photo-y-shift` | LaTeX length | `0pt` |
| `header-column-gap` | LaTeX length | `1em` |
| `header-name-gap` | LaTeX length | `0.78em` |
| `header-after-skip` | LaTeX length | `0.98em` |
| `contact-icon-color` | Any defined color | `black` |
| `contact-text-color` | Any defined color | `black` |
| `contact-icon-size` | LaTeX length | `10.5bp` |
| `contact-text-size` | LaTeX length | follows `body-size` |
| `contact-text-weight` | `regular`, `bold` | `regular` |
| `contact-icon-width` | LaTeX length | `1.25em` |
| `contact-icon-gap` | LaTeX length | `0.28em` |
| `contact-item-gap` | LaTeX length | `0.8em` |
| `number-color` | `inherit` or any defined color | `inherit` |
| `number-weight` | `inherit`, `regular`, `bold` | `bold` |
| `number-scale` | Positive scale factor | `1` |
| `section-before-skip` | LaTeX length | `0.2em` |
| `section-line-gap` | LaTeX length | `0.24em` |
| `section-after-skip` | LaTeX length | `0.55em` |
| `section-list-extra-skip` | LaTeX length | `3.5pt` |
| `section-line-width` | LaTeX length | `0.55pt` |

## Header and portrait

Name styling and header layout can be set globally with the `header-...` keys above or overridden for one header. The portrait path belongs to the current header only:

```tex
\resumeheader[
  photo={images/avatar.png},
  name-size=16bp,
  name-color=ResumePrimary,
  name-weight=inherit,
  photo-x-shift=-1mm,
  photo-y-shift=0.5mm
]{Your Name}{Contact information}
```

| Key | Accepted values | Default |
| --- | --- | --- |
| `name-size` | LaTeX length | `16bp` |
| `name-color` | Any defined color | `ResumePrimary` |
| `name-weight` | `inherit`, `regular`, `bold` | `inherit` |
| `photo` | Image path or `none` | no portrait |
| `layout` | `overlay`, `flow` | `overlay` |
| `align` | `top`, `center`, `bottom` | `center` |
| `photo-width` | LaTeX length | `2.75cm` |
| `photo-max-height` | LaTeX length | `3.15cm` |
| `photo-line-gap` | LaTeX length | `0.18em` |
| `photo-x-shift` | Negative left, positive right | `0pt` |
| `photo-y-shift` | Negative down, positive up | `0pt` |
| `column-gap` | LaTeX length | `1em` |
| `name-gap` | LaTeX length | `0.78em` |
| `after-skip` | LaTeX length | `0.98em` |

The portrait is scaled proportionally within the available height between the top of the identity block and the first section rule, then positioned by `align`; the default is centered. ClarityCV does not crop transparent or blank regions from the source image.

Omit `photo` or use `photo=none` for a text-only header:

```tex
\resumeheader{Your Name}{Contact information}
```

## Contact items

Contact items also support global and per-call overrides. This example changes only one icon and text style:

```tex
\resumecontact[
  icon-color=ResumePrimary,
  text-size=8.8pt,
  text-weight=bold
]{\faPhone}{Phone: 138-0000-0000}
```

| Key | Accepted values | Default |
| --- | --- | --- |
| `icon-color` | Any defined color | global `contact-icon-color` |
| `text-color` | Any defined color | global `contact-text-color` |
| `icon-size` | LaTeX length | global `contact-icon-size` |
| `text-size` | LaTeX length | global `contact-text-size` |
| `text-weight` | `regular`, `bold` | global `contact-text-weight` |
| `icon-width` | Icon column width when wrapping | global `contact-icon-width` |
| `icon-gap` | Space between icon and text | global `contact-icon-gap` |
| `item-gap` | Space between adjacent contact items | global `contact-item-gap` |

## Entries and date ranges

For a plain entry:

```tex
\resumeentry{Organization}{Role}{2023.07}{2025.03}
```

For example, an education entry can override only its title colors while leaving size, weight, dates, and spacing inherited:

```tex
\resumeentry[
  title-color=black,
  subtitle-color=black
]{Example University}{Computer Science}{2020.09}{2024.06}
```

For a branded banner:

```tex
\resumeentry[
  style=banner,
  color=ResumeSky,
  logo={images/logo-stellar-tech.png},
  separator=bar,
  title-weight=bold,
  subtitle-weight=bold,
  date-weight=regular,
  banner-tint=6
]{Company}{Position}{2024.07}{Present}
```

The final two arguments are always the start and end values. Do not type a separator or surrounding spaces; the class generates them consistently. Except for `logo`, each per-entry key below inherits its matching `entry-...` key from `\resumesetup`.

| Key | Accepted values | Default |
| --- | --- | --- |
| `style` | `plain`, `banner` | global `entry-style` |
| `color` | Any defined color | global `entry-color` |
| `logo` | Image path | none |
| `separator` | `dash`, `bar` | global `entry-separator` |
| `title-weight` | `regular`, `bold` | global `entry-title-weight` |
| `subtitle-weight` | `regular`, `bold` | global `entry-subtitle-weight` |
| `date-weight` | `regular`, `bold` | global `entry-date-weight` |
| `title-color` | `entry` or any defined color | global `entry-title-color` |
| `subtitle-color` | `entry` or any defined color | global `entry-subtitle-color` |
| `date-color` | `entry` or any defined color | global `entry-date-color` |
| `heading-size` | LaTeX length | global `entry-heading-size` |
| `divider` | `none`, `before`, `after` | global `entry-divider` |
| `date-width` | LaTeX length | global `entry-date-width` |
| `text-shift` | LaTeX length; banner only | global `entry-text-shift` |
| `padding-left` | LaTeX length; banner only | global `entry-padding-left` |
| `padding-right` | LaTeX length; banner only | global `entry-padding-right` |
| `padding-y` | LaTeX length; banner only | global `entry-padding-y` |
| `banner-tint` | Mix percentage from `0` to `100` | global `entry-banner-tint` |
| `banner-border-width` | LaTeX length | global `entry-banner-border-width` |
| `banner-radius` | LaTeX length | global `entry-banner-radius` |
| `before-skip` | Previous body to this entry heading | global `entry-before-skip` |
| `after-skip` | This entry heading to body, additional | global `entry-after-skip` |

The default keeps the v4 title relationship while improving scan hierarchy: the title and subtitle are both bold theme-colored `9.4pt`, the date is regular muted text, and body lead-ins remain bold black `9pt`. Adjust the three weights independently with `title-weight`, `subtitle-weight`, and `date-weight`.

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

Project steps can also use three Chinese-style number formats. Their default forms stay short and now share a stronger visual weight:

```tex
\begin{enumerate}
  \item Data pipeline: \cvC{1}ingest data; \cvC{2}clean data.
  \item Forecasting: \cvP{1}train models; \cvP{2}run rolling validation.
  \item Optimization: \cvR{1}define constraints; \cvR{2}solve the plan.
\end{enumerate}
```

The three commands output circled, full-parenthesized, and right-parenthesized numbers. Circled numbers support `1`--`10` and fall back to a regular circled form above that range.

The circled-number font has no separate bold face, so `number-weight=bold` applies a `1.06` optical scale to it while the two parenthesized forms use a real bold face. Set all inline numbers globally with:

```tex
\resumesetup{
  number-color=inherit,
  number-weight=bold,
  number-scale=1
}
```

Each number can override the same short keys without affecting its neighbors:

```tex
\cvC[color=ResumePrimary,weight=regular,scale=1.05]{1}
\cvP[weight=regular]{1}
\cvR[scale=1.08]{1}
```

| Local key | Accepted values | Default |
| --- | --- | --- |
| `color` | `inherit` or any defined color | global `number-color` |
| `weight` | `inherit`, `regular`, `bold` | global `number-weight` |
| `scale` | Positive scale factor | global `number-scale` |

The class supplies résumé-friendly spacing and theme-colored list markers while preserving normal nesting behavior.

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
