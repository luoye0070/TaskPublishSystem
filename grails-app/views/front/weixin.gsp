<%--
  Created by IntelliJ IDEA.
  User: Fala.Wang
  Date: 15-12-31
  Time: 下午3:32
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        window.onload =function(){
                    if(isWeiXin()){
                        var p = document.getElementsByTagName('p');
                        p[0].innerHTML = window.navigator.userAgent;
                    }
                }
        function isWeiXin(){
            var ua = window.navigator.userAgent.toLowerCase();
            if(ua.match(/MicroMessenger/i) == 'micromessenger'){
                 return true;
            }else{
                return false;
            }
        }

    </script>
</head>
<body>
    <p></p>
</body>
</html>