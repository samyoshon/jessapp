function previewLogo() {
  
  $('#preview-logo').empty();

  var previewL = document.querySelector('#preview-logo');
  var filesL   = document.querySelector('div.input-logo input[type=file]').files;

  function readAndPreview(file) {

    // Make sure `file.name` matches our extensions criteria
    if ( /\.(jpe?g|png|gif)$/i.test(file.name) ) {
      var reader = new FileReader();

      reader.addEventListener("load", function () {
        var image = new Image();
        image.height = 75;
        image.title = file.name;
        image.src = this.result;
        previewL.appendChild( image );
      }, false);

      reader.readAsDataURL(file);
    }

  }

  if (filesL) {
    [].forEach.call(filesL, readAndPreview);
  }


  // frontend validation - 2mb limit
  var fiL = document.getElementById('image-form-logo'); // GET THE FILE INPUT.

  $('.btn-post').prop('disabled', false);
  $('#fp-logo').empty();
  // VALIDATE OR CHECK IF ANY FILE IS SELECTED.
  if (fiL.filesL.length > 0) {
    // RUN A LOOP TO CHECK EACH SELECTED FILE.
    for (var i = 0; i <= fiL.filesL.length - 1; i++) {
      var fsize = fiL.filesL.item(i).size;      // THE SIZE OF THE FILE.
      if (fsize/1024 > 2048) {    // 1024 = 1MB
        document.getElementById('fp-logo').innerHTML = document.getElementById('fp-logo').innerHTML + '<br /> ' + '<b>' + fiL.filesL.item(i).name + ' is too big. Attachment size limit is 2MB.</b>'; //+ Math.round((fsize / 1024)) + ' KB';
        $('.btn-post').prop('disabled', true);
      }
    }
  }
}

$(document).on('turbolinks:load', function() {
  $('#image-form-logo').on('change', function(evt) {
    // console.log(this.files[0].size);
  });
});
