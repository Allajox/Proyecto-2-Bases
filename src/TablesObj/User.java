package TablesObj;
 
import static Connect.DBConnection.host;
import static Connect.DBConnection.uName;
import static Connect.DBConnection.uPass;
import Connect.DBItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.*;
 
 
public class User extends DBItem {
 
    private static final Logger LOG = Logger.getLogger(User.class.getName());
    private final int id;
    private ArrayList<String> data;
 
    public User(int id) { this.id = id; }
 
    // ── Carga lazy ────────────────────────────────────────────────
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
 
    // ── Getters ───────────────────────────────────────────────────
    public int    getId()       { return id; }
    public String getEmail()    { loadData(); return get(1); }
    public String getPassword() { loadData(); return get(2); }
 
    private String get(int i) { return (data != null && i < data.size()) ? data.get(i) : null; }
 
    // ── BD estática ───────────────────────────────────────────────
    public static ResultSet getAll() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL getUser() }");
            return st.executeQuery();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }
 
    //TODO
    /** Devuelve cursor con la fila si email+password coinciden, vacío si no. */
    public static ResultSet login(String email, String password) {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL login(?, ?) }");
            st.setString(1, email);
            st.setString(2, password);
            return st.executeQuery();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }
 
    public static int insert(String email, String password) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL insertUser(?, ?, ?) }")) {
            st.registerOutParameter(1, Types.INTEGER);
            st.setString(2, email);
            st.setString(3, password);
            st.execute();
            return st.getInt(1);
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return -1;
    }
    
 
    // ── BD instancia ──────────────────────────────────────────────
    @Override
    public ResultSet getItem() {
        return getAll();
    }
 
    public void update(String email, String password) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL updateUser(?, ?, ?) }")) {
            st.setInt(1, id);
            st.setString(2, email);
            st.setString(3, password);
            st.execute();
            data = null;
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }
 
    @Override
    public void deleteItem() {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL deleteUser(?) }")) {
            st.setInt(1, id);
            st.execute();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }
 
    @Override public void updateItem() { throw new UnsupportedOperationException(); }
}
 