<%@ page session="true" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado Videos</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                text-align: center;
                padding: 50px;
            }
            .btn-register {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                font-size: 1.2em;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
            }
            .btn-register:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <%
            // Usar directamente la variable session implícita
            if (session == null || session.getAttribute("usuario") == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>

        <h1>Listado Videos</h1>
        <a href="registroVid.jsp" class="btn-register">Registrar Video</a>
    </body>
</html>
