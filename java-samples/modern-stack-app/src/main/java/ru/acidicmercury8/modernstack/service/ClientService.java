package ru.acidicmercury8.modernstack.service;

public interface ClientService {
    void register(String clientId, String clientSecret);

    void checkCredentials(String clientId, String clientSecret);
}
