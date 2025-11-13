<?php
// Dev-only endpoint: devuelve carreras relacionadas a una "categoría" simple
// Recibe GET 'area' con valores esperados: tecnologia, arte, social, empresarial

$conexion = new mysqli("localhost", "root", "", "unideal");
if ($conexion->connect_error) {
    http_response_code(500);
    echo json_encode(['error' => 'Error de conexión a la base de datos']);
    exit;
}

$area = isset($_GET['area']) ? trim($conexion->real_escape_string($_GET['area'])) : '';

// BasePath para páginas HTML locales (igual que en buscador.php)
$basePath = "/unideal/HTML/";

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


// Mapeo usando IDs de la tabla `areas` (más fiable que búsqueda por palabras)
// Mapear categoría del test a uno o más ID_Area según `unideal.sql`.
$area_map = [
    'tecnologia' => [10, 1], // Informática y Computación (10), Ingeniería y Tecnología (1)
    'arte' => [8],            // Arte y Diseño (8)
    'social' => [3, 7],       // Ciencias Sociales y Humanidades (3), Educación (7)
    'empresarial' => [5]      // Ciencias Económicas y Administrativas (5)
];

$area_ids = $area_map[strtolower($area)] ?? [];
if (!empty($area_ids)) {
    $ids = implode(',', array_map('intval', $area_ids));
    $where = "c.ID_Area IN ($ids)";
} else {
    // Si no reconocemos la categoría, devolvemos las carreras más relevantes (fallback)
    $where = "1=1";
}

$sql = "
    SELECT c.Nombre_Carrera, c.URL_Carrera, u.Acronimo, u.Nombre_Universidad
    FROM carreras c
    INNER JOIN universidades u ON c.ID_Universidad = u.ID_Universidad
    WHERE $where
    ORDER BY RAND()
    LIMIT 6
";


$res = $conexion->query($sql);
$out = [];
if ($res && $res->num_rows > 0) {
    while ($row = $res->fetch_assoc()) {
        $nombre = $row['Nombre_Carrera'];
        $url_carrera = $row['URL_Carrera'];
        $acronimo = $row['Acronimo'];
        $nombre_uni = $row['Nombre_Universidad'];

        if (empty($url_carrera)) {
            // si la carrera no tiene URL, enlazamos a la página local de la universidad (si existe)
            $url_carrera = $links[$acronimo] ?? '';
        }

        $uni_url = $links[$acronimo] ?? '';

        $out[] = [
            'nombre' => $nombre,
            'url' => $url_carrera,
            'universidad_acronimo' => $acronimo,
            'universidad_nombre' => $nombre_uni,
            'universidad_url' => $uni_url
        ];
    }
}

header('Content-Type: application/json; charset=utf-8');
echo json_encode($out, JSON_UNESCAPED_UNICODE);
$conexion->close();
?>
