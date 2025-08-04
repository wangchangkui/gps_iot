package cn.admcc.util;

import cn.hutool.core.io.FileUtil;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.bouncycastle.util.io.pem.PemReader;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 17:43
 */
@Data
@Component
@Slf4j
public class RsaUtil implements InitializingBean {

    @Value("${security.privateKeyPath}")
    private String privateKeyPath;

    @Value("${security.publicKeyPath}")
    public String publicKeyPath;

    public PublicKey publicKey;

    private PrivateKey privateKey;

    private final static String ENCRYPT_MODE = "RSA/ECB/PKCS1Padding";



    @Override
    public void afterPropertiesSet() {
        Path sysPrivateKeyPath = Paths.get(this.privateKeyPath);
        if (!FileUtil.exist(sysPrivateKeyPath.toFile())) {
            log.error("私钥不存在,请检查地址： {}", sysPrivateKeyPath);
            return;
        }

        // 加载私钥
        this.privateKey = loadPrivateKey(privateKeyPath);

        Path sysPublicKeyPath = Paths.get(this.publicKeyPath);
        if (!FileUtil.exist(sysPublicKeyPath.toFile())) {
            log.error("公钥不存在,请检查地址： {}", sysPublicKeyPath);
            return;
        }

        // 加载私钥
        this.publicKey = loadPublicKey(sysPublicKeyPath.toString());

        log.info("RAS工具注入成功");
    }


    /**
     * 加载公钥
     * @param pubKeyPath 公钥地址
     * @return PublicKey
     */
    public  PublicKey loadPublicKey(String pubKeyPath) {
        try (PemReader pemReader = new PemReader(new FileReader(pubKeyPath))) {
            byte[] content = pemReader.readPemObject().getContent();
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(content);
            KeyFactory kf = KeyFactory.getInstance("RSA");
            return kf.generatePublic(keySpec);
        } catch (IOException | NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new RuntimeException(e);
        }
    }


    /**
     * 加载私钥
     * @param privateKeyPath 私钥地址
     * @return PrivateKey
     */
    public  PrivateKey loadPrivateKey(String privateKeyPath) {
        try (PemReader pemReader = new PemReader(new FileReader(privateKeyPath))) {
            byte[] content = pemReader.readPemObject().getContent();
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(content);
            KeyFactory kf = KeyFactory.getInstance("RSA");
            return kf.generatePrivate(keySpec);
        } catch (IOException | InvalidKeySpecException | NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 使用公钥加密数据
     * 使用公钥加密数据Base64编码的加密结果
     * @param data 需要加密对数据
     * @return Base64编码的加密结果
     */
    public  String encrypt(String data) throws Exception {
        if (publicKey == null) {
            throw new RuntimeException("publicKey Key 请检查文件是否存在，并重启系统");
        }
        Cipher cipher = Cipher.getInstance(ENCRYPT_MODE);
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        byte[] encrypted = cipher.doFinal(data.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(encrypted);
    }


    /**
     * 解密数据
     * @param base64Encrypted 加密数据对象
     * @return String
     * @throws Exception 解密失败
     */
    public  String decrypt(String base64Encrypted) throws Exception {
        if (privateKey == null) {
            throw new RuntimeException("Private Key 请检查文件是否存在，并重启系统");
        }
        Cipher cipher = Cipher.getInstance(ENCRYPT_MODE);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] encrypted = Base64.getDecoder().decode(base64Encrypted);
        byte[] decrypted = cipher.doFinal(encrypted);
        return new String(decrypted, StandardCharsets.UTF_8);
    }




    /**
     * 去除公钥和私钥的头尾
     *
     * @param pemContent 文件
     * @return String
     */
    public String extractKeyFromPem(String pemContent) {
        return pemContent
                .replaceAll("-----BEGIN PRIVATE KEY-----", "")
                .replaceAll("-----END PRIVATE KEY-----", "")
                .replaceAll("\\s", "");
    }


}
