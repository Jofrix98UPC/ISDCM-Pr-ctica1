<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login - Plataforma de Streaming</title>

    <!-- Enlace a Bootstrap 4 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Enlace a VideoJS -->
    <link href="https://cdn.jsdelivr.net/npm/video.js@7.11.4/dist/video-js.css" rel="stylesheet">

    <!-- Estilos personalizados -->
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

        .form-control {
            background-color: rgba(245, 245, 245, 0.7);
            color: #333;
            border: 1px solid #ddd;
            font-size: 1.1em;
        }

        .form-control:focus {
            background-color: rgba(245, 245, 245, 0.9);
            border-color: #007bff;
            box-shadow: none;
        }

        .btn {
            background-color: #007bff;
            color: #fff;
            font-size: 1.1em;
            padding: 10px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .video-container {
            margin-top: 30px;
            width: 100%;
            max-width: 100%;
            height: auto;
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

        <div class="video-container">
            <!-- Reproductor de VideoJS -->
            <video id="my-video" class="video-js vjs-default-skin" controls preload="auto">
                <source src="https://www.w3schools.com/html/movie.mp4" type="video/mp4">
                <p class="vjs-no-js">
                    Para ver este video, por favor habilite JavaScript y considere actualizar a un navegador web que 
                    soporte VideoJS.
                </p>
            </video>
        </div>
    </div>

    <!-- Enlace a VideoJS JS -->
    <script src="https://cdn.jsdelivr.net/npm/video.js@7.11.4/dist/video.js"></script>

    <script>
        var player = videojs('my-video');
    </script>
</body>
</html>
