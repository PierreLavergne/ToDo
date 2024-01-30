package com.middleware.todo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.middleware.todo.model.TodoModel;
import com.middleware.todo.service.TodoService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/todos")
public class TodoController {
	private final TodoService todoService;

	@Autowired
	public TodoController(TodoService todoService) {
		this.todoService = todoService;
	}

	@GetMapping
	public Iterable<TodoModel> getAll() {
		return todoService.getAll();
	}

	@PostMapping
	public ResponseEntity<?> create(@Valid @RequestBody final TodoModel todo) {
		try {
			return new ResponseEntity<TodoModel>(todoService.create(todo), HttpStatus.CREATED);
		} catch (DataIntegrityViolationException error) {
			return new ResponseEntity<String>(String.format("%s already exist", todo.getName()), HttpStatus.CONFLICT);
		} catch (Exception e) {
			System.out.println(e);
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping
	public ResponseEntity<?> updateByName(@Valid @RequestBody final TodoModel todo) {
		try {
			final TodoModel updatedTodo = todoService.update(todo);

			if (updatedTodo == null) {
				return new ResponseEntity<String>(String.format("Todo ID must be present", todo.getName()),
						HttpStatus.BAD_REQUEST);
			}
			return new ResponseEntity<TodoModel>(updatedTodo, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/{name}")
	public ResponseEntity<?> getByName(@PathVariable final String name) {
		try {
			final TodoModel todo = todoService.getByName(name);

			if (todo == null) {
				return new ResponseEntity<String>(String.format("%s do not exist", name), HttpStatus.BAD_REQUEST);
			}
			return new ResponseEntity<TodoModel>(todo, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@DeleteMapping("/{name}")
	public ResponseEntity<?> deleteByName(@PathVariable final String name) {
		try {
			if (todoService.deleteByName(name) == 0) {
				return new ResponseEntity<String>(String.format("%s do not exist", name), HttpStatus.NOT_FOUND);
			}
			return new ResponseEntity<String>("OK", HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
