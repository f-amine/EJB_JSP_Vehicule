<!DOCTYPE html>
<html lang="fr">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Gestion des v�hicules</title>
<!-- Add Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
body {
	padding-top: 56px; /* Adjust according to your fixed navbar height */
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
</style>
</head>

<body>
	<nav class="navbar navbar-expand-lg fixed-top">
		<a class="navbar-brand" href="#">Vehicle Management</a>
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

	<div class="hero-section">
		<div class="container">
			<h1 class="mb-4">Comment ex�cuter :</h1>

			<p class="lead text-justify">
				<strong>�tape 1 :</strong> Cloner le R�p�t<br>
				<code>git clone https://github.com/f-amine/ejb-jsp.git</code>
			</p>

			<p class="lead text-justify">
				<strong>�tape 2 :</strong> Installer JBoss Tools<br>
				Assurez-vous d'avoir JBoss Tools install� dans votre Eclipse IDE. Si
				ce n'est pas le cas, t�l�chargez et installez-le depuis le site
				officiel de JBoss Tools : <a href="https://tools.jboss.org/"
					target="_blank">https://tools.jboss.org/</a>
			</p>

			<p class="lead text-justify">
				<strong>�tape 3 :</strong> Cr�er un Nouveau Serveur<br> Ouvrez
				Eclipse IDE.<br> Acc�dez � <strong>Window > Show View
					> Other...</strong>.<br> Dans la bo�te de dialogue "Show View",
				d�veloppez le dossier "Server" et s�lectionnez "Servers", puis
				cliquez sur "Open".<br> Faites un clic droit dans la vue
				"Servers" et s�lectionnez <strong>"New" > "Server"</strong>.<br>
				Choisissez <strong>"JBoss Community" > "WildFly [version]"</strong>
				et cliquez sur <strong>"Next"</strong>.<br> Parcourez et
				s�lectionnez le r�pertoire d'installation de WildFly, puis cliquez
				sur <strong>"Finish"</strong>.
			</p>

			<p class="lead text-justify">
				<strong>�tape 4 :</strong> Ouvrir les Dossiers de Projet<br>
				Ouvrez les trois dossiers de projet (ejb-project, jsp-web-project,
				ear-project) s�par�ment dans votre Eclipse IDE.
			</p>

			<p class="lead text-justify">
				<strong>�tape 5 :</strong> Ajouter le JAR de WildFly au Classpath<br>
				Dans la fen�tre des propri�t�s, allez � <strong>"Java Build
					Path" > onglet "Libraries"</strong>.<br> Cliquez sur <strong>"Add
					External JARs"</strong> et ajoutez le JAR de WildFly depuis votre r�pertoire
				d'installation de WildFly.
			</p>

			<p class="lead text-justify">
				<strong>�tape 6 :</strong> Ex�cuter le Projet EAR<br> Faites un
				clic droit sur ear-project dans l'Explorateur de Projets.<br>
				S�lectionnez "Run As" > "Run on Server".<br> Choisissez le
				serveur WildFly configur� et cliquez sur "Finish".
			</p>
		</div>
	</div>
<div class="hero-section">
    <div class="container">
        <h2 class="mb-8">Technologies Utilis�es :</h2>

        <div class="row">
            <div class="col-md-4">
                <h3>1. WildFly</h3>
                <p>
                    WildFly, d�velopp� par Red Hat, est un serveur d'applications open source, l�ger, flexible et riche en fonctionnalit�s pour les applications Java EE. Il offre un environnement d'ex�cution pour le d�ploiement et l'ex�cution d'applications d'entreprise Java.
                </p>
            </div>

            <div class="col-md-4">
                <h3>2. EJB (Enterprise JavaBeans)</h3>
                <p>
                    EJB est une architecture c�t� serveur pour la construction modulaire d'applications d'entreprise. Il simplifie le d�veloppement de syst�mes � grande �chelle, distribu�s et transactionnels en Java.
                </p>
            </div>

            <div class="col-md-4">
                <h3>3. JSP (JavaServer Pages)</h3>
                <p>
                    JSP est une technologie qui aide les d�veloppeurs � cr�er des pages web g�n�r�es dynamiquement bas�es sur HTML, XML ou d'autres types de documents. Elle est largement utilis�e pour la construction d'applications web dynamiques et fait partie de la pile technologique Java EE.
                </p>
            </div>
        </div>
    </div>
</div>

	<!-- Your page content goes here -->

	<!-- Add Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>

</html>