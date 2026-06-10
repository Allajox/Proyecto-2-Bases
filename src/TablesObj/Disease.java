package TablesObj;
 
import static Connect.DBConnection.host;
import static Connect.DBConnection.uName;
import static Connect.DBConnection.uPass;
import Connect.DBItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.*;
 
/** Columns: 0=id_disease | 1=name */
public class Disease extends DBItem {
 
    private static final Logger LOG = Logger.getLogger(Disease.class.getName());
    private final int id;
    private ArrayList<String> data;
 
    public Disease(int id) { this.id = id; }
 
    private void loadData() {
        if (data != null) return;
        data = new ArrayList<>();
        try {
            ResultSet rs = getItem();
            if (rs != null && rs.next()) {
                int c = rs.getMetaData().getColumnCount();
                for (int i = 1; i <= c; i++) data.add(rs.getString(i));
            }
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }
 
    private String get(int i) { return (data != null && i < data.size()) ? data.get(i) : null; }
 
    public int    getId()   { return id; }
    public String getName() { loadData(); return get(1); }
 
    public static ResultSet getAll() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL getDisease() }");
            st.execute();
            return st.getResultSet();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }

    public static int insertAndGetId(String name) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ ? = CALL insertDisease(?) }")) {
            st.registerOutParameter(1, Types.INTEGER);
            st.setString(2, name);
            st.execute();
            return st.getInt(1);
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, "Error en insertDisease", ex);
        }
        return -1;
    }

    public static void insert(String name) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ ? = CALL insertDisease(?) }")) {
            st.registerOutParameter(1, Types.INTEGER);
            st.setString(2, name);
            st.execute();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    public void update(String name) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL updateDisease(?,?) }")) {
            st.setInt(1, id); st.setString(2, name);
            st.execute(); data = null;
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    @Override public ResultSet getItem() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL getDiseaseById(?) }");
            st.setInt(1, id);
            st.execute();
            return st.getResultSet();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }
    @Override public void deleteItem() { throw new UnsupportedOperationException(); }
    @Override public void updateItem() { throw new UnsupportedOperationException(); }
}
