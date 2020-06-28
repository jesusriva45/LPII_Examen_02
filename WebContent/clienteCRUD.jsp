<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">


<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>

<link rel="stylesheet" href="css/bootstrap-4.5.0.min.css" />
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrapValidator.css" />
<link rel="stylesheet" href="css/style.css" />


<title>Sistema de Clientes</title>
</head>
<body>


	<div class="container">

		<h1>Mantenimiento de Cliente</h1>
	</div>


	<c:if test="${sessionScope.ELIMINO != null}">
		<div class="alert alert-${message} } fade in" id="success-alert">
			<a href="#" class="close" data-dismiss="alert">&times;</a> <strong>${sessionScope.ELIMINO}</strong>
		</div>
	</c:if>
	<c:remove var="ELIMINO" />

	<c:if test="${sessionScope.ACTUALIZO != null}">
		<div class="alert alert-${message} fade in" id="success-alert">
			<a href="#" class="close" data-dismiss="alert">&times;</a> <strong>${sessionScope.ACTUALIZO}</strong>
		</div>
	</c:if>
	<c:remove var="ACTUALIZO" />

	<c:if test="${sessionScope.REGISTRO != null}">
		<div class="alert alert-${message} fade in" id="success-alert">
			<a href="#" class="close" data-dismiss="alert">&times;</a> <strong>${sessionScope.REGISTRO}</strong>
		</div>
	</c:if>
	<c:remove var="REGISTRO" />

	<div class="container">
		<div class="col-md-12">
			<form id="idFormElimina" action="ClienteCrudControlador">
				<input type="hidden" name="metodo" value="elimina"> <input
					type="hidden" id="id_elimina" name="id">
			</form>

			<form accept-charset="UTF-8" action="ClienteCrudControlador"
				id="id_form_listar" class="simple_form" id="defaultForm2"
				method="get">

				<input type="hidden" name="metodo" value="lista" id="id_lista"
					name="id">

				<div class="row p-5 m-0">
					<div class="col-md-3">
						<input class="form-control" id="id_filtro" name="filtro"
							placeholder="Ingrese el nombre" type="text" maxlength="30" />
					</div>
					<div class="col-md-3">
						<button type="submit" class="btn btn-primary" id="validateBtnw1"
							style="width: 120px">FILTRA</button>
						<br>&nbsp;<br>
					</div>
					<div class="col-md-3">
						<button type="button" data-toggle='modal' onclick="registrar();"
							class='btn btn-success' id="validateBtnw2" style="width: 120px">REGISTRA</button>
						<br>&nbsp;<br>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="content">

							<table id="table" class="table table-striped table-bordered">
								<thead class="thead-dark">
									<tr>
										<th>Código</th>
										<th>Nombres</th>
										<th>Apellidos</th>
										<th>Correo</th>
										<th>Fecha de Nacimiento</th>
										<th>DNI</th>
										<th>Actualizar</th>
										<th>Eliminar</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach items="${DATA}" var="x">
										<tr>
											<td id="id_user">${x.idcliente}</td>
											<td>${x.nombre}</td>
											<td>${x.apellido}</td>
											<td>${x.correo}</td>
											<td>${x.fechanacimiento}</td>
											<td>${x.dni}</td>


											<td>
												<button type='button' data-toggle='modal'
													onclick="editar('${x.idcliente}','${x.nombre}','${x.apellido}','${x.correo}','${x.fechanacimiento}','${x.dni}');"
													class='btn btn-success'
													style='background-color: hsla(233, 100%, 100%, 0);'>
													<img src='images/edit.gif' width='auto' height='auto'
														alt="" />
												</button>
											</td>
											<td>
												<button type='button' data-toggle='modal'
													onclick="eliminar('${x.idcliente}');"
													class='btn btn-success'
													style='background-color: hsla(233, 100%, 100%, 0);'>
													<img src='images/delete.gif' width='auto' height='auto'
														alt="" />
												</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>

						</div>
					</div>
				</div>
			</form>
		</div>

		<div class="modal fade" id="idModalRegistra">
			<div class="modal-dialog modal-lg" style="width: 100%">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header text-center">
						<h4>
							Registrar Cliente <span class="glyphicon glyphicon-ok-sign"></span>
						</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body" style="padding: 20px 10px;">
						<form id="id_form_registra" accept-charset="UTF-8"
							action="ClienteCrudControlador" class="form-horizontal"
							method="post">
							<input type="hidden" name="metodo" value="registra">

							<div class="panel-group" id="steps">
								<!-- Step 1 -->
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a data-toggle="collapse" data-parent="#steps"
												href="#stepOne">Datos del Cliente</a>
										</h4>
									</div>
									<div id="stepOne" class="panel-collapse collapse in">

										<div class="panel-body">

											<div class="form-group">
												<label class="col-lg-3 control-label"
													for="id_reg_fechaInicio">Nombre</label>
												<div class="col-lg-5">
													<input class="form-control" id="id_reg_nombre"
														name="nombre" placeholder="Ingrese su nombre" type="text"
														maxlength="30" />
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label" for="id_reg_apellido">Apellido</label>
												<div class="col-lg-5">
													<input class="form-control" id="id_reg_apellido"
														name="apellido" placeholder="Apellido" type="text"
														maxlength="30" />
												</div>
											</div>

											<div class="form-group">
												<label class="col-lg-3 control-label" for="id_reg_correo">Correo</label>
												<div class="col-lg-5">
													<input class="form-control" id="id_reg_correo"
														name="correo" placeholder="xxx.xxx.xxx@xxx.xx" 
														maxlength="40" />
												</div>
											</div>

											<div class="form-group">
												<label class="col-lg-3 control-label" for="id_reg_fecha">Fecha
													de Nacimiento</label>
												<div class="col-lg-5">
													<input class="form-control" id="id_reg_fecha" name="fecha"
														placeholder="1000-10-10" type="text" />
												</div>
											</div>



											<div class="form-group">
												<label class="col-lg-3 control-label" for="id_reg_dni">DNI</label>
												<div class="col-lg-5">
													<input class="form-control" id="id_reg_dni" name="dni"
														placeholder="Ingrese su DNI" type="text" maxlength="8" />
												</div>
											</div>



											<div class="form-group">
												<div class="col-lg-9 col-lg-offset-3">
													<button type="submit" class="btn btn-primary">REGISTRA</button>
												</div>
											</div>
										</div>
									</div>
								</div>

							</div>
						</form>

					</div>
				</div>
			</div>

		</div>

		<div class="modal fade" id="idModalActualiza">
			<div class="modal-dialog modal-lg" style="width: 100%">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header text-center">
						<h4>
							Actualizar Cliente <span class="glyphicon glyphicon-ok-sign"></span>
						</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body" style="padding: 20px 10px;">
						<form id="id_form_actualiza" accept-charset="UTF-8"
							action="ClienteCrudControlador" class="form-horizontal"
							method="post">
							<input type="hidden" name="metodo" value="actualiza">
							<div class="panel-group" id="steps">
								<!-- Step 1 -->
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a data-toggle="collapse" data-parent="#steps"
												href="#stepOne">Datos del Usuario</a>
										</h4>
									</div>
									<div id="stepOne" class="panel-collapse collapse in">
										<div class="panel-body">




											<div class="form-group">
												<label class="col-lg-3 control-label" for="id_act_iduser">ID_Cliente</label>
												<div class="col-lg-5">
													<input class="form-control" id="id_act_iduser"
														name="iduser" placeholder="Ingresu ID" type="text"
														maxlength="8" readonly />
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label"
													for="id_reg_fechaInicio">Nombre</label>
												<div class="col-lg-5">
													<input class="form-control" id="id_act_nombre"
														name="nombre" placeholder="Ingrese su nombre" type="text"
														maxlength="30" />
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label" for="id_act_apellido">Apellido</label>
												<div class="col-lg-5">
													<input class="form-control" id="id_act_apellido"
														name="apellido" placeholder="Apellido" type="text"
														maxlength="30" />
												</div>
											</div>

											<div class="form-group">
												<label class="col-lg-3 control-label" for="id_act_correo">Correo</label>
												<div class="col-lg-5">
													<input class="form-control" id="id_act_correo"
														name="correo" placeholder="xxx.xxx.xxx@xxx.xx" maxlength="40" />
												</div>
											</div>


											<div class="form-group">
												<label class="col-lg-3 control-label" for="id_act_fecha">Fecha
													de Nacimiento</label>
												<div class="col-lg-5">
													<input class="form-control" id="id_act_fecha" name="fecha"
														placeholder="1000-12-31" type="text" />
												</div>
											</div>


											<div class="form-group">
												<label class="col-lg-3 control-label" for="id_act_dni">DNI</label>
												<div class="col-lg-5">
													<input class="form-control" id="id_act_dni" name="dni"
														placeholder="Ingrese su DNI" type="text" maxlength="8" />
												</div>
											</div>







											<div class="form-group">
												<div class="col-lg-9 col-lg-offset-3">
													<button type="submit" class="btn btn-primary"
														onclick="ocultar_act();">ACTUALIZA</button>
												</div>
											</div>
										</div>
									</div>
								</div>

							</div>
						</form>

					</div>
				</div>
			</div>

		</div>

	</div>
	<script type="text/javascript">
		$("#success-alert").fadeTo(1000, 500).slideUp(500, function() {
			$("#success-alert").slideUp(500);
		});
	</script>


	<script type="text/javascript">
		function registrar() {

			$('#idModalRegistra').modal("show");

		}

		function eliminar(id) {
			$('input[id=id_elimina]').val(id);
			$('#idFormElimina').submit();
		}

		function editar(iduser, nombre, apellido, correo, fecha, dni) {

			$('input[id=id_act_iduser]').val(iduser);
			$('input[id=id_act_nombre]').val(nombre);
			$('input[id=id_act_apellido]').val(apellido);
			$('input[id=id_act_correo]').val(correo);
			$('input[id=id_act_fecha]').val(fecha);
			$('input[id=id_act_dni]').val(dni);
			$('#idModalActualiza').modal("show");

		}

		function ocultar(id) {
			var pass = "#" + id;
			console.log(pass);

			$(pass).css("-webkit-text-security", "disc");
		}

		function mostrar(id) {
			var pass = "#" + id;
			console.log(pass);
			$(pass).css("-webkit-text-security", "");
		}

		function ocultar_reg() {
			$('#id_reg_pass').css("-webkit-text-security", "disc");
		}

		function mostrar_reg() {
			$('#id_reg_pass').css("-webkit-text-security", "");
		}

		function ocultar_act() {
			$('#id_act_pass').css("-webkit-text-security", "disc");
		}

		function mostrar_act() {
			$('#id_act_pass').css("-webkit-text-security", "");
		}

		$(document).ready(function() {
			$('#table').DataTable();

		});
	</script>

	<script type="text/javascript">
		$('#id_form_registra')
				.bootstrapValidator(
						{
							message : 'This value is not valid',
							feedbackIcons : {
								valid : 'glyphicon glyphicon-ok',
								invalid : 'glyphicon glyphicon-remove',
								validating : 'glyphicon glyphicon-refresh'
							},
							fields : {

								nombre : {
									selector : '#id_reg_nombre',
									validators : {

										notEmpty : {
											message : "El nombre es obligatorio"
										},
										stringLength : {
											message : "El nombre debe contener min 3 letras max 30",
											min : 3,
											max : 30
										}
									}
								},
								apellido : {
									selector : '#id_reg_apellido',
									validators : {

										notEmpty : {
											message : "El apellido es obligatorio"
										},
										stringLength : {
											message : "El apellido debe contener min 3 letras max 30",
											min : 3,
											max : 30
										}
									}
								},

								fecha : {

									selector : '#id_reg_fecha',
									validators : {

										notEmpty : {
											message : "Fecha obligatoria"
										},

										date : {

											format : 'YYYY-MM-DD',

											message : 'La fecha de nacimiento no es valida'

										}

									}
								},

								dni : {
									selector : '#id_reg_dni',
									validators : {
										notEmpty : {
											message : "El DNI es obligatorio"
										},
										regexp : {
											regexp : /^[0-9]{8}$/,
											message : 'Solo se acepta 8 dígitos'
										}

									}
								},
								correo : {
									selector : '#id_reg_correo',
									validators : {

										notEmpty : {
											message : "El correo es obligatorio"
										},/*,
																				emailAddress: {

																					 message: 'El correo electronico no es valido'

																				 }*/
										regexp : {
														
											regexp : /^([a-zA-Z0-9]{3})+([.]{1})([a-zA-Z0-9]{3})+([.]{1})([a-zA-Z0-9]{3})@([a-zA-Z0-9]{3})+\.([a-zA-Z]{2})$/,

											message : 'Formato invalido'
										}
									}
								}

							}
						});
	</script>

	<script type="text/javascript">
		$('#id_form_actualiza')
				.bootstrapValidator(
						{
							message : 'This value is not valid',
							feedbackIcons : {
								valid : 'glyphicon glyphicon-ok',
								invalid : 'glyphicon glyphicon-remove',
								validating : 'glyphicon glyphicon-refresh'
							},
							fields : {

								nombre : {
									selector : '#id_act_nombre',
									validators : {

										notEmpty : {
											message : "El nombre es obligatorio"
										},
										stringLength : {
											message : "El nombre debe contener min 3 letras y maximo 30",
											min : 3,
											max : 30
										}
									}
								},
								apellido : {
									selector : '#id_act_apellido',
									validators : {

										notEmpty : {
											message : "El apellido es obligatorio"
										},
										stringLength : {
											message : "El apellido debe contener min 3 letras y maximo 30",
											min : 3,
											max : 30
										}
									}
								},

								correo : {
									selector : '#id_act_correo',
									validators : {

										notEmpty : {
											message : "El correo es obligatorio"
										},
										regexp : {

											regexp : /^([a-zA-Z0-9]{3})+([.]{1})([a-zA-Z0-9])+([.]{1})([a-zA-Z0-9]{3})@([a-zA-Z0-9]{3})+\.([a-zA-Z]{2})$/,

											message : 'Formato invalido ss'
										}
									}
								},

								fecha : {

									selector : '#id_act_fecha',
									validators : {

										notEmpty : {
											message : "Fecha obligatoria"
										},

										date : {

											format : 'YYYY-MM-DD',

											message : 'Formato de fecha invalido'

										}

									}
								},
								dni : {
									selector : '#id_act_dni',
									validators : {
										notEmpty : {
											message : "El DNI es obligatorio"
										},
										regexp : {
											regexp : /^[0-9]{8}$/,
											message : 'Solo se acepta 8 dígitos'
										}

									}
								},

							}
						});
	</script>


</body>
</html>