package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sessions.TrackerFacade;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import entities.Tracker;

@WebServlet("/VehiculeController")
public class TrackerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
	private TrackerFacade facade;

	public TrackerController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Tracker> trackers = facade.findAll();
		System.out.println("liste : " + trackers);
		request.setAttribute("Trackers", trackers);
		request.getRequestDispatcher("/ListTrackers.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
			int trackerId = Integer.parseInt(request.getParameter("id"));
			if (facade.find(trackerId) != null) {
				Tracker trackerdelete = facade.find(trackerId);

				boolean updated = facade.edit(trackerdelete);
				if (updated) {
					facade.remove(trackerdelete);
					boolean deleted = true;
					if (deleted) {
						response.sendRedirect(request.getContextPath() + "/TrackerController");
					} else {
						response.sendRedirect(request.getContextPath() + "/TrackerController?deleteFailed=true");
					}
				}
			}
		} else if ("edit".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			System.out.println("id: " + id);
			String simNumber = request.getParameter("simNumber");
			Tracker fieldToEdit = facade.find(id);
			if (fieldToEdit != null) {
				fieldToEdit.setSimNumber(simNumber);
				facade.edit(fieldToEdit);
			}
			response.sendRedirect(request.getContextPath() + "/TrackerController");
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
			String simNumber = request.getParameter("simNumber");
			Tracker newField = new Tracker(simNumber);
			if (facade.create(newField)) {
				List<Tracker> Trackers = facade.findAll();
				System.out.println(facade.findAll());
				request.setAttribute("Trackers", Trackers);
				request.getRequestDispatcher("/ListTrackers.jsp").forward(request, response);
			} else {
				System.out.println("Failure: Field not created.");
			}
		}
	}

	private void showlist(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {

		List<Tracker> liste = facade.findAll();
		RequestDispatcher dispatcher = request.getRequestDispatcher("trackerfield.jsp");
		request.setAttribute("Trackers", liste);
		dispatcher.forward(request, response);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Tracker existingField = facade.find(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("editField.jsp");
		request.setAttribute("field", existingField);
		dispatcher.forward(request, response);

	}
}
