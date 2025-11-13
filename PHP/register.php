<?php
// register.php
$conexion = new mysqli("localhost", "root", "", "unideal");

if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nombre = trim($_POST["nombre"]);
    $email = trim($_POST["email"]);
    $password = trim($_POST["password"]);

    // Validación básica
    if (empty($nombre) || empty($email) || empty($password)) {
        die("Por favor completá todos los campos.");
    }

    // 🔒 Validación de seguridad de contraseña
    $errores = [];

    if (strlen($password) < 8) {
        $errores[] = "La contraseña debe tener al menos 8 caracteres.";
    }
    if (!preg_match('/[A-Z]/', $password)) {
        $errores[] = "La contraseña debe contener al menos una letra mayúscula.";
    }
    if (!preg_match('/[a-z]/', $password)) {
        $errores[] = "La contraseña debe contener al menos una letra minúscula.";
    }
    if (!preg_match('/\d/', $password)) {
        $errores[] = "La contraseña debe contener al menos un número.";
    }
    if (!preg_match('/[\W_]/', $password)) { // símbolos o guiones bajos
        $errores[] = "La contraseña debe contener al menos un símbolo (por ejemplo: ! @ # $ % & *).";
    }

    // Si hay errores, se muestran en alerta
    if (!empty($errores)) {
        $mensaje = implode("\\n", $errores);
        echo "<script>alert('$mensaje'); window.history.back();</script>";
        exit;
    }

    // Verificar si el correo ya existe
    $stmt = $conexion->prepare("SELECT * FROM usuarios WHERE Email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $resultado = $stmt->get_result();

    if ($resultado->num_rows > 0) {
        echo "<script>alert('El correo ya está registrado.'); window.history.back();</script>";
        exit;
    }

    // Hashear contraseña
    $hash = password_hash($password, PASSWORD_BCRYPT);

    // Insertar usuario nuevo
    $stmt = $conexion->prepare("INSERT INTO usuarios (Nombre_Usuario, Email, Contraseña, ID_Rol) VALUES (?, ?, ?, 1)");
    $stmt->bind_param("sss", $nombre, $email, $hash);

    if ($stmt->execute()) {
        echo "<script>alert('Cuenta creada correctamente. Ahora podés iniciar sesión.'); window.location.href='login_register.html';</script>";
    } else {
        echo "Error al registrar el usuario: " . $stmt->error;
    }

    $stmt->close();
}
$conexion->close();
?>
