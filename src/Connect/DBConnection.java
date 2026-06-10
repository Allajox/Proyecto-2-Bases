package Connect;
import TablesObj.BlackList;
import Connect.AESUtil;
import TablesObj.User;
import java.sql.CallableStatement;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;
 
/**
 *
 * @author Allan
 */
public class DBConnection {
 
    // ── Cifrado ───────────────────────────────────────────────────────────────
    // Todas las contraseñas se almacenan cifradas con AES-256-CBC (ver AESUtil).
    // El login descifra el valor guardado y lo compara con el ingresado.
    
    public static String host = "jdbc:mysql://localhost:3306/pr2";
    public static String uName = "ADM";
    public static String  uPass = "ADM";
    
    
    // ── Consultas ─────────────────────────────────────────────────────────────
 
    public static ResultSet getPetTypes() throws SQLException {
        Connection con = DriverManager.getConnection(host, uName, uPass);
        // MySQL: SP hace SELECT y retorna el result set directamente
        CallableStatement stmt = con.prepareCall("{ CALL getPetType() }");
        return stmt.executeQuery();
    }
 
    public static ResultSet getPets() throws SQLException {
        Connection con = DriverManager.getConnection(host, uName, uPass);
        // MySQL: SP hace SELECT y retorna el result set directamente
        CallableStatement stmt = con.prepareCall("{ CALL getUsers() }");
        return stmt.executeQuery();
    }
 
    // ── Login ─────────────────────────────────────────────────────────────────
 
    /**
     * Retorna el id del usuario si las credenciales son correctas, -1 si no.
     * El SP MySQL debe hacer: SELECT id_user FROM user WHERE email=? AND password=?
     */
    /**
     * Login con contraseña cifrada en BD.
     *
     * Flujo:
     *  1. Busca el usuario por email y trae su contraseña cifrada + id.
     *  2. Descifra la contraseña almacenada y la compara con la ingresada.
     *  3. Retorna el id si coinciden, -1 si no.
     *
     * El SP "loginByEmail" solo filtra por email y devuelve (id, password).
     * La comparación se hace en Java para no enviar la clave en texto plano.
     */
    public static int login(String email, String password) throws SQLException {
        Connection con = DriverManager.getConnection(host, uName, uPass);
        // SP retorna: id_user, password (cifrado)
        CallableStatement stmt = con.prepareCall("{ CALL loginByEmail(?) }");
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();
        if (rs != null && rs.next()) {
            int    id              = rs.getInt(1);
            String storedEncrypted = rs.getString(2);
            try {
                if (AESUtil.matches(password, storedEncrypted)) return 1;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;
    }
 
    // ── Inserts simples (sin id de retorno) ───────────────────────────────────
    // Los SPs MySQL ya no reciben el id — usan AUTO_INCREMENT internamente.
 
    public static void insertCurrency(String name, String acronym) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            // Se eliminó s_currency.nextVal; el SP usa AUTO_INCREMENT
            stmt = con.prepareCall("{ CALL insertCurrency(?, ?) }");
            stmt.setString(1, name);
            stmt.setString(2, acronym);
            stmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertProvince(String name) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            stmt = con.prepareCall("{ CALL insertProvince(?) }");
            stmt.setString(1, name);
            stmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertCanton(String name, int idProvince) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            stmt = con.prepareCall("{ CALL insertCanton(?, ?) }");
            stmt.setString(1, name);
            stmt.setInt(2, idProvince);
            stmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertDistrict(String name, int idCanton) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            stmt = con.prepareCall("{ CALL insertDistrict(?, ?) }");
            stmt.setString(1, name);
            stmt.setInt(2, idCanton);
            stmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertPetType(String name) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            stmt = con.prepareCall("{ CALL insertPetType(?) }");
            stmt.setString(1, name);
            stmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertRace(String name, int idPetType) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            stmt = con.prepareCall("{ CALL insertRace(?, ?) }");
            stmt.setString(1, name);
            stmt.setInt(2, idPetType);
            stmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertStatus(String statusType) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            stmt = con.prepareCall("{ CALL insertStatus(?) }");
            stmt.setString(1, statusType);
            stmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertColor(String name) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            stmt = con.prepareCall("{ CALL insertColor(?) }");
            stmt.setString(1, name);
            stmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertValueType(String type) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            stmt = con.prepareCall("{ CALL insertValueType(?) }");
            stmt.setString(1, type);
            stmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertUser(String email, String password) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            stmt = con.prepareCall("{ CALL insertUser(?, ?) }");
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    // ── Inserts compuestos (necesitan el id generado para el segundo SP) ───────
    // MySQL no tiene parámetros OUT en este patrón; usamos getGeneratedKeys()
    // o un segundo CALL a LAST_INSERT_ID() para obtener el id del usuario recién creado.
 
    public static void insertAdopter(String email, String password, String firstName,
                                     String secondName, String firstSurname,
                                     String secondSurname) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            con.setAutoCommit(false);
 
            // 1. Inserta el usuario (contraseña cifrada con AES-256-CBC)
            String encryptedPass;
            try { encryptedPass = AESUtil.encrypt(password); }
            catch (Exception encEx) { throw new SQLException("Error al cifrar la contraseña.", encEx); }
            
            long userId = User.insert(email, encryptedPass);
 
            System.out.println(userId);
 
            // 3. Inserta el adoptante usando ese id
            stmt = con.prepareCall("{ CALL insertAdopter(?, ?, ?, ?, ?) }");
            stmt.setLong(1, userId);
            stmt.setString(2, firstName);
            stmt.setString(3, secondName);
            stmt.setString(4, firstSurname);
            stmt.setString(5, secondSurname);
            stmt.execute();
 
            con.commit();
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertAssociation(String email, String password,
                                         String name) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            con.setAutoCommit(false);
 
            // 1. Inserta el usuario (contraseña cifrada con AES-256-CBC)
            String encryptedPass;
            try { encryptedPass = AESUtil.encrypt(password); }
            catch (Exception encEx) { throw new SQLException("Error al cifrar la contraseña.", encEx); }
            stmt = con.prepareCall("{ CALL insertUser(?, ?) }");
            stmt.setString(1, email);
            stmt.setString(2, encryptedPass);
            stmt.execute();
 
            // 2. Recupera el id generado
            int userId = (int) getLastInsertId(con);
 
            // 3. Inserta la asociación
            stmt = con.prepareCall("{ CALL insertAssociation(?, ?) }");
            stmt.setInt(1, userId);
            stmt.setString(2, name);
            stmt.execute();
 
            con.commit();
 
            // Llamada externa fuera de la transacción (igual que en el original)
            BlackList.insert(userId);
 
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertCribHouse(String email, String password, String name,
                                       int requiresDonations,
                                       List<Integer> acceptedPetTypes,
                                       List<Integer> acceptedSizes) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            con.setAutoCommit(false);
 
            // 1. Inserta el usuario (contraseña cifrada con AES-256-CBC)
            String encryptedPass;
            try { encryptedPass = AESUtil.encrypt(password); }
            catch (Exception encEx) { throw new SQLException("Error al cifrar la contraseña.", encEx); }
            stmt = con.prepareCall("{ CALL insertUser(?, ?) }");
            stmt.setString(1, email);
            stmt.setString(2, encryptedPass);
            stmt.execute();
 
            // 2. Recupera el id generado
            int userId = (int) getLastInsertId(con);
 
            // 3. Inserta el CribHouse
            stmt = con.prepareCall("{ CALL insertCribHouse(?, ?, ?) }");
            stmt.setInt(1, userId);
            stmt.setString(2, name);
            stmt.setInt(3, requiresDonations);
            stmt.execute();
 
            // 4. Tipos de mascota aceptados
            for (Integer petTypeId : acceptedPetTypes) {
                stmt = con.prepareCall("{ CALL insertPetTypeXCribHouse(?, ?) }");
                stmt.setInt(1, petTypeId);
                stmt.setInt(2, userId);
                stmt.execute();
            }
 
            // 5. Tamaños aceptados
            for (Integer sizeId : acceptedSizes) {
                stmt = con.prepareCall("{ CALL insertSizeXCribHouse(?, ?) }");
                stmt.setInt(1, sizeId);
                stmt.setInt(2, userId);
                stmt.execute();
            }
 
            con.commit();
 
            BlackList.insert(userId);
 
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    public static void insertRescuer(String email, String password, String firstName,
                                     String secondName, String firstSurname,
                                     String secondSurname) throws SQLException {
        Connection con = null;
        CallableStatement stmt = null;
        try {
            con = DriverManager.getConnection(host, uName, uPass);
            con.setAutoCommit(false);
 
            // 1. Inserta el usuario (contraseña cifrada con AES-256-CBC)
            String encryptedPass;
            try { encryptedPass = AESUtil.encrypt(password); }
            catch (Exception encEx) { throw new SQLException("Error al cifrar la contraseña.", encEx); }
            stmt = con.prepareCall("{ CALL insertUser(?, ?) }");
            stmt.setString(1, email);
            stmt.setString(2, encryptedPass);
            stmt.execute();
 
            // 2. Recupera el id generado
            long userId = getLastInsertId(con);
 
            // 3. Inserta el rescatador
            stmt = con.prepareCall("{ CALL insertRescuer(?, ?, ?, ?, ?) }");
            stmt.setLong(1, userId);
            stmt.setString(2, firstName);
            stmt.setString(3, secondName);
            stmt.setString(4, firstSurname);
            stmt.setString(5, secondSurname);
            stmt.execute();
 
            con.commit();
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con  != null) try { con.close();  } catch (SQLException e) { e.printStackTrace(); }
        }
    }
 
    // ── Helper: obtiene el último id AUTO_INCREMENT de la conexión activa ─────
    /**
     * Equivalente a OracleTypes OUT + getLong(1).
     * LAST_INSERT_ID() en MySQL es por conexión, así que es seguro dentro
     * de la misma transacción.
     */
    private static long getLastInsertId(Connection con) throws SQLException {
        try (Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT LAST_INSERT_ID()")) {
            return (rs != null && rs.next()) ? rs.getLong(1) : -1L;
        }
    }
 
    private static java.sql.Date convertToDate(String dateString) {
        String[] parts = dateString.split("/");
        String formatedDate = parts[2] + "-" + parts[1] + "-" + parts[0];
        return java.sql.Date.valueOf(formatedDate);
    }
}