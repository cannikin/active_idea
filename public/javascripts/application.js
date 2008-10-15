ideasBlock = {
	
	vote:function(id) {
		new Ajax.Request(	'/ideas/'+id+'/vote',
											{
												evalScripts:true,
												onSuccess:function(r) {
													$('idea_'+id+'_votes').update(r.responseText);
													$('idea_'+id+'_votes').highlight();
												},
												onFailure:function(r) {
													alert(r.responseText);
												}
											});
	},
	
	add:function() {
		// turn off the form so there's no multiple submits
		var self = this;
		
		new Ajax.Request(	'/ideas',
											{
												parameters:$('new_idea').serialize(),
												evalScripts:true,
												onCreate:function() {
													self.disableElements();
												},
												onSuccess:function(r) {
													$('recent_ideas_title').insert({'after':r.responseText});
													var just_added = $$('#recent_ideas .idea').first();
													just_added.hide();
													just_added.blindDown();
													self.clearForm();
													self.enableElements();
												},
												onFailure:function(r) {
													alert(r.responseText);
													self.enableElements();
												}
											});
											
		// don't submit the form
		return false;
	},
	
	edit:function() {
		return true;
	},
	
	enableElements:function(obj) {
		$('new_idea').getElements().each(function(element) {
			element.enable();
		});
	},
	
	disableElements:function(obj) {
		$('new_idea').getElements().each(function(element) {
			element.disable();
		});
	},
	
	clearForm:function() {
		$('new_idea').reset();
	},
	
	addComment:function() {
		var form = $('add_comment_form');
		new Ajax.Request(	form.action,
							{
								parameters:form.serialize(),
								evalScripts:true,
								onCreate:function() {
									form.getElements().each(function(element) {
										element.disable();
									});
								},
								onSuccess:function(r) {
									$('comment_body').value = '';
									if($('no_comments')) {
										$('no_comments').fade();
									}
									$('comments').insert({'bottom':r.responseText});
									var just_added = $$('#comments .comment').last();
									just_added.hide();
									just_added.blindDown();
									form.getElements().each(function(element) {
										element.enable();
									});
								},
								onFailure:function(r) {
									// alert(r.responseText);
									form.getElements().each(function(element) {
										element.enable();
									});
								}
							});
	}
									
	
}