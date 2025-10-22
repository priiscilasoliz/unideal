<?php
	$dbhost = 'localhost';
	$dbuser = 'a0030189_Martin';
	$dbpass = 'MartinPA1126';
	$dbname = 'a0030189_uzo';

$conn = new mysqli($host, $user, $password, $dbname);

if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

$provincia = isset($_GET['provincia']) ? $_GET['provincia'] : '';
$localidad = isset($_GET['localidad']) ? $_GET['localidad'] : '';
$tipo = isset($_GET['tipo']) ? $_GET['tipo'] : '';

$query = "SELECT u.Acronimo
          FROM universidades u
          INNER JOIN localidades l ON u.ID_Localidad = l.ID_Localidad
          INNER JOIN provincias p ON l.ID_Provincia = p.ID_Provincia
          WHERE 1=1";

if (!empty($provincia)) {
    $query .= " AND p.ID_Provincia = " . intval($provincia);
}
if (!empty($localidad)) {
    $query .= " AND l.ID_Localidad = " . intval($localidad);
}
if (!empty($tipo)) {
    $query .= " AND u.Tipo = '" . $conn->real_escape_string($tipo) . "'";
}

$result = $conn->query($query);

$links = [
    "UNLAM"  => "../HTML/unlam.html",
    "UTN"    => "../HTML/utn.html",
    "UNAHUR" => "../HTML/unahur.html",
    "UNO"    => "../HTML/uno.html",
    "UNTREF" => "../HTML/untref.html",
    "UNM"    => "../HTML/unm.html",
    "UM"     => "../HTML/moron.html",
    "CUDI"   => "../HTML/cudi.html"
];

if ($result && $result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $acronimo = $row['Acronimo'];

    if (isset($links[$acronimo])) {
        header("Location: " . $links[$acronimo]);
        exit();
    } else {
        echo "No hay una página definida para el acrónimo: " . htmlspecialchars($acronimo);
    }
} else {
    echo "No se encontraron resultados.";
}

$conn->close();
?>
