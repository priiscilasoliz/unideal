<?php
$mysqli = new mysqli("localhost", "root", "", "unideal");
if ($mysqli->connect_errno) {
    exit("Fallo al conectar a MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error);
}

$provincia = isset($_GET['provincia']) ? $mysqli->real_escape_string($_GET['provincia']) : '';
$localidad = isset($_GET['localidad']) ? $mysqli->real_escape_string($_GET['localidad']) : '';
$tipo = isset($_GET['tipo']) ? $mysqli->real_escape_string($_GET['tipo']) : '';

$sql = "SELECT u.Enlace_Web
        FROM Universidades u
        JOIN Localidades l ON u.ID_Localidad = l.ID_Localidad
        JOIN Provincias p ON l.ID_Provincia = p.ID_Provincia
        WHERE 1=1";

if ($provincia !== '') $sql .= " AND p.ID_Provincia = '$provincia'";
if ($localidad !== '') $sql .= " AND u.ID_Localidad = '$localidad'";
if ($tipo !== '') $sql .= " AND u.Tipo = '$tipo'";

$result = $mysqli->query($sql);

if ($result && $result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $enlace = $row['Enlace_Web'];

    if (!empty($enlace)) {
        header("Location: " . $enlace);
        exit();
    } else {
        exit("La universidad no tiene un enlace configurado.");
    }
} else {
    exit("No se encontraron universidades con esos filtros.");
}

$mysqli->close();
?>
