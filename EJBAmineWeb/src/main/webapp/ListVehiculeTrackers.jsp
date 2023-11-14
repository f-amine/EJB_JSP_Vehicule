<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<meta charset="UTF-8">
<title>Vehicule Trackers List</title>
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
				<h1 class="mb-4">Vehicle Trackers Management</h1>
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#VehiculeTrackerModalCenter">Add Vehicle
					Tracker</button>
			</div>
		</div>
		<!-- Add Vehicle Tracker Modal -->
		<div class="modal fade" id="VehiculeTrackerModalCenter" tabindex="-1"
			role="dialog" aria-labelledby="VehiculeTrackerModalCenterTitle"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<form action="VehiculeTrackerController" method="post">
					<div class="modal-content">
						<input type="hidden" name="originalDateDebut"
							id="modalOriginalVehiculeTrackerDate"> <input
							type="hidden" name="originalTracker"
							id="modalOriginalVehiculeTrackerTracker"> <input
							type="hidden" name="originalVehicule"
							id="modalOriginalVehiculeTrackerVehicule">
						<div class="modal-header">
							<h5 class="modal-title" id="VehiculeTrackerModalCenterTitle">Add
								Vehicle Tracker</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<label class="custom-modal-label" for="dateDebut">Start
								Date</label> <input type="date" name="dateDebut" class="form-control"
								required><br> <label class="custom-modal-label"
								for="tracker">Tracker</label> <select name="tracker"
								class="form-control" required>
								<c:forEach items="${Trackers}" var="Tracker">
									<option value="${Tracker.id}">${Tracker.simNumber}</option>
								</c:forEach>
							</select><br> <label class="custom-modal-label" for="vehicule">Vehicle</label>
							<select name="vehicule" class="form-control" required>
								<c:forEach items="${Vehicules}" var="Vehicule">
									<option value="${Vehicule.id}">${Vehicule.matricule}</option>
								</c:forEach>
							</select><br> <label class="custom-modal-label" for="dateFin">End
								Date</label> <input type="date" name="dateFin" class="form-control"><br>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<input type="submit" class="btn btn-primary" value="Save">
						</div>
					</div>
				</form>
			</div>
		</div>

		<!-- Modify Vehicle Tracker Modal -->
		<div class="modal fade" id="ModifyVehiculeTrackerModal" tabindex="-1"
			role="dialog" aria-labelledby="ModifyVehiculeTrackerModalTitle"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<form action="VehiculeTrackerController" method="post">
					<div class="modal-content">
						<input type="hidden" name="originalDateDebut"
							id="modalOriginalVehiculeTrackerDate"> <input
							type="hidden" name="originalTracker"
							id="modalOriginalVehiculeTrackerTracker"> <input
							type="hidden" name="originalVehicule"
							id="modalOriginalVehiculeTrackerVehicule">
						<div class="modal-header">
							<h5 class="modal-title" id="ModifyVehiculeTrackerModalTitle">Modify
								Vehicle Tracker</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<label class="custom-modal-label" for="dateDebut">Start
								Date</label> <input type="date" name="dateDebut" class="form-control"
								id="modalVehiculeTrackerDate" required><br> <label
								class="custom-modal-label" for="tracker">Tracker</label> <select
								name="tracker" class="form-control"
								id="modalVehiculeTrackerTracker" required>
								<c:forEach items="${Trackers}" var="Tracker">
									<option value="${Tracker.id}">${Tracker.simNumber}</option>
								</c:forEach>
							</select><br> <label class="custom-modal-label" for="vehicule">Vehicle</label>
							<select name="vehicule" class="form-control"
								id="modalVehiculeTrackerVehicule" required>
								<c:forEach items="${Vehicules}" var="Vehicule">
									<option value="${Vehicule.id}">${Vehicule.matricule}</option>
								</c:forEach>
							</select><br> <label class="custom-modal-label" for="dateFin">End
								Date</label> <input type="date" name="dateFin" class="form-control"
								id="modalVehiculeTrackerDateFin"><br> <input
								type="hidden" name="action" value="edit"> <input
								type="hidden" name="id" id="modalVehiculeTrackerId">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<input type="submit" class="btn btn-primary" value="Save Changes">
						</div>
					</div>
				</form>
			</div>
		</div>

		<table class="table">
			<thead class="thead-light">
				<tr>
					<th>Start Date</th>
					<th>Tracker</th>
					<th>Vehicle</th>
					<th>End Date</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${VehiculeTrackers}" var="VehiculeTracker">
					<tr>
						<td>${VehiculeTracker.vehiculetrackerPK.dateDebut}</td>
						<td>${VehiculeTracker.tracker1.simNumber}</td>
						<td>${VehiculeTracker.vehicule1.matricule}</td>
						<td>${VehiculeTracker.dateFin}</td>
						<td class="d-flex align-items-center">
							<form action="VehiculeTrackerController" method="post">
								<input type="hidden" name="action" value="delete"> <input
									type="hidden" name="dateDebut"
									value="${VehiculeTracker.vehiculetrackerPK.dateDebut}">
								<input type="hidden" name="tracker"
									value="${VehiculeTracker.vehiculetrackerPK.tracker}"> <input
									type="hidden" name="vehicule"
									value="${VehiculeTracker.vehiculetrackerPK.vehicule}">
								<button type="submit" class="btn btn-danger">Delete</button>
							</form>
							<button type="button" class="btn btn-secondary ml-2"
								data-toggle="modal" data-target="#ModifyVehiculeTrackerModal"
								data-vehiculetracker-date="${VehiculeTracker.vehiculetrackerPK.dateDebut}"
								data-vehiculetracker-tracker="${VehiculeTracker.vehiculetrackerPK.tracker}"
								data-vehiculetracker-vehicule="${VehiculeTracker.vehiculetrackerPK.vehicule}"
								data-vehiculetracker-datefin="${VehiculeTracker.dateFin}">
								Edit</button>
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
		$('#ModifyVehiculeTrackerModal').on(
				'show.bs.modal',
				function(event) {
					var button = $(event.relatedTarget);
					var vehiculeTrackerDate = button
							.data('vehiculetracker-date');
					var vehiculeTrackerTracker = button
							.data('vehiculetracker-tracker');
					var vehiculeTrackerVehicule = button
							.data('vehiculetracker-vehicule');
					var vehiculeTrackerDateFin = button
							.data('vehiculetracker-datefin');
					var modal = $(this);

					modal.find('#modalVehiculeTrackerDate').val(
							vehiculeTrackerDate);
					modal.find('#modalVehiculeTrackerTracker').val(
							vehiculeTrackerTracker);
					modal.find('#modalVehiculeTrackerVehicule').val(
							vehiculeTrackerVehicule);

					modal.find('#modalOriginalVehiculeTrackerDate').val(
							vehiculeTrackerDate);
					modal.find('#modalOriginalVehiculeTrackerTracker').val(
							vehiculeTrackerTracker);
					modal.find('#modalOriginalVehiculeTrackerVehicule').val(
							vehiculeTrackerVehicule);
				});
	</script>
</body>
</html>
