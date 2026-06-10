package TablesObj;
 
import static Connect.DBConnection.host;
import static Connect.DBConnection.uName;
import static Connect.DBConnection.uPass;
 
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class consult {
 
    private static final Logger LOG = Logger.getLogger(consult.class.getName());
 
    // ─────────────────────────────────────────────────────────────
    //  HELPERS PRIVADOS
    // ─────────────────────────────────────────────────────────────
 
    private static void setDateOrNull(CallableStatement st, int idx, String dateStr)
            throws SQLException {
        if (dateStr != null && !dateStr.isBlank())
            st.setDate(idx, java.sql.Date.valueOf(dateStr.trim()));
        else
            st.setNull(idx, Types.DATE);
    }
 
    private static void setIntOrNull(CallableStatement st, int idx, int val)
            throws SQLException {
        if (val > 0) st.setInt(idx, val);
        else         st.setNull(idx, Types.NUMERIC);
    }
 
    private static ArrayList<ArrayList<Object>> toList(ResultSet rs) throws SQLException {
        ArrayList<ArrayList<Object>> filas = new ArrayList<>();
        if (rs == null) return filas;
        int cols = rs.getMetaData().getColumnCount();
        while (rs.next()) {
            ArrayList<Object> fila = new ArrayList<>();
            for (int i = 1; i <= cols; i++) fila.add(rs.getObject(i));
            filas.add(fila);
        }
        return filas;
    }
 
    // ─────────────────────────────────────────────────────────────
    //  getDonations
    //  SQL: amount | id_donnor | createdAt | association_name | COUNT(1) OVER()
    // ─────────────────────────────────────────────────────────────
 
    public static ArrayList<ArrayList<Object>> getDonations(
            String startDate, String endDate, int idDonor, int idAssociation) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL getDonations(?,?,?,?) }")) {

            setDateOrNull(st, 1, startDate);
            setDateOrNull(st, 2, endDate);
            setIntOrNull(st, 3, idDonor);
            setIntOrNull(st, 4, idAssociation);
            st.execute();

            try (ResultSet rs = st.getResultSet()) { 
                return toList(rs);
            }
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, "Error en getDonations", ex);
        }
        return new ArrayList<>();
    }
 
    // ─────────────────────────────────────────────────────────────
    //  getBlackListReport
    //  SQL: id_user | email | first_name | NVL(second_name,'None') |
    //       first_surname | second_surname | NVL(score,0) | reason | COUNT(1) OVER()
    // ─────────────────────────────────────────────────────────────
 
    public static ArrayList<ArrayList<Object>> getBlackListReport() {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL getBlackListReport() }")) {
            st.execute();
            try (ResultSet rs = st.getResultSet()) {
                return toList(rs);
            }
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, "Error en getBlackListReport", ex);
        }
        return new ArrayList<>();
    }
 
    // ─────────────────────────────────────────────────────────────
    //  getMatches
    //  SQL: similarity_pct (0-100) | COUNT(1) OVER()
    // ─────────────────────────────────────────────────────────────
 
    public static ArrayList<ArrayList<Object>> getMatches(int idLostPet, int idFoundPet) {

        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL getMatches(?,?) }")) {

            setIntOrNull(st, 1, idLostPet);
            setIntOrNull(st, 2, idFoundPet);
            st.execute();

            try (ResultSet rs = st.getResultSet()) {
                return toList(rs);
            }
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, "Error en getMatches", ex);
        }
        return new ArrayList<>();
    }
 
    // ─────────────────────────────────────────────────────────────
    //  getPetNecessaryTreatments
    //  SQL: first_name | disease_count | COUNT(*) OVER()
    // ─────────────────────────────────────────────────────────────

    public static ArrayList<ArrayList<Object>> getPetNecessaryTreatments(int minTreatments, int maxTreatments) {

        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL getPetNecessaryTreatments(?,?) }")) {
            setIntOrNull(st, 1, minTreatments);
            setIntOrNull(st, 2, maxTreatments);
            st.execute();
            try (ResultSet rs = st.getResultSet()) {
                return toList(rs);
            }
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, "Error en getPetNecessaryTreatments", ex);
        }
        return new ArrayList<>();
    }
 
    // ─────────────────────────────────────────────────────────────
    //  getCompatibleCribHouses
    //  SQL: id_user | name | email | requires_donations |
    //       pet_type_name | size_name | COUNT(1) OVER()
    // ─────────────────────────────────────────────────────────────
 
    public static ArrayList<ArrayList<Object>> getCompatibleCribHouses(int idPetType) {

        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL getCompatibleCribHouses(?) }")) {

            setIntOrNull(st, 1, idPetType);
            st.execute();

            try (ResultSet rs = st.getResultSet()) {
                return toList(rs);
            }
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, "Error en getCompatibleCribHouses", ex);
        }
        return new ArrayList<>();
    }
 
    // ─────────────────────────────────────────────────────────────
    //  getBestRescuersAndAdopters
    //  SQL: id_user | email | first_name | second_name |
    //       first_surname | second_surname | rescues | adoptions | total_registers
    // ─────────────────────────────────────────────────────────────

    //TODO
    public static ArrayList<ArrayList<Object>> getBestRescuersAndAdopters(
            String startDate, String endDate) {

        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL getBestRescuersAndAdopters(?,?) }")) {

            setDateOrNull(st, 1, startDate);
            setDateOrNull(st, 2, endDate);
            st.execute();

            try (ResultSet rs = st.getResultSet()) {
                return toList(rs);
            }
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, "Error en getBestRescuersAndAdopters", ex);
        }
        return new ArrayList<>();
    }
}
