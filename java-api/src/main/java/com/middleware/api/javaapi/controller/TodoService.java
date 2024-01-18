package com.middleware.api.javaapi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TodoService {

    public Todo create(Todo todo) {
        return todo;
    }

    public List<Todo> getAll() {
        return null;
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
