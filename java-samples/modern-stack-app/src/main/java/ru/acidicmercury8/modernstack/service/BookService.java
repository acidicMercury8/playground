package ru.acidicmercury8.modernstack.service;

import java.util.List;

import ru.acidicmercury8.modernstack.model.Book;

public interface BookService {
    Book getBookById(Long id);

    List<Book> getAllBooks();

    void addBook(Book book);

    List<Book> findByAuthor(String author);
}
