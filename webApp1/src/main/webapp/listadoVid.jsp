<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listado Videos</title>
    <style>
        body {
            background-image: url('https://smartframe.io/wp-content/uploads/2021/11/Image-streaming-How-it-works-why-you-need-it-and-everything-else-you-need-to-know_SWM.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            height: 100vh;
            margin:0;
            font-family: Arial, sans-serif;
        }
        .container {
            height: 95vh;
            width: 95vw;
            background: rgba(255, 255, 255, 0.8);
            margin: 2.5vh 2.5vw 2.5vh 2.5vw;
            border-radius:10px;
            overflow: hidden;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            padding-inline: 40px;
            background-color: #f4f4f4;
            border-bottom: 2px solid #ccc;
        }
        .button {
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
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
           
        .button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Listado Videos</h2>
            <a href="registroVid.jsp" class="btn-register">Registrar Video</a>
            <a href="reproduccion.jsp" class="btn-register">Ver Videos</a>
        </div>

        <table>
            <tr>
                <th>ID</th>
                <th>Título</th>
                <th>Autor</th>
                <th>Fecha</th>
                <th>Duración</th>
                <th>Reproducciones</th>
                <th>Descripción</th>
            </tr>
            <%
                java.util.List<String[]> videos = (java.util.List<String[]>) request.getAttribute("videos");
                if (videos != null) {
                    for (String[] video : videos) {
            %>
            <tr>
                <td><%= video[0] %></td>
                <td><%= video[1] %></td>
                <td><%= video[2] %></td>
                <td><%= video[3] %></td>
                <td><%= video[4] %></td>
                <td><%= video[5] %></td>
                <td><%= video[6] %></td>

            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>
</body>
<script>
    window.onload = function() {
        window.location.href = "<%= request.getContextPath() %>/servletListadoVid";
    };
</script>
</html>