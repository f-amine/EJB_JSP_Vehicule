<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<meta charset="UTF-8">
<title>Vehicules List</title>
<style>
body {
	background-color: #343a40;
	color: #ffffff;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	padding-top: 56px;
}

.container {
	margin-top: 20px;
}

.custom-modal-label {
	font-weight: bold;
}

.navbar {
	background-color: #343a40;
	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px
		rgba(0, 0, 0, 0.06);
}

.navbar-brand, .nav-link {
	color: #fff;
}

.nav-link:hover {
	color: #ddd;
}

.hero-section {
	background-color: #343a40;
	color: #fff;
	padding: 80px 0;
	text-align: center;
}

.hero-section h1 {
	font-size: 2.5rem;
	margin-bottom: 20px;
}

.hero-section p {
	font-size: 1.2rem;
}

.table {
	margin-top: 20px;
}

.modal-content {
	background-color: #1e1e1e;
	color: #ffffff;
	border: 1px solid #343a40;
}

.modal-header, .modal-footer {
	border-color: #343a40;
}

.modal-title {
	color: #ffffff;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg fixed-top">
		<a class="navbar-brand" href="/EJBG6Web">Tracker Management</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link"
					href="TrackerController">Manage Trackers</a></li>
				<li class="nav-item"><a class="nav-link"
					href="VehiculeController">Manage Vehicles</a></li>
				<li class="nav-item"><a class="nav-link"
					href="VehiculeTrackerController">Manage Vehicle Trackers</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="hero-section">
			<div class="container">
				<h1 class="mb-4">Gestion des Vehicules</h1>
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#FiliereModalCente">Ajouter une Vehicule</button>
			</div>
		</div>
		<!-- Add Filiere Modal -->
		<div class="modal fade" id="FiliereModalCenter" tabindex="-1"
			role="dialog" aria-labelledby="FiliereModalCenterTitle"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<form action="VehiculeController" method="post">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="FiliereModalCenterTitle">Ajouter
								une Vehicule</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<label class="custom-modal-label" for="matricule">Matricule</label>
							<input type="text" name="matricule" class="form-control" required><br>
							<br>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Fermer</button>
							<input type="submit" class="btn btn-primary" value="Enregistrer">
						</div>
					</div>
				</form>
			</div>
		</div>

		<!-- Modify Filiere Modal -->
		<div class="modal fade" id="ModifyFiliereModal" tabindex="-1"
			role="dialog" aria-labelledby="ModifyFiliereModalTitle"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<form action="VehiculeController" method="post">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="ModifyFiliereModalTitle">Modifier
								une Vehicule</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<label class="custom-modal-label" for="matricule">Matricule</label>
							<input type="text" name="matricule" class="form-control"
								id="modalFiliereName" required><br>
							<br> <input type="hidden" name="action" value="edit">
							<input type="hidden" name="id" id="modalFiliereId">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Fermer</button>
							<input type="submit" class="btn btn-primary"
								value="Enregistrer les modifications">
						</div>
					</div>
				</form>
			</div>
		</div>

		<table class="table">
			<thead class="thead-light">
				<tr>
					<th>ID</th>
					<th>Matricule</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${Vehicules}" var="Vehicule">
					<tr>
						<td>${Vehicule.id}</td>
						<td>${Vehicule.matricule}</td>
						<td class="d-flex align-items-center">
							<form action="VehiculeController" method="post">
								<input type="hidden" name="action" value="delete"> <input
									type="hidden" name="id" value="${Vehicule.id}">
								<button type="submit" class="btn btn-danger">Supprimer</button>
							</form>
							<button type="button" class="btn btn-secondary ml-2"
								data-toggle="modal" data-target="#ModifyFiliereModal"
								data-filiere-id="${Vehicule.id}"
								data-filiere-code="${Vehicule.matricule}">Modifier</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

	<script>
		$('#ModifyFiliereModal').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			var filiereId = button.data('filiere-id');
			var filiereCode = button.data('filiere-code');
			var filiereName = button.data('filiere-name');
			var modal = $(this);

			modal.find('#modalFiliereCode').val(filiereCode);
			modal.find('#modalFiliereName').val(filiereName);
			modal.find('#modalFiliereId').val(filiereId);
		});
	</script>
</body>
</html>