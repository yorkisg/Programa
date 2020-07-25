<?php 

/*echo 'editar.php?id=1&nombre=sucess';
echo '<br>';
*/

$id = $_GET['id'];
$nombre = $_GET['nombre'];

/*echo $id;
echo '<br>';
echo $nombre;
echo '<br>';
*/

include_once 'conexion.php';

$sql_editar = 'UPDATE tabla SET nombre=? WHERE id=? ';

$sentencia_editar = $pdo->prepare($sql_editar);

$sentencia_editar->execute(array($nombre,$id));

header('location:index.php');