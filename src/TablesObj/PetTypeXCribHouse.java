package TablesObj;
 
import static Connect.DBConnection.host;
import static Connect.DBConnection.uName;
import static Connect.DBConnection.uPass;
import Connect.DBItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.*;
 
 
public class PetTypeXCribHouse extends DBItem {
 
    private static final Logger LOG = Logger.getLogger(PetTypeXCribHouse.class.getName());
 
    // ── Static — consultas ────────────────────────────────────────
    public static ResultSet getAll() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement stmt = con.prepareCall("{ CALL getPetTypeXCribHouse() }");
            return stmt.executeQuery();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }
 
    public static void insert(int idPetType, int idCribHouse) {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement stmt = con.prepareCall("{ CALL insertPetTypeXCribHouse(?, ?) }");
            stmt.setInt(1, idPetType);
            stmt.setInt(2, idCribHouse);
            stmt.execute();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
    }
 
    // ── DBItem — no aplica para tablas intermedias ────────────────
    @Override public ResultSet getItem()  { throw new UnsupportedOperationException("Junction table — use getAll()."); }
    @Override public void deleteItem()    { throw new UnsupportedOperationException("Junction table — use delete(...)."); }
    @Override public void updateItem()    { throw new UnsupportedOperationException("Junction table — no update SP."); }
}