package org.example

import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.security.KeyFactory
import java.security.KeyPairGenerator
import java.security.PrivateKey
import java.security.PublicKey
import java.security.SecureRandom
import java.security.spec.X509EncodedKeySpec
import java.util.Base64
import javax.crypto.AEADBadTagException
import javax.crypto.Cipher
import javax.crypto.KeyGenerator
import javax.crypto.spec.GCMParameterSpec
import javax.crypto.spec.OAEPParameterSpec
import javax.crypto.spec.PSource
import javax.crypto.spec.SecretKeySpec

class Mck {
    private val AES_ALGO = "AES/GCM/NoPadding"
    private val RSA_ALGO = "RSA/ECB/OAEPwithSHA-512andMGF1Padding"
    
    fun enc(data: ByteArray): String = Base64.getEncoder().encodeToString(data)
    
    fun dec(data: String): ByteArray = Base64.getDecoder().decode(data)
    
    fun aesEncrypt(key: String, data: String): String? {
        return try {
            val iv = ByteArray(12).also { SecureRandom().nextBytes(it) }
            val cipher = Cipher.getInstance(AES_ALGO)
            cipher.init(Cipher.ENCRYPT_MODE, SecretKeySpec(dec(key), "AES"), GCMParameterSpec(128, iv))
            enc(iv + cipher.doFinal(data.toByteArray()))
        } catch (e: Exception) {
            null
        }
    }
    
    fun aesDecrypt(key: String, data: String): String? {
        return try {
            val d = dec(data)
            val iv = d.copyOfRange(0, 12)
            val text = d.copyOfRange(12, d.size)
            val cipher = Cipher.getInstance(AES_ALGO)
            cipher.init(Cipher.DECRYPT_MODE, SecretKeySpec(dec(key), "AES"), GCMParameterSpec(128, iv))
            cipher.doFinal(text).decodeToString()
        } catch (e: Exception) {
            null
        }
    }
    
    fun aesFileEncrypt(key: String, inFile: File, outFile: File) {
        val iv = ByteArray(12).also { SecureRandom().nextBytes(it) }
        val cipher = Cipher.getInstance(AES_ALGO)
        cipher.init(Cipher.ENCRYPT_MODE, SecretKeySpec(dec(key), "AES"), GCMParameterSpec(128, iv))
        
        FileInputStream(inFile).use { fis ->
            FileOutputStream(outFile).use { fos ->
                val buff = ByteArray(1024)
                var len: Int
                try {
                    fos.write(iv, 0, 12)
                    while (fis.read(buff).also { len = it } != -1) {
                        val chunked = cipher.update(buff, 0, len)
                        if (chunked != null) fos.write(chunked)
                    }
                    val fine = cipher.doFinal()
                    if (fine != null) fos.write(fine)
                } catch (e: Exception) {
                    outFile.delete()
                }
            }
        }
    }
    
    fun aesFileDecrypt(key: String, inFile: File, outFile: File) {
        var iv = ByteArray(12)
        val cipher = Cipher.getInstance(AES_ALGO)
        FileInputStream(inFile).use { fis ->
            cipher.init(Cipher.DECRYPT_MODE, SecretKeySpec(dec(key), "AES"), GCMParameterSpec(128, iv))
            val buff = ByteArray(1024)
            var len: Int
            FileOutputStream(outFile).use { fos ->
                try {
                    fis.read(iv)
                    while (fis.read(buff).also { len = it } != -1) {
                        val chunked = cipher.update(buff, 0, len)
                        if (chunked != null) fos.write(chunked)
                    }
                    val fine = cipher.doFinal()
                    if (fine != null) fos.write(fine)
                } catch (badTag: AEADBadTagException) {
                    outFile.delete()
                } catch (e: Exception) {
                    outFile.delete()
                }
            }
        }
    }
    
    fun rasEncrypt() {
        // todo: rsa encryption
    }
    
    fun rsaDecrypt() {
        // todo: rsa decryption
    }
}