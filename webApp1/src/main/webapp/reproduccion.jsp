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
            align-items: flex-start; /* Ajusta la alineación para que no se quede pegado al centro */
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .container {
            width: 100%;
            max-width: 1000px;
            padding: 30px;
        }

        h1 {
            text-align: center;
            color: #f0f8ff;
            font-size: 3em;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .video-container {
            display: flex;
            margin-bottom: 40px;
            position: relative;
            border-radius: 15px;
            overflow: hidden;
            background-color: rgba(0, 0, 0, 0.6); /* Fondo oscuro semi-transparente */
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.5);
        }

        .video-container:hover {
            transform: scale(1.03);
            transition: transform 0.3s ease-in-out;
        }

        video {
            width: 60%; /* Video ocupará el 60% del contenedor */
            height: auto;
            border-radius: 10px;
        }

        .video-info {
            width: 40%; /* El contenedor de info ocupará el 40% restante */
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            color: white;
        }

        .video-info h3 {
            font-size: 1.8em;
            font-weight: bold;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .reproducciones {
            font-size: 1.2em;
            font-weight: bold;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 5px 10px;
            border-radius: 5px;
            margin-top: 15px;
        }

        .description {
            color: #fff;
            font-size: 1.1em;
            font-weight: 300;
            line-height: 1.6;
            background-color: rgba(0, 0, 0, 0.7);
            border-radius: 15px;
            padding: 10px;
            margin-top: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6);
            flex-grow: 1; /* Asegura que la descripción ocupe todo el espacio disponible */
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .form-container {
            animation: fadeIn 1s ease-in-out;
        }

        /* Estilo para los controles de VideoJS */
        .vjs-default-skin .vjs-control-bar {
            background-color: rgba(0, 0, 0, 0.7) !important;
            border-radius: 0 0 15px 15px;
        }

        .vjs-play-control {
            color: #fff !important;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Reproducción de Videos</h1>

        <div id="videos-container"></div> <!-- Contenedor donde se agregarán los videos dinámicamente -->
    </div>

    <script>
    // Llamada a la API REST para obtener la lista de videos
    fetch('http://localhost:8080/webapp2/api/videos') // URL de tu servicio REST
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
                source.src = video.url; // URL del video
                source.type = 'video/youtube'; // Especificamos que es de tipo YouTube
                videoElement.appendChild(source);

                // Agregamos el reproductor al contenedor
                videoContainer.appendChild(videoElement);

                // Creamos un contenedor para la información del video (título, reproducciones, descripción)
                const videoInfo = document.createElement('div');
                videoInfo.classList.add('video-info');

                // Título del video
                const videoTitle = document.createElement('h3');
                videoTitle.innerText = video.titulo;
                videoInfo.appendChild(videoTitle);

                // Reproducciones
                const reproduccionesText = document.createElement('div');
                reproduccionesText.classList.add('reproducciones');
                reproduccionesText.innerText = "Reproducciones: " + video.reproducciones;
                videoInfo.appendChild(reproduccionesText);

                // Descripción
                const descriptionText = document.createElement('div');
                descriptionText.classList.add('description');
                descriptionText.innerText = video.descripcion;
                videoInfo.appendChild(descriptionText);

                // Agregamos la información al contenedor principal
                videoContainer.appendChild(videoInfo);

                // Agregamos el contenedor al DOM
                container.appendChild(videoContainer);

                // Inicializamos VideoJS para el nuevo video
                const player = videojs(videoElement.id, {
                    techOrder: ["youtube"]
                });

                // EVENTO: Aumentar reproducciones al reproducir
                player.on('play', () => {
                    fetch("http://localhost:8080/webapp2/api/videos/" + video.id + "/reproduccion", {
                        method: 'PUT',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({})
                    })
                    .then(response => {
                        if (response.ok) {
                            // Incrementar visualmente el número de reproducciones
                            video.reproducciones++;
                            reproduccionesText.innerText = "Reproducciones: " + video.reproducciones;
                        } else {
                            console.error("No se pudo actualizar reproducciones para el video ID " + video.id);
                        }
                    })
                    .catch(error => {
                        console.error("Error en el PUT de reproducciones:", error);
                    });
                });
            });
        })
        .catch(error => {
            console.error('Error al cargar los videos:', error);
        });
        
    </script>
</body>
</html>
