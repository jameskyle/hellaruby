function createRequestObject() {
  var ro;
  var browser = navigator.appName;
  if(browser == "Microsoft Internet Explorer") {
    ro = new ActiveXObject("Microsoft.XMLHTTP");
  }
  else {
    ro = new XMLHttpRequest(); 
  }

  return ro;
}

var http = createRequestObject();
var http2 = createRequestObject();
function sndReq() {
  http.open('get', '/file_manager/download_progress');
  http2.open('get','/file_manager/processing');
  
  http.onreadystatechange = handleResponse;
  http.send(null);
  http2.onreadystatechange = handleResponse;
  http2.send(null);
  setTimeout("sndReq()",1000);

}

function handleResponse() {
  if(http.readyState == 4) {
    var response = http.responseText;
    var update = new Array();
    
    update = response.split("|")
    if(response.indexOf('|' != -1)) {
      document.getElementById("progress_bar").style.width = update[0] + "%";
      document.getElementById("rate").innerHTML = update[1]+"Kb/s";
      document.getElementById("progress_text").innerHTML = update[0]+"&#37;";
    }
    else {
      document.getElementById("rate").innerHTML = "0Kb/s"; 
    }
    
    }
  if(http2.readyState == 4) {
    var response = http2.responseText;
   document.getElementById("currently_processing").innerHTML = response; 
  } 
  }
