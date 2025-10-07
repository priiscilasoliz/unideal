<?php
$conexion = new mysqli("localhost", "root", "", "unideal");
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

$q = isset($_GET['q']) ? trim($conexion->real_escape_string($_GET['q'])) : '';

$basePath = "/unideal/unideal/HTML/"; // ajustá si tu proyecto se llama distinto

$links = [
    "UNLAM"  => $basePath . "unlam.html",
    "UTN"    => $basePath . "utn.html",
    "UNAHUR" => $basePath . "unahur.html",
    "UNO"    => $basePath . "uno.html",
    "UNTREF" => $basePath . "untref.html",
    "UNM"    => $basePath . "unm.html",
    "UM"     => $basePath . "moron.html",
    "CUDI"   => $basePath . "cudi.html"
];

$sugerencias = [];

if ($q !== '') {
    // 🔹 Buscar universidades
    $sql_uni = "
        SELECT Nombre_Universidad, Acronimo
        FROM universidades
        WHERE Nombre_Universidad LIKE '%$q%' COLLATE utf8mb4_general_ci
           OR Acronimo LIKE '%$q%' COLLATE utf8mb4_general_ci
        LIMIT 15
    ";

    $res_uni = $conexion->query($sql_uni);
    if ($res_uni && $res_uni->num_rows > 0) {
        while ($row = $res_uni->fetch_assoc()) {
            $nombre = $row['Nombre_Universidad'];
            $acronimo = $row['Acronimo'];
            $url = $links[$acronimo] ?? '#';

            $sugerencias[] = [
                'nombre' => $nombre,
                'acronimo' => $acronimo,
                'url' => $url,
                'tipo' => 'universidad'
            ];
        }
    }

    // 🔹 Buscar carreras (usando tus columnas reales)
    $sql_carr = "
        SELECT c.Nombre_Carrera, u.Acronimo, c.URL_Carrera
        FROM carreras c
        INNER JOIN universidades u ON c.ID_Universidad = u.ID_Universidad
        WHERE c.Nombre_Carrera LIKE '%$q%' COLLATE utf8mb4_general_ci
        LIMIT 25
    ";

    $res_carr = $conexion->query($sql_carr);
    if ($res_carr && $res_carr->num_rows > 0) {
        while ($row = $res_carr->fetch_assoc()) {
            $nombre = $row['Nombre_Carrera'];
            $acronimo = $row['Acronimo'];
            $url = $row['URL_Carrera'];

            // Si no tiene URL, mandamos al HTML de la universidad
            if (empty($url)) {
                $url = $links[$acronimo] ?? '#';
            }

            $sugerencias[] = [
                'nombre' => $nombre,
                'acronimo' => $acronimo,
                'url' => $url,
                'tipo' => 'carrera'
            ];
        }
    }
}

header('Content-Type: application/json; charset=utf-8');
echo json_encode($sugerencias, JSON_UNESCAPED_UNICODE);
$conexion->close();
?>
