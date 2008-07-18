$.ajaxSetup({
  type: 'GET',  
  dataType: 'html',
  timeout: 1000,
});
function updateStats() {
  $('#hellanzb_stats').load('/hellanzb_manager/server_info');
  $('#queue_list').load('/nzb_manager/queue_list');
  $('#currently_processing').load('/file_manager/processing');
  $.ajax({
    url: '/file_manager/download_progress',
    dataType: 'text',
    success: function(text) {
      var update = new Array();
      update = text.split('|');

      if(text.indexOf('|' != -1 && update[2] != 'none')) {
        $('#progress_bar').width(update[0] + "%"); 
        $('#rate').html(update[1] + "KB/s");
        $('#progress_text').html(update[0] + "&#37;");
        $('#nzb_name').html(update[2]);
      }
    }
  });
  setTimeout("updateStats()",1500);
}

