package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sessions.TrackerFacade;
import sessions.VehiculeFacade;
import sessions.VehiculetrackerFacade;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import entities.Tracker;
import entities.Vehicule;
import entities.Vehiculetracker;
import entities.VehiculetrackerPK;
@WebServlet("/VehiculeController")
public class VehiculeTrackerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
	VehiculeFacade vdao;

	@EJB
	TrackerFacade tdao;
	
	@EJB
	VehiculetrackerFacade vtdao;
    public VehiculeTrackerController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Vehicule> VehiculeList = vdao.findAll();
		List<Tracker> TrackerList = tdao.findAll();
		List<Vehiculetracker> VehiculeTrackerList = vtdao.findAll();
		System.out.println("liste : "+VehiculeTrackerList);
		request.setAttribute("Vehicules", VehiculeList);
		request.setAttribute("Trackers", TrackerList);
		request.setAttribute("VehiculeTrackers", VehiculeTrackerList);
		request.getRequestDispatcher("/ListVehiculeTrackers.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
	    if ("delete".equals(action)) {
	        // Assuming you have appropriate parameter names, e.g., "dateDebut", "tracker", "vehicule"
	        Date dateDebut = parseDate(request.getParameter("dateDebut"));
	        int tracker = Integer.parseInt(request.getParameter("tracker"));
	        int vehicule = Integer.parseInt(request.getParameter("vehicule"));

	        // Assuming you have a method similar to find in your facade
	        Vehiculetracker vehiculeTrackerToDelete = vtdao.find(new VehiculetrackerPK(dateDebut, tracker, vehicule));

	        if (vehiculeTrackerToDelete != null) {
	            boolean updated = vtdao.edit(vehiculeTrackerToDelete);
	            if (updated) {
	                vtdao.remove(vehiculeTrackerToDelete);
	                response.sendRedirect(request.getContextPath() + "/VehiculeTrackerController");
	            } else {
	                response.sendRedirect(request.getContextPath() + "/VehiculeTrackerController?deleteFailed=true");
	            }
	        }
	    }
	    else if ("edit".equals(action)) {
	        Date originalDateDebut = parseDate(request.getParameter("originalDateDebut"));
	        originalDateDebut = addOneDay(originalDateDebut);
	        int originalTrackerId = Integer.parseInt(request.getParameter("originalTracker"));
	        int originalVehiculeId = Integer.parseInt(request.getParameter("originalVehicule"));

	        Date editedDateDebut = parseDate(request.getParameter("dateDebut"));
	        int editedTrackerId = Integer.parseInt(request.getParameter("tracker"));
	        int editedVehiculeId = Integer.parseInt(request.getParameter("vehicule"));
	        Date editedDateFin = parseDate(request.getParameter("dateFin"));

	        VehiculetrackerPK originalVehiculeTrackerPK = new VehiculetrackerPK(originalDateDebut, originalTrackerId, originalVehiculeId);
	        Vehiculetracker vehiculeTrackerToEdit = vtdao.find(originalVehiculeTrackerPK);

	        if (vehiculeTrackerToEdit != null) {
	            Tracker tracker = tdao.find(editedTrackerId);
	            Vehicule vehicule = vdao.find(editedVehiculeId);

	            if (tracker != null && vehicule != null) {
	                vehiculeTrackerToEdit.getVehiculetrackerPK().setDateDebut(editedDateDebut);
	                vehiculeTrackerToEdit.getVehiculetrackerPK().setTracker(editedTrackerId);
	                vehiculeTrackerToEdit.getVehiculetrackerPK().setVehicule(editedVehiculeId);
	                vehiculeTrackerToEdit.setTracker1(tracker);
	                vehiculeTrackerToEdit.setVehicule1(vehicule);
	                vehiculeTrackerToEdit.setDateFin(editedDateFin);

	                vtdao.edit(vehiculeTrackerToEdit);
	                response.sendRedirect(request.getContextPath() + "/VehiculeTrackerController");
	            } else {
	                response.sendRedirect(request.getContextPath() + "/VehiculeTrackerController?editFailed=true");
	            }
	        } else {
	            response.sendRedirect(request.getContextPath() + "/VehiculeTrackerController?editFailed=true");
	        }
	    }
	    else if ("filterByVehicule".equals(action)) {
	        int vehiculeId = Integer.parseInt(request.getParameter("filterVehicule"));

	        if (vehiculeId == 0) {
	            List<Vehicule> vehiculeList = vdao.findAll();
	            request.setAttribute("Vehicules", vehiculeList);
	        } else {
	            // Retrieve the vehicule using vehiculeId
	            Vehicule vehicule = vdao.find(vehiculeId);
	            
	            if (vehicule != null) {
	                String vehiculeMatricule = vehicule.getMatricule();
	                
	                // Assuming you have a method similar to findByVehicule in your sdao
	                List<Vehiculetracker> vehiculeTrackerList = vtdao.findByVehiculeMatricule(vehiculeMatricule);
	                request.setAttribute("VehiculeTrackers", vehiculeTrackerList);
	            } else {
	                response.sendRedirect(request.getContextPath() + "/Error.jsp");
	                return;
	            }
	        }
	        // Populate other data needed for the JSP page
	        List<Vehicule> vehiculeList = vdao.findAll();
	        List<Tracker> trackerList = tdao.findAll();
	        request.setAttribute("Vehicules", vehiculeList);
	        request.setAttribute("Trackers", trackerList);

	        // Forward to the JSP page
	        request.getRequestDispatcher("/ListVehiculeTrackers.jsp").forward(request, response);
	    }
	    else {
	        Date dateDebut = parseDate(request.getParameter("dateDebut"));
	        int trackerId = Integer.parseInt(request.getParameter("tracker"));
	        int vehiculeId = Integer.parseInt(request.getParameter("vehicule"));
	        Date dateFin = parseDate(request.getParameter("dateFin"));

	        Tracker tracker = tdao.find(trackerId);
	        Vehicule vehicule = vdao.find(vehiculeId);

	        if (tracker != null && vehicule != null) {
	            Vehiculetracker vehiculeTracker = new Vehiculetracker(new VehiculetrackerPK(dateDebut, trackerId, vehiculeId));
	            vehiculeTracker.setDateFin(dateFin);

	            // Assuming you have appropriate setter methods for other attributes

	            if (vtdao.create(vehiculeTracker)) {
	                List<Vehiculetracker> vehiculeTrackerList = vtdao.findAll();
	                List<Tracker> trackerList = tdao.findAll();
	                List<Vehicule> vehiculeList = vdao.findAll();

	                request.setAttribute("VehiculeTrackers", vehiculeTrackerList);
	                request.setAttribute("Trackers", trackerList);
	                request.setAttribute("Vehicules", vehiculeList);

	                request.getRequestDispatcher("/ListVehiculeTrackers.jsp").forward(request, response);
	            } else {
	                System.out.println("Failure: VehiculeTracker not created.");
	            }
	        } else {
	            // Handle the case where the tracker or vehicule with the given id is not found
	            response.sendRedirect(request.getContextPath() + "/YourErrorPage.jsp");
	        }
	    }
	   
	}
	private Date parseDate(String dateString) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
	    try {
	        return dateFormat.parse(dateString);
	    } catch (ParseException e) {
	        e.printStackTrace();
	        return null;
	    }
	}
    public static Date atStartOfDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }
    public static Date addOneDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }
}
