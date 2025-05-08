<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Búsqueda de Videos</title>

    <!-- Bootstrap 4 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-image: url('https://smartframe.io/wp-content/uploads/2021/11/Image-streaming-How-it-works-why-you-need-it-and-everything-else-you-need-to-know_SWM.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            font-family: Arial, sans-serif;
            color: #fff;
        }

        .container {
            max-width: 800px;
            margin-top: 40px;
        }

        .form-container {
            background-color: rgba(25, 25, 112, 0.85);
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            color: #ffffff;
            margin-bottom: 30px;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            font-weight: 700;
            color: #f0f8ff;
        }

        .video-result {
            background-color: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 15px;
        }

        .video-result h5 {
            color: #f0f8ff;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h1>Búsqueda de Videos</h1>
            <form id="busqueda-form">
                <div class="form-group">
                    <label for="titulo">Título</label>
                    <input type="text" class="form-control" id="titulo" name="titulo">
                </div>
                <p>o</p>
                <div class="form-group">
                    <label for="autor">Autor</label>
                    <input type="text" class="form-control" id="autor" name="autor">
                </div>
                <p>o</p>
                <div class="form-group">
                    <label for="fecha">Fecha de creación (formato: yyyy-mm-dd)</label>
                    <input type="text" class="form-control" id="fecha" name="fecha">
                </div>
                <button type="submit" class="btn btn-light btn-block">Buscar</button>
            </form>
        </div>

        <div id="resultados"></div>
    </div>

    <script>
        document.getElementById('busqueda-form').addEventListener('submit', function(e) {
            e.preventDefault();

            const titulo = document.getElementById('titulo').value.trim();
            const autor = document.getElementById('autor').value.trim();
            const fecha = document.getElementById('fecha').value.trim();
            const resultadosDiv = document.getElementById('resultados');

            // Construir la URL de búsqueda según los parámetros ingresados
            let url = 'http://localhost:8080/webapp2/api/videos/';

            if (titulo !== '') {
                url += 'buscar/titulo?titulo=' + encodeURIComponent(titulo);
            } else if (autor !== '') {
                url += 'buscar/autor?autor=' + encodeURIComponent(autor);
            } else if (fecha !== '') {
                url += 'buscar/fecha?fecha=' + encodeURIComponent(fecha);
            }

            // Llamada al servicio REST
            fetch(url)
                .then(response => {
                    if (!response.ok) throw new Error("Error en la búsqueda");
                    return response.json();
                })
                .then(videos => {
                    resultadosDiv.innerHTML = ''; // Limpiar resultados anteriores
                    if (videos.length === 0) {
                        resultadosDiv.innerHTML = '<p class="text-white">No se encontraron resultados.</p>';
                        return;
                    }

                    videos.forEach(video => {
                        const div = document.createElement('div');
                        div.classList.add('video-result');
                        div.innerHTML = "<h5>" +
                                video.titulo + 
                                "</h5> <p><strong> Autor:</strong> " + 
                                video.autor + 
                                "</p> <p>Fecha de Creación:" + 
                                new Date(video.fechaCreacion).toLocaleDateString() +
                                "</p> <p><strong>Duración:</strong> " +
                                video.duracion + "segundos</p> <p><strong>Reproducciones:</strong> " + 
                                video.reproducciones + 
                                "</p> <p><strong>Descripción:</strong> " + 
                                video.descripcion + 
                                "</p>"
                        ;
                        resultadosDiv.appendChild(div);
                    });
                })
                .catch(err => {
                    console.error(err);
                    resultadosDiv.innerHTML = '<p class="text-danger">Ocurrió un error al realizar la búsqueda.</p>';
                });
        });
    </script>
</body>
</html>
