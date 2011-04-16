// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$().ready(function() {
    if($(".track-link").size() > 0) {

    console.log("hi");
      $(".track-link").each(function(i) {
        window.open("/tracks/" +$(this).attr("id").match(/\d+$/));
        });
      }
      }); 
