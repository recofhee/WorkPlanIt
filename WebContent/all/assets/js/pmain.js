// Modal Open
$("#myBtn1").click(function(){
    $("#myModal1").modal();
});

// Collapse
$(document).ready(function(){
  $("#createPlanet").on("hide.bs.collapse", function(){
    $(".createplanet-bottom").html('<i class="fa fa-plus" aria-hidden="true"></i>');
  });
  $("#createPlanet").on("show.bs.collapse", function(){
    $(".createplanet-bottom").html('<i class="fa fa-times" aria-hidden="true"></i>');
  });
  
  $("#searchPlanet").on("show.bs.collapse", function(){
	    
	  });
});

// Upload crop
$uploadCrop = $('#upload-demo').croppie({
    enableExif: true,
    viewport: {
        width: 234,
        height: 234,
        type: 'circle'
    },
    boundary: {
        width: 234,
        height: 234
    }
});

$('#upload').on('change', function () { 
  var reader = new FileReader();
    reader.onload = function (e) {
      $uploadCrop.croppie('bind', {
        url: e.target.result
      }).then(function(){
        //console.log('jQuery bind complete');
      });
      
    }
    reader.readAsDataURL(this.files[0]);
});

$('.upload-result').on('click', function (ev) {
  $uploadCrop.croppie('result', {
    type: 'canvas',
    size: 'viewport'
  }).then(function (resp) {

    $.ajax({
      url: "http://localhost/croppie/ajaxpro.php",
      type: "POST",
      data: {"image":resp},
      success: function (data) {
        html = '<img src="' + resp + '" class="image" />';
        $("#upload-demo-i").html(html);
      }
    });
  });
});

/*
 * jQuery File Upload Plugin JS Example
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * https://opensource.org/licenses/MIT
 */

/* global $, window */

$(function () {
    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
        // Uncomment the following to send cross-domain cookies:
        //xhrFields: {withCredentials: true},
        url: 'server/php/'
    });

    // Enable iframe cross-domain access via redirect option:
    $('#fileupload').fileupload(
        'option',
        'redirect',
        window.location.href.replace(
            /\/[^\/]*$/,
            '/cors/result.html?%s'
        )
    );

    if (window.location.hostname === 'blueimp.github.io') {
        // Demo settings:
        $('#fileupload').fileupload('option', {
            url: '//jquery-file-upload.appspot.com/',
            // Enable image resizing, except for Android and Opera,
            // which actually support image resizing, but fail to
            // send Blob objects via XHR requests:
            disableImageResize: /Android(?!.*Chrome)|Opera/
                .test(window.navigator.userAgent),
            maxFileSize: 999000,
            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
        });
        // Upload server status check for browsers with CORS support:
        if ($.support.cors) {
            $.ajax({
                url: '//jquery-file-upload.appspot.com/',
                type: 'HEAD'
            }).fail(function () {
                $('<div class="alert alert-danger"/>')
                    .text('Upload server currently unavailable - ' +
                            new Date())
                    .appendTo('#fileupload');
            });
        }
    } else {
        // Load existing files:
        $('#fileupload').addClass('fileupload-processing');
        $.ajax({
            // Uncomment the following to send cross-domain cookies:
            //xhrFields: {withCredentials: true},
            url: $('#fileupload').fileupload('option', 'url'),
            dataType: 'json',
            context: $('#fileupload')[0]
        }).always(function () {
            $(this).removeClass('fileupload-processing');
        }).done(function (result) {
            $(this).fileupload('option', 'done')
                .call(this, $.Event('done'), {result: result});
        });
    }

});

// function writeSave(){
// 	eval writearticle = document.writearticle;
	
// 	if(!writearticle.writer.value){
// 	  alert("작성자를 입력하십시요.");
// 	  writearticle.writer.focus();
// 	  return false;
// 	}
	
// 	if(!writearticle.subject.value){
// 	  alert("제목을 입력하십시요.");
// 	  writearticle.subject.focus();
// 	  return false;
// 	}
	
// 	if(!writearticle.content.value){
// 	  alert("내용을 입력하십시요.");
// 	  writearticle.content.focus();
// 	  return false;
// 	}
        
// 	if(!writearticle.passwd.value){
// 	  alert(" 비밀번호를 입력하십시요.");
// 	  writearticle.passwd.focus();
// 	  return false;
// 	}
//  };