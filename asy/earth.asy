import markers;

pair higher = (0, 5cm);
pair lower = (0, 0cm);
real nudge = 0.5cm;

struct Scale {
  real tell;
  string spell;
  picture sizely;
  picture unitsizely;

  picture demonstration(picture p, bool withUnitsizely) {
    pair O = (0, 0);
    pair P = (3, 2);
    dot(p, "$(0, 0)$", O, unit(-P));
    dot(p, "$(3, 2)$", P, unit(P));
    draw(p, O--P, marker(stickframe, markuniform(4), true));

    return p;
  }

  void operator init(real tell, string spell) {
    this.tell = tell;
    this.spell = spell;

    this.sizely = (new picture() {
      picture p;
      size(p, this.tell);
      return this.demonstration(p, false);
    })();

    this.unitsizely = (new picture() {
      picture p;
      unitsize(p, this.tell);
      draw(p, brace((1, 0), (0, 0)));
      label(p, this.spell, (0.5, -30/this.tell));
      return this.demonstration(p, true);
    })();
  }
}

pair mid(picture p) {
  return min(p) + size(p)/2;
}

pair maxes(Scale[] ss) {
  pair z = (0, 0);
  for (Scale s: ss) {
    z += max(s.unitsizely);
  }
  return z;
}

void demonstrate(Scale[] scales) {
  for (int i=0; i<scales.length; ++i) {
    add(scales[i].unitsizely, (maxes(scales[:i]).x, higher.y));
    label("unitsize("+scales[i].spell+")", (
      (maxes(scales[:i]) + mid(scales[i].unitsizely)).x,
      nudge + (higher + max(scales[i].unitsizely)).y
    ));

    add(scales[i].sizely, (maxes(scales[:i]).x, lower.y));
    label("size("+scales[i].spell+")", (
      (maxes(scales[:i]) + mid(scales[i].sizely)).x,
      nudge + (lower + max(scales[i].sizely)).y
    ));
    draw(shift((maxes(scales[:i]) + min(scales[i].sizely)).x, -nudge) * brace(((scales[i].tell), 0), (0, 0)));
    label(scales[i].spell, (maxes(scales[:i]).x + mid(scales[i].sizely).x, -3nudge));
  }
}