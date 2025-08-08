<?php
$mysqli = new mysqli("localhost", "root", "", "unideal");
if ($mysqli->connect_errno) {
    exit("Fallo al conectar a MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error);
}

$provincia = isset($_GET['provincia']) ? $mysqli->real_escape_string($_GET['provincia']) : '';
$localidad = isset($_GET['localidad']) ? $mysqli->real_escape_string($_GET['localidad']) : '';
$tipo = isset($_GET['tipo']) ? $mysqli->real_escape_string($_GET['tipo']) : '';

$sql = "SELECT u.Acronimo
        FROM Universidades u
        JOIN Provincias p ON u.ID_Provincia = p.ID_Provincia
        JOIN Localidades l ON u.ID_Localidad = l.ID_Localidad
        WHERE 1=1";

if ($provincia !== '') $sql .= " AND u.ID_Provincia = '$provincia'";
if ($localidad !== '') $sql .= " AND u.ID_Localidad = '$localidad'";
if ($tipo !== '') $sql .= " AND u.Tipo = '$tipo'";

$result = $mysqli->query($sql);

if ($result && $result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $acronimo = $row['Acronimo'];

    $paginas = [
        "UnLaM"  => "../HTML/unlam.html",
        "UNM"    => "../HTML/unm.html",
        "UNO"    => "../HTML/uno.html",
        "UNTREF" => "../HTML/untref.html",
        "UTN"    => "../HTML/utn.html",
        "UNAHUR" => "../HTML/unahur.html"
    ];

    if (isset($paginas[$acronimo])) {
        header("Location: " . $paginas[$acronimo]);
        exit();
    } else {
        exit("Universidad no mapeada a página.");
    }
} else {
    exit("No se encontraron universidades con esos filtros.");
}

$mysqli->close();
?>
