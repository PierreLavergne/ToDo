package com.middleware.api.javaapi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/todos")
public class TodoController {
    private final TodoService todoService;

    @Autowired
    public TodoController(TodoService todoService) {
        this.todoService = todoService;
    }

    @GetMapping("/")
    public List<Todo> getTodos() {
        return todoService.getAll();
    }

    @GetMapping("/{name}")
    public Todo getTodoByName(@PathVariable String name) {
        return todoService.getByName(name);
    }

    @PostMapping("/create")
    public Todo createTodo(@RequestBody Todo todo) {
        return todoService.create(todo);
    }

    @PostMapping("/update/{name}")
    public Todo updateTodoByName(@PathVariable String name, @RequestBody Todo todo) {
        return todoService.updateByName(name, todo);
    }

    @DeleteMapping("/delete/{name}")
    public void deleteTodoByName(@PathVariable String name) {
        todoService.deleteByName(name);
    }
}
