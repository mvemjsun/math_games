$(document).ready(function(){
	$(".game_level_image").click(function(){
		$(".game_level_image").removeClass("selected_option");
		$(this).addClass("selected_option");
		$('#game_level_input_id').attr("value",$(this).attr("name"));
	})

	$(".game_type_image").click(function(){
		$(".game_type_image").removeClass("selected_option");
		$(this).addClass("selected_option");
		$('#game_name_input_id').attr("value",$(this).attr("name"));
	})

	$("#answer_input").keyup(function() {
		$(this).css({"background-color": "white"});
		var expected_answer = $("#expected_answer" ).attr("value");
		var input_answer = $("#answer_input" ).val();

		var expected_answer_length = $("#expected_answer" ).val().length;
		var entered_answer_length = $("#answer_input" ).val().length;
		
		if (entered_answer_length == 0) {
			$(this).css({"background-color": "white"});
		}

		if (entered_answer_length == expected_answer_length) {
			$("#finish_url").attr("href","/game/finish_game?answer="+input_answer);
			if (expected_answer == input_answer) {
				$(this).css({"background-color": "#5da423"});
			} else {
				$(this).css({"background-color": "#c60f13"});
			}
		}

		if (entered_answer_length > expected_answer_length) {
			$(this).css({"background-color": "#c60f13"});
			$("#finish_url").attr("href","/game/finish_game?answer="+input_answer);
		}
	})

	$("#answer_input").focus();	
});