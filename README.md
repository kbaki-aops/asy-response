# Asymptote scaling demonstration.

Asymptote diagrams are scaled in one of two ways:
* The `unitsize(real x)` command, which sets 1 Asymptote unit to be scaled to `x` units.
* The `size(real x)` command, which sets the entire diagram to be scaled to width `x` units.

If `x` is a unitless number, then it is interpreted as PostScript big points (`bp`). Otherwise, it is interpreted with the given unit (`pt`, `cm`, `mm`, or `inches`).

Scaling affects everything *except* for stroke width, font size, and anything I've forgotten about. Dot size is a function of stroke width, so it also does not scale.

Here is a line from `(0, 0)` to `(3, 2)` at various scales.
![](asy/heaven.png)