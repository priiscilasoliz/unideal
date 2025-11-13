<?php
session_start();

// Conexión a la base de datos
$conexion = new mysqli("localhost", "root", "", "unideal");
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

// Solo procesar POST
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $email = trim($_POST["email"]);
    $password = trim($_POST["password"]);

    // Buscar el usuario por email
    $stmt = $conexion->prepare("SELECT ID_Usuario, Nombre_Usuario, Contraseña, ID_Rol FROM usuarios WHERE Email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $resultado = $stmt->get_result();

    if ($resultado->num_rows === 1) {
        $usuario = $resultado->fetch_assoc();

        // Verificar contraseña
        if (password_verify($password, $usuario["Contraseña"])) {
            // Guardar datos en sesión
            $_SESSION["usuario_id"] = $usuario["ID_Usuario"];
            $_SESSION["usuario_nombre"] = $usuario["Nombre_Usuario"];
            $_SESSION["usuario_rol"] = $usuario["ID_Rol"];

            // Crear cookie para indicar sesión activa (solo indicador, sin datos sensibles)
            setcookie("sesionActiva", "1", time() + 3600, "/"); // dura 1 hora

            // Redirigir según rol
            if ($usuario["ID_Rol"] == 3) {
                header("Location: admin_dashboard.php");
            } elseif ($usuario["ID_Rol"] == 2) {
                header("Location: moderador_dashboard.php");
            } else {
                header("Location: ../index.html");
            }
            exit;

        } else {
            echo "<script>alert('Contraseña incorrecta.'); window.history.back();</script>";
        }

    } else {
        echo "<script>alert('No existe una cuenta con ese correo.'); window.history.back();</script>";
    }

    $stmt->close();
}

$conexion->close();
?>
