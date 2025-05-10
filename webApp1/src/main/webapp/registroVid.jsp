<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Video</title>

    <!-- Enlace a Bootstrap 4 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">

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
            max-width: 600px;
        }

        .form-container {
            background-color: rgba(25, 25, 112, 0.85);
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            color: #ffffff;
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

        #mensaje {
            text-align: center;
            margin-top: 10px;
            font-size: 1.1em;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="form-container">
            <h1>Subir Video</h1>
            <form id="formRegistro">
                <div class="form-group">
                    <label for="titulo">Título</label>
                    <input type="text" class="form-control" id="titulo" name="titulo" placeholder="Ingrese el titulo" required>
                </div>

                <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <input type="text" class="form-control" id="descripcion" name="descripcion" placeholder="Ingrese la descripcion" required>
                </div>

                <div class="form-group">
                    <label for="autor">Autor</label>
                    <input type="text" class="form-control" id="autor" name="autor" placeholder="Ingrese el autor" required>
                </div>

                <div class="form-group">
                    <label for="linkYT">Link YT</label>
                    <input type="text" class="form-control" id="linkYT" name="linkYT" placeholder="Ingrese el link de YT" required>
                </div>

                <div id="mensaje" class="text-white font-weight-bold"></div>

                <br><br>
                <input type="submit" class="btn btn-block" value="Subir Video">
            </form>
        </div>
    </div>

    <!-- Scripts de Bootstrap -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Script para enviar datos por fetch -->
    <script>
        document.getElementById("formRegistro").addEventListener("submit", function(event) {
            event.preventDefault();

            const data = {
                titulo: document.getElementById("titulo").value,
                descripcion: document.getElementById("descripcion").value,
                autor: document.getElementById("autor").value,
                url: document.getElementById("linkYT").value,
                fechaCreacion: new Date().toISOString().split('T')[0],
                duracion: 0,
                formato: "MP4",
                reproducciones: 0
            };

            fetch("http://localhost:8080/webapp2/api/videos", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(data)
            })
            .then(response => response.text())
            .then(texto => {
                const mensaje = document.getElementById("mensaje");
                mensaje.textContent = texto;
                if (texto.includes("éxito")) {
                    document.getElementById("formRegistro").reset();
                    setTimeout(() => {
                        window.location.href = "listadoVid.jsp";
                    }, 2000);
                }
            })
            .catch(error => {
                document.getElementById("mensaje").textContent = "Error al registrar el video.";
                console.error(error);
            });
        });
    </script>
</body>
</html>
