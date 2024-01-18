package com.middleware.api.javaapi.controller;

import org.springframework.data.jpa.repository.JpaRepository;


public interface TodoRepository extends JpaRepository<Todo, Long> {
    Todo findByName(String name);

    void deleteByName(String name);

    Todo updateByName(String name, Todo todo);
}
