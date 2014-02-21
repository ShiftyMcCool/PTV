var portfolioArray = [];
var currentRecordSet = 0;

$(document).ready(function() {
	// Any List Scroller init
	$("#carousel").als({
		visible_items: 4,
		scrolling_items: 4,
		orientation: "horizontal",
		circular: "no",
		autoscroll: "no"
	});

	$("#editPageTemplate").submit(function(e){
		var postData = $(this).serializeArray();
		var formURL = $(this).attr("action");

		if(!validateForm()) {
			e.preventDefault();
		}

		// Use this for ajax form post
		/*if(validateForm()) {
			$.ajax( {
				url : formURL,
				type: "POST",
				data : postData,
				success:function(data, textStatus, jqXHR) {
					console.log(data);
					
					if(data) {
						$("#saveResult").html("Saved");
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					alert(errorThrown);
				}
			});

			$("#cancelEdit").click();
		}
		else {
			alert("All fields are required");
		}

		e.preventDefault();*/
	});

	$("#addTemplate").on("click", function(){
		$(".form-field").attr("disabled",false);
		$(".form-field").val("");

		// Show/hide form buttons
		$(".form-button").toggle();
	});

	$("#editTemplate").on("click", function(){
		$(".form-field").attr("disabled",false);

		$("#title").focus();

		$(".form-button").toggle();
	});

	$("#deletTemplate").on("click", function(){
		$(".form-field").attr("disabled",false);

		$(".form-button").toggle();
	});

	$("#cancelEdit").on("click", function(){
		$(".form-field").attr("disabled",true);

		$(".form-button").toggle();
	});	

	$("#deleteTemplate").on("click", function(){
		if(confirm("Are you sure you want to delete this template?")){
			var $thisForm = $("#editPageTemplate");
			var url = '/apphome/index.cfm?event=delete';

			$(".form-field").attr("disabled",false);

			$thisForm.attr("action", url);
		}
	});

	$("a.als-link").on("click",function(){
		var $this = $(this);

		$(".currentThumb").removeClass("currentThumb");
		$this.find("img").addClass("currentThumb");

		$("#title").val($this.attr("title"));
		$("#description").val($this.attr("description"));
		$("#cost").val($this.attr("cost"));
		$("#pid").val($this.attr("pid"));
		$("#smallpic").val($this.attr("smallpic"));
		$("#largepic").val($this.attr("largepic"));
		$("#largeimage").attr("src", "/assets/images/large/"+$this.attr("largepic"));
	});

	$("#als-item_0_0 a").click();
	$('#saveResult').delay(3000).fadeOut();
});

function validateForm() {
	var retVal = false;
	var message = "";

	if(	$("#title").val() != "" 
		&& $("#description").val() != ""
		&& $("#cost").val() != ""
		&& $("#pid").val() != ""
		&& $("#smallpic").val() != ""
		&& $("#largepic").val() != "") {

		if($.isNumeric($("#pid").val()) && $.isNumeric($("#cost").val())) {
			retVal = true;
		}
		else {
			message += "ID and Cost must be numbers";
		}
	}
	else{
		message += "All fields are required";
	}

	if(message != "") {
		alert(message);
	}

	return retVal;
}