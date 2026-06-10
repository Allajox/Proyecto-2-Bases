package Connect;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Utilidad AES-256-CBC para cifrar y descifrar contraseñas.
 *
 * Formato almacenado en BD: Base64(IV) + ":" + Base64(ciphertext)
 * El IV (16 bytes) es aleatorio por cada cifrado, lo que garantiza
 * que la misma contraseña produzca valores distintos en cada registro.
 *
 * IMPORTANTE: SECRET_KEY debe tener exactamente 32 caracteres (256 bits).
 * En producción, cargá este valor desde una variable de entorno o un
 * archivo de configuración externo — nunca lo dejés hardcodeado.
 */
public class AESUtil {

    // ── Clave de 256 bits (32 chars ASCII) ───────────────────────
    private static final String SECRET_KEY = "QuieroUnPeludo!!SecretKey2024!!X"; // 32 chars

    private static final String ALGORITHM       = "AES";
    private static final String TRANSFORMATION  = "AES/CBC/PKCS5Padding";
    private static final int    IV_LENGTH_BYTES  = 16;

    // ─────────────────────────────────────────────────────────────

    /**
     * Cifra un texto plano con AES-256-CBC.
     *
     * @param plainText texto a cifrar (ej: contraseña del usuario)
     * @return String con formato "Base64(iv):Base64(ciphertext)"
     * @throws Exception si falla el cifrado
     */
    public static String encrypt(String plainText) throws Exception {
        byte[] iv = generateIV();
        Cipher cipher = buildCipher(Cipher.ENCRYPT_MODE, iv);
        byte[] encrypted = cipher.doFinal(plainText.getBytes(StandardCharsets.UTF_8));

        String ivBase64         = Base64.getEncoder().encodeToString(iv);
        String encryptedBase64  = Base64.getEncoder().encodeToString(encrypted);
        return ivBase64 + ":" + encryptedBase64;
    }

    /**
     * Descifra un valor producido por {@link #encrypt(String)}.
     *
     * @param stored texto almacenado en BD con formato "Base64(iv):Base64(ciphertext)"
     * @return contraseña en texto plano
     * @throws Exception si el formato es inválido o falla el descifrado
     */
    public static String decrypt(String stored) throws Exception {
        String[] parts = stored.split(":");
        if (parts.length != 2)
            throw new IllegalArgumentException("Formato de contraseña cifrada inválido.");

        byte[] iv         = Base64.getDecoder().decode(parts[0]);
        byte[] cipherText = Base64.getDecoder().decode(parts[1]);

        Cipher cipher = buildCipher(Cipher.DECRYPT_MODE, iv);
        byte[] decrypted = cipher.doFinal(cipherText);
        return new String(decrypted, StandardCharsets.UTF_8);
    }

    /**
     * Compara una contraseña en texto plano con el valor cifrado almacenado.
     * Usar este método en el login en lugar de comparar strings directamente.
     *
     * @param plainText  contraseña ingresada por el usuario
     * @param stored     valor almacenado en BD ("iv:ciphertext")
     * @return true si coinciden
     */
    public static boolean matches(String plainText, String stored) {
        try {
            return plainText.equals(decrypt(stored));
        } catch (Exception e) {
            return false;
        }
    }

    // ── Helpers privados ──────────────────────────────────────────

    private static Cipher buildCipher(int mode, byte[] iv) throws Exception {
        SecretKey key    = new SecretKeySpec(SECRET_KEY.getBytes(StandardCharsets.UTF_8), ALGORITHM);
        IvParameterSpec ivSpec = new IvParameterSpec(iv);
        Cipher cipher = Cipher.getInstance(TRANSFORMATION);
        cipher.init(mode, key, ivSpec);
        return cipher;
    }

    private static byte[] generateIV() {
        byte[] iv = new byte[IV_LENGTH_BYTES];
        new SecureRandom().nextBytes(iv);
        return iv;
    }
}
