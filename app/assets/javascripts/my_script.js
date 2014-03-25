var $j = jQuery.noConflict();

$j(document).ready(function(){
	
	$j(".game_level_btn").click(function(){
		$j(".game_level_btn").removeClass("btn-success");
		$j(this).addClass("btn-success");
		$j('#game_level_input_id').attr("value",$j(this).attr("name"));
	})

	$j(".game_type_btn").click(function(){
		$j(".game_type_btn").removeClass("btn-success");
		$j(this).addClass("btn-success");
		$j('#game_name_input_id').attr("value",$j(this).attr("name"));
	})

	$j(".keypadc").click(function(){
		$j("#answer_input" ).attr("value","");
		$j("#answer_input" ).val("");
		$j( "#answer_input" ).trigger( "keyup" );
		$j("#answer_input").focus();
	})

	$j(".keypadd").click(function(){
		if ($j("#answer_input" ).val().length > 0) {
			new_value = $j("#answer_input" ).val().slice(0,$j("#answer_input" ).val().length - 1);
			$j("#answer_input" ).val(new_value);
			$j( "#answer_input" ).trigger( "keyup" );
			$j("#answer_input").focus();		
		}
	})	

	$j(".keypad").click(function(){
		key_stroke = $j(this).attr("name");
		new_value = $j("#answer_input" ).attr("value") + key_stroke;
		$j("#answer_input" ).attr("value",new_value);
		$j("#answer_input" ).val(new_value);
		$j( "#answer_input" ).trigger( "keyup" );
		$j("#answer_input").focus();
	})

	$j("#answer_input").on("keyup change" ,function() {
		$j(this).css({"background-color": "white"});
		var expected_answer = $j("#expected_answer" ).attr("value");
		var input_answer = $j("#answer_input" ).val();

		var expected_answer_length = $j("#expected_answer" ).val().length;
		var entered_answer_length = $j("#answer_input" ).val().length;
		
		if (entered_answer_length == 0) {
			$j(this).css({"background-color": "white"});
		}

		if (entered_answer_length == expected_answer_length) {
			$j("#finish_url").attr("href","/questions/finish?answer="+input_answer);
			if (expected_answer == input_answer) {
				$j(this).css({"background-color": "#DFF0D8"});
			} else {
				$j(this).css({"background-color": "#F2DEDE"});
			}
		}

		if (entered_answer_length > expected_answer_length) {
			$j(this).css({"background-color": "#F2DEDE"});
			$j("#finish_url").attr("href","/questions/finish?answer="+input_answer);
		}
		$j(this).attr("value",input_answer);
	})

	$j("#answer_input").focus();
	$j("#report_date").datepicker({ dateFormat: 'yy-mm-dd' });

});