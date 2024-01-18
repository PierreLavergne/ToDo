package com.middleware.api.javaapi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TodoService {
    private final TodoRepository todoRepository;

    @Autowired
    public TodoService(TodoRepository todoRepository) {
        this.todoRepository = todoRepository;
    }

    public Todo create(Todo todo) {
        return todoRepository.save(todo);
    }

    public List<Todo> getAll() {
        return todoRepository.findAll();
    }

    public Todo getByName(String name) {
        return todoRepository.findByName(name);
    }

    public void deleteByName(String name) {
        todoRepository.deleteByName(name);
    }

    public Todo updateByName(String name, Todo todo) {
        Todo todoToUpdate = todoRepository.findByName(name);
        todoToUpdate.setName(todo.getName());
        todoToUpdate.setDeadline(todo.getDeadline());
        todoToUpdate.setLabel(todo.getLabel());

        return todoRepository.save(todoToUpdate);
    }
}
