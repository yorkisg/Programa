<?php

include_once 'conexion.php';

$sql = 'SELECT * FROM tabla';

$gsent = $pdo->prepare($sql);
$gsent->execute();

$resultado = $gsent->fetchall();

//var_dump($resultado);

//AGREGAR

if($_POST){

	$id = $_POST['id'];
	$nombre = $_POST['nombre'];

	$sql_agregar = 'INSERT INTO tabla (id, nombre) VALUES (?,?) ';

	$sentencia_agregar = $pdo->prepare($sql_agregar);
	$sentencia_agregar->execute(array($id,$nombre));

	header('location:index.php');

} 

if($_GET){

$id=$_GET['id'];

$sql_unico = 'SELECT * FROM tabla WHERE id=?';

$gsent_unico = $pdo->prepare($sql_unico);
$gsent_unico->execute(array($id));

$resultado_unico = $gsent_unico->fetch();

//var_dump($resultado_unico);

}

?>

<!doctype html>
<html lang="en">
	  <head>
	    <!-- Required meta tags -->
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	    <!-- Bootstrap CSS -->
	    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.0/css/all.css">

	   <title> Hola estoy probando algo </title>

	  </head>

  <body>

     <!--<h1>Hello, world!</h1>--> 

     <h1> 

		<h1> 



		</h1>

     </h1>

	<div class_"container mt-5">

		<div class="row">

			<div class="col-md-4 ">

				<?php foreach($resultado as $dato): ?>

						<div class="alert alert-<?php echo $dato['nombre'] ?> text-uppercase"
						role="alert">

					  		<?php echo $dato['id'] ?>
							-
							<?php echo $dato['nombre'] ?>

							<a href="eliminar.php?id=<?php echo $dato['id'] ?>" 
							 class="float-right ml-3"> 
								<i class="fas fa-trash-alt"></i>
							</a>

							<a href="index.php?id=<?php echo $dato['id'] ?>" 
								class="float-right"> 
								<i class="fas fa-edit"></i>
							</a>

					</div>

				<?php endforeach ?>

			</div>

			<div class=col-md-6">

				<?php if(!$_GET): ?>

					<h2> AGREGAR ELEMENTOS </h2>

					<form method="POST">

					 	<form>
					 		<input type="text" class="form-control" name="id">
					 		<input type="text" class="form-control mt-3" name="nombre">
					 		<button class="btn btn-primary mt-3"> Agregar </button>
					 	</form>

				<?php endif ?>	

				<?php if($_GET): ?>

					<h2> EDITAR ELEMENTOS </h2>

					<form method="GET" action="editar.php">

					 	<form>
					 		<input type="text" class="form-control" name="id"

					 		value="<?php echo $resultado_unico['id']?> ">

					 		<input type="text" class="form-control mt-3" name="nombre"

					 		value="<?php echo $resultado_unico['nombre']?> ">

					 		<input type="hidden" name="id"
					 		value="<?php echo $resultado_unico['id']?> ">

					 		<button class="btn btn-primary mt-3"> Agregar </button>
					 	</form>

				<?php endif ?>	

			</div>

		</div>

	</div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
  
</html>