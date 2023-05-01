package ru.acidicmercury8.modernstack.util;

import java.math.BigInteger;
import java.security.SecureRandom;

public class SecretGenerator {
    public String generate() {
        byte[] bytes = new byte[32];
        new SecureRandom().nextBytes(bytes);
        return new BigInteger(1, bytes).toString(16);
    }
}
