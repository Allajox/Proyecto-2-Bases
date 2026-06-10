package TablesObj;
 
import static Connect.DBConnection.host;
import static Connect.DBConnection.uName;
import static Connect.DBConnection.uPass;
import Connect.DBItem;
 
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
 
/**
 * Columnas de phone_number:
 *   id_phone | number | id_user | id_pet | id_veterinarian
 */
public class PhoneNumber extends DBItem {
 
    private static final Logger LOG = Logger.getLogger(PhoneNumber.class.getName());
 
    private final int id;
    private ArrayList<String> data;
 
    // ─────────────────────────────────────────────────────────────
    //  CONSTRUCTOR
    // ─────────────────────────────────────────────────────────────
 
    public PhoneNumber(int id) {
        this.id = id;
    }
 
    // ─────────────────────────────────────────────────────────────
    //  CARGA LAZY
    // ─────────────────────────────────────────────────────────────
 
    private void loadData() {
        if (data != null) return;
        data = new ArrayList<>();
        try {
            ResultSet rs = getItem();
            if (rs != null && rs.next()) {
                int cols = rs.getMetaData().getColumnCount();
                for (int i = 1; i <= cols; i++) data.add(rs.getString(i));
            }
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, "Error al cargar PhoneNumber id=" + id, ex);
        }
    }
 
    // ─────────────────────────────────────────────────────────────
    //  GETTERS
    // ─────────────────────────────────────────────────────────────
 
    public int    getId()     { return id; }
    /** Devuelve el número de teléfono como String (columna 0). */
    public String getNumber() { loadData(); return get(0); }
 
    private String get(int index) {
        return (data != null && index < data.size()) ? data.get(index) : null;
    }
 
    // ─────────────────────────────────────────────────────────────
    //  HELPERS PRIVADOS
    // ─────────────────────────────────────────────────────────────
 
    private static void setIntOrNull(CallableStatement st, int idx, int val) throws SQLException {
        if (val > 0) st.setInt(idx, val);
        else         st.setNull(idx, Types.NUMERIC);
    }
 
    // ─────────────────────────────────────────────────────────────
    //  BD — ESTÁTICAS
    // ─────────────────────────────────────────────────────────────
 
    /** Todos los teléfonos de la tabla. */
    public static ResultSet getAll() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL getPhoneNumber() }");
            return st.executeQuery();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }
 
    /** Teléfonos asociados a un usuario. */
    public static ArrayList<String> getByUser(int idUser) {
        return fetchNumbers("{ CALL getUserPhones(?) }", idUser);
    }
 
    /** Teléfonos asociados a una mascota. */
    public static ArrayList<String> getByPet(int idPet) {
        return fetchNumbers("{ CALL getPetPhones(?) }", idPet);
    }
 
    /** Teléfonos asociados a un veterinario. */
    public static ArrayList<String> getByVeterinarian(int idVet) {
        return fetchNumbers("{ CALL getVeterinarianPhones(?) }", idVet);
    }
 
    /** Helper compartido para las tres consultas anteriores. */
    private static ArrayList<String> fetchNumbers(String sql, int paramId) {
        ArrayList<String> list = new ArrayList<>();
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall(sql)) {
            st.setInt(1, paramId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs != null && rs.next()) list.add(rs.getString(1));
            }
        } catch (SQLException ex) { LOG.log(Level.SEVERE, "Error en fetchNumbers: " + sql, ex); }
        return list;
    }
 
    public static void insert(long number, int idUser, int idPet, int idVeterinarian) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL insertPhoneNumber(?, ?, ?, ?) }")) {
            st.setLong(1, number);
            setIntOrNull(st, 2, idUser);
            setIntOrNull(st, 3, idPet);
            setIntOrNull(st, 4, idVeterinarian);
            st.execute();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, "Error en insertPhoneNumber", ex); }
    }
 
    /** Inserta varios teléfonos de usuario de una sola vez. */
    public static void insertForUser(int idUser, ArrayList<String> numbers) {
        for (String raw : numbers) {
            if (raw == null || raw.isBlank()) continue;
            try { insert(Long.parseLong(raw.trim()), idUser, 0, 0); }
            catch (NumberFormatException e) { LOG.log(Level.WARNING, "Número no válido: " + raw, e); }
        }
    }
 
    /** Inserta varios teléfonos de mascota de una sola vez. */
    public static void insertForPet(int idPet, ArrayList<String> numbers) {
        for (String raw : numbers) {
            if (raw == null || raw.isBlank()) continue;
            try { insert(Long.parseLong(raw.trim()), 0, idPet, 0); }
            catch (NumberFormatException e) { LOG.log(Level.WARNING, "Número no válido: " + raw, e); }
        }
    }
    
    public static void insertForVeterinarian(int idVet, ArrayList<String> numbers) {
        for (String raw : numbers) {
            if (raw == null || raw.isBlank()) continue;
            try { insert(Long.parseLong(raw.trim()), 0, 0, idVet); }
            catch (NumberFormatException e) { LOG.log(Level.WARNING, "Número no válido: " + raw, e); }
        }
    }
 
    // ─────────────────────────────────────────────────────────────
    //  BD — INSTANCIA
    // ─────────────────────────────────────────────────────────────
 
    @Override
    public ResultSet getItem() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL getPhoneNumberById(?) }");
            st.setInt(1, id);
            return st.executeQuery();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }
 
    @Override
    public void deleteItem() {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL deletePhoneNumber(?) }")) {
            st.setInt(1, id);
            st.execute();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, "Error en deletePhoneNumber", ex); }
    }
 
    @Override public void updateItem() { throw new UnsupportedOperationException("No soportado."); }
}