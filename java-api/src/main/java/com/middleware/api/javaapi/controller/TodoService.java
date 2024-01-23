package com.middleware.api.javaapi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.web.bind.annotation.*;

@Service
public class TodoService {
    private final TodoRepository todoRepository;

    @Autowired
    public TodoService(TodoRepository todoRepository) {
        this.todoRepository = todoRepository;
    }

    public Todo create(Todo todo) {
        return todo;
    }

    public Iterable<Todo> getAll() {
        return todoRepository.findAll();
    }

    public Todo getByName(String name) {
        return null;
    }

    public void deleteByName(String name) {
        return;
    }

    public Todo updateByName(String name, Todo todo) {
        return todo;
    }
}
