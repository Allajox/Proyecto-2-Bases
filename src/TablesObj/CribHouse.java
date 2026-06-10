package TablesObj;

import static Connect.DBConnection.host;
import static Connect.DBConnection.uName;
import static Connect.DBConnection.uPass;
import Connect.DBItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.*;

/**
 * Columnas 
 *   0 id_user | 1 name | 2 requires_donations | 3 accepted_size
 */
public class CribHouse extends DBItem {

    private static final Logger LOG = Logger.getLogger(CribHouse.class.getName());
    private final int id;
    private ArrayList<String> data;

    public CribHouse(int id) { this.id = id; }

    private void loadData() {
        if (data != null) return;
        data = new ArrayList<>();
        try {
            ResultSet rs = getItem();
            if (rs != null && rs.next()) {
                int cols = rs.getMetaData().getColumnCount();
                for (int i = 1; i <= cols; i++) data.add(rs.getString(i));
            }
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    public int    getId()                { return id; }
    public String getName()              { loadData(); return get(1); }
    public int    getRequiresDonations() { loadData(); return getInt(2); }
    public int    getAcceptedSize()      { loadData(); return getInt(3); }

    private String get(int i)  { return (data != null && i < data.size()) ? data.get(i) : null; }
    private int getInt(int i) {
        String v = get(i);
        if (v == null) return 0;
        try { return Integer.parseInt(v); } catch (NumberFormatException e) { return 0; }
    }

    //TODO
    public static ResultSet getAll() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL getCribHouse() }");
            st.execute();
            return st.getResultSet();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }
    
    //TODO
    public static boolean getCribHouseByID(int id) {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL getCribHouseById(?) }");
            st.setInt(1, id);
            st.execute();
            ResultSet rs = st.getResultSet();
            return rs != null && rs.next();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return false;
    }

    public static void insert(int idUser, String name, int requiresDonations) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL insertCribHouse(?,?,?) }")) {
            st.setInt(1, idUser); st.setString(2, name);
            st.setInt(3, requiresDonations);
            st.execute();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    public void update(String name, int requiresDonations) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL updateCribHouse(?,?,?) }")) {
            con.setAutoCommit(false);
            st.setInt(1, id); st.setString(2, name);
            st.setInt(3, requiresDonations);
            st.execute(); con.commit(); data = null;
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    @Override
    public void deleteItem() {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL deleteCribHouse(?) }")) {
            st.setInt(1, id); st.execute();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    @Override public ResultSet getItem() { return getAll(); }
    @Override public void updateItem()   { throw new UnsupportedOperationException(); }
}
