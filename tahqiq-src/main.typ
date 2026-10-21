#import "preamble.typ": *

#let ardigits = ("٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩")
#let arnum(n) = {
  let out = ""
  for ch in str(n) {
    out += ardigits.at(int(ch))
  }
  out
}

#set text(font: "Amiri", fill: ink, dir: rtl, lang: "ar", size: 15pt, top-edge: 0.8em, bottom-edge: -0.2em)
#set par(leading: 8.4pt, spacing: 11.5pt, justify: true, first-line-indent: 0pt)
#set page(
  width: 595.28pt, height: 841.89pt,
  margin: (top: 68pt, bottom: 70pt, left: 68pt, right: 68pt),
  header: context [
    #place(top + right, dy: 25pt, text(fill: green, weight: "bold", size: 10.5pt)[جامعة الملك فيصل])
    #place(top + right, dy: 39.4pt, text(fill: gray, weight: "regular", size: 9.5pt)[تحقيق المناط في كتاب ابن القيم «إعلام الموقعين عن رب العالمين»: دراسة استقرائية وصفية])
    #place(bottom, line(length: 100%, stroke: 0.75pt + khaki))
  ],
  footer: context [
    #place(top + center, dy: 26.4pt, text(fill: gray, size: 9.5pt)[إعداد الطالبة: تغريد الغامدي | إشراف: د. TBD])
    #place(top + center, dy: 39.5pt, text(fill: green, size: 10pt)[– #arnum(counter(page).get().first()) –])
  ],
)
#show footnote.entry: set text(size: 10.2pt)

// s01–s07 تُستعاد بعد عودة الـPDF الأصلي
#include "s08.typ"
#include "s09.typ"
#include "s10.typ"
