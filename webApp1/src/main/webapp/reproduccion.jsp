<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reproducción Video - Plataforma de Streaming</title>

    <!-- Enlace a Bootstrap 4 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Enlace a VideoJS -->
    <link href="https://cdn.jsdelivr.net/npm/video.js@7.11.4/dist/video-js.css" rel="stylesheet">
    
    <!-- Enlace a videojs-youtube -->
    <script src="https://cdn.jsdelivr.net/npm/video.js@7.11.4/dist/video.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/videojs-youtube@2.6.0/dist/Youtube.min.js"></script>

    <style>
        body {
            background-image: url('https://smartframe.io/wp-content/uploads/2021/11/Image-streaming-How-it-works-why-you-need-it-and-everything-else-you-need-to-know_SWM.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 800px;
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

        .video-container {
            margin-top: 30px;
            width: 100%;
            max-width: 100%;
            height: auto;
            margin-bottom: 30px;
        }

        video {
            width: 100%;  /* Esto hace que el video ocupe el 100% del contenedor */
            height: 500px; /* Puedes ajustar la altura aquí */
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .form-container {
            animation: fadeIn 1s ease-in-out;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h1>Reproducción Videos</h1>
        </div>

        <div id="videos-container"></div> <!-- Contenedor donde se agregarán los videos dinámicamente -->
    </div>

    <script>
        // Llamada a la API REST para obtener la lista de videos
        fetch('http://localhost:8080/webapp2/api/videos') // Aquí pones la URL de tu servicio REST
            .then(response => response.json())
            .then(videos => {
                console.log(videos); // Verifica en la consola la respuesta de la API
                const container = document.getElementById('videos-container');
                
                // Iteramos sobre el array de videos
                videos.forEach((video, index) => {
                    // Creamos un contenedor para cada video
                    const videoContainer = document.createElement('div');
                    videoContainer.classList.add('video-container');

                    // Creamos el elemento de video
                    const videoElement = document.createElement('video');
                    videoElement.id = 'my-video-' + index;
                    videoElement.classList.add('video-js', 'vjs-default-skin');
                    videoElement.controls = true;
                    videoElement.preload = "auto";
                    
                    // Creamos el source para el video de YouTube
                    const source = document.createElement('source');
                    source.src = video.url; // URL del video de YouTube
                    source.type = 'video/youtube'; // Especificamos que el tipo es YouTube
                    videoElement.appendChild(source);

                    // Agregamos el reproductor al contenedor
                    videoContainer.appendChild(videoElement);

                    // Agregamos el contenedor del video al contenedor principal
                    container.appendChild(videoContainer);

                    // Inicializamos VideoJS para el nuevo video
                    videojs(videoElement.id, {
                        techOrder: ["youtube"]
                    });
                });
            })
            .catch(error => {
                console.error('Error al cargar los videos:', error);
            });
    </script>
</body>
</html>
