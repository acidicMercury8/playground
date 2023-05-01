package ru.acidicmercury8.modernstack.repository;

import org.springframework.data.repository.CrudRepository;

import ru.acidicmercury8.modernstack.model.ClientEntity;

public interface ClientRepository extends CrudRepository<ClientEntity, String> {
}
