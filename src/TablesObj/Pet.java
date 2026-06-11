package TablesObj;
 
import static Connect.DBConnection.host;
import static Connect.DBConnection.uName;
import static Connect.DBConnection.uPass;
import Connect.DBItem;
 
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
 
import java.util.logging.Level;
import java.util.logging.Logger;
 
public class Pet extends DBItem {
 
    private static final Logger LOG = Logger.getLogger(Pet.class.getName());
 
    private final int id;
    private ArrayList<String> data;
 
    // ─────────────────────────────────────────────────────────────
    //  CONSTRUCTOR
    // ─────────────────────────────────────────────────────────────
 
    public Pet(int id) {
        this.id = id;
    }
 
    private void loadData() {
        if (data != null) return;
        data = new ArrayList<>();
        try {
            ResultSet rs = getItem();
            if (rs != null && rs.next()) {
                int cols = rs.getMetaData().getColumnCount();
                for (int i = 1; i <= cols; i++) {
                    data.add(rs.getString(i));
                }
            }
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, "Error al cargar datos de Pet id=" + id, ex);
        }
    }
 
    // ─────────────────────────────────────────────────────────────
    //  GETTERS
    // ─────────────────────────────────────────────────────────────
    
    //  Id  | Column            | Extra Info
    //  1   | id_pet            |
    //  2   | picture           |
    //  3   | name              |
    //  4   | birth_date        |
    //  5   | date_lost         |
    //  6   | date_found        |
    //  7   | email             |
    //  8   | id_size           |
    //  9   | id_status         |
    //  10  | id_race           |
    //  11  | id_user           | Se refiere al user que registra la mascota
    //  12  | id_adopter        | Se refiere al user el cual posee la mascota actualmente
    //  13  | id_district       |
    //  14  | createdBy         |
    //  15  | createAt          |
    //  16  | modifiedBy        |
    //  17  | modifiedAt        |
    
    
    
 
    public int    getId()        { return id; }
    public String getPicture()   { loadData(); return get(1); }
    public String getFirstName() { loadData(); return get(2); }
    public String getBirthdate() { loadData(); return normalizeDate(get(3)); }
    public String getDateLost()  { loadData(); return normalizeDate(get(4)); }
    public String getDateFound() { loadData(); return normalizeDate(get(5)); }
    public String getEmail()     { loadData(); return get(6); } 
    public int    getIdSize()        { loadData(); return getInt(7); }
    public int    getIdStatus()      { loadData(); return getInt(8); }
    public int    getIdPetRace()     { loadData(); return getInt(9); }
    public int    getIdUser()        { loadData(); return getInt(10); }
    public int    getIdCurrentUser() { loadData(); return getInt(11); }
    public int    getIdDistrict()    { loadData(); return getInt(12); }
 
    public PetExtraInfo getExtraInfo() { return new PetExtraInfo(id); }
 
    // ─────────────────────────────────────────────────────────────
    //  HELPERS INTERNOS
    // ─────────────────────────────────────────────────────────────
 
    private String get(int index) {
        return (data != null && index < data.size()) ? data.get(index) : null;
    }
 
    private int getInt(int index) {
        String val = get(index);
        if (val == null) return 0;
        try { return Integer.parseInt(val); }
        catch (NumberFormatException e) { return 0; }
    }
    
    private static void setIntOrNull(CallableStatement st, int idx, int val) throws SQLException {
        if (val > 0) st.setInt(idx, val);
        else         st.setNull(idx, Types.NUMERIC);
    }
 
    /**
     * Normaliza cualquier string de fecha al formato "YYYY-MM-DD" que espera Date.valueOf().
     * Oracle devuelve las fechas como "2016-07-29 00:00:00" al usar rs.getString(),
     * lo que hace que Date.valueOf() lance IllegalArgumentException.
     * Este método recorta el timestamp y maneja también el formato "YYYY/MM/DD".
     */
    private static String normalizeDate(String raw) {
        if (raw == null || raw.isBlank()) return null;
        String s = raw.trim();
 
        // Caso: "2016-07-29 00:00:00" o "2016-07-29T00:00:00" — recortar al separador
        if (s.length() > 10 && (s.charAt(10) == ' ' || s.charAt(10) == 'T'))
            s = s.substring(0, 10);
 
        // Caso: "2026/02/14" — reemplazar separador
        s = s.replace('/', '-');
 
        return s; // debería quedar como "YYYY-MM-DD"
    }
 
    /**
     * Bindea un parámetro DATE desde un String de cualquier formato reconocible.
     * Si el string es null, en blanco, o no parseable, bindea SQL NULL.
     */
    private static void setDateOrNull(CallableStatement st, int idx, String dateStr)
            throws SQLException {
        String normalized = normalizeDate(dateStr);
        if (normalized == null) {
            st.setNull(idx, Types.DATE);
            return;
        }
        try {
            st.setDate(idx, Date.valueOf(normalized));
        } catch (IllegalArgumentException ex) {
            LOG.log(Level.WARNING, "Fecha con formato no reconocido, se bindea NULL: '" + dateStr + "'");
            st.setNull(idx, Types.DATE);
        }
    }
 
    // ─────────────────────────────────────────────────────────────
    //  OPERACIONES DE BD — ESTÁTICAS
    // ─────────────────────────────────────────────────────────────

    //TODO
    public static ArrayList<ArrayList<Object>> runSearch(
            int pIdChip, int pIdRescuer, int pIdStatus, int pIdPetType,
            int pIdColor, int pIdRace, int pIdProvince, int pIdCanton, int pIdDistrict) {
        ArrayList<ArrayList<Object>> filas = new ArrayList<>();
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement st = con.prepareCall("{ CALL getPetFilters(?,?,?,?,?,?,?,?,?) }")) {
            setIntOrNull(st, 1, pIdChip);
            setIntOrNull(st, 2, pIdDistrict);
            setIntOrNull(st, 3, pIdCanton);
            setIntOrNull(st, 4, pIdProvince);
            setIntOrNull(st, 5, pIdStatus);
            setIntOrNull(st, 6, pIdPetType);
            setIntOrNull(st, 7, pIdRescuer);
            setIntOrNull(st, 8, pIdRace);
            setIntOrNull(st, 9, pIdColor);
            st.execute();
            try (ResultSet rs = st.getResultSet()) {
                if (rs != null) {
                    ResultSetMetaData meta = rs.getMetaData();
                    int cols = meta.getColumnCount();
                    while (rs.next()) {
                        ArrayList<Object> fila = new ArrayList<>();
                        for (int i = 1; i <= cols; i++) fila.add(rs.getObject(i));
                        filas.add(fila);
                    }
                }
            }

        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, "Error en getPetFilters", ex);
        }

        return filas;
    }
 
    public static ArrayList<String> getPopupItem(int id) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement stmt = con.prepareCall("{ CALL getPopUpInfo(?) }")) {
            stmt.setInt(1, id);
            stmt.execute();
            ResultSet rs = stmt.getResultSet(); 
            ArrayList<String> arr = new ArrayList<>();
            if (rs != null && rs.next()) {
                int cols = rs.getMetaData().getColumnCount();
                for (int i = 1; i <= cols; i++) arr.add(rs.getString(i));
            }
            return arr;
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, null, ex);
        }
        return null;
    }
 
    public static ResultSet getAllPets() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement stmt = con.prepareCall("{ CALL getPet() }");
            stmt.execute();
            return stmt.getResultSet(); 
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, null, ex);
        }
        return null;
    }
 
    public static ResultSet getAllPetsByStatus(int p_IdStatus) {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement stmt = con.prepareCall("{ CALL getPetByStatus(?) }");
            stmt.setInt(1, p_IdStatus);
            stmt.execute();
            return stmt.getResultSet();
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, null, ex);
        }
        return null;
    }
 
    // ─────────────────────────────────────────────────────────────
    //  OPERACIONES DE BD — INSTANCIA
    // ─────────────────────────────────────────────────────────────
 
    @Override
    public ResultSet getItem() {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement stmt = con.prepareCall("{ CALL getPetById(?) }");
            stmt.setInt(1, id);
            stmt.execute();
            return stmt.getResultSet();
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, null, ex);
        }
        return null;
    }
 
    /*
     * @return: 0.imagen, 1.statusType, 2.nombre, 3.idExtraInfo, 4.energyLevel,
     *          5.email, 6.size, 7.TrainingEase, 8.PetType
     */
     public static ArrayList<String> getCardItem(int id) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
             CallableStatement stmt = con.prepareCall("{ CALL getCardInfo(?) }")) {
            stmt.setInt(1, id);
            stmt.execute();
            ResultSet rs = stmt.getResultSet();
            ArrayList<String> arr = new ArrayList<>();
            if (rs != null && rs.next()) {
                int cols = rs.getMetaData().getColumnCount();
                for (int i = 1; i <= cols; i++) arr.add(rs.getString(i));
            }
            return arr;
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, null, ex);
        }
        return null;
    }
 
    
    public void updateItem(String pPicture, String pFirstName, String pBirthDate,
                           String pDateLost, String pDateFound, String pEmail, int pIdStatus) {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            con.setAutoCommit(false);
            stmt = con.prepareCall("{ CALL updatePet(?, ?, ?, ?, ?, ?, ?, ?) }");
            stmt.setInt(1, id);
            stmt.setString(2, pPicture);
            stmt.setString(3, pFirstName);
            setDateOrNull(stmt, 4, pBirthDate);
            setDateOrNull(stmt, 5, pDateLost);
            setDateOrNull(stmt, 6, pDateFound);
            stmt.setString(7, pEmail);
            stmt.setInt(8, pIdStatus);
            stmt.execute();
            con.commit();
            data = null;
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    public void changePetStatus(int idUser, int pIdStatus, int idPet) {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            con.setAutoCommit(false);
            stmt = con.prepareCall("{ CALL adoptPet(?, ?, ?) }");
            stmt.setInt(1, idUser);
            stmt.setInt(2, pIdStatus);
            stmt.setInt(3, idPet);
            stmt.execute();
            con.commit();
            data = null;
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    
    public void petFound(int pIdPet) {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            con.setAutoCommit(false);
            stmt = con.prepareCall("{ CALL petFound(?) }");
            stmt.setInt(1, pIdPet);
            stmt.execute();
            con.commit();
            data = null;
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        }
    }
    
    public static ResultSet getByRescuer(int idUser) {
        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL getPetByRescuer(?) }");
            st.setInt(1, idUser);
            st.execute();
            return st.getResultSet();
        } catch (SQLException ex) { LOG.log(Level.SEVERE, null, ex); }
        return null;
    }
 
    public static int insert(String picture, String firstName, String birthdate,
                             String dateLost, String dateFound, String email,
                             int idStatus, int idPetRace, int idSize, int idRescuer, int idDistrict) {
        try (Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement st = con.prepareCall("{ CALL insertPet(?,?,?,?,?,?,?,?,?,?,?,?,?) }")) {
            st.registerOutParameter(1, Types.INTEGER);
            st.setString(2,  picture);
            st.setString(3,  firstName);
            setDateOrNull(st, 4, birthdate);  
            setDateOrNull(st, 5, dateLost);
            setDateOrNull(st, 6, dateFound);
            st.setString(7,  email);
            st.setInt   (8,  idStatus);
            st.setInt   (9,  idPetRace);
            st.setInt   (10, idSize);
            st.setInt   (11, idRescuer);
            st.setNull  (12, Types.INTEGER);
            st.setInt   (13, idDistrict);
            
            st.execute();
            return st.getInt(1);
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, null, ex);
        }
        return -1;
    }
 
    @Override public void deleteItem() { throw new UnsupportedOperationException("Not supported yet."); }
    @Override public void updateItem() { throw new UnsupportedOperationException("Not supported yet."); }
}
