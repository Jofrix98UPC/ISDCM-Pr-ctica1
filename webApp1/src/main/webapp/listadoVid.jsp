<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listado Videos</title>
    <style>
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
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
    <div class="header">
        <h2>Listado Videos</h2>
        <a href="registroVid.jsp" class="btn-register">Registrar Video</a>
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
</body>
<script>
    window.onload = function() {
        window.location.href = "<%= request.getContextPath() %>/servletListadoVid";
    };
</script>
</html>