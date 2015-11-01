var Book = {
  'navigate': {
    'previous': function() {
      var link = document.querySelector('a.prev-link');
      if (link != null) {
        window.location = link.href;
      }
    },
    'next': function() {
      var link = document.querySelector('a.next-link');
      if (link != null) {
        window.location = link.href;
      }
    },
    'up': function() {
      var link = document.querySelector('a.chapter-link');
      if (link == null) {
        link = document.querySelector('a.home-link');
      }
      if (link != null) {
        window.location = link.href;
      } 
    },
    'home': function(e) {
      e.preventDefault();
      var link = document.querySelector('a.home-link');  
      if (link != null) {
        window.location = link.href;
      } 
    }
  }
};

Hammer(document.getElementsByTagName("body")[0]).on("swipeleft", function(e) {
  $("body").animate({"margin-left": "-2000px"}, "fast");
  Book.navigate.previous();
});

Hammer(document.getElementsByTagName("body")[0]).on("swiperight", function(e) {
  $("body").animate({"margin-left": "2000px"}, "fast");
  Book.navigate.next();
});

Mousetrap.bind('left', Book.navigate.previous);
Mousetrap.bind('right', Book.navigate.next);
Mousetrap.bind('alt+up', Book.navigate.up);
Mousetrap.bind('esc', Book.navigate.home);


$('[title!=""]').qtip({
  style: { 
    classes: 'qtip-light',

  }
});
