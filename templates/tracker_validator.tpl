{* $Id$ *}
{if isset($validationjs)}{jq}
$("#editItemForm{{$trackerEditFormId}}").validate({
	{{$validationjs}},
	ignore: '.ignore',
	submitHandler: function(){
		if( nosubmitItemForm{{$trackerEditFormId}} == true ) {
			return false;
		} else {
			process_submit(this.currentForm);
		}
	}
});
{/jq}{/if}
