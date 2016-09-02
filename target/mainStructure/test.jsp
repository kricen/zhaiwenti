<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta charset="utf-8">
    <title>宅文体</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- CSS -->
    <link rel="stylesheet" href="/asset/sellerAsset/css/supersized.css">
    <link rel="stylesheet" href="/asset/sellerAsset/css/login.css">
    <link href="/asset/sellerAsset/css/bootstrap.min.css" rel="stylesheet">
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="/asset/sellerAsset/js/html5.js"></script>
    <![endif]-->
    <script src="/asset/sellerAsset/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="/asset/sellerAsset/js/jquery.form.js"></script>
    <script type="text/javascript" src="/asset/sellerAsset/js/tooltips.js"></script>
    <script type="text/javascript" src="/asset/sellerAsset/js/md5.js"></script>
    <script type="text/javascript" src="/asset/sellerAsset/js/login.js"></script>
</head>

<body>

<div class="page-container">
    <div class="main_box">
        <div class="login_box">
            <div class="login_logo">
                <img src="/asset/sellerAsset/images/logo.png" >
            </div>

            <div class="login_form">
                <form action="index.html" id="login_form" method="post">
                    <div class="form-group">
                        <label for="j_username" class="t">手机号码：</label>
                        <input id="email" value="" name="email" type="text" class="form-control x319 in"
                               autocomplete="off">
                    </div>
                    <div class="form-group">
                        <label for="j_password" class="t">密　码：</label>
                        <input id="password" value="" name="password" type="password"
                               class="password form-control x319 in">
                    </div>
                    <div class="form-group space">
                        <label class="t"></label>　　　
                        <button type="button"  id="submit_btn"
                                class="btn btn-primary btn-lg">&nbsp;登&nbsp;录&nbsp </button>
                        <input type="reset" value="&nbsp;重&nbsp;置&nbsp;" class="btn btn-default btn-lg">
                    </div>
                </form>
            </div>
        </div>
        <div class="bottom">Copyright &copy; 2016 </div>
    </div>
</div>

<!-- Javascript -->

<script src="/asset/sellerAsset/js/supersized.3.2.7.min.js"></script>
<script src="/asset/sellerAsset/js/supersized-init.js"></script>
<script src="/asset/sellerAsset/js/scripts.js"></script>
</body>
</html>