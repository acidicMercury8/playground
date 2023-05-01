package ru.acidicmercury8.modernstack.controller;

import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ru.acidicmercury8.modernstack.exception.LoginException;
import ru.acidicmercury8.modernstack.exception.RegistrationException;
import ru.acidicmercury8.modernstack.model.ErrorResponse;
import ru.acidicmercury8.modernstack.model.TokenResponse;
import ru.acidicmercury8.modernstack.model.User;
import ru.acidicmercury8.modernstack.service.ClientService;
import ru.acidicmercury8.modernstack.service.TokenService;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {
    private final ClientService clientService;
    private final TokenService tokenService;

    @PostMapping
    public ResponseEntity<String> register(@RequestBody User user) {
        clientService.register(user.getClientId(), user.getClientSecret());
        return ResponseEntity.ok("Registered");
    }

    @PostMapping("/token")
    public TokenResponse getToken(@RequestBody User user) {
        clientService.checkCredentials(
                user.getClientId(), user.getClientSecret());
        return new TokenResponse(
                tokenService.generateToken(user.getClientId()));
    }

    @ExceptionHandler({RegistrationException.class, LoginException.class})
    public ResponseEntity<ErrorResponse> handleUserRegistrationException(RuntimeException ex) {
        return ResponseEntity
                .badRequest()
                .body(new ErrorResponse(ex.getMessage()));
    }
}
