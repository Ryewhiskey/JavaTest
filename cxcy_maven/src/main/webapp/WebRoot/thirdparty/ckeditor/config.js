/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	
	config.toolbar_Full =
	[
	        { name: 'document', items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
	        { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
	        { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
	        { name: 'forms', items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton','HiddenField' ] },
	        '/',
	        { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
	        { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv',
	        '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
	        { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
	        { name: 'insert', items : [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ] },
	        '/',
	        { name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
	        { name: 'colors', items : [ 'TextColor','BGColor' ] },
	        { name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
	];
	 
	config.toolbar_Basic =
	[
	        ['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink','-','About']
	];
	
	config.toolbar_MyToolbar =
		[  
	        ['Source','-','Save','Preview','Print'],  
	        ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Scayt'],  
	        ['Undo','Redo','-','Find','Replace','-','SelectAll'],  
	        [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','TextColor','BGColor','-','RemoveFormat'],
	        ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	        ['Styles','Format','Font','FontSize'],  
	        ['Link','Unlink','Anchor'],  
	        ['Maximize','autoformat','-'], 
		    ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar'],  
		    [ 'Page' ]
	    ];
	config.toolbar_MyToolbar1 =
        [
            { name: 'document', items : [ 'Source','NewPage','Preview' ] },
            { name: 'basicstyles', items : [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
            { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
            { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','Scayt' ] },
            '/',
            { name: 'styles', items : [ 'Font','FontSize' ] },           
            { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote' ] },
            { name: 'insert', items :[ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ] },
            { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
            { name: 'tools', items : [ 'Maximize','-','About' ] }
        ];
	
	config.font_names = '宋体;黑体;楷体_GB2312;Arial;Comic Sans MS;Courier New;Tahoma;Times New Roman;Verdana' ;
	config.language = 'zh-cn';//语言设置  
	config.uiColor='#ADE82E';//颜色  
	config.width='99%';//宽度  
	config.height='450px';//高度  
	config.skin='office2003';//界面：kama/office2003/v2  
	config.toolbar='MyToolbar';//工具栏：Full/Basic  
	config.resize_eabled='false';
	config.enterMode = CKEDITOR.ENTER_BR;
	config.shiftEnterMode = CKEDITOR.ENTER_P;
	//config.fontSize_defaultLabel = '22';
	
	config.toolbarCanCollapse = true;//工具栏是否可以被收缩
	
	config.toolbarStartupExpanded = false;//工具栏默认是否展开

	
};
