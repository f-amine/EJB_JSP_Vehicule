/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessions;

import java.util.List;

import entities.Vehicule;
import entities.Vehiculetracker;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Root;

/**
 *
 * @author Lachgar
 */
@Stateless
public class VehiculetrackerFacade extends AbstractFacade<Vehiculetracker> {
    @PersistenceContext(unitName = "EJBG6PU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public VehiculetrackerFacade() {
        super(Vehiculetracker.class);
    }
    public List<Vehiculetracker> findByVehiculeMatricule(String matricule) {
        try {
            CriteriaBuilder cb = getEntityManager().getCriteriaBuilder();
            CriteriaQuery<Vehiculetracker> cq = cb.createQuery(Vehiculetracker.class);
            Root<Vehiculetracker> root = cq.from(Vehiculetracker.class);

            // Join Vehiculetracker to Vehicule
            Join<Vehiculetracker, Vehicule> vehiculeJoin = root.join("vehicule");

            // Add condition for matricule
            cq.select(root).where(cb.equal(vehiculeJoin.get("matricule"), matricule));

            return getEntityManager().createQuery(cq).getResultList();
        } catch (Exception e) {
            // Log or handle the exception as needed
            return null;
        }
    }
}
