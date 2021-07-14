<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="mainbody middle">
    <form class="form-box front" action="./index.jsp" method="post">
      <div>
        <input class="input-normal" type="text" name="user" required autofocus placeholder="账户名" />
        <input class="input-normal" type="password" name="passwd" maxlength="20" required placeholder="账户密码" />
        <input type="checkbox" class="checkbox" name="24h_nologin" value="checked" /><a>24小时内免登录</a>
		<input type="hidden" name="do_login" value="true" />
		<button class="btn-submit" type="submit">
          登录
        </button>
      </div>
      <div>
        <p class="switch-box">如果您没有账号，您可以<a id="signup" href="#">进行注册</a></p>
      </div>
    </form>
    <form class="form-box back">
      <div>
        <input class="input-normal" type="text" name="user" required autofocus placeholder="账户名" />
        <input class="input-normal" type="password" name="passwd" maxlength="20" required placeholder="账户密码" />
		<input class="input-normal" type="text" name="name" maxlength="10" required placeholder="用户名称" />
        <input type="hidden" name="do_register" value="true" />
		<button class="btn-submit" type="submit">
          注册
        </button>
      </div>
      <div>
        <p class="switch-box">已经有一个账户？您可以<a id="login" href="#">进行登录</a></p>
      </div>
    </form>
  </div>
	<script> 
		$("#signup").click(function() {
			$(".middle").toggleClass("middle-flip");
  		});
  		$("#login").click(function() {
			$(".middle").toggleClass("middle-flip");
  		});
	</script>