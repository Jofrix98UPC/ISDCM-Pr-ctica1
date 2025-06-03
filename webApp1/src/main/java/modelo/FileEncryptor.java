package modelo;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.io.*;
import java.nio.file.Files;

public class FileEncryptor {
    private static final String ALGORITHM = "AES";
    private static final String KEY_FILE = "keyfile.key";

    public static void encryptFile(File inputFile, File outputFile) throws Exception {
        SecretKey key = getSecretKey();
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, key);

        try (FileInputStream fis = new FileInputStream(inputFile);
             FileOutputStream fos = new FileOutputStream(outputFile)) {
            byte[] inputBytes = fis.readAllBytes();
            byte[] outputBytes = cipher.doFinal(inputBytes);
            fos.write(outputBytes);
        }
    }

    public static void decryptFile(File inputFile, File outputFile) throws Exception {
        SecretKey key = getSecretKey();
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, key);

        try (FileInputStream fis = new FileInputStream(inputFile);
             FileOutputStream fos = new FileOutputStream(outputFile)) {
            byte[] inputBytes = fis.readAllBytes();
            byte[] outputBytes = cipher.doFinal(inputBytes);
            fos.write(outputBytes);
        }
    }

    private static SecretKey getSecretKey() throws Exception {
        File keyFile = new File(KEY_FILE);
        if (!keyFile.exists()) {
            KeyGenerator keyGen = KeyGenerator.getInstance(ALGORITHM);
            keyGen.init(128);
            SecretKey secretKey = keyGen.generateKey();
            Files.write(keyFile.toPath(), secretKey.getEncoded());
            return secretKey;
        }
        byte[] keyBytes = Files.readAllBytes(keyFile.toPath());
        return new SecretKeySpec(keyBytes, ALGORITHM);
    }
}
