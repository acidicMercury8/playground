package ru.acidicmercury8.modernstack.mapper;

import org.mapstruct.Mapper;

import ru.acidicmercury8.modernstack.model.Book;
import ru.acidicmercury8.modernstack.model.BookRequest;

@Mapper(componentModel = "spring")
public interface BookToDtoMapper {
    Book AddBookRequestToBook(BookRequest bookRequest);
}
