<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuario</title>

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
            <h1>Registro de Usuario</h1>
            <form action="servletUsuarios" method="POST" accept-charset="UTF-8">
                <div class="form-group">
                    <label for="nombre">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese su nombre" required>
                </div>

                <div class="form-group">
                    <label for="apellidos">Apellidos</label>
                    <input type="text" class="form-control" id="apellidos" name="apellidos" placeholder="Ingrese sus apellidos" required>
                </div>

                <div class="form-group">
                    <label for="correo">Correo Electrónico</label>
                    <input type="email" class="form-control" id="correo" name="correo" placeholder="Ingrese su correo electrónico" required>
                </div>

                <div class="form-group">
                    <label for="usuario">Nombre de Usuario</label>
                    <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Ingrese un nombre de usuario" required>
                </div>

                <div class="form-group">
                    <label for="contrasena">Contraseña</label>
                    <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Ingrese su contraseña" required>
                </div>
                
                <div class="form-group">
                    <label for="repetir-contrasena">Repetir Contraseña</label>
                    <input type="password" class="form-control" id="repetir-contrasena" name="repetir-contrasena" placeholder="Repita su contraseña" required>
                </div>

                <button type="submit" class="btn btn-primary btn-block">Registrar</button>
            </form>
        </div>
    </div>

    <!-- Scripts de Bootstrap -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
