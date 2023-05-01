package ru.acidicmercury8.modernstack.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import ru.acidicmercury8.modernstack.model.BookEntity;

public interface BookRepository extends CrudRepository<BookEntity, Long> {
    List<BookEntity> findAllByAuthorContaining(String author);
}
