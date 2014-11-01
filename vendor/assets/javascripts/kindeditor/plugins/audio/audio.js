KindEditor.plugin('audio', function(K) {
	var self = this, name = 'audio';
		self.plugin.audio = {
			edit : function() {
				var lang = self.lang(name + '.'),
					html = '<div style="padding:20px;">' +
						//url
						'<div class="ke-dialog-row">' +
						'<label for="keUrl" style="width:60px;">' + lang.url + '</label>' +
						'<input class="ke-input-text" type="text" id="keUrl" name="url" value="" style="width:260px;" /></div>' +

						'</div>',
					dialog = self.createDialog({
						name : name,
						width : 450,
						title : self.lang(name),
						body : html,
						yesBtn : {
							name : self.lang('yes'),
							click : function(e) {
								var url = K.trim(urlBox.val());
								if (url == 'http://' || K.invalidUrl(url)) {
									alert(self.lang('invalidUrl'));
									urlBox[0].focus();
									return;
								}
								
								var html = "<p><audio src=\""+ url +"\" autoplay=\"autoplay\" controls=\"controls\" style=\"width:100%\"></audio></p>";
								self.insertHtml(html).hideDialog().focus();
									
							}
						}
					}),
					div = dialog.div,
					urlBox = K('input[name="url"]', div),
					typeBox = K('select[name="type"]', div);
			      	urlBox.val('http://');
			},
			'delete' : function() {
				self.plugin.getSelectedMedia().remove();
			}
		};
		self.clickToolbar(name, self.plugin.audio.edit);
});