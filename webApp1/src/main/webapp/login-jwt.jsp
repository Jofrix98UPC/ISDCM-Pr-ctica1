<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login JWT - Sistema de Videos</title>

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

        .btn-secondary {
            background-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #545b62;
        }

        .btn-success {
            background-color: #28a745;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        #mensaje {
            text-align: center;
            margin-top: 15px;
            font-size: 1.1em;
            padding: 15px;
            border-radius: 5px;
        }

        .mensaje-exito {
            background-color: rgba(40, 167, 69, 0.8);
            color: #fff;
        }

        .mensaje-error {
            background-color: rgba(220, 53, 69, 0.8);
            color: #fff;
        }

        .jwt-container {
            background-color: rgba(52, 58, 64, 0.8);
            padding: 15px;
            border-radius: 5px;
            margin: 15px 0;
        }

        .jwt-textarea {
            background-color: rgba(248, 249, 250, 0.9);
            color: #212529;
            font-family: 'Courier New', monospace;
            font-size: 12px;
            border: 1px solid #dee2e6;
            resize: vertical;
            width: 100%;
            border-radius: 3px;
            padding: 8px;
        }

        .info-text {
            font-size: 0.9em;
            color: #e9ecef;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="form-container">
            <h1>🔐 Login JWT</h1>
            <p class="text-center text-light mb-4">Autenticación con JSON Web Token</p>
            
            <form id="loginForm">
                <div class="form-group">
                    <label for="username">Usuario</label>
                    <input type="text" class="form-control" id="username" name="username" 
                           placeholder="Introduce tu nombre de usuario" required>
                </div>

                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Introduce tu contraseña" required>
                </div>

                <div id="mensaje"></div>

                <br>
                <input type="submit" class="btn btn-block" value="Iniciar Sesión">
            </form>
        </div>
    </div>

    <!-- Scripts de Bootstrap -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.getElementById("loginForm").addEventListener("submit", function(event) {
            event.preventDefault();

            const username = document.getElementById("username").value;
            const password = document.getElementById("password").value;
            const mensaje = document.getElementById("mensaje");

            // Mostrar mensaje de carga
            mensaje.innerHTML = '<div class="text-center text-light">🔄 Verificando credenciales...</div>';
            mensaje.className = "";

            // Crear parámetros URL-encoded
            const params = new URLSearchParams();
            params.append('username', username);
            params.append('password', password);

            // Realizar petición POST al servicio REST (cambiar URL para comunicación entre apps)
            fetch('http://localhost:8080/webapp2/api/auth/login', {
                method: "POST",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params
            })
            .then(response => response.text())
            .then(data => {
                console.log('Data recibida:', data);
                
                try {
                    const jsonData = JSON.parse(data);
                    
                    if (jsonData.success) {
                        mensaje.className = "mensaje-exito";
                        
                        // Obtener el JWT de la respuesta
                        const jwtToken = jsonData.JWT || 'JWT no encontrado en la respuesta';
                        const userName = jsonData.user || 'Usuario no especificado';
                        
                        // Crear el contenedor del JWT primero
                        mensaje.innerHTML = `
                            <div>
                                <h5>✅ ¡Login Exitoso!</h5>
                                <p><strong>Usuario:</strong> ${userName}</p>
                                <p><strong>Mensaje:</strong> ${jsonData.message}</p>
                                
                                <div class="jwt-container">
                                    <p><strong>🔑 JWT Generado:</strong></p>
                                    <textarea class="jwt-textarea" rows="6" readonly id="jwtTokenArea"></textarea>
                                    
                                    <div class="text-center mt-3">
                                        <a href="https://jwt.io/" target="_blank" class="btn btn-info btn-sm">
                                            🔍 Verificar en JWT.io
                                        </a>
                                        <button type="button" class="btn btn-success btn-sm ml-2" onclick="copiarJWT()">
                                            📋 Copiar JWT
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="info-text">
                                    <small>
                                        <strong>Instrucciones:</strong> Copia el JWT y pégalo en jwt.io para ver su contenido decodificado.
                                        <br>El token es válido por 1 hora.
                                    </small>
                                </div>
                            </div>
                        `;
                        
                        // Usar setTimeout para asegurar que el DOM esté listo
                        setTimeout(() => {
                            const jwtTextarea = document.getElementById('jwtTokenArea');
                            if (jwtTextarea) {
                                jwtTextarea.value = jwtToken;
                                console.log('JWT asignado al textarea:', jwtToken);
                            } else {
                                console.error('No se encontró el textarea con ID jwtTokenArea');
                            }
                        }, 100);
                        
                        // Limpiar formulario
                        document.getElementById("loginForm").reset();
                        
                    } else {
                        mensaje.className = "mensaje-error";
                        mensaje.innerHTML = `
                            <div>
                                <h5>❌ Error de Autenticación</h5>
                                <p><strong>Mensaje:</strong> ${jsonData.message}</p>
                                <p>Verifica que el usuario y contraseña sean correctos.</p>
                            </div>
                        `;
                    }
                } catch (e) {
                    console.error('Error parsing JSON:', e);
                    mensaje.className = "mensaje-error";
                    mensaje.innerHTML = `
                        <div>
                            <h5>❌ Error de formato</h5>
                            <p>La respuesta del servidor no es JSON válido.</p>
                            <pre style="background: rgba(0,0,0,0.3); padding: 10px; border-radius: 3px; font-size: 0.8em;">${data}</pre>
                        </div>
                    `;
                }
            })
            .catch(error => {
                mensaje.className = "mensaje-error";
                mensaje.innerHTML = `
                    <div>
                        <h5>❌ Error de Conexión</h5>
                        <p><strong>Error:</strong> ${error.message}</p>
                        <p>Verifica que el servidor esté funcionando correctamente.</p>
                    </div>
                `;
                console.error('Error:', error);
            });
        });

        // Función para copiar el JWT al portapapeles
        function copiarJWT() {
            console.log('Función copiarJWT llamada');
            const textarea = document.getElementById('jwtTokenArea');
            console.log('Textarea encontrado:', textarea);
            
            if (textarea && textarea.value) {
                console.log('Valor del textarea:', textarea.value);
                textarea.select();
                textarea.setSelectionRange(0, 99999); // Para móviles
                
                try {
                    const successful = document.execCommand('copy');
                    if (successful) {
                        alert('JWT copiado al portapapeles');
                    } else {
                        // Fallback: usar la API moderna del navegador
                        if (navigator.clipboard && navigator.clipboard.writeText) {
                            navigator.clipboard.writeText(textarea.value)
                                .then(() => alert('JWT copiado al portapapeles'))
                                .catch(() => alert('Error al copiar. Selecciona el texto manualmente.'));
                        } else {
                            alert('Error al copiar. Selecciona el texto manualmente.');
                        }
                    }
                } catch (err) {
                    console.error('Error al copiar: ', err);
                    // Fallback moderno
                    if (navigator.clipboard && navigator.clipboard.writeText) {
                        navigator.clipboard.writeText(textarea.value)
                            .then(() => alert('JWT copiado al portapapeles'))
                            .catch(() => alert('Error al copiar. Selecciona el texto manualmente.'));
                    } else {
                        alert('No se pudo copiar automáticamente. Selecciona y copia manualmente.');
                    }
                }
            } else {
                console.error('Textarea no encontrado o sin contenido');
                alert('Error: No hay JWT para copiar');
            }
        }
    </script>
</body>
</html>