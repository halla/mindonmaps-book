#lang pollen

◊(define-meta template "template.html")
◊(define-meta page-title "Mind on maps")


◊a['class:"cover-image" 'href: "#main-title" 'title: "Click to jump into table of contents"]{ ◊img['class:"cover-image" 'src: "images/centermap_1000.png"] }

◊div['class: "cover-title"]{◊div['class:"left-container"]{◊h1['id: "main-title"]{◊(hash-ref metas 'page-title)}◊div['class:"author"]{Antti Halla}}
 ◊div['class: "tagline"]{expand your memory ◊br[] index your mind ◊br[] organize your life}
}



◊wip{You are reading a free early access version of a book. ◊br[] This book is a work in progress. All feedback is welcome. ◊br[] Give me a shout on Twitter ◊a['href: "https://twitter.com/AnttiHalla"]{@AnttiHalla} if you like.}
◊br[]

