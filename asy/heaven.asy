import markers;

pair mid(picture p) {
  return min(p) + size(p)/2;
}

picture lyly(picture p, real r, string s, bool b) {
  pair O = (0, 0);
  pair P = (3, 2);
  dot(p, "$(0, 0)$", O, unit(-P));
  dot(p, "$(3, 2)$", P, unit(P));
  draw(p, O--P, marker(stickframe, markuniform(4), true));

  if (b) {
    draw(p, brace((1, 0), (0, 0)));
    label(p, s, (0.5, -30/r));
  }

  return p;
}

picture sizely(real r, string s) {
  picture p;
  size(p, r);
  return lyly(p, r, s, false);
}

picture unitsizely(real r, string s) {
  picture p;
  unitsize(p, r);
  return lyly(p, r, s, true);
}

real height = 5cm;

struct Scale {
  real tell;
  string spell;
  picture sizely;
  picture unitsizely;
  
  void operator init(real tell, string spell) {
    this.tell = tell;
    this.spell = spell;
    this.sizely = sizely(tell, spell);
    this.unitsizely = unitsizely(tell, spell);
  }
}

Scale[] scales = {
  Scale(3cm, "3cm"), 
  Scale(4cm, "4cm"), 
  Scale(5cm, "5cm"), 
};

pair maxes(Scale[] ss, bool withSizely) {
  pair z = (0, 0);
  for (Scale s: ss) {
    z += max(withSizely ? s.sizely : s.unitsizely);
  }
  return z;
}

for (int i=0; i<scales.length; ++i) {
  add(scales[i].unitsizely, (maxes(scales[:i], false).x, height));
  label("unitsize("+scales[i].spell+")",
    (
      maxes(scales[:i], false).x + mid(scales[i].unitsizely).x,
      height + max(scales[i].unitsizely).y
    )
  );
}

for (int i=0; i<scales.length; ++i) {
  add(scales[i].sizely, (maxes(scales[:i], false).x, 0cm));
  label("size("+scales[i].spell+")",
    (
      (maxes(scales[:i], false).x + mid(scales[i].sizely).x),
      0.5cm + max(scales[i].sizely).y
    )
  );
  draw(shift(maxes(scales[:i], false).x, -0.5cm)
    * brace(E*(max(scales[i].sizely)).x, E*(min(scales[i].sizely)).x)
  );
  label(scales[i].spell, (maxes(scales[:i], false).x + mid(scales[i].sizely).x, -1.5cm));
}