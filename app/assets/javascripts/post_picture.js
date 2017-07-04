$(document).ready(function(){
  $('#post_picture').bind('change', function() {
    var size = $('.picture').attr('data-attribute')
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > size) {
      alert( I18n.t("posts.picture_size.file_size"));
    }
  });
})
