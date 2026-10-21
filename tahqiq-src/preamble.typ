// RESTORED 2026-10-21 after workspace loss.
// Exact: colors, h2/h3*, boxes, bullets, captions, wraps, bibsec, index cells, toc.
// TBD-verify vs original.pdf: bgbox/gray values, abstitle geometry, h1b/h1,
//   header/footer placement, dia() size, mahwar/gb/qf/vrf/fig/tab macros (restore with s01-s06).

#let green = rgb("#164D49")
#let khaki = rgb("#CFC3A4")
#let goldD = rgb("#A0884A")
#let bgbox = rgb("#F6F8F4") // TBD: computed from orig fill, verify
#let ink = rgb("#0F1716")
#let gray = rgb("#808080") // TBD: exact orig gray unknown
#let tocgray = rgb("#4B5553")

// عناوين (TBD: h1b/h1 أُعيد بناؤهما وظيفياً — تُضبط مع عودة الأصل)
#let h1b(t) = block(above: 24pt, below: 12pt, align(center, text(fill: green, weight: "bold", size: 20pt)[#t]))
#let h1(t) = block(above: 24pt, below: 12pt, align(center, text(fill: green, weight: "bold", size: 18pt)[#t]))
#let dia() = box(baseline: -3.5pt, polygon(fill: green, stroke: none, (4.2pt, 0pt), (8.4pt, 4.6pt), (4.2pt, 9.2pt), (0pt, 4.6pt)))
#let h2(t) = {
  block(sticky: true, above: 9.2pt, below: 10.7pt)[
    #place(right + top, dx: 1.7pt, dy: 0.2pt, box(height: 15.2pt, width: 4.05pt, fill: green))
    #pad(right: 9pt, align(right, text(fill: green, weight: "bold", size: 16.2pt, [#t])))
  ]
}
#let h3(t) = {
  block(sticky: true, above: 8pt, below: 1.6pt, align(right)[
    #dia()
    #h(4pt)
    #text(fill: green, weight: "bold", size: 15pt, [#t])
  ])
}
#let h4box(t) = block(breakable: false, above: 22.5pt, below: 14.8pt, rect(
  fill: bgbox, stroke: 0.75pt + khaki, width: 100%,
  inset: (x: 10pt, top: 4.8pt, bottom: 4.4pt),
  align(right, text(fill: goldD, weight: "bold", size: 14.5pt, [#t])),
))

// نصوص مميزة
#let qt(it) = block(
  inset: (x: 16.2pt, y: 0pt), above: 7.9pt, below: 12.4pt,
  text(size: 14.1pt)[#set par(leading: 7.9pt, spacing: 7.9pt); #it],
)
#let q(it) = text(font: "Amiri Quran", fill: green, size: 14.1pt)[#it]
#let h7(it) = text(fill: green, weight: "bold")[#it]

// صناديق
#let defbox(title, body) = block(breakable: false, above: 3.7pt, below: 9.7pt, rect(
  fill: bgbox, stroke: 0.75pt + khaki, width: 100%,
  inset: (x: 13pt, top: 8.2pt, bottom: 4.7pt),
)[
  #align(center, text(fill: green, weight: "bold", size: 12.2pt)[#title])
  #v(-3.3pt)
  #body
])
#let notebox(title, body) = block(breakable: false, above: 2.7pt, below: 2pt, rect(
  fill: bgbox, stroke: (left: 0.75pt + khaki, top: 0.75pt + khaki, bottom: 0.75pt + khaki, right: 3.5pt + goldD), width: 100%,
  inset: (x: 14pt, top: 9pt, bottom: 7.3pt),
)[
  #align(center, text(fill: goldD, weight: "bold", size: 12.5pt)[#title])
  #v(3.7pt)
  #set par(spacing: 8.4pt)
  #body
])
#let qbox(cap, body) = block(breakable: false, above: 4.7pt, below: 10.6pt, rect(
  fill: bgbox, stroke: 0.75pt + khaki, width: 100%,
  inset: (x: 14pt, top: 8.5pt, bottom: 8pt),
)[
  #align(right, text(fill: goldD, weight: "bold", size: 11.5pt)[#cap])
  #v(2.4pt)
  #set par(leading: 6.9pt)
  #text(size: 12.2pt)[#body]
])

// تعداد نقطي مخصص (RTL)
#let bi1(body) = block(breakable: false, above: 6.6pt, below: 6.7pt)[
  #place(right + top, dx: -8pt, text(fill: green, weight: "bold", size: 15pt)[•])
  #pad(right: 20.4pt, [#body])
]
#let bi2(body) = block(breakable: false, above: 6.6pt, below: 6.7pt)[
  #place(right + top, dx: -28.4pt, text(fill: green, weight: "bold", size: 15pt)[•])
  #pad(right: 40.8pt, [#body])
]

// تسميات وجداول
#let caption(t, cbelow: 10pt) = block(width: 100%, above: 8pt, below: cbelow, align(center, text(fill: green, weight: "bold", size: 11.5pt, [#t])))
#let figwrap(cap, body, wabove: 4.9pt, wbelow: 8.7pt, cb: 10pt) = block(breakable: false, above: wabove, below: wbelow)[#caption(cbelow: cb)[#cap]#body]
#let tabwrap(cap, body, wabove: 4.9pt, cb: 0pt) = block(breakable: true, above: wabove, below: 0pt)[#caption(cbelow: cb)[#cap]#body]
#let vref(t) = text(fill: gray, size: 12.7pt)[#t]
#let caplead(body) = block(below: 0.9pt, [#body])
#let indextab(t) = [#v(-5.1pt)#block(above: 11.6pt, below: 14.5pt, [#t])]

// فقرة علامة حاشية بعد صندوق الاقتباس
#let cc(t) = [#set text(top-edge: 0.8em, bottom-edge: -0.2em); #set par(leading: 6.3pt); #text(size: 11.2pt)[#t]]
#let markpar(m) = block(above: 10.6pt, below: 11.8pt, [#m])

// عنوان رئيس (TBD: هندسة دقيقة تُضبط مع الأصل)
#let abstitle(t) = block(width: 100%, above: 0pt, below: 38.8pt, pad(top: 13.4pt, align(center, text(fill: green, weight: "bold", size: 16.5pt)[#t])))

// أقسام المصادر
#let bibsec(t) = block(above: 5.4pt, below: 5.3pt, text(weight: "bold", size: 15pt)[#t])

// فهارس T1-T4
#let idxh(t) = table.cell(inset: (right: 8pt, left: 2pt, top: 5.3pt, bottom: 2pt), align(right + top, text(fill: white, weight: "bold", size: 11pt)[#t]))
#let idxc(t) = [#set par(leading: 6.3pt); #text(size: 11.2pt)[#t]]
#let idxv(t) = [#v(8.45pt)#set par(leading: 6.3pt); #text(size: 11.2pt)[#t]]
#let idxv5(t) = [#v(9.55pt)#set par(leading: 6.3pt); #text(size: 11.2pt)[#t]]
#let idxp(t) = [#set par(leading: 6.3pt); #text(fill: green, weight: "bold", size: 11.2pt)[#t]]
#let idxvp(t) = [#v(8.45pt)#set par(leading: 6.3pt); #text(fill: green, weight: "bold", size: 11.2pt)[#t]]
#let idxvp5(t) = [#v(9.55pt)#set par(leading: 6.3pt); #text(fill: green, weight: "bold", size: 11.2pt)[#t]]
#let idxq(t) = [#set par(leading: 6.3pt); #text(font: "Amiri Quran", fill: green, size: 12.2pt)[#t]]
#let idxb(t) = [#set par(leading: 6.3pt); #text(weight: "bold", size: 11.2pt)[#t]]
#let indextable(cols, rows, head, body) = table(
  table.header(..head, repeat: true),
  ..body,
  columns: cols, rows: rows,
  stroke: 0.65pt + khaki,
  fill: (x, y) => if y == 0 { green } else { white },
  inset: (right: 8pt, left: 2pt, top: 5.6pt, bottom: 2pt),
  align: right + top,
)

// فهرس الموضوعات
#let tocblock(t) = block(above: 20.5pt, below: 0pt, [#t])
#let toct1(t) = align(right + top, text(fill: green, weight: "bold", size: 12.8pt)[#t])
#let toct2(t) = align(right + top, text(fill: ink, weight: "bold", size: 11.8pt)[#t])
#let toct3(t) = align(right + top, text(fill: tocgray, weight: "regular", size: 11pt)[#t])
#let tocn1(n) = align(left + top, text(fill: green, weight: "bold", size: 12.8pt)[#n])
#let tocn2(n) = align(left + top, text(fill: green, weight: "bold", size: 11.8pt)[#n])
#let tocn3(n) = align(left + top, text(fill: green, weight: "bold", size: 11pt)[#n])
#let tocdots = align(top, repeat(text(fill: khaki, size: 9pt)[.], gap: 2.5pt))
