
Mousetrap.bind('left', function() {
  var link = document.querySelector('a.prev-link');
  if (link != null) {
    window.location = link.href;
  }
});

Mousetrap.bind('right', function() {
  var link = document.querySelector('a.next-link');
  if (link != null) {
    window.location = link.href;
  }
});

Mousetrap.bind('alt+up', function() {
  var link = document.querySelector('a.chapter-link');
  if (link == null) {
    link = document.querySelector('a.home-link');
  }
  if (link != null) {
    window.location = link.href;
  } 
});

Mousetrap.bind('esc', function(e) {
  e.preventDefault();
  var link = document.querySelector('a.home-link');  
  if (link != null) {
    window.location = link.href;
  } 
});

