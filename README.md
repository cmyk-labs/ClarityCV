# SimpleCNResume-LaTeX-Template

<p>
  <a href="README.md"><img src="https://img.shields.io/badge/English-current-0B5394" alt="English"></a>
  <a href="README.zh-CN.md"><img src="https://img.shields.io/badge/简体中文-switch-555555" alt="简体中文"></a>
</p>

A clean, configurable, general-purpose LaTeX template for Chinese résumés. Resume content stays in `resume.tex`, while typography, spacing, colors, and reusable components live in `simplecnresume.cls`.

## Preview gallery

Click a preview to open its PDF. Each preset uses the same content structure so the layout differences are easy to compare.

<table>
  <tr>
    <td width="50%" align="center">
      <strong>Recommended default</strong><br>
      <a href="resume.pdf"><img src="previews/default-resume.png" alt="Recommended default résumé preview" width="100%"></a><br>
      <a href="resume.tex">Source</a>
    </td>
    <td width="50%" align="center">
      <strong>Modern color blocks</strong><br>
      <a href="examples/modern-colorblocks.pdf"><img src="previews/modern-colorblocks.png" alt="Modern color blocks preview" width="100%"></a><br>
      <a href="examples/modern-colorblocks.tex">Source</a>
    </td>
  </tr>
  <tr>
    <td width="50%" align="center">
      <strong>Classic clean</strong><br>
      <a href="examples/classic-clean.pdf"><img src="previews/classic-clean.png" alt="Classic clean preview" width="100%"></a><br>
      <a href="examples/classic-clean.tex">Source</a>
    </td>
    <td width="50%" align="center">
      <strong>Minimal monochrome</strong><br>
      <a href="examples/minimal-mono.pdf"><img src="previews/minimal-mono.png" alt="Minimal monochrome preview" width="100%"></a><br>
      <a href="examples/minimal-mono.tex">Source</a>
    </td>
  </tr>
</table>

## Features

- Ready for Chinese content and compiled with XeLaTeX.
- Resume content and visual definitions are separated.
- Global controls for modern sans or classic serif typography, color, section rules, entry separators, font sizes, and layout spacing.
- An adaptive foreground portrait aligned with the name, excluded from content height, and constrained above the first section rule; it can also be hidden, shifted, or switched back to flow layout.
- Plain entries and optional logo-based company banners.
- Automatic wrapping for long titles while dates remain right-aligned.
- Multi-page support with basic orphan prevention around sections and entries.
- Black contact and award icons for restrained visual emphasis.
- Included placeholder portrait and logo assets.
- Three additional layout presets with compiled previews.

## Requirements

- TeX Live 2022 or later, or a recent MiKTeX release.
- XeLaTeX as the compiler.
- A complete LaTeX installation. The required English text font is included under `fonts/`.

## Quick start

Clone or download the whole project, then compile from the project root:

```bash
latexmk -xelatex resume.tex
```

Without `latexmk`, run XeLaTeX twice:

```bash
xelatex resume.tex
xelatex resume.tex
```

For Overleaf, upload the entire project, select XeLaTeX, and set `resume.tex` as the main document.

## Project structure

```text
.
├─ resume.tex              # Resume content and user-facing configuration
├─ simplecnresume.cls      # Layout definitions and reusable commands
├─ fontawesome.sty         # Local icon compatibility package
├─ fonts/                  # Bundled font files
├─ images/                 # Portrait and logo assets
├─ previews/               # PNG previews rendered from every PDF
├─ examples/               # Additional presets, source files, and PDFs
├─ LICENSE                 # MIT License
├─ README.md               # English documentation
├─ README.zh-CN.md         # Simplified Chinese documentation
└─ resume.pdf              # Compiled recommended default
```

## Global configuration

The recommended style now lives in `simplecnresume.cls`, so using the class directly inherits every default. Add `\resumesetup` to the `resume.tex` preamble only when overriding selected keys.

```tex
\documentclass{simplecnresume}

% Specify overrides only; omitted keys continue to inherit class defaults.
\resumesetup{
  font-mode=modern,
  color=ResumeModern
}
```

| Key | Accepted values | Default | Effect |
| --- | --- | --- | --- |
| `color` | `ResumeClassic`, `ResumeModern`, or a defined color name | `ResumeClassic` | Name, section titles, rules, bullets, number markers, and theme-colored entries |
| `font-mode` | `modern` or `classic` | `classic` | `classic` uses FandolSong + TeX Gyre Termes body text; `modern` auto-selects a modern CJK sans font with TeX Gyre Heros |
| `section-line` | `gradient` or `solid` | `solid` | Gradient or solid rule below each section title |
| `entry-separator` | `dash` or `bar` | `bar` | Separator between an entry title and subtitle |
| `name-size` | Any valid LaTeX length | `14bp` | Name size; slightly larger than the `12.5bp` section-title default |
| `section-size` | Any valid LaTeX length | `12.5bp` | Section title size; about 1.34 times the 9.3pt body default |
| `body-size` | Any valid LaTeX length | `9.3pt` | Body size; line spacing scales automatically |
| `name-weight` | `inherit`, `regular`, or `bold` | `inherit` | The name inherits the section-title weight by default and can be overridden |
| `name-bold` | `true` or `false` | unset | Compatibility Boolean override for the name weight |
| `section-font` | `simhei` or `modern` | `simhei` | Section-title font; `simhei` matches v4, while `modern` uses the modern CJK fallback chain |
| `section-font-name` | An installed font name | none | Overrides section titles with any installed system font, such as `{Microsoft YaHei}` |
| `section-weight` | `regular` or `bold` | `bold` | Section-title weight; SimHei uses a light 1.3 synthetic bold by default |
| `section-bold` | `true` or `false` | `true` | Whether every `\resumesection` title is bold; Boolean alias for `section-weight` |
| `header-photo` | `true` or `false` | `true` | Globally shows or hides the portrait column |
| `header-photo-layout` | `overlay` or `flow` | `overlay` | Draws the portrait in the foreground without adding vertical height; `flow` restores a two-column layout |
| `header-photo-align` | `top`, `center`, or `bottom` | `bottom` | Vertical alignment relative to personal information in `flow` layout only |
| `header-photo-width` | Any valid LaTeX length | `2.8cm` | Maximum portrait width and portrait-column width |
| `header-photo-max-height` | Any valid LaTeX length | `3.2cm` | Maximum portrait height; the original aspect ratio is preserved |
| `header-photo-trim` | Four lengths: `left bottom right top` | `0 0 0 0` | Crops transparent or blank borders built into the image file |
| `header-photo-line-gap` | Any valid LaTeX length | `0.18em` | Minimum gap between the foreground portrait and the first section rule |
| `header-photo-x-shift` | Any valid LaTeX length | `0pt` | Manual horizontal adjustment; positive moves right, negative moves left |
| `header-photo-y-shift` | Any valid LaTeX length | `0pt` | Manual vertical adjustment; positive moves up, negative moves down while boundary scaling remains active |
| `header-column-gap` | Any valid LaTeX length | `1em` | Space between personal information and the portrait column |
| `header-name-gap` | Any valid LaTeX length | `0.35em` | Space between the name and contact details |
| `header-after-skip` | Any valid LaTeX length | `0.15em` | Additional space after the complete header |
| `section-before-skip` | Any valid LaTeX length | `1.05em` | Space between a section heading and preceding content |
| `section-line-gap` | Any valid LaTeX length | `0.28em` | Space between a section heading and its rule |
| `section-after-skip` | Any valid LaTeX length | `0.42em` | Space between a section rule and its content |
| `section-line-width` | Any valid LaTeX length | `0.4pt` | Thickness of a gradient or solid section rule |
| `project-divider-before-skip` | Any valid LaTeX length | `0.35em` | Space above a project divider |
| `project-divider-after-skip` | Any valid LaTeX length | `0.35em` | Space below a project divider |
| `project-divider-width` | Any valid LaTeX length | `0.35pt` | Project-divider thickness |
| `banner-text-shift` | Any valid LaTeX length | `0.4ex` | Vertical adjustment for Logo-adjacent text; positive values move it upward while dates remain naturally centered |
| `banner-padding-y` | Any valid LaTeX length | `0.12em` | Vertical padding inside Logo banners; surrounding spacing is unchanged |
| `banner-date-width` | Any valid LaTeX length | `9.3em` | Width of the date column in Logo banners; the company/role column wraps in the remaining space |

Adjust only the sizes you need:

```tex
\resumesetup{
  name-size=24pt,
  section-size=15pt,
  body-size=9.5pt
}
```

Larger body text may naturally move content to another page.

### Font mode

```tex
% Modern technical style: modern CJK sans + Latin sans.
\resumesetup{font-mode=modern}

% Classic formal style: restore Chinese Song + Latin serif body text.
\resumesetup{font-mode=classic}
```

`modern` prefers Microsoft YaHei, then tries Source Han Sans SC, Noto Sans CJK SC, PingFang SC, and DengXian, falling back to FandolHei only when none is installed. By default, names and section titles share SimHei, the theme color, and the same weight; only their sizes are independent. Both fall back to the modern CJK chain when SimHei is unavailable. `classic` restores only the body and contact text to the Song/serif pairing.

Section-title fonts can be selected independently or set to any installed font:

```tex
\resumesetup{section-font=simhei}                 % v4 style
\resumesetup{section-font=modern}                 % modern fallback chain
\resumesetup{section-font-name={Microsoft YaHei}} % explicit system font
```

### Custom theme color

Define an xcolor color before passing it to `\resumesetup`:

```tex
\definecolor{MyResumeColor}{RGB}{80,90,140}

\resumesetup{
  color=MyResumeColor,
  section-line=solid,
  entry-separator=bar
}
```

The older `gradientline` and `solidline` document-class options and `\setresumecolor{...}` remain compatible.

Both solid and gradient section rules use the current `\linewidth`. Changing page margins, columns, or a surrounding `minipage` therefore requires no manual rule length.

## Content commands

### Header, contact information, and sections

```tex
\resumeheader[images/placeholder-id-photo-transparent.png][photo-trim={0 0 0 168bp}]{Sample Name}{%
  \resumecontact{\faPhone}{Phone: 138-0000-0000}
  \resumecontact{\faEnvelope}{Email: \resumelink{mailto:hello@example.com}{hello@example.com}}\\
  \resumecontact{\faGlobe}{Website: \resumelink{https://example.com}{https://example.com}}
  \\
  \resumecontact{\faGithub}{GitHub: \resumelink{https://github.com/your-name}{https://github.com/your-name}\hspace{0.35em}\resumehighlight[ResumeGold]{(\faStar\hspace{0.25em}100+ Star)}}
}

\resumesection{Work Experience}
```

The header has no fixed height: the name and contacts determine it naturally. By default, the portrait is a foreground overlay whose top aligns with the name and which contributes no vertical height. The first `\resumesection` rule becomes its lower boundary; when space is short, the portrait scales proportionally and preserves `header-photo-line-gap`. Omitting the image path displays a generic placeholder. Contact icons remain black.

If an image file contains transparent or blank space above the person, use `photo-trim={left bottom right top}` so the visible person—not the canvas—aligns with the name. The bundled placeholder needs a `168bp` top trim; remove that option for a tightly cropped replacement portrait.

Short contact items can still share a line. If one item is naturally wider than the personal-information column, `\resumecontact` automatically switches to a fixed icon column plus a wrapping text column. Use `\resumelink{target}{display text}` for email addresses and URLs so long links can break safely without entering the portrait column.

The second optional argument affects only the current header and overrides global settings:

```tex
% Hide the portrait for this résumé; personal information uses the full row.
\resumeheader[][photo=false,name-gap=0.4em,after-skip=0.2em]{Name}{Contacts}

% Adjust this foreground portrait's size, crop, and position.
\resumeheader[images/avatar.png][
  photo-width=2.6cm,
  photo-max-height=3.1cm,
  photo-trim={0 0 0 8bp},
  photo-x-shift=-1mm,
  photo-y-shift=-0.5mm,
  column-gap=1.2em
]{Name}{Contacts}

% Restore a flow-based two-column header if the portrait should add height.
\resumeheader[images/avatar.png][photo-layout=flow,photo-align=bottom]{Name}{Contacts}
```

Local header keys map to global keys as follows:

| Local header key | Global key |
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

### Standard entries

```tex
\resumeentry{Organization or project}{Role or subtitle}{Date}
```

The complete form is:

```tex
\resumeentry*[color][separator]{title}{subtitle}{date}
```

- The star disables bold text.
- `color` defaults to `black` and accepts `ResumePrimary` or any defined color.
- `separator` accepts `dash` or `bar` and otherwise follows the global setting.
- Long titles and subtitles wrap automatically; the date stays aligned to the right.

Examples:

```tex
\resumeentry[black][dash]{University}{Major and degree}{2020.09 -- 2024.06}
\resumeentry[ResumePrimary][bar]{Project name}{Project subtitle}{2024.08 -- 2025.01}
\resumeentry*[black][bar]{Lightweight heading}{Subtitle}{Date}
```

### Company banner with a logo

```tex
\resumebanner[ResumeSky][images/logo-stellar-tech.png]
  {Company name}{Role}{2024.07 -- Present}
```

The first optional argument is the banner color, and the second is the logo path. Pass an empty logo path to use the generic company icon:

```tex
\resumebanner[ResumeOrange][]{Company name}{Role}{Date}
```

Long company names and roles wrap automatically in the middle column while the date stays in a fixed right-hand column inside the banner. Adjust that column with `banner-date-width` when a different date format needs more or less space.

### Lists and highlighted results

```tex
\begin{resumeitems}
  \item \textbf{Responsibility:} Designed the workflow and delivered the service.
  \item \textbf{Result:} Accuracy reached \resumehighlight{91\%}.
\end{resumeitems}
```

`\resumehighlight` uses `ResumeAccent` by default. Choose the bundled gold color or define your own:

```tex
\resumehighlight{78\% to 91\%}
\resumehighlight[ResumeGold]{2.4k stars}

\definecolor{MyHighlightColor}{RGB}{160,90,180}
\resumehighlight[MyHighlightColor]{Custom highlight}
```

### Inline numbering inside descriptions

Use the number commands after a bold mini-heading, without adding manual spaces:

```tex
\begin{resumedetails}
  \item \textbf{Pipeline:}\resumecircled{1}First step;\resumecircled{2}second step.
  \item \textbf{Retrieval:}\resumeparen{1}First item;\resumeparen{2}second item.
  \item \textbf{Evaluation:}\resumerightparen{1}First metric;\resumerightparen{2}second metric.
  \item \textbf{Reliability:}A regular description without numbering.
\end{resumedetails}
```

The commands render `①②`, `（1）（2）`, and `1）2）`. `\resumecircled` already includes its visual scaling, baseline correction, and trailing spacing.

### Education

```tex
\resumeentry[black]{University}{Major \quad Degree}{Start -- End}
\begin{resumeitems}
  \item \textbf{GPA:} 3.7/4.0 (top 10\%).
  \item \textbf{Honors:} Scholarship, outstanding graduate.
  \item \textbf{Coursework:} Data structures, databases, machine learning.
\end{resumeitems}
```

### Awards and competitions

```tex
\resumesection{Awards}
\begin{resumeawards}
  \resumeaward{Competition award}
  \resumeaward{Scholarship or academic honor}
  \resumeaward{Innovation contest award}
  \resumeaward{Modeling contest award}
\end{resumeawards}
```

`resumeawards` uses black trophy icons and arranges items in two columns.

## Style presets

Preset source files and compiled PDFs are stored in `examples/`. They share `examples/example-content.tex` and override only style-related commands.

Compile a preset from the project root:

```bash
latexmk -xelatex -output-directory=examples examples/modern-colorblocks.tex
```

## License

Released under the [MIT License](LICENSE).

Copyright (c) 2026 SimpleCNResume Contributors
