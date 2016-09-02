<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="#ffffff" name="msapplication-TileColor">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta charset="utf-8">
<meta name="data-spn" content="a215s">
<meta content="telphone=no, email=no" name="format-detection">
<meta name="MobileOptimized" content="320">
<title>选择学校</title>
<style>
    [v-cloak] {
        display: none;
    }
</style>
<link rel="stylesheet" type="text/css" href="/asset/newUser/css/chooseScho.css">
<link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">

<body>
<header id="title">选择学校</header>

<div id="content">

    <%--<ul class="scopes" id="vueroot" v-cloak>--%>
        <%--<li class="scope" v-for="school in schools">--%>
            <%--<ul class="list">--%>
                <%--<li class="scho"><a href="/user/selectSchool.action?sid={{school.id}}"><span class="schoolName">{{school.name}}</span></a></li>--%>
            <%--</ul>--%>
        <%--</li>--%>
    <%--</ul>--%>
        <ul class="scopes">
            <s:iterator value="schools" var="school">
                <li class="scope" >
                    <ul class="list">
                        <li class="scho"><a href="/user/confirmSchool.action?id=<s:property value="#school.id"/>"><span class="schoolName"><s:property value="#school.name"/></span></a></li>
                    </ul>
                </li>
            </s:iterator>

        </ul>

</div>
</body>
<script src="/asset/main/js/vue.min.js"></script>
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="/asset/newUser/js/choseScho.js"></script>
</html>