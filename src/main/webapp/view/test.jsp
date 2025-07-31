<!DOCTYPE html>
<html>
<head>
<style>
.tox-tinymce {
	margin: 0 auto;
}
</style>
<script src="../js/tinymce/tinymce.min.js"></script>
<script>
	tinymce
			.init({
				selector : '#foo',
				plugins : 'image',
				toolbar : [ 'undo redo | styles | bold italic | alignleft aligncenter alignright alignjustify | outdent indent | image' ],
				language : 'ja',
				language_url : '../js/tinymce/langs/ja/langs/ja.js',
				width : '80%'
			});
</script>
</head>
<body>
	<textarea id="foo">Next, start a free trial!</textarea>
</body>
</html>
