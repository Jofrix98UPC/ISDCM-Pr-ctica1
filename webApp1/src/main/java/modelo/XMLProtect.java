package modelo;

import org.apache.xml.security.Init;
import org.apache.xml.security.encryption.XMLCipher;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.FileOutputStream;

public class XMLProtect {
    static {
        Init.init(); // Inicializa Apache Santuario
    }

    public static void encryptXML(String inputPath, String outputPath, String keyPath) throws Exception {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse(new File(inputPath));

        Element rootElement = doc.getDocumentElement();

        SecretKey symmetricKey = getOrGenerateKey(keyPath);
        XMLCipher xmlCipher = XMLCipher.getInstance(XMLCipher.AES_128);
        xmlCipher.init(XMLCipher.ENCRYPT_MODE, symmetricKey);

        xmlCipher.doFinal(doc, rootElement, false);
        writeDocument(doc, outputPath);
    }

    public static void decryptXML(String inputPath, String outputPath, String keyPath) throws Exception {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse(new File(inputPath));

        Element rootElement = doc.getDocumentElement();

        SecretKey symmetricKey = getOrGenerateKey(keyPath);
        XMLCipher xmlCipher = XMLCipher.getInstance(XMLCipher.AES_128);
        xmlCipher.init(XMLCipher.DECRYPT_MODE, symmetricKey);

        xmlCipher.doFinal(doc, rootElement);
        writeDocument(doc, outputPath);
    }

    private static SecretKey getOrGenerateKey(String keyPath) throws Exception {
        File keyFile = new File(keyPath);
        if (!keyFile.exists()) {
            KeyGenerator keyGen = KeyGenerator.getInstance("AES");
            keyGen.init(128);
            SecretKey key = keyGen.generateKey();
            try (FileOutputStream fos = new FileOutputStream(keyFile)) {
                fos.write(key.getEncoded());
            }
            return key;
        }
        byte[] keyBytes = java.nio.file.Files.readAllBytes(keyFile.toPath());
        return new SecretKeySpec(keyBytes, "AES");
    }

    private static void writeDocument(Document doc, String outputPath) throws Exception {
        Transformer transformer = TransformerFactory.newInstance().newTransformer();
        DOMSource source = new DOMSource(doc);
        StreamResult result = new StreamResult(new File(outputPath));
        transformer.transform(source, result);
    }
}
