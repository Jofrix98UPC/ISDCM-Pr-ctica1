<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registro de Usuario</title>

    <!-- Enlace a Bootstrap 4 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-pzjw8f+ua7Kw1TIq0E6pDhRl1t7fX02r6vYxj9a7u4s4g0Ds2U6M6dVIZh8Yt9N5" crossorigin="anonymous">

    <!-- Estilos personalizados -->
    <style>
        /* Fondo de pantalla con tema de streaming */
        body {
            background-image: url('https://smartframe.io/wp-content/uploads/2021/11/Image-streaming-How-it-works-why-you-need-it-and-everything-else-you-need-to-know_SWM.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Arial', sans-serif;
            margin: 0;
        }

        .container {
            width: 100%;
            max-width: 600px;
        }

        .form-container {
            background-color: rgba(25, 25, 112, 0.85); /* Fondo azul marino semi-transparente */
            padding: 30px;
            border-radius: 5px; /* Bordes no redondeados */
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
            background-color: rgba(245, 245, 245, 0.7); /* Gris claro y algo transparente */
            color: #333; /* Texto más oscuro para mejor contraste */
            border: 1px solid #ddd; /* Borde suave gris */
            font-size: 1.1em;
            border-radius: 0px; /* Campos sin bordes redondeados */
        }

        .form-control:focus {
            background-color: rgba(245, 245, 245, 0.9); /* Gris más opaco cuando se hace foco */
            border-color: #007bff;
            color: #333;
            box-shadow: none;
        }

        label {
            font-size: 1.1em;
            font-weight: 600;
            color: #f0f8ff;
        }

        .btn {
            background-color: #007bff;
            color: #fff;
            border-radius: 5px; /* Bordes no redondeados */
            font-size: 1.1em;
            padding: 10px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .form-group {
            margin-bottom: 20px;
        }

        /* Animación para el formulario */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .form-container {
            animation: fadeIn 1s ease-in-out;
        }
        
        /* Centrado de formulario en pantalla */
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="form-container">
            <h1>Registro de Usuario</h1>
            <form action="#" method="POST">
                <!-- Nombre -->
                <div class="form-group">
                    <label for="nombre">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese su nombre" required>
                </div>

                <!-- Apellidos -->
                <div class="form-group">
                    <label for="apellidos">Apellidos</label>
                    <input type="text" class="form-control" id="apellidos" name="apellidos" placeholder="Ingrese sus apellidos" required>
                </div>

                <!-- Correo electrónico -->
                <div class="form-group">
                    <label for="correo">Correo Electrónico</label>
                    <input type="email" class="form-control" id="correo" name="correo" placeholder="Ingrese su correo electrónico" required>
                </div>

                <!-- Nombre de usuario -->
                <div class="form-group">
                    <label for="usuario">Nombre de Usuario</label>
                    <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Ingrese un nombre de usuario" required>
                </div>

                <!-- Contraseña -->
                <div class="form-group">
                    <label for="contraseña">Contraseña</label>
                    <input type="password" class="form-control" id="contraseña" name="contraseña" placeholder="Ingrese su contraseña" required>
                </div>

                <!-- Repetir contraseña -->
                <div class="form-group">
                    <label for="repetirContraseña">Repetir Contraseña</label>
                    <input type="password" class="form-control" id="repetirContraseña" name="repetirContraseña" placeholder="Repita su contraseña" required>
                </div>

                <!-- Botón de enviar -->
                <button type="submit" class="btn btn-primary btn-block">Registrar</button>
            </form>
        </div>
    </div>

    <!-- Scripts de Bootstrap -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy0ht7xHiGJw0M8PaO5u6ZY1d2r8c7Z5Q4py6j0E" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0E6pDhRl1t7fX02r6vYxj9a7u4s4g0Ds2U6M6dVIZh8Yt9N5" crossorigin="anonymous"></script>
</body>
</html>
