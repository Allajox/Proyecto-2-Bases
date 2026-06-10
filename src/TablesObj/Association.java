package TablesObj;

import Connect.DBItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.*;

/**
 * Columnas (índice base 0):
 *   0 id_user | 1 name
 */
public class Association extends DBItem {

    private static final Logger LOG = Logger.getLogger(Association.class.getName());
    private final int id;
    private ArrayList<String> data;

    public Association(int id) { this.id = id; }

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

    public int    getId()   { return id; }
    public String getName() { loadData(); return get(1); }

    private String get(int i) { return (data != null && i < data.size()) ? data.get(i) : null; }

    //TODO
    public static ResultSet getAll() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL getAssociation() }");
            st.execute();
            return st.getResultSet(); 
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }
    
    //TODO
    public static boolean getAssociationById(int id) {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL getAssociationById(?) }");
            st.setInt(1, id);
            st.execute();
            ResultSet rs = st.getResultSet();
            return rs != null && rs.next();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return false;
    }
    

    public static void insert(int idUser, String name) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL insertAssociation(?,?) }")) {
            st.setInt(1, idUser);
            st.setString(2, name);
            st.execute();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    public void update(String name) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL updateAssociation(?,?) }")) {
            con.setAutoCommit(false);
            st.setInt(1, id);
            st.setString(2, name);
            st.execute();
            con.commit();
            data = null;
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    @Override
    public void deleteItem() {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL deleteAssociation(?) }")) {
            st.setInt(1, id);
            st.execute();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    @Override public ResultSet getItem() { return getAll(); }
    @Override public void updateItem()   { throw new UnsupportedOperationException(); }
}
