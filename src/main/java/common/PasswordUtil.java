package common;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {

    // Generate a random salt
    public static String generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }

    // Hash password with salt using SHA-256
    public static String hashPassword(String password, String salt) {
        if (password == null || salt == null) return null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt.getBytes("UTF-8"));
            byte[] hashedBytes = md.digest(password.getBytes("UTF-8"));
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    // Hash password with auto-generated salt — returns "salt:hash"
    public static String hashPassword(String password) {
        if (password == null) return null;
        String salt = generateSalt();
        String hash = hashPassword(password, salt);
        return salt + ":" + hash;
    }

    // Verify password against stored "salt:hash"
    public static boolean verifyPassword(String inputPassword, String storedHash) {
        if (inputPassword == null || storedHash == null) return false;
        try {
            // Split only on first colon
            int idx = storedHash.indexOf(":");
            if (idx == -1) return false;
            String salt = storedHash.substring(0, idx);
            String hash = storedHash.substring(idx + 1);
            String inputHash = hashPassword(inputPassword, salt);
            return hash.equals(inputHash);
        } catch (Exception e) {
            return false;
        }
    }
}
