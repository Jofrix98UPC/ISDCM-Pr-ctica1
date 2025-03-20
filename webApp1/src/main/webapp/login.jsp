<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login - Plataforma de Streaming</title>

    <!-- Enlace a Bootstrap 4 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
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
    <div class ="container">
        <div class="form-container">
            <h1>Iniciar Sesión</h1>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
                <p style="color: red;"><%= errorMessage %></p>
            <% } %>
            <form action="servletLoginUsuarios" method="POST" accept-charset="UTF-8">
                <!-- Nombre de usuario -->
                <div class="form-group">
                    <label for="username">Nombre de Usuario</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Ingrese su nombre de usuario" required>
                </div>

                <!-- Contraseña -->
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Ingrese su contraseña" required>
                </div>

                <!-- Botón de iniciar sesión -->
                <button type="submit" class="btn btn-primary btn-block">Iniciar sesión</button>

                <!-- Enlace para el registro -->
                <p class="mt-3 text-center">¿No tienes cuenta? <a href="./registroUsu.jsp" style="color: #007bff;">Regístrate aquí</a></p>
            </form>
        </div>
    </div>

    <!-- Scripts de Bootstrap -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy0ht7xHiGJw0M8PaO5u6ZY1d2r8c7Z5Q4py6j0E" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0E6pDhRl1t7fX02r6vYxj9a7u4s4g0Ds2U6M6dVIZh8Yt9N5" crossorigin="anonymous"></script>
</body>
</html>
