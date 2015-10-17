
Mousetrap.bind('left', function() {
  var link = document.querySelector('a.prev-link');
  window.location = link.href;
});

Mousetrap.bind('right', function() {
  var link = document.querySelector('a.next-link');
  window.location = link.href;
});

Mousetrap.bind('esc', function(e) {
  e.preventDefault();
  var link = document.querySelector('a.home-link');  
  window.location = link.href;
});

