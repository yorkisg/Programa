<?php

$enlace = 'mysql:host=localhost;dbname=prueba';
$usuario = 'root';
$contraseña = '';

try {
    
    $pdo = new pdo($enlace,$usuario,$contraseña);
    
    //echo 'Conexion';

 	//foreach($pdo->query('SELECT * FROM `tabla`') as $fila) {
    //print_r($fila);
	//}

} catch (PDOException $e) {
    
    print "¡Error!: " . $e->getMessage() . "<br/>";
    die();
}