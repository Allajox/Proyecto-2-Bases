package TablesObj;

import static Connect.DBConnection.host;
import static Connect.DBConnection.uName;
import static Connect.DBConnection.uPass;
import Connect.DBItem;
import static Connect.DBItem.host;
import static Connect.DBItem.uName;
import static Connect.DBItem.uPass;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.*;


public class PetXDistrict extends DBItem {

    private static final Logger LOG = Logger.getLogger(PetXDistrict.class.getName());

    // ── Static — consultas ────────────────────────────────────────
    public static ResultSet getAll() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement stmt = con.prepareCall("{ CALL getPetXDistrict() }");
            return stmt.executeQuery();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }

    public static void insert(int idPet, int idDistrict) {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement stmt = con.prepareCall("{ CALL insertPetXDistrict(?, ?) }");
            stmt.setInt(1, idPet);
            stmt.setInt(2, idDistrict);
            stmt.execute();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }

    // ── DBItem — no aplica para tablas intermedias ────────────────
    @Override public ResultSet getItem()  { throw new UnsupportedOperationException("Junction table — use getAll()."); }
    @Override public void deleteItem()    { throw new UnsupportedOperationException("Junction table — use delete(...)."); }
    @Override public void updateItem()    { throw new UnsupportedOperationException("Junction table — no update SP."); }
}
