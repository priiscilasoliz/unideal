<?php
// Configuración de conexión a la base de datos
$host = "localhost";
$usuario = "root";
$contrasena = "";
$base_de_datos = "unideal";

// Conectar a la base de datos
$conn = new mysqli($host, $usuario, $contrasena, $base_de_datos);

// Verificar conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Obtener el término de búsqueda
$q = isset($_GET['q']) ? $conn->real_escape_string($_GET['q']) : "";

// Inicializar resultados
$resultados = [];

if (strlen($q) >= 2) {
    $sql = "SELECT Nombre_Universidad, Acronimo 
            FROM universidades 
            WHERE Nombre_Universidad LIKE '%$q%' OR Acronimo LIKE '%$q%'
            LIMIT 10";

    $res = $conn->query($sql);

    // Verificar que la consulta no haya fallado
    if (!$res) {
        echo json_encode(["error_sql" => $conn->error]);
    } else {
        while ($fila = $res->fetch_assoc()) {
            $nombre = $fila["Nombre_Universidad"];
            $acronimo = $fila["Acronimo"];
            $resultados[] = "$nombre ($acronimo)";
        }

        // Devolver resultados en formato JSON
        header('Content-Type: application/json');
        echo json_encode($resultados);
    }
} else {
    // Si no hay suficientes caracteres, devolver array vacío
    echo json_encode([]);
}

// Cerrar conexión
$conn->close();
?>
