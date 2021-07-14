<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>

<div id="tips" align="center">
    <div style="filter: alpha(opacity=90);opacity: 0.9;">
        <div>
            <h1 style="font-weight:900;">说明</h1>
            <p>此管理系统可以登录和注册账号，实现学生的课程和成绩管理以及老师的信息和课程管理，进行查找、插入、删除和修改操作。</p>
            <p>联系邮箱：1454973178@qq.com、2139447940@qq.com</p>
            <%-- <div class="aboutcontext">
                <h5 style="text-align:left;">管理员邮箱：</h5>
                <p>qzqq.in@gmail.com</p>
                <p>1197445586@qq.com</p>
                <p>uruse@qq.com</p>
            </div> --%>
        </div><br>

        <div class="container">
            <h1 style="font-weight:900;">留言</h1>
            <form>
                <div style="text-align:left;" class="form-group">
                    <label for="comment">评论:</label>
                    <textarea class="form-control" rows="5" id="comment" placeholder="想要说什么？"></textarea>
                </div>
                <div style="text-align:left;" class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" class="form-control" id="email" placeholder="Enter email">
                </div>
                <div style="text-align:left;" class="form-group">
                    <label for="pwd">Password:</label>
                    <input type="password" class="form-control" id="pwd" placeholder="Enter password">
                </div>
                <div class="form-check">
                    <label class="form-check-label">
                        <input class="form-check-input" type="checkbox"> Remember me
                    </label>
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            <br>
            <br>
            <p style="font-size:0.6rem">Copyright©2021 作者:1454973178@qq.com、2139447940@qq.com</p>
        </div>

    </div>
</div>