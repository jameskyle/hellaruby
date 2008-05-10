jQuery(function($) {
  $("a.confirm.delete").click(function() { return confirm("Delete this file permanently?"); }
)});

jQuery(function($) {
  $("a.confirm.clear").click(function() { return confirm("Clear the download queue?"); })
});

jQuery(function($){
  $("a.confirm.cancel").click(function() {return confirm("Cancel the current download?")})
});
