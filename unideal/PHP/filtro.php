<?php
// Datos de conexión (los podés pasar como variables de entorno)
$host = "br-patient-sun-acvqmba9.neon.tech"; // reemplazar con tu host de Neon
$port = "5432";
$dbname = "unideal";
$user = "neondb_owner";
$password = "npg_pw0DCkord7VB";

try {
    $pdo = new PDO("pgsql:host=$host;port=$port;dbname=$dbname", $user, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    exit("Error de conexión: " . $e->getMessage());
}

// Obtener filtros
$provincia = $_GET['provincia'] ?? '';
$localidad = $_GET['localidad'] ?? '';
$tipo = $_GET['tipo'] ?? '';

// Consulta base
$sql = "SELECT u.acronimo
        FROM universidades u
        JOIN localidades l ON u.id_localidad = l.id_localidad
        JOIN provincias p ON l.id_provincia = p.id_provincia
        WHERE 1=1";

$params = [];

if ($provincia !== '') {
    $sql .= " AND p.id_provincia = :provincia";
    $params[':provincia'] = $provincia;
}
if ($localidad !== '') {
    $sql .= " AND u.id_localidad = :localidad";
    $params[':localidad'] = $localidad;
}
if ($tipo !== '') {
    $sql .= " AND u.tipo = :tipo";
    $params[':tipo'] = $tipo;
}

$stmt = $pdo->prepare($sql);
$stmt->execute($params);

if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    // Acrónimo encontrado
    $acronimo = $row['acronimo'];

    // Aquí vos podés definir manualmente la URL según el acrónimo
    switch ($acronimo) {
        case 'UBA':
            $pagina = 'https://www.uba.ar';
            break;
        case 'UNLP':
            $pagina = 'https://www.unlp.edu.ar';
            break;
        default:
            $pagina = 'https://www.ejemplo.com';
            break;
    }

    header("Location: $pagina");
    exit();
} else {
    exit("No se encontró ninguna universidad con esos filtros.");
}
?>
