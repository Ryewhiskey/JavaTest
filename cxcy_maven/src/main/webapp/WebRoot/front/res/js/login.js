$(function () {

		//弹出登录
		$(".front_login").on('click', function () {
			
			$("#mask").css({ display: 'block' });
			$("#userlogin").fadeIn("fast");
			return false;
		});
		//
		
		
		//关闭
		$(".close_btn,.cancel_btn").on('click', function () {
			
			$("#userlogin").css({ display: 'none' });
			$("#mask").css({ display: 'none' });
			return false;
		});
	});
