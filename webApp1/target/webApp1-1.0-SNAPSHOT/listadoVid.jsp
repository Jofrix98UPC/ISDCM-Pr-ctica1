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
        .xml-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .xml-buttons form {
            display: inline-block;
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
                <th>Acciones</th>
            </tr>
            <%
                java.util.List<modelo.video> videos = (java.util.List<modelo.video>) request.getAttribute("videos");
                if (videos != null) {
                    for (modelo.video video : videos) {
            %>
            <tr>
                <td><%= video.getId() %></td>
                <td><%= video.getTitulo() %></td>
                <td><%= video.getAutor() %></td>
                <td><%= video.getFecha() %></td>
                <td><%= video.getDuracion() %></td>
                <td><%= video.getReproducciones() %></td>
                <td><%= video.getDescripcion() %></td>
                <td>
                    <form method="post" action="cifrar" style="display:inline;">
                        <input type="hidden" name="archivo" value="<%= video.getRutaArchivo() %>">
                        <input type="hidden" name="op" value="cifrar">
                        <input type="submit" value="Cifrar" class="button">
                    </form>
                    <form method="post" action="cifrar" style="display:inline;">
                        <input type="hidden" name="archivo" value="cifrar_<%= video.getRutaArchivo() %>">
                        <input type="hidden" name="op" value="descifrar">
                        <input type="submit" value="Descifrar" class="button">
                    </form>
                </td>

            </tr>
            <%
                    }
                }
            %>
        </table>
        <div class="xml-buttons">
            <form method="post" action="protegerXML">
                <input type="hidden" name="op" value="cifrar">
                <input type="submit" value="Cifrar XML" class="button">
            </form>

            <form method="post" action="protegerXML">
                <input type="hidden" name="op" value="descifrar">
                <input type="submit" value="Descifrar XML" class="button">
            </form>
        </div>
    </div>
</body>
<script>
    window.onload = function() {
        window.location.href = "<%= request.getContextPath() %>/servletListadoVid";
        const params = new URLSearchParams(window.location.search);
        if (params.has("msg")) {
            alert(params.get("msg"));
        }
    };
</script>
</html>