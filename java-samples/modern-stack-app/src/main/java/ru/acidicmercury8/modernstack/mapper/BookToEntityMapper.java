package ru.acidicmercury8.modernstack.mapper;

import org.mapstruct.Mapper;

import ru.acidicmercury8.modernstack.model.Book;
import ru.acidicmercury8.modernstack.model.BookEntity;

@Mapper(componentModel = "spring")
public interface BookToEntityMapper {
    BookEntity bookToBookEntity(Book book);

    Book bookEntityToBook(BookEntity bookEntity);
}
