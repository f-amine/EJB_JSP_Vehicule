package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sessions.VehiculeFacade;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import entities.Vehicule;

@WebServlet("/VehiculeController")
public class VehiculeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
	private VehiculeFacade facade;

	public VehiculeController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Vehicule> vehicules = facade.findAll();
		System.out.println("liste : " + vehicules);
		request.setAttribute("Vehicules", vehicules);
		request.getRequestDispatcher("/ListVehicules.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
			int vehiculeId = Integer.parseInt(request.getParameter("id"));
			if (facade.find(vehiculeId) != null) {
				Vehicule vehiculedelete = facade.find(vehiculeId);

				boolean updated = facade.edit(vehiculedelete);
				if (updated) {
					facade.remove(vehiculedelete);
					boolean deleted = true;
					if (deleted) {
						response.sendRedirect(request.getContextPath() + "/VehiculeController");
					} else {
						response.sendRedirect(request.getContextPath() + "/VehiculeController?deleteFailed=true");
					}
				}
			}
		} else if ("edit".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			System.out.println("id: " + id);
			String matricule = request.getParameter("matricule");
			Vehicule fieldToEdit = facade.find(id);
			if (fieldToEdit != null) {
				fieldToEdit.setMatricule(matricule);
				facade.edit(fieldToEdit);
			}
			response.sendRedirect(request.getContextPath() + "/VehiculeController");
		} else if ("showform".equals(action)) {
			try {
				showEditForm(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else if ("showlist".equals(action)) {
			try {
				showlist(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			String matricule = request.getParameter("matricule");
			Vehicule newField = new Vehicule(matricule);
			if (facade.create(newField)) {
				List<Vehicule> vehicules = facade.findAll();
				System.out.println(facade.findAll());
				request.setAttribute("Vehicules", vehicules);
				request.getRequestDispatcher("/ListVehicules.jsp").forward(request, response);
			} else {
				System.out.println("Failure: Field not created.");
			}
		}
	}

	private void showlist(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {

		List<Vehicule> liste = facade.findAll();
		RequestDispatcher dispatcher = request.getRequestDispatcher("vehiculefield.jsp");
		request.setAttribute("Vehicules", liste);
		dispatcher.forward(request, response);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Vehicule existingField = facade.find(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("editField.jsp");
		request.setAttribute("field", existingField);
		dispatcher.forward(request, response);

	}
}
