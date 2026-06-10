package TablesObj;

import static Connect.DBConnection.host;
import static Connect.DBConnection.uName;
import static Connect.DBConnection.uPass;
import Connect.DBItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.*;

public class Match extends DBItem {

    private static final Logger LOG = Logger.getLogger(Match.class.getName());
    private final int id;
    private ArrayList<String> data;

    public Match(int id) { this.id = id; }

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

    private String get(int i)  { return (data != null && i < data.size()) ? data.get(i) : null; }
    private int getInt(int i)  { String v = get(i); if (v == null) return 0; try { return Integer.parseInt(v); } catch (NumberFormatException e) { return 0; } }

    public int    getId()                   { return id; }
    public String getMatchDate()            { loadData(); return get(1); }
    public int    getSimilarityPercentage() { loadData(); return getInt(2); }

    public static ResultSet getAll() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL getMatch() }");
            st.execute();
            return st.getResultSet();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }

    public static void insert(String matchDate, int idPetLost, int idPetFound) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL insertMatch(?,?,?) }")) {
            st.setString(1, matchDate); st.setInt(2, idPetLost); st.setInt(3, idPetFound);
            st.execute();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    public void update(String matchDate) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL updateMatch(?,?) }")) {
            con.setAutoCommit(false);
            st.setInt(1, id); st.setString(2, matchDate);
            st.execute(); con.commit(); data = null;
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    @Override public ResultSet getItem() { return getAll(); }
    @Override public void deleteItem()   { throw new UnsupportedOperationException(); }
    @Override public void updateItem()   { throw new UnsupportedOperationException(); }
}
