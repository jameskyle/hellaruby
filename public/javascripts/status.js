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
var http3 = createRequestObject();
var http4 = createRequestObject();

function sndReq() {
  http.open('get', '/file_manager/download_progress');
  http2.open('get','/file_manager/processing');
  http3.open('get', '/nzb_manager/queue_list'); 
  http4.open('get', '/hellanzb_manager/server_info');
  
  http.onreadystatechange = handleResponse;
  http.send(null);

  http2.onreadystatechange = handleResponse;
  http2.send(null);

  http3.onreadystatechange = handleResponse;
  http3.send(null);
  
  http4.onreadystatechange = handleResponse;
  http4.send(null);

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
  else if(http2.readyState == 4) {
    var response = http2.responseText;
   document.getElementById("currently_processing").innerHTML = response; 
  } 
  else if(http3.readyState == 4) {
    var response = http3.responseText;
    document.getElementById("queue_list").innerHTML = response;
  }
  else if(http4.readyState == 4) {
    var response = http4.responseText;
    document.getElementById("hellanzb_stats").innerHTML = response;
  }
}
